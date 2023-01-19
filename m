Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E938674B26
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 05:45:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjATEpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 23:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjATEod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 23:44:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F17BC768
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 20:39:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2930B82155
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACF7C433F0;
        Thu, 19 Jan 2023 10:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674124436;
        bh=yrB1AwKauGkM5RIWgoCMC6OhuRt/6p9R6HJRmpn7n1w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G+xUqufmDN+NyzXpH7tqgteSgfqFcRARlUh7hA7XlUZdOmiqpHWHa7MWjgjGc3an5
         KkZZSzhw/5BsleL0iGGnXQossNxj/VjG8hFz8Hj9tqJdGs56+/zw81/Iprn40O2PG3
         vMLRN7+fqRuHpyjmr0Sf7mpq2vdIBKP5H8YDy+1tiqXTl7AmsOdxOk0KmyyZ6HPJ1L
         SKWcYe1VGZgkB4jtpexUPhfRj7J02SEbGAWBHFZdOlqP8QiOr7brtsKk/glCY0j1dk
         JPnBfMRRdx9djj3aXku5Z3qa/NJ6W46xW7q8L9TvgXdDpEOSgjUw3d+08cdocNy68C
         P80SIFd78CHiw==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Tomer Tayar <ttayar@habana.ai>
Subject: [PATCH 09/10] habanalabs: clear in_compute_reset when escalating to hard reset
Date:   Thu, 19 Jan 2023 12:33:38 +0200
Message-Id: <20230119103339.718430-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230119103339.718430-1-ogabbay@kernel.org>
References: <20230119103339.718430-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomer Tayar <ttayar@habana.ai>

If resetting device upon release while the release watchdog work is
scheduled, the compute reset is replaced with hard reset.
In this case, need to clear the in_compute_reset indication in the
device reset information structure.

Signed-off-by: Tomer Tayar <ttayar@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index edeec35fd9c6..9933e5858a36 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -1514,6 +1514,7 @@ int hl_device_reset(struct hl_device *hdev, u32 flags)
 						&hdev->device_release_watchdog_work.reset_work);
 
 			if (from_dev_release) {
+				hdev->reset_info.in_compute_reset = 0;
 				flags |= HL_DRV_RESET_HARD;
 				flags &= ~HL_DRV_RESET_DEV_RELEASE;
 				hard_reset = true;
-- 
2.25.1

