Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9312B737AFB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjFUF4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 01:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjFUF4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 01:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB51CA;
        Tue, 20 Jun 2023 22:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB13661472;
        Wed, 21 Jun 2023 05:56:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24983C433C8;
        Wed, 21 Jun 2023 05:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687326995;
        bh=US3Xe7yz1+AVCinByPs1eOKpdoQy+FtobpB/5DLulWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ApWBaV3TgZW9WTYCyLlgF0j+nqO+nqmitwslpm8g44yprfBubzuc/R2N7ybTRvLh/
         Ns2uFpGWP95Ae6rWEKexoj9fyhiRxZA/wLLqVZFEM73cbQIxwPlddy3soGTxo8yvU+
         KmhjFIivoFQ3qB5ah+k5e8Gio3hzQKnNmch9z4ONG0+pLoezU4BG4f+2eIC028XG9j
         utIhP2VICtz5KV8tRvjIeDWimNFy4DzoSprB2oAuTb+YWOSZbTF0QLt2bsSZrnA02M
         1XRU1qkVxPK3DQN1U2NTHyiuI13Tc/yQ9JPpS4V1ZAVmfzUQehSI+M00JtumYmXzHB
         sFdwPG5FVkIVw==
Date:   Wed, 21 Jun 2023 08:55:51 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Jeff Xu <jeffxu@chromium.org>
Cc:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, zhangpeng.00@bytedance.com,
        akpm@linux-foundation.org, koct9i@gmail.com, david@redhat.com,
        ak@linux.intel.com, hughd@google.com, emunson@akamai.com,
        rppt@linux.ibm.com, aarcange@redhat.com,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: inconsistence in mprotect_fixup mlock_fixup madvise_update_vma
Message-ID: <20230621055551.GE52412@kernel.org>
References: <CABi2SkWx_BnEHzGqqqbDMJi+vi-5a7XkQUCkyesN5PUtk23SgQ@mail.gmail.com>
 <CABi2SkXw6ZD-M1ZrcXNL7abtM=RzQXv716PPM_k=1Tay=5rUFA@mail.gmail.com>
 <ZIjOlU5EfVNt6NRU@x1n>
 <CABi2SkXE4pUhHucZ_c-_4Ux-VcLKic0+HY_DN2wUEC6DGkDvQQ@mail.gmail.com>
 <20230614011814.sz2l6z6wbaubabk2@revolver>
 <20230614125731.GY52412@kernel.org>
 <CABi2SkXySaoRxB0dfhhTQz6P5jCL8iWpY_ti=LC7Qi49+2F01w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABi2SkXySaoRxB0dfhhTQz6P5jCL8iWpY_ti=LC7Qi49+2F01w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 03:29:34PM -0700, Jeff Xu wrote:
