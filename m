Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEAA736D24
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 15:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjFTNVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 09:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbjFTNU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 09:20:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC211FEA
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:19:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-25edb2433b8so655314a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 06:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687267180; x=1689859180;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xVUN/UeiDfdpA4Wf+eSb0/ZWuKlO/eBPU0TJTZdGiJU=;
        b=FIpNdsuz91q5A7kLQ0j0ZfYx8Rg2FiCOpmGc8uV7yDNVSy89++Zlmlt8pSCdJPivFo
         /Uz5y6XMRFoJcXmt7Ci7y7ipXlv9iXlvZ1Py4iFTRBLAm5KJkyrf1KPOI/IzjKYRaLSM
         YbjINvsaxuferhK1tfQSbaY3Krmh66rQA2vaePkoHuIzajOy6a/LaAQmGjDx1U/Zb7ha
         oiYIfTz5UqzE78DtCLNAi2FHa6eWlh10RisFvHa8Nzd5DGPjb+afJm9CB5s/CxiIc23j
         OqbjFBuPg0QSqqsskAKgfoaw3J0G3s9/t5NLz1cggR17+Bf+GW3rtROnE7Ui0t96wqe/
         SmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687267180; x=1689859180;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xVUN/UeiDfdpA4Wf+eSb0/ZWuKlO/eBPU0TJTZdGiJU=;
        b=TuWfGZ9ciQ2W692xGCaT5W6Tnn08ipCsQskEzZfiPsxTLefwdu1Ze2uEATIPLNMLzb
         /2rnqIGWCa4KGnFqv6TeljMRpJBuNuDQHQid8zb1NJRYOvUj2+kqCQqzR357ycs/desU
         fGSysHEZdXXX73VF43SVnNQ4/yZ+WDnT9vD0g4zi/tLsKd7eDIdkiYVTvWKduilSdPME
         sju9u5GMHgxBQBALZ9bXsawsu4ayzS6LHilXpDWam/No2fUPCK7Xt12c7wfS9r7qP6w+
         Pl8dB/gHkj/rMc6izn0uaj3elStRWYtsgT6rJifZXZ5YgWEbYEAEVlejk9qItpjxmpte
         Ebfw==
X-Gm-Message-State: AC+VfDwm4Zdn+ta7gqvpheWo50OYVa0Eydv5MA74NPi7/d7VC5LtpG/W
        01y7I5vcGN7xGQa1tHF+peGMSiQpco1aKf7S5/w=
X-Google-Smtp-Source: ACHHUZ439jswv/SXgv/CmKXTfq/lZyFwq/ZU8iTJxKlOQ5HLoq/MxPCQ51T1RKCEQGdLU30umIxZ0w==
X-Received: by 2002:a17:90b:350f:b0:255:54c4:9a75 with SMTP id ls15-20020a17090b350f00b0025554c49a75mr15065844pjb.2.1687267180146;
        Tue, 20 Jun 2023 06:19:40 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j16-20020a17090ae61000b002532ddc3a00sm7372589pjy.15.2023.06.20.06.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 06:19:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, jack@suse.cz, jinpu.wang@ionos.com,
        dchinner@redhat.com, hare@suse.de, trix@redhat.com,
        bvanassche@acm.org, yukuai3@huawei.com, willy@infradead.org,
        yi.zhang@huawei.com, dsterba@suse.com, brauner@kernel.org,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangerkun@huawei.com
In-Reply-To: <20230620111322.1014775-1-yukuai1@huaweicloud.com>
References: <20230620111322.1014775-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] reiserfs: fix blkdev_put() warning from
 release_journal_dev()
Message-Id: <168726717847.3595984.4839375056813352937.b4-ty@kernel.dk>
Date:   Tue, 20 Jun 2023 07:19:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 20 Jun 2023 19:13:22 +0800, Yu Kuai wrote:
> In journal_init_dev(), if super bdev is used as 'j_dev_bd', then
> blkdev_get_by_dev() is called with NULL holder, otherwise, holder will
> be journal. However, later in release_journal_dev(), blkdev_put() is
> called with journal unconditionally, cause following warning:
> 
> WARNING: CPU: 1 PID: 5034 at block/bdev.c:617 bd_end_claim block/bdev.c:617 [inline]
> WARNING: CPU: 1 PID: 5034 at block/bdev.c:617 blkdev_put+0x562/0x8a0 block/bdev.c:901
> RIP: 0010:blkdev_put+0x562/0x8a0 block/bdev.c:901
> Call Trace:
>  <TASK>
>  release_journal_dev fs/reiserfs/journal.c:2592 [inline]
>  free_journal_ram+0x421/0x5c0 fs/reiserfs/journal.c:1896
>  do_journal_release fs/reiserfs/journal.c:1960 [inline]
>  journal_release+0x276/0x630 fs/reiserfs/journal.c:1971
>  reiserfs_put_super+0xe4/0x5c0 fs/reiserfs/super.c:616
>  generic_shutdown_super+0x158/0x480 fs/super.c:499
>  kill_block_super+0x64/0xb0 fs/super.c:1422
>  deactivate_locked_super+0x98/0x160 fs/super.c:330
>  deactivate_super+0xb1/0xd0 fs/super.c:361
>  cleanup_mnt+0x2ae/0x3d0 fs/namespace.c:1247
>  task_work_run+0x16f/0x270 kernel/task_work.c:179
>  exit_task_work include/linux/task_work.h:38 [inline]
>  do_exit+0xadc/0x2a30 kernel/exit.c:874
>  do_group_exit+0xd4/0x2a0 kernel/exit.c:1024
>  __do_sys_exit_group kernel/exit.c:1035 [inline]
>  __se_sys_exit_group kernel/exit.c:1033 [inline]
>  __x64_sys_exit_group+0x3e/0x50 kernel/exit.c:1033
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Applied, thanks!

[1/1] reiserfs: fix blkdev_put() warning from release_journal_dev()
      commit: c576c4bf9ecfa3fb9f7b11681cc2f60aba5276c4

Best regards,
-- 
Jens Axboe



