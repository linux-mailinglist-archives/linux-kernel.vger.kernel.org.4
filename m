Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07AD26E311D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 13:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjDOL1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 07:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDOL1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 07:27:18 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30244239
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 04:27:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id eo6-20020a05600c82c600b003ee5157346cso13138826wmb.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 04:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681558035; x=1684150035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kd5MmsBf8CECOG+Q9e/Du3+V2fqX2JlI3U1aqIIAEq4=;
        b=OSRc51dSXShNWcrdH8P6Yp8aRMcnt9EgoPr1Fux06iyeQoPYk+eloqkVagMAcYv51T
         irO091w875QoIpII5MxmxC1CfX/+zbHuFY8u1PhBMBXuLlFA8YICayrxSz2oju3CNMe8
         GmuWbDMP+gmrmtDwTsw60uG/7FDvuJSor/ZpOfnQnmo0IO+CeIfSpVuQoaCKGuVMsWzL
         lWoGZ4AKoFrRJOS9S8FXA26++lbpOvMuMPCWwzLckkQ1R0aTm3+ewkwzOxI+mvo25tdK
         8ICNTx+cW5RUsc1OEPbDS7PkpwPqwgtScLucMr+1ARPmpw5WbYcoN2Lm4caS3Qo/2ILa
         jXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681558035; x=1684150035;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kd5MmsBf8CECOG+Q9e/Du3+V2fqX2JlI3U1aqIIAEq4=;
        b=D2FOfWRsN/lTzDrvRA72fWuYJJhqbj+BaApzrDa14DKNkXYJBn42sDKLxUdXM5wp1O
         cepAjrdeHm8VEOMfXPojI9l6KPnWyMuimAFGg4hEi5Q7EhZP+YAx3VhcfQZc/HYmWgf6
         Mt4lsdWN6+eOH5lgbNfGjW83kOMy9JvFhZTe5QwCdkrVaXUzVcTa6xd/Ft673jNhd/ba
         W8ZpqkjLOg87zFDzqNIzg6NxZOsbZlPjXI1tbijD2z3ZlAdWVbjSxyc0TtgXtewTesnW
         RfjS36WHDdRgFR39d68TpNPImf/kKm7ysrcjm2tHFYMiN1HlEjOYVFX89M7OWvJ6BZLo
         o37g==
X-Gm-Message-State: AAQBX9fX1FRADP0IpOgQ/DoU4Uz5jB8/GS/dR5q7F/OZkyQ6eIUjaXCm
        mrLm+KsetTJNxVCYaPaJEiYkAKKDg5AUvw==
X-Google-Smtp-Source: AKy350b8KNVDjCd9ld2enXCO8Ye/49/7l9oDn3EwLZPpm5PiEJizPJcXT6oNmYsWQO8ACXyDgI5Pxg==
X-Received: by 2002:a7b:cb8b:0:b0:3f1:65f6:a69 with SMTP id m11-20020a7bcb8b000000b003f165f60a69mr1401318wmi.0.1681558035053;
        Sat, 15 Apr 2023 04:27:15 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id c9-20020a05600c0a4900b003ee6aa4e6a9sm10306776wmq.5.2023.04.15.04.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 04:27:13 -0700 (PDT)
Date:   Sat, 15 Apr 2023 12:27:13 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] mm/gup: remove vmas parameter from
 get_user_pages_remote()
Message-ID: <64ae6557-0e46-48a8-badd-af8993645330@lucifer.local>
References: <cover.1681547405.git.lstoakes@gmail.com>
 <631001ecc556c5e348ff4f47719334c31f7bd592.1681547405.git.lstoakes@gmail.com>
 <b4706369-f97c-8b78-f194-b45a870114e1@I-love.SAKURA.ne.jp>
 <63d92734-2185-439c-bbc7-53a4720f5d4a@lucifer.local>
 <65e79cf8-8713-4d2d-7a50-76d7e2aa454a@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65e79cf8-8713-4d2d-7a50-76d7e2aa454a@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 07:36:06PM +0900, Tetsuo Handa wrote:
