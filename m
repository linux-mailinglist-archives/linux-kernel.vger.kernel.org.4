Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18C47377A6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 00:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjFTWyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 18:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjFTWyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 18:54:52 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C061BC5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:54:28 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b520329adeso7315ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 15:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687301664; x=1689893664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gTsACT6nEhP8Rat6ipfLZr90IJgF0RJ5gktjobnTTRI=;
        b=sjWmVxxopBnx7MWXsHH3UX/AMT4oyvxe9CxCLaxaz0Mv55DhIolffsGsVxj8tiX9jh
         cGuH7A03yYcJNBShuF/wvp5eP9J6g1iEgWP/q2yGcKbfv7wnJprPekuStlct9k0uGn0d
         b6Nfp+dzyeYIey08hpS2la/4Nr9FfFmtXHaX5o6lwxRshwl2tC+bhTjVZNFFC36QzLNg
         7MQujn8uSfNlaQ5yh2ViaD5ZCk1pejWNOhhaXIHfUR5+n9u9fECrXNShKIjutOFyPDZb
         ydB/KSb75XiKsVP+papCyF3xs0gqDER1bF7lsmnQr6qdFs9Uw70gaQpA8mlcG8loNvbU
         mSPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687301664; x=1689893664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTsACT6nEhP8Rat6ipfLZr90IJgF0RJ5gktjobnTTRI=;
        b=BSVB2NI7VLEsEEdMNsypquIShc6gPqF+u/KlAZkeH1OKSdEYl7RD+4RjbTCV4yTSFQ
         BCUQ+PuLyFcVtlp35oyh/gZ9GPp+y6cSOmjrp641pinPlo8TT3rV8ChygafI6d8WyqDz
         u4br6Z09lIBU75L5zqz1+uMLaAfKZsds7s2sOhVOinwIaSto5VcAhgTpUSpRxrZFDJUt
         PCsWUJr+Eid4se3hLq44PONAx17JjaM4Tw2P6wlvu6TCo60le5iFYPohwCzxARBf56Qa
         U4pUnvf4N9BZ+rxRLQCIUsJoNV6gwuPanRhxfIOWYY7ImXeIkj+pqPeTNCKrebGLf4ma
         ziZQ==
X-Gm-Message-State: AC+VfDwhZo0drRsHIIhbjmKG0HynlL1P/0ToL8+ufO8U3Jv1VuY/ZJx+
        arRFG7NpJ9B6zHzu00aTI0KWgQ==
X-Google-Smtp-Source: ACHHUZ4NkTCi41DamOA4c/OVerhJYRHT+N3p3hcc4fxJKmbuVI3MCE/ohiuZVTO3MvBESnW4cWWBOg==
X-Received: by 2002:a17:903:32cd:b0:1b0:4a2:5920 with SMTP id i13-20020a17090332cd00b001b004a25920mr209207plr.19.1687301664299;
        Tue, 20 Jun 2023 15:54:24 -0700 (PDT)
Received: from google.com (197.59.83.34.bc.googleusercontent.com. [34.83.59.197])
        by smtp.gmail.com with ESMTPSA id a16-20020aa78650000000b00659b8313d08sm1768096pfo.78.2023.06.20.15.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 15:54:23 -0700 (PDT)
Date:   Tue, 20 Jun 2023 22:54:19 +0000
From:   Edward Liaw <edliaw@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Suwan Kim <suwan.kim027@gmail.com>,
        "Roberts, Martin" <martin.roberts@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2] Revert "virtio-blk: support completion batching for
 the IRQ path"
Message-ID: <ZJIuG9hyTYIIDbF5@google.com>
References: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <336455b4f630f329380a8f53ee8cad3868764d5c.1686295549.git.mst@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 03:27:24AM -0400, Michael S. Tsirkin wrote:
> This reverts commit 07b679f70d73483930e8d3c293942416d9cd5c13.
This commit was also breaking kernel tests on a virtual Android device
(cuttlefish).  We were seeing hangups like:

