Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BAA62886F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiKNSjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiKNSji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:39:38 -0500
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A289324BC4;
        Mon, 14 Nov 2022 10:39:36 -0800 (PST)
Received: by mail-vk1-xa2f.google.com with SMTP id e2so5396619vkd.13;
        Mon, 14 Nov 2022 10:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fBD1OWmrjBsMLFUG5eOKvkR0gk9oq/LI0JbXvTfwkno=;
        b=cJBaxGwNsvY2BSv/vJg95TnFLkko4G1FkWpSb5Tt4I/9qGPf9HHIv97U/7S81+yeAB
         m+T9P4pv7e24Vh6+TRBoXLcGlU9Utl6qWWlRQrs+PlnUhEq9+vdmbeibi5trIJb4HRJT
         cmRf1ni9QZ5aZuKns9eGU2rT6vmx7LnOGXF+rWzMTJ4REsM6VUM/qiX05zX3CfvYwgEZ
         1fxkzniGV3IMc9+TGS0HNG/xOcKAWUwvWJ6B457NHVTziU/yc/iRKtIeBRHDyzGr3XD/
         teqsw1WG04Tj0whZdCWzzz12jp3ytaOm62LxQngq+qDXHZXPsqYj/RM1VUZ+ToDm7IKg
         J+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fBD1OWmrjBsMLFUG5eOKvkR0gk9oq/LI0JbXvTfwkno=;
        b=p6z+H9tO5ssdUg8EEW/Gh41Fx+zYkN7UHv9qdGzlGtl555Zb0zvXho8RnDIXZ6k8Sk
         1Uf2vA0gxL6rYyDlAX0aqFB3SVvoxE7nr4Av8310NhLuo9hMK3vrHFU2+9Ojr0CFRD0e
         kfQ0GltLZMLkON2n0vc7FMJC4Phgv3tVkVZtWtizUJT/0izGnOIe2Pk+aIwbSid1wRwT
         87YdRkeftMF9ld2AKdVE0ZDqIC1WxKjMHAf85wnwi2aNSmX8ZcMz4iHBgHTkrp3plVhi
         7S0hrWEaxmqdYH5pdzm039XUoRet7gbEAYhI5CrSMrbtZK3oJT4jAOJIsUst2I93szEo
         4IHQ==
X-Gm-Message-State: ANoB5pmPx5t76MLuzB07H4TzqSj0tFup3LZVCHaMLrzlyqze2uvgMb/A
        8foBv1pDXtvTRUf53S9r9o0gh/DcHJuPaK9JcBM1Q/Xqn/A=
X-Google-Smtp-Source: AA0mqf4QiiB2BZHAWfgFBOieYK+Lh3z4liEHhxwc5Q9f7rsLaJk2vI0TRMChJlu/JjkSlBO83FTNYuwg/N184NVDb18=
X-Received: by 2002:a05:6122:8c:b0:3ac:fba7:fc83 with SMTP id
 r12-20020a056122008c00b003acfba7fc83mr7422912vka.23.1668451175208; Mon, 14
 Nov 2022 10:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20221114040441.1649940-1-zhangpeng362@huawei.com>
In-Reply-To: <20221114040441.1649940-1-zhangpeng362@huawei.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Tue, 15 Nov 2022 03:39:18 +0900
Message-ID: <CAKFNMomu3Sf4_QHOm=zXM-QiLaVxASpMqpjek0F3SQnXwje4KA@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix NULL pointer dereference in nilfs_palloc_commit_free_entry()
To:     Peng Zhang <zhangpeng362@huawei.com>
Cc:     ye.xingchen@zte.com.cn, chi.minghao@zte.com.cn,
        vishal.moola@gmail.com, linux-nilfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+ebe05ee8e98f755f61d0@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 12:39 PM Peng Zhang wrote:
