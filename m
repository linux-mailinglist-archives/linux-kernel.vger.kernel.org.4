Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC64669BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjAMPPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjAMPPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:15:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538C47ECBE;
        Fri, 13 Jan 2023 07:06:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC9CFB8215B;
        Fri, 13 Jan 2023 15:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0361C433EF;
        Fri, 13 Jan 2023 15:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673622383;
        bh=K7WK57Zb9KRI++qnpMkAWpqHW8Ow1xmRhgfG0Xv2IkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B/hgRiwcLeO63ZeEndTXCiGvpQOrNWHgakC+BVK6xdw/ar3z2vxz7grmlDU9Wg05H
         cPlX4cspQ8K1u5hfLQfvv1VRWPYaqf9KxfK55ydwqmz03v1UAaPNX8MSUsH1UQAaOE
         F0Ofjj20SHLz1Xpaq6PFwGhOoeeqFdxSfNoGXdgVSPQourpV4qhGH+lPfysWptQDzN
         uxkHsM3AePLrpkhxi/jl7WZKrkTNI5qVqaWzMlLp6sUOjJOehu/C3bDzyKXjwHDxIG
         jyzmVS14Mjti+H0My87Lpc/CU8C6I3EIj5H7iA2PbPuIiBhIh4jdr/UZNYkjr4esV3
         mV8vYHiivD5Jw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com,
        avid.rheinsberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH 2/2] HID: uhid: Over-ride the default maximum data buffer value with our own
Date:   Fri, 13 Jan 2023 15:05:57 +0000
Message-Id: <20230113150557.1308176-2-lee@kernel.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
In-Reply-To: <20230113150557.1308176-1-lee@kernel.org>
References: <20230113150557.1308176-1-lee@kernel.org>
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

The default maximum data buffer size for this interface is UHID_DATA_MAX
(4k).  When data buffers are being processed, ensure this value is used
when ensuring the sanity, rather than a value between the user provided
value and HID_MAX_BUFFER_SIZE (16k).

Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/hid/uhid.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
index 2a918aeb0af13..59ac757c1d471 100644
--- a/drivers/hid/uhid.c
+++ b/drivers/hid/uhid.c
@@ -395,6 +395,7 @@ struct hid_ll_driver uhid_hid_driver = {
 	.parse = uhid_hid_parse,
 	.raw_request = uhid_hid_raw_request,
 	.output_report = uhid_hid_output_report,
+	.max_buffer_size = UHID_DATA_MAX,
 };
 EXPORT_SYMBOL_GPL(uhid_hid_driver);
 
-- 
2.39.0.314.g84b9a713c41-goog

