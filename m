Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C83F694893
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjBMOte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjBMOtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:49:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5D91ABF5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676299711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=17iYD86Ql6pEQsYrWnsd0ZD8yFa8I2jvKb8kSAxiHNU=;
        b=SQiTZ/9aION8I6f7HD8sZI/aO50gDj00lPQRhjuj0sdBHg7cs6OMfIsVsAXeMHxPdx4v21
        Z0wcghufaTbpW/He2CY2EmUSkVdjOYcH9llMpkEN/WWrBQdedLnK4MpWxJYQRACePZSpEC
        OJmqHlUt3PjOPQpsIHLI6Y+1rCHzNa4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-5-u1ktbGSeOqiHWrVz43MuEw-1; Mon, 13 Feb 2023 09:48:30 -0500
X-MC-Unique: u1ktbGSeOqiHWrVz43MuEw-1
Received: by mail-qv1-f72.google.com with SMTP id i7-20020a056214020700b004ffce246a2bso6897189qvt.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=17iYD86Ql6pEQsYrWnsd0ZD8yFa8I2jvKb8kSAxiHNU=;
        b=NdpPKP3xSHdreeu3ooLnKMp0ywgqoW8a5hDEj8HxNpYH5ypt5cSGXcQ+mlkC9mLnRw
         2a/qObCJgWorutueb29r6Q7sr3lB7YQ9w4sSO1HrR7ZoFKv61K91jtbF3VUmK78AHYu+
         PoFSPICtSgMlvg+B3sz8dYr90nHyyyfMjxg/j0VepGOKJrj7bjoTvq6Lhz9H1O2BFhRZ
         4UOOKDjK2XuNk1Br9n2CZvnyS8S1XY35YPa8KR7bvzIlz6ZrVj7bYjDKwIEI86iXnO/r
         ltoSHRrlo7q1VaTHcOTjdMbr19UNf4MRD1ZcrNOgtbDQGqO01FUZnlAtK2rD6D1zMBJV
         dtpA==
X-Gm-Message-State: AO0yUKVR7Z7dH3bxgdW9rArtfpwnEP2bKayd2FJ5CsVdP+6VQMpkoHq2
        DH3AcDun54gqM42pbVuEkuz0fOIKNUIvfplO3TnM2mx8nqZDWIErQrhf7sOCQy7KbwQM05LjGkE
        PxkTMKcJIovs7awue4xkGunPf
X-Received: by 2002:a05:6214:21c7:b0:56e:bc4c:b55d with SMTP id d7-20020a05621421c700b0056ebc4cb55dmr2685824qvh.20.1676299709828;
        Mon, 13 Feb 2023 06:48:29 -0800 (PST)
X-Google-Smtp-Source: AK7set/7zkrBHCIVkrfX9gg0xNDw4iKrhSwi1ktMsBoo1KD7XBP0PBXktes+LN0BxNRs3wH4qM6lKQ==
X-Received: by 2002:a05:6214:21c7:b0:56e:bc4c:b55d with SMTP id d7-20020a05621421c700b0056ebc4cb55dmr2685805qvh.20.1676299709626;
        Mon, 13 Feb 2023 06:48:29 -0800 (PST)
Received: from borg.redhat.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id z187-20020a37b0c4000000b0070638ad5986sm9878111qke.85.2023.02.13.06.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 06:48:29 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     ogabbay@kernel.org, ttayar@habana.ai, gregkh@linuxfoundation.org,
        dliberman@habana.ai, osharabi@habana.ai, dhirschfeld@habana.ai
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] habanalabs: set hl_capture_*_err storage-class-specifier to static
Date:   Mon, 13 Feb 2023 06:48:14 -0800
Message-Id: <20230213144814.2225707-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports
drivers/accel/habanalabs/common/device.c:2619:6: warning:
  symbol 'hl_capture_hw_err' was not declared. Should it be static?
drivers/accel/habanalabs/common/device.c:2641:6: warning:
  symbol 'hl_capture_fw_err' was not declared. Should it be static?

both are only used in device.c, so they should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/accel/habanalabs/common/device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/common/device.c b/drivers/accel/habanalabs/common/device.c
index fefe70bbbede..a5f5ee102823 100644
--- a/drivers/accel/habanalabs/common/device.c
+++ b/drivers/accel/habanalabs/common/device.c
@@ -2616,7 +2616,7 @@ void hl_handle_page_fault(struct hl_device *hdev, u64 addr, u16 eng_id, bool is_
 		*event_mask |=  HL_NOTIFIER_EVENT_PAGE_FAULT;
 }
 
-void hl_capture_hw_err(struct hl_device *hdev, u16 event_id)
+static void hl_capture_hw_err(struct hl_device *hdev, u16 event_id)
 {
 	struct hw_err_info *info = &hdev->captured_err_info.hw_err;
 
@@ -2638,7 +2638,7 @@ void hl_handle_critical_hw_err(struct hl_device *hdev, u16 event_id, u64 *event_
 		*event_mask |= HL_NOTIFIER_EVENT_CRITICL_HW_ERR;
 }
 
-void hl_capture_fw_err(struct hl_device *hdev, struct hl_info_fw_err_info *fw_info)
+static void hl_capture_fw_err(struct hl_device *hdev, struct hl_info_fw_err_info *fw_info)
 {
 	struct fw_err_info *info = &hdev->captured_err_info.fw_err;
 
-- 
2.26.3

