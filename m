Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8D76D4949
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjDCOgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjDCOgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:36:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF91E58
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680532548;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cP+bGhDlk17abfeJRcbu/Vx3+Nezj9s5bVdauklB/8Q=;
        b=fOyBMqc+ENNZ7W97GkBGk+GjEUltgRsi+Dt8PAtfZUW7iN6DEB82FI03L8HysmY38a3MXP
        /XPXvRibX5v9MwMZ6IiFrWCsyCzmdz8Eyw3FiV1cnrTfkG7ihZKMPpLVxPC1migFdnyLid
        eLmPQajN1EF/BZ/xZckyZ8i7XgJnnTQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-kXwApEh3NracL8aTR_vbkw-1; Mon, 03 Apr 2023 10:35:47 -0400
X-MC-Unique: kXwApEh3NracL8aTR_vbkw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 744272A5954F;
        Mon,  3 Apr 2023 14:35:46 +0000 (UTC)
Received: from rotkaeppchen (unknown [10.39.192.158])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 612E21121315;
        Mon,  3 Apr 2023 14:35:45 +0000 (UTC)
Date:   Mon, 3 Apr 2023 16:35:40 +0200
From:   Philipp Rudo <prudo@redhat.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH v3] kexec: Support purgatories with .text.hot sections
Message-ID: <20230403163540.4f597d50@rotkaeppchen>
In-Reply-To: <CANiDSCtu8oOn9vV9eak=S2RDVVO9yan2BO8K5ia9jALABqiwjQ@mail.gmail.com>
References: <20230321-kexec_clang16-v3-0-5f016c8d0e87@chromium.org>
        <20230324165855.23084947@rotkaeppchen>
        <CANiDSCtu8oOn9vV9eak=S2RDVVO9yan2BO8K5ia9jALABqiwjQ@mail.gmail.com>
Organization: Red Hat inc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

sorry for the late reply...

On Mon, 27 Mar 2023 13:52:08 +0200
Ricardo Ribalda <ribalda@chromium.org> wrote:

[...]

> 
> I tried removing the -r from arch/x86/purgatory/Makefile and that resulted into:
> 
> [  115.631578] BUG: unable to handle page fault for address: ffff93224d5c8e20
> [  115.631583] #PF: supervisor write access in kernel mode
> [  115.631585] #PF: error_code(0x0002) - not-present page
> [  115.631586] PGD 100000067 P4D 100000067 PUD 1001ed067 PMD 132b58067 PTE 0
> [  115.631589] Oops: 0002 [#1] PREEMPT SMP NOPTI
> [  115.631592] CPU: 0 PID: 5291 Comm: kexec-lite Tainted: G     U
>       5.15.103-17399-g852a928df601-dirty #19
> cd159e0d6a91f03e06035a0a8eb7fc984a8f3e82
> [  115.631594] Hardware name: Google Crota/Crota, BIOS
> Google_Crota.14505.288.0 11/08/2022
> [  115.631595] RIP: 0010:memcpy_erms+0x6/0x10
> [  115.631599] Code: 5d 00 eb bd eb 1e 0f 1f 00 48 89 f8 48 89 d1 48
> c1 e9 03 83 e2 07 f3 48 a5 89 d1 f3 a4 c3 cc cc cc cc 66 90 48 89 f8
> 48 89 d1 <f3> a4 c3 cc cc cc cc 0f 1f 00 48 89 f8 48 83 fa 20 72 7e 40
> 38 fe
> [  115.631601] RSP: 0018:ffff93224f65fe50 EFLAGS: 00010246
> [  115.631602] RAX: ffff93224d5c8e20 RBX: 00000000ffffffea RCX: 0000000000000100
> [  115.631603] RDX: 0000000000000100 RSI: ffff9322407bd000 RDI: ffff93224d5c8e20
> [  115.631604] RBP: ffff93224f65fe88 R08: 0000000000000000 R09: ffff92133cd3ef08
> [  115.631605] R10: ffff9322407be000 R11: ffffffffa1b4f2e0 R12: 0000000000000000
> [  115.631606] R13: ffff92133cee4c00 R14: 0000000000000100 R15: ffffffffa2b6f14f
> [  115.631607] FS:  000078e8b9dbf7c0(0000) GS:ffff921437800000(0000)
> knlGS:0000000000000000
> [  115.631609] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  115.631610] CR2: ffff93224d5c8e20 CR3: 000000015be26001 CR4: 0000000000770ef0
> [  115.631611] PKRU: 55555554
> [  115.631612] Call Trace:
> [  115.631614]  <TASK>
> [  115.631615]  kexec_purgatory_get_set_symbol+0x82/0xd3
> [  115.631619]  __se_sys_kexec_file_load+0x523/0x644
> [  115.631621]  do_syscall_64+0x58/0xa5
> [  115.631623]  entry_SYSCALL_64_after_hwframe+0x61/0xcb

Yeah, simply dropping -r doesn't work. You at least need to add -fPIE
to the CFLAGS. But probably you need more. When you go down this route
you really need to pay attention to some nasty details...

> And I did not continue in that direction.

That's totally fine.

Thanks
Philipp

> I also tried finding a flag for llvm that would avoid splitting .text,
> but was not lucky either.
> 
> I will look into making a linker script for x86, we could combine it
> with something like:
> 
>                 if (sechdrs[i].sh_flags & SHF_EXECINSTR &&
>                     pi->ehdr->e_entry >= sechdrs[i].sh_addr &&
>                     pi->ehdr->e_entry < (sechdrs[i].sh_addr
> -                                        + sechdrs[i].sh_size) &&
> -                   kbuf->image->start == pi->ehdr->e_entry) {
> -                       kbuf->image->start -= sechdrs[i].sh_addr;
> -                       kbuf->image->start += kbuf->mem + offset;
> +                                        + sechdrs[i].sh_size)) {
> +                       if (!WARN_ON(kbuf->image->start != pi->ehdr->e_entry)) {
> +                               kbuf->image->start -= sechdrs[i].sh_addr;
> +                               kbuf->image->start += kbuf->mem + offset;
> +                       }
>                 }
> 
> So developers have some hints of what to look at.
> 
> Thanks!
> 
> 
> >
> > Thanks
> > Philipp
> >  
> > >                       kbuf->image->start -= sechdrs[i].sh_addr;
> > >                       kbuf->image->start += kbuf->mem + offset;
> > >               }
> > >
> > > ---
> > > base-commit: 17214b70a159c6547df9ae204a6275d983146f6b
> > > change-id: 20230321-kexec_clang16-4510c23d129c
> > >
> > > Best regards,  
> >  
> 
> 

