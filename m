Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3A16E3096
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 12:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjDOKgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 06:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDOKgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 06:36:20 -0400
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3474EDE
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 03:36:18 -0700 (PDT)
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 33FAa749075332;
        Sat, 15 Apr 2023 19:36:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Sat, 15 Apr 2023 19:36:07 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 33FAa7LV075329
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 15 Apr 2023 19:36:07 +0900 (JST)
        (envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <65e79cf8-8713-4d2d-7a50-76d7e2aa454a@I-love.SAKURA.ne.jp>
Date:   Sat, 15 Apr 2023 19:36:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/7] mm/gup: remove vmas parameter from
 get_user_pages_remote()
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1681547405.git.lstoakes@gmail.com>
 <631001ecc556c5e348ff4f47719334c31f7bd592.1681547405.git.lstoakes@gmail.com>
 <b4706369-f97c-8b78-f194-b45a870114e1@I-love.SAKURA.ne.jp>
 <63d92734-2185-439c-bbc7-53a4720f5d4a@lucifer.local>
From:   Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <63d92734-2185-439c-bbc7-53a4720f5d4a@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/04/15 19:14, Lorenzo Stoakes wrote:
> On Sat, Apr 15, 2023 at 06:52:41PM +0900, Tetsuo Handa wrote:
>> On 2023/04/15 18:08, Lorenzo Stoakes wrote:
>>> @@ -475,10 +474,14 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
>>>  		gup_flags |= FOLL_SPLIT_PMD;
>>>  	/* Read the page with vaddr into memory */
>>>  	ret = get_user_pages_remote(mm, vaddr, 1, gup_flags,
>>> -				    &old_page, &vma, NULL);
>>> +				    &old_page, NULL);
>>>  	if (ret <= 0)
>>>  		return ret;
>>>
>>> +	vma = vma_lookup(mm, vaddr);
>>> +	if (!vma)
>>> +		goto put_old;
>>> +
>>>  	ret = verify_opcode(old_page, vaddr, &opcode);
>>>  	if (ret <= 0)
>>>  		goto put_old;
>>
>> This conversion looks wrong.
>> This causes returning a positive number when vma_lookup() returned NULL.
>>
>>   * Return 0 (success) or a negative errno.
>>
> 
> In reality it shouldn't be possible for vma to return NULL, I'm adding the
> checks to be extra careful.
> 
> In any case you're right, attaching a -fix patch to avoid spam:-

If you want to return -EINVAL when vma_lookup() returned NULL for whatever
unexpected reason, returning -EOPNOTSUPP in below path looks strange.

> @@ -448,7 +448,8 @@ static int __access_remote_tags(struct mm_struct *mm, unsigned long addr,
>  		 * would cause the existing tags to be cleared if the page
>  		 * was never mapped with PROT_MTE.
>  		 */
> -		if (!(vma->vm_flags & VM_MTE)) {
> +		vma = vma_lookup(mm, addr);
> +		if (!vma || !(vma->vm_flags & VM_MTE)) {
>  			ret = -EOPNOTSUPP;
>  			put_page(page);
>  			break;

Also,

> @@ -5591,7 +5591,9 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
>  		struct page *page = NULL;
>  
>  		ret = get_user_pages_remote(mm, addr, 1,
> -				gup_flags, &page, &vma, NULL);
> +				gup_flags, &page, NULL);
> +		vma = vma_lookup(mm, addr);
> +
>  		if (ret <= 0) {
>  #ifndef CONFIG_HAVE_IOREMAP_PROT
>  			break;
> @@ -5600,7 +5602,6 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
>  			 * Check if this is a VM_IO | VM_PFNMAP VMA, which
>  			 * we can access using slightly different code.
>  			 */
> -			vma = vma_lookup(mm, addr);
>  			if (!vma)
>  				break;
>  			if (vma->vm_ops && vma->vm_ops->access)
> @@ -5617,11 +5618,11 @@ int __access_remote_vm(struct mm_struct *mm, unsigned long addr, void *buf,
>  				bytes = PAGE_SIZE-offset;
>  
>  			maddr = kmap(page);
> -			if (write) {
> +			if (write && vma) {
>  				copy_to_user_page(vma, page, addr,
>  						  maddr + offset, buf, bytes);
>  				set_page_dirty_lock(page);
> -			} else {
> +			} else if (vma) {
>  				copy_from_user_page(vma, page, addr,
>  						    buf, maddr + offset, bytes);
>  			}

not calling copy_{from,to}_user_page() if vma == NULL is not sufficient for
propagating an error to caller.

