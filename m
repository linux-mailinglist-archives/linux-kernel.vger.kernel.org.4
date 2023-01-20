Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45BA675DCE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 20:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjATTST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 14:18:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjATTSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 14:18:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FDA1A2979
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 11:18:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A9EC6206B
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 19:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567A2C433EF;
        Fri, 20 Jan 2023 19:18:03 +0000 (UTC)
Date:   Fri, 20 Jan 2023 19:18:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [RESEND PATCH v2 2/2] mm/kmemleak: Fix UAF bug in kmemleak_scan()
Message-ID: <Y8ro6DxR1v0XlDs3@arm.com>
References: <20230119040111.350923-1-longman@redhat.com>
 <20230119040111.350923-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119040111.350923-3-longman@redhat.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

Thanks for your effort on trying to fix this.

On Wed, Jan 18, 2023 at 11:01:11PM -0500, Waiman Long wrote:
> @@ -567,7 +574,9 @@ static void __remove_object(struct kmemleak_object *object)
>  	rb_erase(&object->rb_node, object->flags & OBJECT_PHYS ?
>  				   &object_phys_tree_root :
>  				   &object_tree_root);
> -	list_del_rcu(&object->object_list);
> +	if (!(object->del_state & DELSTATE_NO_DELETE))
> +		list_del_rcu(&object->object_list);
> +	object->del_state |= DELSTATE_REMOVED;
>  }

So IIUC, this prevents the current object being scanned from being
removed from the list during the kmemleak_cond_resched() call.

>  /*
> @@ -633,6 +642,7 @@ static void __create_object(unsigned long ptr, size_t size,
>  	object->count = 0;			/* white color initially */
>  	object->jiffies = jiffies;
>  	object->checksum = 0;
> +	object->del_state = 0;
>  
>  	/* task information */
>  	if (in_hardirq()) {
> @@ -1470,9 +1480,22 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
>  	if (!get_object(object))
>  		return;	/* Try next object */
>  
> +	raw_spin_lock_irq(&kmemleak_lock);
> +	if (object->del_state & DELSTATE_REMOVED)
> +		goto unlock_put;	/* Object removed */
> +	object->del_state |= DELSTATE_NO_DELETE;
> +	raw_spin_unlock_irq(&kmemleak_lock);
> +
>  	rcu_read_unlock();
>  	cond_resched();
>  	rcu_read_lock();
> +
> +	raw_spin_lock_irq(&kmemleak_lock);
> +	if (object->del_state & DELSTATE_REMOVED)
> +		list_del_rcu(&object->object_list);
> +	object->del_state &= ~DELSTATE_NO_DELETE;
> +unlock_put:
> +	raw_spin_unlock_irq(&kmemleak_lock);
>  	put_object(object);
>  }

I'm not sure this was the only problem. We do have the problem that the
current object may be removed from the list, solved above, but another
scenario I had in mind is the next object being released during this
brief resched period. The RCU relies on object->next->next being valid
but, with a brief rcu_read_unlock(), the object->next could be freed,
reallocated, so object->next->next invalid.

-- 
Catalin
