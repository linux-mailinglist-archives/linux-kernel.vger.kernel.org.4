Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D9E69C383
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 01:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBTAOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 19:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjBTAOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 19:14:31 -0500
Received: from irl.hu (irl.hu [95.85.9.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BF3CC01;
        Sun, 19 Feb 2023 16:14:29 -0800 (PST)
Received: from fedori.lan (bc065635.dsl.pool.telekom.hu [::ffff:188.6.86.53])
  (AUTH: CRAM-MD5 soyer@irl.hu, )
  by irl.hu with ESMTPSA
  id 00000000000663A2.0000000063F2BB65.002C6BFB; Mon, 20 Feb 2023 01:14:16 +0100
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
Subject: [PATCH v3 1/3] Input: gpio-keys - add support for linux,input-value DTS property
Date:   Mon, 20 Feb 2023 01:13:02 +0100
Message-Id: <3519a11b0ef5324a2befbd137cd2aa0cb8fd057d.1676850819.git.soyer@irl.hu>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1676850819.git.soyer@irl.hu>
References: <cover.1676850819.git.soyer@irl.hu>
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

Allows setting the value of EV_ABS events from DTS.
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
2.39.2