> On Wed, Jun 14, 2023 at 5:58 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > On Tue, Jun 13, 2023 at 09:18:14PM -0400, Liam R. Howlett wrote:
> > > * Jeff Xu <jeffxu@chromium.org> [230613 17:29]:
> > > > Hello Peter,
> > > >
> > > > Thanks for responding.
> > > >
> > > > On Tue, Jun 13, 2023 at 1:16 PM Peter Xu <peterx@redhat.com> wrote:
> > > > >
> > > > > Hi, Jeff,
> > > > >
> > > > > On Tue, Jun 13, 2023 at 08:26:26AM -0700, Jeff Xu wrote:
> > > > > > + more ppl to the list.
> > > > > >
> > > > > > On Mon, Jun 12, 2023 at 6:04 PM Jeff Xu <jeffxu@chromium.org> wrote:
> > > > > > >
> > > > > > > Hello,
> > > > > > >
> > > > > > > There seems to be inconsistency in different VMA fixup
> > > > > > > implementations, for example:
> > > > > > > mlock_fixup will skip VMA that is hugettlb, etc, but those checks do
> > > > > > > not exist in mprotect_fixup and madvise_update_vma. Wouldn't this be a
> > > > > > > problem? the merge/split skipped by mlock_fixup, might get acted on in
> > > > > > > the madvice/mprotect case.
> > > > > > >
> > > > > > > mlock_fixup currently check for
> > > > > > > if (newflags == oldflags ||
> > >
> > > newflags == oldflags, then we don't need to do anything here, it's
> > > already at the desired mlock.  mprotect does this, madvise does this..
> > > probably.. it's ugly.
> > >
> > > > > > > (oldflags & VM_SPECIAL) ||
> > >
> > > It's special, merging will fail always.  I don't know about splitting,
> > > but I guess we don't want to alter the mlock state on special mappings.
> > >
> > > > > > > is_vm_hugetlb_page(vma) || vma == get_gate_vma(current->mm) ||
> > > > > > > vma_is_dax(vma) || vma_is_secretmem(vma))
> > > > >
> > > > > The special handling you mentioned in mlock_fixup mostly makes sense to me.
> > > > >
> > > > > E.g., I think we can just ignore mlock a hugetlb page if it won't be
> > > > > swapped anyway.
> > > > >
> > > > > Do you encounter any issue with above?
> > > > >
> > > > > > > Should there be a common function to handle VMA merge/split ?
> > > > >
> > > > > IMHO vma_merge() and split_vma() are the "common functions".  Copy Lorenzo
> > > > > as I think he has plan to look into the interface to make it even easier to
> > > > > use.
> > > > >
> > > > The mprotect_fixup doesn't have the same check as mlock_fixup. When
> > > > userspace calls mlock(), two VMAs might not merge or split because of
> > > > vma_is_secretmem check, However, when user space calls mprotect() with
> > > > the same address range, it will merge/split.  If mlock() is doing the
> > > > right thing to merge/split the VMAs, then mprotect() is not ?
> > >
> > > It looks like secretmem is mlock'ed to begin with so they don't want it
> > > to be touched.  So, I think they will be treated differently and I think
> > > it is correct.
> >
> > Right, they don't :)
> >
> > secretmem VMAs are always mlocked, they cannot be munlocked and there is no
> > point trying to mlock them again.
> >
> > The mprotect for secretmem is Ok though, so e.g. if we (unlikely) have two
> > adjacent secretmem VMAs in a range passed to mprotect, it's fine to merge
> > them.
> >
> 
> I m thinking/brainstorming below, assuming:
> Address range 1: 0x5000 to 0x6000 (regular mmap)
> Address range 2: 0x6000 to 0x7000 (allocated to secretmem)
> Address range 3: 0x7000 to 0x8000 (regular mmap)
> 
> User space call: mlock(0x5000,0x3000)
> range 1 and 2 won't merge.
> range 2 and 3  could merge, when mlock_fixup  checks current vma
> (range 3), it is not secretmem, so it will merge with prev vma.

But 2 and 3 have different vm_file, they won't merge.
 
> user space call: mprotect(0x5000,0x3000)
> range 1 2 3 could merge,  all three can have the same flags.
> Note: vma_is_secretmem() isn't checked in mprotect_fixup, same for
> vma_is_dax and get_gate_vma, those doesn't have included in
> vma->vm_flags
> 
> Once 1 and 2 are merged, maybe user space is able to use
> munlock(0x5000,0x3000)
> to unlock range 1 to 3, this will include 2, right ? (haven't used the
> code to prove it)

But 1 and 2 won't merge because their vm_file's are different.
 
> I'm using secretmem as an example here, having 3 different _fixup
> implementations seems to be error prone to me.

The actual decision whether to merge VMAs is taken in vma_merge rather than
by the _fixup functions. So while the checks around vma_merge might be
different in these functions, it does not mean it's possible to wrongly
merge VMA unless there is a bug in vma_merge. So in the end it boils down
to a single core implementation, don't you agree?
 
> Thanks
> -Jeff

-- 
Sincerely yours,
Mike.
