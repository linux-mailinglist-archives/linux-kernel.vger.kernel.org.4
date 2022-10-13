Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A84E35FD63E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 10:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJMIdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 04:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJMIdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 04:33:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543BD285
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 01:33:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5FAF4219FD;
        Thu, 13 Oct 2022 08:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665650028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UykCCyJppeIUxswHlrvpiYaqBuU5BdEdPSbdjTJa47Q=;
        b=Rc9cWLzaN+2mBDp03fYhJKtCItFrzeHJFnUVYf/Chm/uom0tNUiP2Lz39xyu4OVfXQ0/FU
        m/XNh6OM+2z3ZbWkTTicNTczAN4rs7rls45qwp9bXENDOSNJJCPXq1W7Ba//E98zJq3Sms
        5oRCjPDXxwwhVRzEqfTpczbVYTdTQzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665650028;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UykCCyJppeIUxswHlrvpiYaqBuU5BdEdPSbdjTJa47Q=;
        b=c1bxmZqV6zA4PCXwr2Duu/z5BawMYC/UfhCr+2HxsFxCuVQHps+0xYxUJN1aHhJf3Pj2Vy
        bPMMnH6yK4064oDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0C2013AAA;
        Thu, 13 Oct 2022 08:33:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id asdNJGvNR2OrbAAAMHmgww
        (envelope-from <osalvador@suse.de>); Thu, 13 Oct 2022 08:33:47 +0000
Date:   Thu, 13 Oct 2022 10:33:45 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] mm/hwpoison: introduce per-memory_block hwpoison
 counter
Message-ID: <Y0fNaYGvnMdwHkg1@localhost.localdomain>
References: <20221007010706.2916472-1-naoya.horiguchi@linux.dev>
 <20221007010706.2916472-5-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007010706.2916472-5-naoya.horiguchi@linux.dev>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 10:07:06AM +0900, Naoya Horiguchi wrote:
> From: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> Currently PageHWPoison flag does not behave well when experiencing memory
> hotremove/hotplug.  Any data field in struct page is unreliable when the
> associated memory is offlined, and the current mechanism can't tell whether
> a memory block is onlined because a new memory devices is installed or
> because previous failed offline operations are undone.  Especially if
> there's a hwpoisoned memory, it's unclear what the best option is.
> 
> So introduce a new mechanism to make struct memory_block remember that
> a memory block has hwpoisoned memory inside it. And make any online event
> fail if the onlining memory block contains hwpoison.  struct memory_block
> is freed and reallocated over ACPI-based hotremove/hotplug, but not over
> sysfs-based hotremove/hotplug.  So the new counter can distinguish these
> cases.
> 
> Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> Reported-by: kernel test robot <lkp@intel.com>

I glanzed over it and looks good overall.
Have a small question though:

> @@ -864,6 +878,7 @@ void remove_memory_block_devices(unsigned long start, unsigned long size)
>  		mem = find_memory_block_by_id(block_id);
>  		if (WARN_ON_ONCE(!mem))
>  			continue;
> +		num_poisoned_pages_sub(-1UL, memblk_nr_poison(mem));

Why does num_poisoned_pages_sub() have to make this distinction (!-1 == -1)
for the hot-remove stage?


-- 
Oscar Salvador
SUSE Labs
