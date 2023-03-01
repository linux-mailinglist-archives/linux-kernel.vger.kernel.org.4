Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 404496A7413
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 20:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjCATKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 14:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjCATKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 14:10:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17F14D626
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 11:10:28 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3D50221AA0;
        Wed,  1 Mar 2023 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1677697827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbm6Hwho1WNEO+BzUCGTeM2WNbgC07zt/Pe/XjjbxP8=;
        b=UaLSUnMOLqw92deEICinMO9G+XAH3yoGNclRLm5drBrvf/iUP/BaAkuikou+RnmROklirn
        CTIPE/4Cef6BY69ssfeaxOrSF/IGA0DSvIuUZ+rYeop4PiLZRZPBIUshcg/jn19P60iVj4
        XfG3MCPEyo/z2i5Mxw/50DW+CRF6UUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1677697827;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbm6Hwho1WNEO+BzUCGTeM2WNbgC07zt/Pe/XjjbxP8=;
        b=r0USI+V0HHR4+6Q6kJq1fsby09KOrPDMJa5L46F5Objy/+KZ0gaNKXnLcZEHDMipRV2NsV
        g2zIL26UvUI3hIDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 174DD13A63;
        Wed,  1 Mar 2023 19:10:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +Oi+BCOj/2NcUwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Wed, 01 Mar 2023 19:10:27 +0000
Message-ID: <45eeb539-ed82-4984-197b-3f88cd765a59@suse.cz>
Date:   Wed, 1 Mar 2023 20:10:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [linus:master] [mm/mmap] 04241ffe3f:
 Kernel_panic-not_syncing:Fatal_exception
To:     "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
References: <202303010946.d35666d1-oliver.sang@intel.com>
 <20230301165036.mal6lkb6qhpjyz2r@revolver>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230301165036.mal6lkb6qhpjyz2r@revolver>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/23 17:50, Liam R. Howlett wrote:
> * kernel test robot <oliver.sang@intel.com> [230301 02:21]:
>> 
>> Greeting,
>> 
>> FYI, we noticed Kernel_panic-not_syncing:Fatal_exception due to commit (built with gcc-11):
>> 
>> commit: 04241ffe3f0458d54c61cf6c9d58d703efda4dd5 ("mm/mmap: introduce dup_vma_anon() helper")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>> 
>> [test failed on linus/master f3a2439f20d918930cc4ae8f76fe1c1afd26958f]
>> [test failed on linux-next/master 7f7a8831520f12a3cf894b0627641fad33971221]
> 
> I tracked the problem down in that commit.  The fix is simple enough:
> 
> -----------------
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -802,10 +802,13 @@ int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *vma,
>                          * If next doesn't have anon_vma, import from vma after
>                          * next, if the vma overlaps with it.
>                          */
> -                       if (remove != NULL && !next->anon_vma)
> +                       if (remove2 != NULL && !next->anon_vma)

Oh I actually did notice that one too, but as it was only temporary within
the series and already baked into git, thought there's no benefit in
pointing it out. A problem for bisect obviously as was just confirmed.

> ----------------
> 
> However, that will not fix the problem in linux-next or linus/master
> since this code is completely changed shortly after.
> 
> You need the fix from Vlastimil (Cc'ed).  After cherry-picking

> 07dc4b186203 ("mm/mremap: fix dup_anon_vma() in vma_merge() case 4") on

Which tree is that?
The mm-hotfixes-stable commit is here:
https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/commit/?h=mm-hotfixes-stable&id=4c6759967826b87f56c73e0f1deb7b76379ccd23

> top of linus/master, I don't get this particular failure anymore.
> 
> I do get the "kernel BUG at mm/filemap.c:155!", so it might be masking
> another problem. (Added Matthew to Cc)
> 
> I think the right thing to do is to include Vlastimil's fix.

Great, thanks.

> Thanks,
> Liam
> 
> ...
> 

