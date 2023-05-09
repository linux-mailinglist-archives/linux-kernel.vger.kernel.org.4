Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D276FBC69
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 03:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbjEIBS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 21:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEIBSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 21:18:55 -0400
Received: from pku.edu.cn (mx18.pku.edu.cn [162.105.129.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0286E4C11;
        Mon,  8 May 2023 18:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:Date:From:To:Cc:Subject:
        Message-ID:References:MIME-Version:Content-Type:
        Content-Disposition:Content-Transfer-Encoding:In-Reply-To; bh=xj
        bIFdYA7ZLprFEPKvqLjiDfPiU+1R5Mk42cfin4h/Q=; b=WbMwtobwt590XE+dzh
        IeLxtinZTW5dxH1VZtgmW0nJKYcFZwCFNLxCZK0TcQa8v6ldiawiQunedj/NxO49
        cxDC4QO7CEYcxzdLxNZHf4Y0lLBAf/RDrs4WsBOR/Jt6nIXsBX8IKjE4hBlL7tG0
        diZZkFUnN+FeQLbuAEztlQhAo=
Received: from localhost (unknown [10.7.101.92])
        by front01 (Coremail) with SMTP id 5oFpogCXHz5Wn1lkGk5PAg--.4269S2;
        Tue, 09 May 2023 09:18:18 +0800 (CST)
Date:   Tue, 9 May 2023 09:18:14 +0800
From:   Ruihan Li <lrh2000@pku.edu.cn>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        syzbot+fcf1a817ceb50935ce99@syzkaller.appspotmail.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Ruihan Li <lrh2000@pku.edu.cn>
Subject: Re: usbdev_mmap causes type confusion in page_table_check
Message-ID: <cyexilogx5xvdne6f2uoxbvir7i5mqykpzbbg27x4l2qnlxksg@f5xqssrqanzq>
References: <CA+CK2bBe2YKYM3rUTCnZ0RF=NFUR9VqO-QYn3ygPsFJWLY1MUA@mail.gmail.com>
 <ZFlrbDft1QfMyIDc@casper.infradead.org>
 <CA+CK2bDVjovwB9v-Zv4Fn7EUfp5FV2XK36iJKYKY7pYNOFfOGA@mail.gmail.com>
 <ZFlvJEfs1ufh1UUD@casper.infradead.org>
 <CA+CK2bDC-FVv1tZg9MDn-N735Ak3OAtdZPf+LEYM-JHsO90YcQ@mail.gmail.com>
 <fa1dac7a-406e-30ea-6aba-ded2e0e871fa@redhat.com>
 <CA+CK2bAHbHHwLUoGJkz8n6mrM5dy7oMojeNksdVOMYn+qFYngA@mail.gmail.com>
 <CA+CK2bD=bv1vPGZaNcxDy-uUFj2ZAKkdPmAtJaweXhgTe91oEw@mail.gmail.com>
 <366ab078-1101-421c-691d-34f5efe006b5@redhat.com>
 <CA+CK2bBwYGd2_CVQ4Nr87CGEjp7BqVbBeoP++yHB7Cr9_peBOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bBwYGd2_CVQ4Nr87CGEjp7BqVbBeoP++yHB7Cr9_peBOQ@mail.gmail.com>
X-CM-TRANSID: 5oFpogCXHz5Wn1lkGk5PAg--.4269S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr48Jr4Dtr1kCr4rXr43Jrb_yoW5uFyxpa
        y3t3W7Crs8GFn8X34qvwn5ZryFyrs3X3y8Xrn8X3s8C3s8trySkr1Syr12va4akrWfA3Wj
        vFWYga4rAay5Aa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6c
        xK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr
        1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
        jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
        x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
        8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
        0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUOlksUUUUU
X-CM-SenderInfo: yssqiiarrvmko6sn3hxhgxhubq/1tbiAgEEBVPy770DbwAPsS
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the discussion!

On Mon, May 08, 2023 at 05:07:26PM -0700, Pasha Tatashin wrote:
> On Mon, May 8, 2023 at 4:37 PM David Hildenbrand <david@redhat.com> wrote:
> >
> > On 09.05.23 01:21, Pasha Tatashin wrote:
> > >> For normal Kernel-MM operations, vm_normal_page() should be used to
> > >> get "struct page" based on vma+addr+pte combination, but
> > >> page_table_check does not use vma for its operation in order to
> > >> strengthen the verification of no invalid page sharing. But, even
> >
> > I'm not sure if that's the right approach for this case here, though.
> >
> > >> vm_normal_page() can cause access to the "struct page" for VM_PFNMAP
> > >> if pfn_valid(pfn) is true. So, vm_normal_page() can return a struct
> > >> page for a user mapped slab page.
> > >
> > > Only for !ARCH_HAS_PTE_SPECIAL case, otherwise NULL is returned.
> >
> > That would violate VM_PFNMAP semantics, though. I remember that there
> > was a trick to it.
> >
> > Assuming we map /dev/mem, what stops a page we mapped and determined to
> > be !anon to be freed and reused, such that we suddenly have an anon page
> > mappped?
> >
> > In that case, we really don't want to look at the "struct page" ever, no?
> 
> Good point. page_table_check just does not work well /dev/mem. I am
> thinking of adding BUG_ON(PageSlab(page); and also "depends on
> !DEVMEM" for the PAGE_TABLE_CHECK config option.
> 
> Pasha

Agreed. I have previously thought about using something like
	anon = !PageSlab(page) && PageAnon(page);
or
	BUG(PageSlab(page))
in page_table_check_*. But this just does not work well with /dev/mem,
and cannot be made to work unless something like VM_PFNMAP is involved.
The reason is that both PageSlab(page) and PageAnon(page) can evaluate
to different values when mapping and unmapping the same page, since the
page number can be totally arbitrary.

But if we do not want /dev/mem to work with PAGE_TABLE_CHECK, this is
what I doubted and Pasha confirmed earlier,

On Mon, May 08, 2023 at 05:27:10PM -0400, Pasha Tatashin wrote:
> On Sun, May 7, 2023 at 9:58 AM Ruihan Li <lrh2000@pku.edu.cn> wrote:
> > This does not actually fix the type confusion bug in page_table_check_*. It
> > should be noted that by leveraging /dev/mem, users can map arbitrary physical
> > memory regions into the user space, which is also achieved through
> > remap_pfn_range. I'm not 100% certain whether a fix is necessary, as one may
> > argue that using page table checks (a kernel hardening technique, which means
> > security is important) and /dev/mem (clearly insecure and potentially
> 
> Yes, /dev/mem device is a security problem, and would not work with a
> hardern kernel.
> 
> > exploitable) together is completely unreasonable.

we should enforce this explicitly (and perhaps document it explicitly as
well), and the exact way to do this is to make the PAGE_TABLE_CHECK
config option dependent on !DEVMEM.

This also implies that we must fix hcd_buffer_alloc on the usb side as
well. I am also not sure if there are other uses of remap_pfn_range on
slab pages (as David asked earlier) besides usbfs and /dev/mem. Maybe
the calls to remap_pfn_range (and other functions that can map the
userspace memory?) need to be manually checked one by one. But later I
can first try this approach at least, and see if anything goes wrong
(though unlikely).

Thanks,
Ruihan Li

