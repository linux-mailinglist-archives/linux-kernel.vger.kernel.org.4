Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8546890D7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 08:28:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232090AbjBCH2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 02:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjBCH23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 02:28:29 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACBE28866;
        Thu,  2 Feb 2023 23:28:27 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id c10-20020a17090a1d0a00b0022e63a94799so8012162pjd.2;
        Thu, 02 Feb 2023 23:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yrUqXfryLQlrLCm9hyDoqZD26Fw47bBABUs2gO/ieAw=;
        b=LSsFXEfftMJGiVLjtMNzhivatY1XQ4DELbLj6r0NuahhqFSAQPW6dZJKiLGhd/ldn4
         tRCsuYkfgyRPh0zAYLKwjVmpGFrmHQ5jo4RAyaujkwkfvX1JmrhTUiXEV3wm9FN7Xqeo
         7sdGfotQxJHTTl+uJEsVs0BuQw4xi0vpfsBSvuj4Bp0RhULIM5bd7GQ92Ot8DW325Gum
         H6vhmNPcYUc9xGjAeErLni63/TWKuqIlrLrQPoCT1JOuv30azv/nkmfi64RqK8M9BTRj
         T/tVYfnu18b+373OACSI68IYyq9E0uF+3GV2NdNmf6vHtn61VRpuSEHIZz1b1VDnm37Z
         +QaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yrUqXfryLQlrLCm9hyDoqZD26Fw47bBABUs2gO/ieAw=;
        b=uCTjg1p8mu3yvK7tIdULWl9L2291kx8hgXAMoQRBNM7CEFn+gLZo7PVqDJGhIU8FSe
         KRBrH3ye9L2d8rH1OrM80/dYsOGxlpGXzrfk2gR8lasN3+9d5NlFdjYFL51jXF8xvw/5
         NwHb2mLM3oh5oXYbD4/NGZ7UOxRszUNMoiPP3/mv6Q72go/JZE/0jnJ7S4qOfVRzWOm+
         XaIzDBSIHwy8NYIiqaLwXfAo0UzoeVEQl6cYoznmdkuxRnuPgKod/jrSsWMDdi6cML9e
         Z0NhE26VZt8vDjR9SlGqkN3awO2GGXbybQdTkXiVoRIWrOT+NAL65SD0r5bW0RqDjtww
         Z76w==
X-Gm-Message-State: AO0yUKUFwNdDEXNYqQMZaKGLpSLD9iaApEfCe9QstQAXWZVdITNy430J
        KqRqKya7qKTG2koL608xHux0i2xQkT0=
X-Google-Smtp-Source: AK7set9q2Adj1gdXQI/B+c5O74A8qQBVNq4OwTNFPaCkZ7iDmdp2cs23NtuXcMJlbb04+uq+bSOoUw==
X-Received: by 2002:a17:903:2288:b0:198:dd3f:2846 with SMTP id b8-20020a170903228800b00198dd3f2846mr1879080plh.29.1675409306986;
        Thu, 02 Feb 2023 23:28:26 -0800 (PST)
Received: from zj-T470P.. ([103.135.104.6])
        by smtp.gmail.com with ESMTPSA id c19-20020a170902849300b00192a8b35fa3sm874750plo.122.2023.02.02.23.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 23:28:26 -0800 (PST)
From:   Zhu Zhongjie <zhongjiezhu1@gmail.com>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Zhongjie Zhu <zhongjiezhu1@gmail.com>
Subject: [PATCH] USB: core: hub: fix usb_hub worker blocking drain_all_pages() worker issue
Date:   Fri,  3 Feb 2023 15:28:19 +0800
Message-Id: <20230203072819.3408-1-zhongjiezhu1@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhongjie Zhu <zhongjiezhu1@gmail.com>

When disconnecting a usb mass storege, if there are a lot of inodes
like 10 thousands files need to be freed, the invalidate_inodes() will
run for a loog time to freeing all inodes, this will block other worker
to run in the cpu, so mark the usb_hub workqueue to WQ_CPU_INTENSIVE to
avoid this situation.

Sometimes the flowing call stack will hanppen: the cma_alloc() will be
blocked at __flush_work() by the hub_event worker.

usb_hub worker:
Call trace:
[<ffffffc010335e84>] invalidate_inodes+0xc0/0x294
<ffffffc0103659cc>] __invalidate_device+0x44/0xbc
[<ffffffc01059efe4>] invalidate_partition+0x7c/0xac
[<ffffffc01059ed54>] del_gendisk+0x148/0x35c
[<ffffffc0107620e4>] sd_remove+0x58/0xc4
[<ffffffc01070cb3c>] device_release_driver_internal+0x184/0x248
[<ffffffc010709e40>] bus_remove_device+0xdc/0x104
[<ffffffc0107068dc>] device_del+0x2b0/0x534
[<ffffffc01075c1a8>] __scsi_remove_device+0xc8/0x14c
[<ffffffc01075b788>] scsi_forget_host+0x60/0x7c
[<ffffffc010750040>] scsi_remove_host+0x84/0x130
[<ffffffc010882d60>] usb_stor_disconnect+0x7c/0xd0
[<ffffffc010828430>] usb_unbind_interface+0xc0/0x25c
[<ffffffc01070cb3c>] device_release_driver_internal+0x184/0x248
[<ffffffc010709e40>] bus_remove_device+0xdc/0x104
[<ffffffc0107068dc>] device_del+0x2b0/0x534
[<ffffffc010825b38>] usb_disable_device+0x80/0x180
[<ffffffc010817ef0>] usb_disconnect+0x128/0x314
[<ffffffc01081c95c>] hub_event+0x99c/0x16c8
[<ffffffc01011ed94>] process_one_work+0x2e8/0x574
[<ffffffc01011f2cc>] worker_thread+0x2ac/0x5e8
[<ffffffc0101252b4>] kthread+0x14c/0x15c
[<ffffffc010083ff0>] ret_from_fork+0x10/0x18

cma_alloc():
Call trace
[<ffffffc010090c18>] __switch_to+0x244/0x264
[<ffffffc0112153e0>] __schedule+0x564/0x754
[<ffffffc011215660>] schedule+0x90/0xc4
[<ffffffc011219468>] schedule_timeout+0x4c/0x1d0
[<ffffffc011216814>] do_wait_for_common+0xf8/0x1b4
[<ffffffc0112163bc>] wait_for_completion+0x50/0x68
[<ffffffc010119d94>] __flush_work.llvm.11756653060903382828+0x270/0x324
[<ffffffc0102d51e4>] drain_all_pages+0x224/0x2a8
[<ffffffc0103031fc>] start_isolate_page_range+0x1e4/0x2dc
[<ffffffc010e25624>] aml_cma_alloc_range+0xfc/0x3ec
[<ffffffc0103072e0>] cma_alloc+0x1ac/0x6d8

Signed-off-by: Zhongjie Zhu <zhongjiezhu1@gmail.com>
---
 drivers/usb/core/hub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 9eca403af2a8..850549b30277 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -5904,7 +5904,8 @@ int usb_hub_init(void)
 	 * device was gone before the EHCI controller had handed its port
 	 * over to the companion full-speed controller.
 	 */
-	hub_wq = alloc_workqueue("usb_hub_wq", WQ_FREEZABLE, 0);
+	hub_wq = alloc_workqueue("usb_hub_wq",
+			WQ_FREEZABLE | WQ_CPU_INTENSIVE, 0);
 	if (hub_wq)
 		return 0;
 
-- 
2.34.1