> On 2023/04/15 19:14, Lorenzo Stoakes wrote:
> > On Sat, Apr 15, 2023 at 06:52:41PM +0900, Tetsuo Handa wrote:
> >> On 2023/04/15 18:08, Lorenzo Stoakes wrote:
> >>> @@ -475,10 +474,14 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >>>  		gup_flags |= FOLL_SPLIT_PMD;
> >>>  	/* Read the page with vaddr into memory */
> >>>  	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags,
> >>> -				    &old_page, &vma, NULL);
> >>> +				    &old_page, NULL);
> >>>  	if (ret <= 0)
> >>>  		return ret;
> >>>
> >>> +	vma = vma_lookup(mm, vaddr);
> >>> +	if (!vma)
> >>> +		goto put_old;
> >>> +
> >>>  	ret = verify_opcode(old_page, vaddr, &opcode);
> >>>  	if (ret <= 0)
> >>>  		goto put_old;
> >>
> >> This conversion looks wrong.
> >> This causes returning a positive number when vma_lookup() returned NULL.
> >>
> >>   * Return 0 (success) or a negative errno.
> >>
> > 
> > In reality it shouldn't be possible for vma to return NULL, I'm adding the
> > checks to be extra careful.
> > 
> > In any case you're right, attaching a -fix patch to avoid spam:-
> 
> If you want to return -EINVAL when vma_lookup() returned NULL for whatever
> unexpected reason, returning -EOPNOTSUPP in below path looks strange.
>

This feels a little pedantic, this is not a condition that is expected to
occur in practice, I'm not sure users will be writing code to differentiate
between the two, and certainly vma being NULL implies MTE is not supported.

To differentiate with minimal churn, I'll add a WARN_ON_ONCE() here and in
each other case where an impossible condition arises as it would be
indicative of a kernel bug.

> > @@ -448,7 +448,8 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
> >  		 * would cause the existing tags to be cleared if the page
> >  		 * was never mapped with PROT_MTE.
> >  		 */
> > -		if (!(vma->vm_flags & VM_MTE)) {
> > +		vma = vma_lookup(mm, addr);
> > +		if (!vma || !(vma->vm_flags & VM_MTE)) {
> >  			ret = -EOPNOTSUPP;
> >  			put_page(page);
> >  			break;
> 
> Also,
> 
> > @@ -5591,7 +5591,9 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
> >  		struct page *page = NULL;
> >  
> >  		ret = get_user_pages_remote(mm, addr, 1,
> > -				gup_flags, &page, &vma, NULL);
> > +				gup_flags, &page, NULL);
> > +		vma = vma_lookup(mm, addr);
> > +
> >  		if (ret <= 0) {
> >  #ifndef CONFIG_HAVE_IOREMAP_PROT
> >  			break;
> > @@ -5600,7 +5602,6 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
> >  			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
> >  			 * we can access using slightly different code.
> >  			 */
> > -			vma = vma_lookup(mm, addr);
> >  			if (!vma)
> >  				break;
> >  			if (vma->vm_ops && vma->vm_ops->access)
> > @@ -5617,11 +5618,11 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
> >  				bytes = PAGE_SIZE-offset;
> >  
> >  			maddr = kmap(page);
> > -			if (write) {
> > +			if (write && vma) {
> >  				copy_to_user_page(vma, page, addr,
> >  						  maddr + offset, buf, bytes);
> >  				set_page_dirty_lock(page);
> > -			} else {
> > +			} else if (vma) {
> >  				copy_from_user_page(vma, page, addr,
> >  						    buf, maddr + offset, bytes);
> >  			}
> 
> not calling copy_{from,to}_user_page() if vma == NULL is not sufficient for
> propagating an error to caller.
> 

This is a product of wanting to avoid churn, again this condition is simply
impossible. Also as a pedantic side note - the loop explicitly indicates no
errors are propagated, so there is no need to do so.

However, I want to be consistent with how I handle this and also I think
it's sensible to add warnings for violation of this 'impossible' condition
so I'll add a branch for it.

Since I'd end up confusingly fixing up a fix-patch (and I want to change
another patch in series to be consistent), I'll do a respin, apologies for
spam in advance...