>
> From: ZhangPeng <zhangpeng362@huawei.com>
>
> Syzbot reported a null-ptr-deref bug:
>
> NILFS (loop0): segctord starting. Construction interval = 5 seconds, CP
> frequency < 30 seconds
> general protection fault, probably for non-canonical address
> 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
> KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> CPU: 1 PID: 3603 Comm: segctord Not tainted
> 6.1.0-rc2-syzkaller-00105-gb229b6ca5abb #0
> Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google
> 10/11/2022
> RIP: 0010:nilfs_palloc_commit_free_entry+0xe5/0x6b0
> fs/nilfs2/alloc.c:608
> Code: 00 00 00 00 fc ff df 80 3c 02 00 0f 85 cd 05 00 00 48 b8 00 00 00
> 00 00 fc ff df 4c 8b 73 08 49 8d 7e 10 48 89 fa 48 c1 ea 03 <80> 3c 02
> 00 0f 85 26 05 00 00 49 8b 46 10 be a6 00 00 00 48 c7 c7
> RSP: 0018:ffffc90003dff830 EFLAGS: 00010212
> RAX: dffffc0000000000 RBX: ffff88802594e218 RCX: 000000000000000d
> RDX: 0000000000000002 RSI: 0000000000002000 RDI: 0000000000000010
> RBP: ffff888071880222 R08: 0000000000000005 R09: 000000000000003f
> R10: 000000000000000d R11: 0000000000000000 R12: ffff888071880158
> R13: ffff88802594e220 R14: 0000000000000000 R15: 0000000000000004
> FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb1c08316a8 CR3: 0000000018560000 CR4: 0000000000350ee0
> Call Trace:
>  <TASK>
>  nilfs_dat_commit_free fs/nilfs2/dat.c:114 [inline]
>  nilfs_dat_commit_end+0x464/0x5f0 fs/nilfs2/dat.c:193
>  nilfs_dat_commit_update+0x26/0x40 fs/nilfs2/dat.c:236
>  nilfs_btree_commit_update_v+0x87/0x4a0 fs/nilfs2/btree.c:1940
>  nilfs_btree_commit_propagate_v fs/nilfs2/btree.c:2016 [inline]
>  nilfs_btree_propagate_v fs/nilfs2/btree.c:2046 [inline]
>  nilfs_btree_propagate+0xa00/0xd60 fs/nilfs2/btree.c:2088
>  nilfs_bmap_propagate+0x73/0x170 fs/nilfs2/bmap.c:337
>  nilfs_collect_file_data+0x45/0xd0 fs/nilfs2/segment.c:568
>  nilfs_segctor_apply_buffers+0x14a/0x470 fs/nilfs2/segment.c:1018
>  nilfs_segctor_scan_file+0x3f4/0x6f0 fs/nilfs2/segment.c:1067
>  nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1197 [inline]
>  nilfs_segctor_collect fs/nilfs2/segment.c:1503 [inline]
>  nilfs_segctor_do_construct+0x12fc/0x6af0 fs/nilfs2/segment.c:2045
>  nilfs_segctor_construct+0x8e3/0xb30 fs/nilfs2/segment.c:2379
>  nilfs_segctor_thread_construct fs/nilfs2/segment.c:2487 [inline]
>  nilfs_segctor_thread+0x3c3/0xf30 fs/nilfs2/segment.c:2570
>  kthread+0x2e4/0x3a0 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:nilfs_palloc_commit_free_entry+0xe5/0x6b0
> fs/nilfs2/alloc.c:608
> Code: 00 00 00 00 fc ff df 80 3c 02 00 0f 85 cd 05 00 00 48 b8 00 00 00
> 00 00 fc ff df 4c 8b 73 08 49 8d 7e 10 48 89 fa 48 c1 ea 03 <80> 3c 02
> 00 0f 85 26 05 00 00 49 8b 46 10 be a6 00 00 00 48 c7 c7
> RSP: 0018:ffffc90003dff830 EFLAGS: 00010212
> RAX: dffffc0000000000 RBX: ffff88802594e218 RCX: 000000000000000d
> RDX: 0000000000000002 RSI: 0000000000002000 RDI: 0000000000000010
> RBP: ffff888071880222 R08: 0000000000000005 R09: 000000000000003f
> R10: 000000000000000d R11: 0000000000000000 R12: ffff888071880158
> R13: ffff88802594e220 R14: 0000000000000000 R15: 0000000000000004
> FS:  0000000000000000(0000) GS:ffff8880b9b00000(0000)
> knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fb1c08316a8 CR3: 0000000018560000 CR4: 0000000000350ee0
> ----------------
> Code disassembly (best guess), 7 bytes skipped:
>    0:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1)
>    4:   0f 85 cd 05 00 00       jne    0x5d7
>    a:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax
>   11:   fc ff df
>   14:   4c 8b 73 08             mov    0x8(%rbx),%r14
>   18:   49 8d 7e 10             lea    0x10(%r14),%rdi
>   1c:   48 89 fa                mov    %rdi,%rdx
>   1f:   48 c1 ea 03             shr    $0x3,%rdx
> * 23:   80 3c 02 00             cmpb   $0x0,(%rdx,%rax,1) <-- trapping
> instruction
>   27:   0f 85 26 05 00 00       jne    0x553
>   2d:   49 8b 46 10             mov    0x10(%r14),%rax
>   31:   be a6 00 00 00          mov    $0xa6,%esi
>   36:   48                      rex.W
>   37:   c7                      .byte 0xc7
>   38:   c7                      .byte 0xc7
>
> When maxlevelp is 1, there is a case where req->pr_desc_bh is NULL and
> blocknr is 0, because nilfs_dat_commit_alloc() will modify the blocknr
> of oldreq at one level higher to 0. And we don't have a NULL check on
> req->pr_desc_bh and req->pr_bitmap_bh in
> nilfs_palloc_commit_free_entry() function, so when req->pr_desc_bh is
> NULL and kmap() dereferences a NULL pointer, it leads to above crash.
> Fix this by adding a NULL check on req->pr_desc_bh and req->pr_bitmap_bh
> before nilfs_palloc_commit_free_entry() in nilfs_dat_commit_free().
>
> Reported-by: syzbot+ebe05ee8e98f755f61d0@syzkaller.appspotmail.com
> Fixes: bd8169efae8b ("nilfs2: add update functions of virtual block address to dat")
> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> ---
>  fs/nilfs2/dat.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/nilfs2/dat.c b/fs/nilfs2/dat.c
> index 3b55e239705f..84ce050a8fa3 100644
> --- a/fs/nilfs2/dat.c
> +++ b/fs/nilfs2/dat.c
> @@ -111,6 +111,9 @@ static void nilfs_dat_commit_free(struct inode *dat,
>         kunmap_atomic(kaddr);
>
>         nilfs_dat_commit_entry(dat, req);
> +
> +       if (req->pr_desc_bh == NULL || req->pr_bitmap_bh == NULL)
> +               return;
>         nilfs_palloc_commit_free_entry(dat, req);
>  }
>
> --
> 2.25.1
>

Thank you for your help.

This patch actually fixes the NULL pointer dereference, and doesn't
seem to cause any regressions so far.
But, if de_blocknr is 0 in the first place, it assumes that
req->pr_desc_bh and req->pr_bitmap_bh are set properly in the
corresponding "prepare" operation, nilfs_dat_prepare_end(), so I'd
like to review in a little more detail why that is broken.

Thanks,
Ryusuke Konishi
