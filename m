Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A994620701
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 03:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiKHC4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 21:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbiKHC4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 21:56:06 -0500
Received: from mail-pg1-x561.google.com (mail-pg1-x561.google.com [IPv6:2607:f8b0:4864:20::561])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A99C1B9C6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 18:56:04 -0800 (PST)
Received: by mail-pg1-x561.google.com with SMTP id q71so12222375pgq.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 18:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=from:message-id:content-transfer-encoding:user-agent:subject:to
         :date:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dpZj7X5Two18D9Vasgv7AH793WdduwGaJXYn74NdXF0=;
        b=rZrx5HAZ+5S45KpDY4VlRp2mHWpVk3g90bmN2wEiv8Ay9wcXiQP/FqYndnZovLFbD2
         HFYqfwlEWgdjVs0Qi0OL52wiufdvw+dKyzTt3DYqSZbU03gJddsFSIKdHiu56Pncdv0W
         0feU/Z5bK0hOtGRpgDKsdmZ6Vkr05CWEjvO8LkR1OfoEhhW7tuiJhYxCJoE7WtdTxeBS
         hDoybwHVoWhsbfWlvXQxtU4yEUATsC5kCx/GU3a4A/bBW7dA9IdWEGHF9aA0HSI7QNFC
         22M9a8CNdn0vqNcKzASMnzlglWcghmfWHPSzXdhvDKIzIu8vtwyt1d3rT6m+l5aEBNPV
         fpsw==
X-Gm-Message-State: ACrzQf0f1QO/P4036BuQe+gYP/wXO4ajHOF4wFdgDEHaVUAey5huf+ES
        oUdT+cS/aqH8yJsjAlu8YnweYu7e49pVmcivZD7zWjCsdwZV
X-Google-Smtp-Source: AMsMyM4COWnw3wwSCUAGBvsyIOyTaG7HIX3TjoVA/GwYBqGU3aWe9BW8AcwELEU/DOZhlb+ZJ87PWskHFEjN
X-Received: by 2002:a63:5559:0:b0:464:a987:8365 with SMTP id f25-20020a635559000000b00464a9878365mr46076556pgm.479.1667876163471;
        Mon, 07 Nov 2022 18:56:03 -0800 (PST)
Received: from smtp.aristanetworks.com (mx.aristanetworks.com. [162.210.129.12])
        by smtp-relay.gmail.com with ESMTPS id mz9-20020a17090b378900b00212e4b57315sm517742pjb.16.2022.11.07.18.56.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Nov 2022 18:56:03 -0800 (PST)
X-Relaying-Domain: arista.com
Received: from us226.sjc.aristanetworks.com (us226.sjc.aristanetworks.com [10.243.208.9])
        by smtp.aristanetworks.com (Postfix) with ESMTP id 1AF17400F81;
        Mon,  7 Nov 2022 18:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-B; t=1667876163;
        bh=dpZj7X5Two18D9Vasgv7AH793WdduwGaJXYn74NdXF0=;
        h=Date:To:Subject:From:From;
        b=LDOk7VQNpXA5rV0gRrb/JFDyNBCzKnW/VsL8NIApQQ674/1UKnQNPFgsSiK4tXk0I
         stqfPCdOGSAST93pDoYOhqBj5Nk17fT4/Xqf2Mn00bHOuAH/4I0Y8kFmACApQWZhuD
         ZqWB7ZvfeHz0yxCmH3TzE+RBIny+JG11fFShBdb8=
Received: by us226.sjc.aristanetworks.com (Postfix, from userid 10189)
        id E48005EC04F9; Mon,  7 Nov 2022 18:56:02 -0800 (PST)
Date:   Mon, 07 Nov 2022 18:56:02 -0800
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        sagi@grimberg.me, hch@lst.de, axboe@fb.com, kbusch@kernel.org,
        fruggeri@arista.com
