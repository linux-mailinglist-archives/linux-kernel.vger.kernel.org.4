Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F4D672D03
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjARXxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:53:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjARXww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:52:52 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A7C4AA7E;
        Wed, 18 Jan 2023 15:52:07 -0800 (PST)
Received: from fedori.lan (c3e47541.dsl.pool.telekom.hu [::ffff:195.228.117.65])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 0000000000068C0C.0000000063C884ED.0028DB17; Thu, 19 Jan 2023 00:46:53 +0100
From:   Gergo Koteles <soyer@irl.hu>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>,
        Gergo Koteles <soyer@irl.hu>
Subject: [PATCH 1/3] Input: gpio-keys - add support for linux,input-value dts property
Date:   Thu, 19 Jan 2023 00:46:36 +0100
Message-Id: <20230118234638.189098-2-soyer@irl.hu>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118234638.189098-1-soyer@irl.hu>
References: <20230118234638.189098-1-soyer@irl.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows setting the value of EV_ABS events from dts.
This property is included in the gpio-keys.yaml scheme, but was only
implemented for gpio-keys-polled.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
---
 drivers/input/keyboard/gpio_keys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/keyboard/gpio_keys.c b/drivers/input/keyboard/gpio_keys.c
index 5496482a38c1..c42f86ad0766 100644
--- a/drivers/input/keyboard/gpio_keys.c
+++ b/drivers/input/keyboard/gpio_keys.c
@@ -770,6 +770,9 @@ gpio_keys_get_devtree_pdata(struct device *dev)
 					     &button->type))
 			button->type = EV_KEY;
 
+		fwnode_property_read_u32(child, "linux,input-value",
+					 (u32 *)&button->value);
+
 		button->wakeup =
 			fwnode_property_read_bool(child, "wakeup-source") ||
 			/* legacy name */
-- 
2.39.0

