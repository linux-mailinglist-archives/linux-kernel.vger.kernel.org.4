Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E9A72A2E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 21:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjFITMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 15:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjFITMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 15:12:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F751A4;
        Fri,  9 Jun 2023 12:12:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8997E611B0;
        Fri,  9 Jun 2023 19:12:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628F2C433D2;
        Fri,  9 Jun 2023 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686337929;
        bh=KFNOV3o4cqtQYNywig/OkDKy4bUHopCwMFlABCAl2zQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nXyUBVzvCMSSoCB+HWwPC+EduJ1s0zzgtsCoFlQp/k4a/Yg37cO5twLzXZYmhhNfY
         ywrwWgFT0+H7daHKQfEdQn2yfabwnOqdu41l2ruM993kQ8WmX+EuekP+WtfxyLk/vj
         waVl4IAMZW0Y2i5lESWeJsBZHkCQhtU6jgv+j9tsxHn5zWpT+M7aqcmobKNEshZ5D+
         he9Zq5MwPM7wD67cvQ2RAwCSp3yA1ptrKhY5UjXueJJNfp6r59XLKtKSubGNKNK8Rb
         3AdJKu7vWZ/ykO1d/KfIuWysfwQnzEMQRd52WOXjmCmfRbXKke8BBE3yhZovpqZASD
         KmIO1cZ0ZXvKA==
From:   SeongJae Park <sj@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     SeongJae Park <sj@kernel.org>, paulmck@kernel.org, corbet@lwn.net,
        rcu@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] Docs/RCU/rculist_nulls: Drop unnecessary '_release' in insert function
Date:   Fri,  9 Jun 2023 19:12:06 +0000
Message-Id: <20230609191206.30465-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAEXW_YQFqW2QcAuHZEhc_GaUaB-=QOS0WgUOizd=FYwtFQ8vag@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 May 2023 14:52:50 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:

> On Thu, May 18, 2023 at 6:40 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > The document says we can avoid extra smp_rmb() in lockless_lookup() and
> > extra _release() in insert function when hlist_nulls is used.  However,
> > the example code snippet for the insert function is still using the
> > extra _release().  Drop it.
> >
> > Signed-off-by: SeongJae Park <sj@kernel.org>
> > ---
> >  Documentation/RCU/rculist_nulls.rst | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Documentation/RCU/rculist_nulls.rst b/Documentation/RCU/rculist_nulls.rst
> > index 5cd6f3f8810f..463270273d89 100644
> > --- a/Documentation/RCU/rculist_nulls.rst
> > +++ b/Documentation/RCU/rculist_nulls.rst
> > @@ -191,7 +191,7 @@ scan the list again without harm.
> >    obj = kmem_cache_alloc(cachep);
> >    lock_chain(); // typically a spin_lock()
> >    obj->key = key;
> > -  atomic_set_release(&obj->refcnt, 1); // key before refcnt
> > +  atomic_set(&obj->refcnt, 1);
> >    /*
> >     * insert obj in RCU way (readers might be traversing chain)
> >     */
> 
> If write to ->refcnt of 1 is reordered with setting of ->key, what
> prevents the 'lookup algorithm' from doing a key match (obj->key ==
> key) before the refcount has been initialized?
> 
> Are we sure the reordering mentioned in the document is the same as
> the reordering prevented by the atomic_set_release()?

Paul, may I ask your opinion?


Thanks,
SJ

> 
> For the other 3 patches, feel free to add:
> Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> thanks,
> 
>  - Joel