Subject: nvme: hung task in blk_mq_freeze_queue_wait
User-Agent: Heirloom mailx 12.5 7/5/10
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20221108025602.E48005EC04F9@us226.sjc.aristanetworks.com>
From:   fruggeri@arista.com (Francesco Ruggeri)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are running into hung tasks in blk_mq_freeze_queue_wait, sometimes
in nvme_reset_work and sometimes in nvme_scan_work.
In some cases we also see a warning in blk_mq_unfreeze_queue
(WARN_ON_ONCE(q->mq_freeze_depth < 0)):
WARNING: CPU: 10 PID: 152 at block/blk-mq.c:199 blk_mq_unfreeze_queue+0x26/0x5a
The hung tasks are preceded by two instances of nvme_timeout racing in
nvme_dev_disable after a device becomes unresponsive.
The first nvme_dev_disable blocks in wait_for_completion_io_timeout, and
a while later a second instance blocks in mutex_lock(&dev->shutdown_lock).
When the timeout expires and the first instance releases the mutex,
the two instances start racing.
We have seen the hung tasks in 4.19, but from a quick look at the
latest 6.1 code the issue is probably there as well.
There seem to be two different scenarios where unbalanced
blk_freeze_queue_start/blk_mq_unfreeze_queue could be the cause.

1) In this case we have an unfreeze without a corresponding freeze
preceding it.

TIMEOUT 1	TIMEOUT 2	RESET WORK 1	RESET WORK 2

state = NVME_CTRL_LIVE
nvme_timeout
nvme_dev_disable
mutex_lock
nvme_start_freeze
blk_freeze_queue_start
nvme_disable_io_queues
wait_for_completion_io_timeout
		nvme_timeout
		nvme_dev_disable
		mutex_lock
mutex_unlock
nvme_reset_ctrl
state = NVME_CTRL_RESETTING
queue_work(nvme_reset_work)
				nvme_reset_work
				state = NVME_CTRL_CONNECTING
		(state != NVME_CTRL_LIVE and
		state != NVME_CTRL_RESETTING)
		skips nvme_start_freeze
		mutex_unlock
		nvme_reset_ctrl
		state = NVME_CTRL_RESETTING
		queue_work(nvme_reset_work)
				nvme_unfreeze (matches
				nvme_start_freeze in
				TIMEOUT 1)
						nvme_reset_work
						nvme_unfreeze (no
						match in TIMEOUT 2)


2) In this case a freeze has no corresponding unfreeze following it.
TIMEOUT 2 cannot schedule nvme_reset_work because TIMEOUT 1's is already
scheduled but not yet running.

TIMEOUT 1	TIMEOUT 2	RESET WORK 1	RESET WORK 2

state = NVME_CTRL_LIVE
nvme_timeout
nvme_dev_disable
mutex_lock
nvme_start_freeze
blk_freeze_queue_start
nvme_disable_io_queues
wait_for_completion_io_timeout
		nvme_timeout
		nvme_dev_disable
		mutex_lock
mutex_unlock
nvme_reset_ctrl
state = NVME_CTRL_RESETTING
queue_work(nvme_reset_work)
		(state == NVME_CTRL_LIVE or
		state == NVME_CTRL_RESETTING)
		nvme_start_freeze
		blk_freeze_queue_start
		mutex_unlock
		nvme_reset_ctrl
		state = NVME_CTRL_RESETTING
		queue_work(nvme_reset_work)
		fails because nvme_reset_work
		is not running yet
				nvme_reset_work
				nvme_unfreeze (matches
				nvme_start_freeze in
				TIMEOUT 1)
						It gets never
						scheduled.


Following is one such backtrace.

[ 4390.119745] INFO: task kworker/u80:2:8279 blocked for more than 300 seconds.
[ 4390.471456]       Tainted: P           O      4.19.142.Ar-29007847.buytenhb7335070 #1
[ 4390.832568] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 4391.193663] kworker/u80:2   D    0  8279      2 0x80000000
[ 4391.526603] Workqueue: nvme-reset-wq nvme_reset_work
[ 4391.853272] Call Trace:
[ 4392.149696]  __schedule+0x75b/0x7c2
[ 4392.458627]  schedule+0x78/0x8c
[ 4392.763399]  blk_mq_freeze_queue_wait+0x8b/0xb6
[ 4393.084849]  ? wait_woken+0x92/0x92
[ 4393.393791]  nvme_wait_freeze+0x39/0x4e
[ 4393.706900]  nvme_reset_work+0x1464/0x1665
[ 4394.023142]  ? dequeue_entity+0x694/0x6a3
[ 4394.338340]  process_one_work+0x1c2/0x30f
[ 4394.511642]  worker_thread+0x1e9/0x2cc
[ 4394.556626]  ? rescuer_thread+0x2b7/0x2b7
[ 4394.604738]  kthread+0x15d/0x165
[ 4394.643460]  ? kthread_park+0x98/0x98
[ 4394.687396]  ret_from_fork+0x1f/0x30