[ 2889.910733] INFO: task kworker/u8:2:6312 blocked for more than 720 seconds.
[ 2889.910967]       Tainted: G           OE      6.2.0-mainline-g5c05cafa8df7-ab9969617 #1
[ 2889.911143] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2889.911389] task:kworker/u8:2    state:D stack:12160 pid:6312  ppid:2      flags:0x00004000
[ 2889.911567] Workqueue: writeback wb_workfn (flush-254:57)
[ 2889.911771] Call Trace:
[ 2889.911831]  <TASK>
[ 2889.911893]  __schedule+0x55f/0x880
[ 2889.912021]  schedule+0x6a/0xc0
[ 2889.912110]  schedule_timeout+0x58/0x1a0
[ 2889.912200]  wait_for_common+0xf7/0x1b0
[ 2889.912289]  wait_for_completion+0x1c/0x40
[ 2889.912377]  f2fs_issue_checkpoint+0x14c/0x210
[ 2889.912504]  f2fs_sync_fs+0x4c/0xb0
[ 2889.912597]  f2fs_balance_fs_bg+0x2f6/0x340
[ 2889.912736]  ? can_migrate_task+0x39/0x2b0
[ 2889.912872]  f2fs_write_node_pages+0x77/0x240
[ 2889.912989]  do_writepages+0xde/0x240
[ 2889.913094]  __writeback_single_inode+0x3f/0x360
[ 2889.913231]  writeback_sb_inodes+0x320/0x5f0
[ 2889.913349]  ? move_expired_inodes+0x58/0x210
[ 2889.913470]  __writeback_inodes_wb+0x97/0x100
[ 2889.913587]  wb_writeback+0x17e/0x390
[ 2889.913682]  wb_workfn+0x35f/0x500
[ 2889.913774]  process_one_work+0x1d9/0x3b0
[ 2889.913870]  worker_thread+0x251/0x410
[ 2889.913960]  kthread+0xeb/0x110
[ 2889.914052]  ? __cfi_worker_thread+0x10/0x10
[ 2889.914168]  ? __cfi_kthread+0x10/0x10
[ 2889.914257]  ret_from_fork+0x29/0x50
[ 2889.914364]  </TASK>
[ 2889.914565] INFO: task mkdir09:6425 blocked for more than 720 seconds.
[ 2889.916065]       Tainted: G           OE      6.2.0-mainline-g5c05cafa8df7-ab9969617 #1
[ 2889.916255] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 2889.916450] task:mkdir09         state:D stack:13016 pid:6425  ppid:6423   flags:0x00004000
[ 2889.916656] Call Trace:
[ 2889.916900]  <TASK>
[ 2889.917004]  __schedule+0x55f/0x880
[ 2889.917129]  schedule+0x6a/0xc0
[ 2889.917273]  schedule_timeout+0x58/0x1a0
[ 2889.917425]  wait_for_common+0xf7/0x1b0
[ 2889.917535]  wait_for_completion+0x1c/0x40
[ 2889.917670]  f2fs_issue_checkpoint+0x14c/0x210
[ 2889.917844]  f2fs_sync_fs+0x4c/0xb0
[ 2889.917969]  f2fs_do_sync_file+0x3a8/0x8c0
[ 2889.918090]  ? mt_find+0xa0/0x1a0
[ 2889.918216]  f2fs_sync_file+0x2f/0x60
[ 2889.918310]  vfs_fsync_range+0x74/0x90
[ 2889.918567]  __se_sys_msync+0x176/0x270
[ 2889.918730]  __x64_sys_msync+0x1c/0x40
[ 2889.918873]  do_syscall_64+0x53/0xb0
[ 2889.918996]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[ 2889.919178] RIP: 0033:0x7540b08bcf47
[ 2889.919297] RSP: 002b:00007fff5fcbeea8 EFLAGS: 00000206 ORIG_RAX: 000000000000001a
[ 2889.919496] RAX: ffffffffffffffda RBX: 0000000000001000 RCX: 00007540b08bcf47
[ 2889.919828] RDX: 0000000000000004 RSI: 0000000000001000 RDI: 00007540b4ae7000
[ 2889.920227] RBP: 0000000000000000 R08: 721e0000010b0016 R09: 0000000000000003
[ 2889.920435] R10: 0000000000000100 R11: 0000000000000206 R12: 00005d2f95fd2f08
[ 2889.920793] R13: 00005d2f95fbc310 R14: 00007540b08e1bb8 R15: 00005d2f95fbc310
[ 2889.921072]  </TASK>

in random tests in the LTP (linux test project) test suite.

> ---
> 
> Since v1:
> 	fix build error
> 
> Still completely untested as I'm traveling.
> Martin, Suwan, could you please test and report?
> Suwan if you have a better revert in mind pls post and
> I will be happy to drop this.
> 
> Thanks!
> 
This revert appears to have resolved the test failures for me.

Tested-by: edliaw@google.com
