Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4792365B182
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 12:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbjABLwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 06:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232782AbjABLv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 06:51:59 -0500
X-Greylist: delayed 154 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 02 Jan 2023 03:51:57 PST
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5FA26E6;
        Mon,  2 Jan 2023 03:51:56 -0800 (PST)
Received: from spock.localnet (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id A023C119FCC3;
        Mon,  2 Jan 2023 12:45:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1672659931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=F0S4U7+fTNn/PPM2LEUUIETOtpqfY5ngMCVLsBSOEE0=;
        b=uPiO7YSknuvcCgL1H6yNmgOF5bOChiPH/002jUE1asG+IosqDHn1E8zQN8f59FRQclKqj2
        QbSUA0X7K5qc0QaEG0QS4cbgMtCGLMzb88FegIolWhsQeifH+Cl3n2vZhTa1el7M1Hc0M+
        RkW80XTKXe2ZNjhWO7synZ1judcMu7k=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: BUG: KFENCE: use-after-free read in bfq_exit_icq_bfqq+0x132/0x270
Date:   Mon, 02 Jan 2023 12:45:30 +0100
Message-ID: <8202004.NyiUUSuA9g@natalenko.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

This is a sudden splash I've got while just using my workstation:

==================================================================
BUG: KFENCE: use-after-free read in bfq_exit_icq_bfqq+0x132/0x270
Use-after-free read at 0x00000000e57c579c (in kfence-#173):
 bfq_exit_icq_bfqq+0x132/0x270
 bfq_exit_icq+0x5e/0x80
 exit_io_context+0x88/0xb0
 do_exit+0x66c/0xb80
 kthread_exit+0x29/0x30
 kthread+0xbd/0x110
 ret_from_fork+0x22/0x30

kfence-#173: 0x000000005d7be631-0x000000006ad0b684, size=568, cache=bfq_queue
allocated by task 40147 on cpu 16 at 13975.114285s:
 bfq_get_queue+0xdf/0x4e0
 bfq_get_bfqq_handle_split+0x75/0x170
 bfq_insert_requests+0x832/0x2580
 blk_mq_sched_insert_requests+0x63/0x150
 blk_mq_flush_plug_list+0x122/0x360
 __blk_flush_plug+0x106/0x160
 blk_finish_plug+0x29/0x40
 dm_bufio_prefetch+0x108/0x4d0 [dm_bufio]
 dm_tm_issue_prefetches+0x44/0x70 [dm_persistent_data]
 dm_pool_issue_prefetches+0x39/0x43 [dm_thin_pool]
 do_worker+0x4c/0xd60 [dm_thin_pool]
 process_one_work+0x258/0x410
 worker_thread+0x55/0x4c0
 kthread+0xde/0x110
 ret_from_fork+0x22/0x30

freed by task 40147 on cpu 20 at 14500.096700s:
 bfq_put_queue+0x185/0x2d0
 bfq_exit_icq_bfqq+0x129/0x270
 bfq_exit_icq+0x5e/0x80
 exit_io_context+0x88/0xb0
 do_exit+0x66c/0xb80
 kthread_exit+0x29/0x30
 kthread+0xbd/0x110
 ret_from_fork+0x22/0x30

CPU: 20 PID: 40147 Comm: kworker/dying Tainted: G        W          6.1.0-pf2 #1 ff5dbde5ea280110a73397797e059b8558cda111
Hardware name: ASUS System Product Name/Pro WS X570-ACE, BIOS 4304 12/12/2022
==================================================================

I'm using v6.1.2, never experienced this before and cannot reproduce it at will. This kernel does not have any extra patches for the block layer on top of v6.1.2.

In case you know what's going on, please let me know.

Thanks!

-- 
Oleksandr Natalenko (post-factum)


