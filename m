Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FDB635A57
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 11:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbiKWKky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 05:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237333AbiKWKkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 05:40:19 -0500
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Nov 2022 02:24:21 PST
Received: from wedge010.net.lu.se (wedge010.net.lu.se [130.235.56.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A7D14F9F6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 02:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; d=control.lth.se; s=edge;
        c=relaxed/relaxed; t=1669198148; h=from:subject:to:date:message-id;
        bh=LOG11IkVuLSppmJk7o7Daf3tskCPuBJsXjz2PdvUY4c=;
        b=TH8BWLxRu1pBSr134K+7ELySd7uMzKb42vpZc7568ZF1eV296wF6wWE3+TBBzYYuPb50KfF2TPc
        0wGXAAFW5sTdKpYf2o0ab5NrYjdZYOvjETb+oDgJRy+FLjiiynwuyVfYiixd61r+BCbeCudIF5sK4
        j/NnB7pHx56RKtFiStXEs3JwDJleZrMc4+I4+0ybdXoAYiDWRSCGhOLt2KV5bT6aWhS+y4YQcyJGi
        SsvFesOF/Su6/Bf+wyD6zyx/CqKVkQaELiKZW9JcvwLkiVcA/Kw0KotRN+h7Y5Ql+C0xX56QNjim0
        /jiOarMwQb24VzrmBzIsT9JE3hO6fJQfpmsA==
Received: from wexc007.uw.lu.se (130.235.59.251) by mail.lu.se
 (130.235.56.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.1.2507.13; Wed, 23
 Nov 2022 11:09:07 +0100
Received: from [130.235.83.196] (130.235.139.100) by wexc007.uw.lu.se
 (130.235.59.251) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P521) id 15.1.2507.13; Wed, 23
 Nov 2022 11:08:47 +0100
Message-ID: <0abaa41e-79e1-3c0c-6d1b-47d4e21f2296@control.lth.se>
Date:   Wed, 23 Nov 2022 11:08:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: Kernel 6.0.5 breaks virtual machines that boot from nfs mounted
 qcow2 images
Content-Language: en-US
From:   Anders Blomdell <anders.blomdell@control.lth.se>
To:     <linux-nfs@vger.kernel.org>, Chuck Lever <chuck.lever@oracle.com>,
        "Jeff Layton" <jlayton@kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Anna Schumaker <anna@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Benjamin Coddington <bcodding@redhat.com>
References: <65115206-ec17-443e-8495-91661a2fd9be@control.lth.se>
In-Reply-To: <65115206-ec17-443e-8495-91661a2fd9be@control.lth.se>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [130.235.139.100]
X-ClientProxiedBy: wexc008.uw.lu.se (130.235.59.252) To wexc007.uw.lu.se
 (130.235.59.251)
X-CrossPremisesHeadersFilteredBySendConnector: wexc007.uw.lu.se
X-OrganizationHeadersPreserved: wexc007.uw.lu.se
Received-SPF: Pass (wedge010.net.lu.se: domain of
 anders.blomdell@control.lth.se designates 130.235.59.251 as permitted sender)
 receiver=wedge010.net.lu.se; client-ip=130.235.59.251; helo=wexc007.uw.lu.se;
X-CrossPremisesHeadersFilteredBySendConnector: wedge010.net.lu.se
X-OrganizationHeadersPreserved: wedge010.net.lu.se
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our problems turned out to be a fallout of Al Viros's splice rework, where nfsd reads with non-zero offsets and not ending
on a page boundary failed to remap the last page. I belive that this is a decent fix for that problem (tested on v6.1-rc6,
6.0.7 and 6.0.9)

---- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -873,7 +873,7 @@ nfsd_splice_actor(struct pipe_inode_info *pipe, struct pipe_buffer *buf,
         unsigned offset = buf->offset;
  
         page += offset / PAGE_SIZE;
-       for (int i = sd->len; i > 0; i -= PAGE_SIZE)
+       for (int i = sd->len + offset % PAGE_SIZE; i > 0; i -= PAGE_SIZE)
                 svc_rqst_replace_page(rqstp, page++);
         if (rqstp->rq_res.page_len == 0)        // first call
                 rqstp->rq_res.page_base = offset % PAGE_SIZE;

On 2022-11-11 20:35, Anders Blomdell wrote:
> The text below is an excerpt of  https://bugzilla.redhat.com/show_bug.cgi?id=2142132
> 
> Description of problem:
> 
> Virtual machines that boots from nfs mounted qcow2 images fails to boot when
> the nfs server runs kernel 6.0.5
> 
> The erros are often
> 
>    Booting from Hard Disk...
>    GRUB loading.
>    Welcome to GRUB!
> 
>    error ../../grub-core/kern/dl.c:ELF header smaller than expected.
>    Entering rescue mode...
>    grub rescue>
> 
> Version-Release number of selected component (if applicable):
> 
>    qemu-6.2.0-16.fc36.x86_64
>    kernel-6.0.5-200.fc36.x86_64
> 
> How reproducible:
> 
>    always
> 
> Steps to Reproduce:
> 1. Run a virtual machine with boot disk qcow2 formatted mounted from an nfs server
>     running kernel-6.0.5-200.fc36.x86_64
> 
> Actual results:
> 
> Machine fails to boot
> 
> Expected results:
> 
> Clean boot
> 
> Additional info:
> 
> Git repo is linux-stable
> 
> A git bisect lands me at 310d9d5a5009a93377200b98daa2d84aa2bd8160
> 
> So commit 746de1f86fcd works
> 
> But cherry picking f0f6b614f83d 310d9d5a5009 bfbfb6182ad1 on top of 746de1f86fcd is broken.
> 
> The bfbfb6182ad1 is picked due to the commit comment
> 
> commit bfbfb6182ad1d7d184b16f25165faad879147f79
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Sat Sep 10 22:14:02 2022 +0100
> 
>      nfsd_splice_actor(): handle compound pages
>      pipe_buffer might refer to a compound page (and contain more than a PAGE_SIZE
>      worth of data).  Theoretically it had been possible since way back, but
>      nfsd_splice_actor() hadn't run into that until copy_page_to_iter() change.
>      Fortunately, the only thing that changes for compound pages is that we
>      need to stuff each relevant subpage in and convert the offset into offset
>      in the first subpage.
>      Acked-by: Chuck Lever <chuck.lever@oracle.com>
>      Tested-by: Benjamin Coddington <bcodding@redhat.com>
>      Fixes: f0f6b614f83d "copy_page_to_iter(): don't split high-order page in case of ITER_PIPE"
>      Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> 
> The bisect I did:
> 
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [3829606fc5dffeccdf80aebeed3aa75255257f35] Linux 6.0.5
> git bisect bad 3829606fc5dffeccdf80aebeed3aa75255257f35
> # status: waiting for good commit(s), bad commit known
> # good: [0b0649b1d27a768d37f23acf4d88e6e90cca7856] Linux 5.19.4
> git bisect good 0b0649b1d27a768d37f23acf4d88e6e90cca7856
> # good: [0b0649b1d27a768d37f23acf4d88e6e90cca7856] Linux 5.19.4
> git bisect good 0b0649b1d27a768d37f23acf4d88e6e90cca7856
> # good: [3d7cb6b04c3f3115719235cc6866b10326de34cd] Linux 5.19
> git bisect good 3d7cb6b04c3f3115719235cc6866b10326de34cd
> # good: [7c5c3a6177fa9646884114fc7f2e970b0bc50dc9] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
> git bisect good 7c5c3a6177fa9646884114fc7f2e970b0bc50dc9
> # bad: [eeac7730418563152b0e3172bce9bac4ff6d6bc4] perf pmu-events: Avoid passing pmu_events_map
> git bisect bad eeac7730418563152b0e3172bce9bac4ff6d6bc4
> # good: [f20c95b46b8fa3ad34b3ea2e134337f88591468b] Merge tag 'tpmdd-next-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd
> git bisect good f20c95b46b8fa3ad34b3ea2e134337f88591468b
> # good: [c993e07be023acdeec8e84e2e0743c52adb5fc94] Merge tag 'dma-mapping-5.20-2022-08-06' of git://git.infradead.org/users/hch/dma-mapping
> git bisect good c993e07be023acdeec8e84e2e0743c52adb5fc94
> # good: [e2ebff9c57fe4eb104ce4768f6ebcccf76bef849] vfs: Check the truncate maximum size in inode_newsize_ok()
> git bisect good e2ebff9c57fe4eb104ce4768f6ebcccf76bef849
> # good: [c8a684e2e110376c58f0bfa30fb3855d1e319670] Merge tag 'leds-5.20-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds
> git bisect good c8a684e2e110376c58f0bfa30fb3855d1e319670
> # good: [c72687614b3627b3ea55d8d169e31cac70f56f3e] Merge tag 'rpmsg-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux
> git bisect good c72687614b3627b3ea55d8d169e31cac70f56f3e
> # bad: [f30adc0d332fdfe5315cb98bd6a7ff0d5cf2aa38] Merge tag 'pull-work.iov_iter-rebased' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
> git bisect bad f30adc0d332fdfe5315cb98bd6a7ff0d5cf2aa38
> # good: [60349fd52ecbb8b14545ff25aba2f2e230c4d618] remoteproc: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
> git bisect good 60349fd52ecbb8b14545ff25aba2f2e230c4d618
> # good: [8520008417c581c4c22e39597f92b9814ae34c31] fold __pipe_get_pages() into pipe_get_pages()
> git bisect good 8520008417c581c4c22e39597f92b9814ae34c31
> # good: [746de1f86fcd33464acac047f111eea877f2f7a0] pipe_get_pages(): switch to append_pipe()
> git bisect good 746de1f86fcd33464acac047f111eea877f2f7a0
> # good: [5d5d353bed32dc3ea52e2619e0d1c60b17133b91] Merge tag 'rproc-v5.20' of git://git.kernel.org/pub/scm/linux/kernel/git/remoteproc/linux
> git bisect good 5d5d353bed32dc3ea52e2619e0d1c60b17133b91
> # bad: [f0f6b614f83dbae99d283b7b12ab5dd2e04df979] copy_page_to_iter(): don't split high-order page in case of ITER_PIPE
> git bisect bad f0f6b614f83dbae99d283b7b12ab5dd2e04df979
> # bad: [310d9d5a5009a93377200b98daa2d84aa2bd8160] expand those iov_iter_advance()...
> git bisect bad 310d9d5a5009a93377200b98daa2d84aa2bd8160
> # first bad commit: [310d9d5a5009a93377200b98daa2d84aa2bd8160] expand those iov_iter_advance()...
> 
> 

-- 
Anders Blomdell                  Email: anders.blomdell@control.lth.se
Department of Automatic Control
Lund University                  Phone:    +46 46 222 4625
P.O. Box 118
SE-221 00 Lund, Sweden
