Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC32364CE5B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 17:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbiLNQuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 11:50:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbiLNQur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 11:50:47 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15405DF2F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:50:45 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id x11so6798021ilo.13
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 08:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79e+vhj0sXS+Zj1qXRz76VRkeCVDOtMW1Uf+oekAwkc=;
        b=VQ5/M4I4l7GPfnXU8QuuPIaNA+V3ws2AIBOKxc+ZLGdBBtvNTeCcBb0xG9Swsglih8
         zxk9E+Lp6XtEeHbQiBf+Japt8QkqA8Vz9ayvaBLuZONCiX+9QzOtSVESVysYA9vHsyki
         vDSAToZ7qR2KVCui1e5S594xkCB5E5hBr1Q3IxYEa+PfEFa7IWLsxbZ+Izdw/FnXub1J
         khehKVgnduaD6p2e6tf5WhJ15MK3CgfpX/YhiJhRoORT+soz0/o1O3GWa54VPHNbSgXC
         jNXz/zKhOJfeeHgjWC+CsHk59oV40lkEMbqkdmVsN/xTqdiApQfn4mH4+zdYI9vXZ34n
         6heg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79e+vhj0sXS+Zj1qXRz76VRkeCVDOtMW1Uf+oekAwkc=;
        b=gYLh4NGNOJNsaknwpfoy8B2STRWh4ERmjZ2HE8nj4nxgNWBy1yearSPdEZpRa486t1
         mMh7XfhwrYUo02XlB7GVs3wqKLTG+drdQddM5YZnJ5Ha3BWCDhI4k5EADlnOU+3WKV7b
         2sNy/Dx1mxF0KcwRTq1JmMDUznxJ5bGMykqSF795MbmHL7zDOi6uQVq2Pn7WeOzJ8HIa
         jW6ItWxQ1JmavoXxaf3jCFW/jaSa6DnsbDy1yWZrktx3N1ZO7Zfzx5mZwvQFG6r3UTve
         QfAROrM1mu3JzcZSqCbMA2+C3KJeVmvZ/4vxeKnPHAP5zd5Kin4hkPDc0XJ2b0jsO1b6
         j5HQ==
X-Gm-Message-State: ANoB5pllPbfG2fLa6Bc588QVj640jAJM8Tf2KtM//QPm5YqazK0e9hVR
        a94akd3EOr7QhhxAPiqc+JAAwQ==
X-Google-Smtp-Source: AA0mqf5GVZXH87An9Q/fJpDbAGg2QzVN7HYK3UECfk3dQd/WSDowOARx26SEiBkieWZIUM7it0yjjA==
X-Received: by 2002:a05:6e02:892:b0:303:9c30:7eff with SMTP id z18-20020a056e02089200b003039c307effmr2202930ils.2.1671036644356;
        Wed, 14 Dec 2022 08:50:44 -0800 (PST)
Received: from [127.0.0.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u8-20020a92da88000000b00304ad1e7d21sm3511744iln.28.2022.12.14.08.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 08:50:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     paolo.valente@linaro.org, jack@suse.cz,
        Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com
In-Reply-To: <20221214030430.3304151-1-yukuai1@huaweicloud.com>
References: <20221214030430.3304151-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] block, bfq: fix possible uaf for 'bfqq->bic'
Message-Id: <167103664344.6701.9808643500961565105.b4-ty@kernel.dk>
Date:   Wed, 14 Dec 2022 09:50:43 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.0-dev-50ba3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Dec 2022 11:04:30 +0800, Yu Kuai wrote:
> Our test report a uaf for 'bfqq->bic' in 5.10:
> 
> ==================================================================
> BUG: KASAN: use-after-free in bfq_select_queue+0x378/0xa30
> 
> CPU: 6 PID: 2318352 Comm: fsstress Kdump: loaded Not tainted 5.10.0-60.18.0.50.h602.kasan.eulerosv2r11.x86_64 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58-20220320_160524-szxrtosci10000 04/01/2014
> Call Trace:
>  bfq_select_queue+0x378/0xa30
>  bfq_dispatch_request+0xe8/0x130
>  blk_mq_do_dispatch_sched+0x62/0xb0
>  __blk_mq_sched_dispatch_requests+0x215/0x2a0
>  blk_mq_sched_dispatch_requests+0x8f/0xd0
>  __blk_mq_run_hw_queue+0x98/0x180
>  __blk_mq_delay_run_hw_queue+0x22b/0x240
>  blk_mq_run_hw_queue+0xe3/0x190
>  blk_mq_sched_insert_requests+0x107/0x200
>  blk_mq_flush_plug_list+0x26e/0x3c0
>  blk_finish_plug+0x63/0x90
>  __iomap_dio_rw+0x7b5/0x910
>  iomap_dio_rw+0x36/0x80
>  ext4_dio_read_iter+0x146/0x190 [ext4]
>  ext4_file_read_iter+0x1e2/0x230 [ext4]
>  new_sync_read+0x29f/0x400
>  vfs_read+0x24e/0x2d0
>  ksys_read+0xd5/0x1b0
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x61/0xc6
> 
> [...]

Applied, thanks!

[1/1] block, bfq: fix possible uaf for 'bfqq->bic'
      commit: 64dc8c732f5c2b406cc752e6aaa1bd5471159cab

Best regards,
-- 
Jens Axboe


