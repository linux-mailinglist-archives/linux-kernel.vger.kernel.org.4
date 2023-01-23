Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41BF677B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbjAWMjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:39:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbjAWMje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:39:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FE9E392;
        Mon, 23 Jan 2023 04:39:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D21E560EBA;
        Mon, 23 Jan 2023 12:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0AD4C4339E;
        Mon, 23 Jan 2023 12:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674477573;
        bh=1PI2T5xveMfDhZZ24HxZ12AYBSpicLQJgjLOms+7IWc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TfBWCxrKATaYDGEuyWhveiyfP9aPAsTaSIWR9VUX5yKLfK+bordjPFzspyg0nFE1g
         ndmdMJMrExgEN1AtuTd/lv/2Aau89XPTDBIJYHgix+i5MD2jAWfa13i8bnEZw5/0oq
         lW/BRtPJhd1VRDX2p3xndEnGfhA9t9ruCbf3lTaoDcOK+9/dvGfGwbEwzlmdboP3C1
         Mdt4OE27WKb3DBHhs5agMj/1jH2WRhJz/LKP6/xe88/iPOU7qB3kewR5HX7kWjYI9f
         YbFzI2ldw06X1maCex40r7Wdh9kzM9CxXDXMzzP9vNCFbJjNo8I3jnJcm6HWEi++6G
         qV9fCkEtMgZaQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com,
        avid.rheinsberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [PATCH v2 2/2] HID: uhid: Over-ride the default maximum data buffer value with our own
Date:   Mon, 23 Jan 2023 12:39:12 +0000
Message-Id: <20230123123912.360651-2-lee@kernel.org>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
In-Reply-To: <20230123123912.360651-1-lee@kernel.org>
References: <20230123123912.360651-1-lee@kernel.org>
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
2.39.0.246.g2a6d74b583-goog

