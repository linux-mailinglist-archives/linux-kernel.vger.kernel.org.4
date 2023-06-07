Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1C77254BB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbjFGGu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbjFGGuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:50:23 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C941994;
        Tue,  6 Jun 2023 23:50:22 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-19f30256921so7736825fac.1;
        Tue, 06 Jun 2023 23:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686120622; x=1688712622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9pDlIdyeQah+nboO5HAEZGHCKY6oxRAm/f74A2r54DE=;
        b=K/5+lX3Rx/b9mCkIad9707Zrdek3bum2r/NRWAiKd39cLn0hUsMr9qgeKQ7oBvHZy7
         VLV3aV962rIbLV8A5Is/1e15Kx86HhfwzADXNEfQO46LGdU3uVmgv665GsW1YoJhQXk9
         W8mAQfuVFyy+CeONIFJ/vaVcdQIuTsfZgGaflwWvqMpVAfjH+in1STpoTAl1TsM/aI/J
         7uEba6ZzpMoGOueGivegCM0MGbHXuQq7vnM4zXYvUkzM1EvODmIOUNVZU4JsetaJPf+H
         v+NX9jCiNo1VJ47dpvHSc5Oe2+IV6qzdo/jcraLWPSxnoXza7i5qGTzUv0NHq4lE3J2T
         nQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686120622; x=1688712622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pDlIdyeQah+nboO5HAEZGHCKY6oxRAm/f74A2r54DE=;
        b=HIHiUwY67iY6mfHdtBsopFxFxjRfSMlpgZXcXrIAWZiC0/cyrJj5dlZTCqzGhm1+uw
         9zG7jCS4xKzBSqY+dVNXbbBwbdBxgaN9t/PwNEh15XOLpS7V1YYYmzqYmWr7OIPSzg7F
         vWzr/xdyhXBH1x09njpi9AjlWjYRiOhg20OMKg3mUBDckFwIRxdhdGFRHlIRu+XZpUc9
         LgfWnfC/WGK8NxMdTbiEbcWXZ2fBWvtEZu0OiXQjiJh2hHAxYTy8LL+tXMfCl30jQCHH
         WwLscxSx89Js8SjwdzWS7FeRH+CK8QbyrnwdBwU9AOPiZ8Sr18vXLBWL4wfoKUPKps1k
         Jmgw==
X-Gm-Message-State: AC+VfDyOkGy787rryvbPkYVQbZIs2dg9CFEDsFzMK0qdqT+MJrhBg0kv
        RnSTY28if4TKeDYX1AIIEd3iwKFg8zE=
X-Google-Smtp-Source: ACHHUZ4Rar7VJ5sL8BOFbamwHsckno07VzQu65vOeB1XPIAYpkKo5IxLKw3bVSbx4jRzPzx1b1mJAQ==
X-Received: by 2002:a05:6871:84c5:b0:196:12ec:110a with SMTP id sw5-20020a05687184c500b0019612ec110amr6909714oab.48.1686120621991;
        Tue, 06 Jun 2023 23:50:21 -0700 (PDT)
Received: from sol.home.arpa (194-223-178-180.tpgi.com.au. [194.223.178.180])
        by smtp.gmail.com with ESMTPSA id 200-20020a6301d1000000b0051ba9d772f9sm8504026pgb.59.2023.06.06.23.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jun 2023 23:50:21 -0700 (PDT)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH] gpio: sim: quietly ignore configured lines outside the bank
Date:   Wed,  7 Jun 2023 14:50:04 +0800
Message-Id: <20230607065004.37112-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user-space policy of the gpio-sim is that configuration for lines
with offsets outside the bounds of the corresponding bank is ignored,
but gpio-sim is still using that configuration when constructing the
sim.  In the case of named lines this results in temporarily allocating
space for names that are not used, and for hogs results in errors being
logged when the gpio-sim attempts to register the out of range hog with
gpiolib:

gpiochip_machine_hog: unable to get GPIO desc: -22

Add checks to filter out any line configuration outside the bounds
of the bank when constructing the sim.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---

This is based on for-next patched with my recent memory corruption fix,
as it touches a bit of the same code.

Cheers,
Kent.

 drivers/gpio/gpio-sim.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpio/gpio-sim.c b/drivers/gpio/gpio-sim.c
index fab67a5785d7..8b49b0abacd5 100644
--- a/drivers/gpio/gpio-sim.c
+++ b/drivers/gpio/gpio-sim.c
@@ -696,6 +696,9 @@ static char **gpio_sim_make_line_names(struct gpio_sim_bank *bank,
 	char **line_names;
 
 	list_for_each_entry(line, &bank->line_list, siblings) {
+		if (line->offset >= bank->num_lines)
+			continue;
+
 		if (line->name) {
 			if (line->offset > max_offset)
 				max_offset = line->offset;
@@ -722,6 +725,9 @@ static char **gpio_sim_make_line_names(struct gpio_sim_bank *bank,
 		return ERR_PTR(-ENOMEM);
 
 	list_for_each_entry(line, &bank->line_list, siblings) {
+		if (line->offset >= bank->num_lines)
+			continue;
+
 		if (line->name && (line->offset <= max_offset))
 			line_names[line->offset] = line->name;
 	}
@@ -756,6 +762,9 @@ static int gpio_sim_add_hogs(struct gpio_sim_device *dev)
 
 	list_for_each_entry(bank, &dev->bank_list, siblings) {
 		list_for_each_entry(line, &bank->line_list, siblings) {
+			if (line->offset >= bank->num_lines)
+				continue;
+
 			if (line->hog)
 				num_hogs++;
 		}
@@ -771,6 +780,9 @@ static int gpio_sim_add_hogs(struct gpio_sim_device *dev)
 
 	list_for_each_entry(bank, &dev->bank_list, siblings) {
 		list_for_each_entry(line, &bank->line_list, siblings) {
+			if (line->offset >= bank->num_lines)
+				continue;
+
 			if (!line->hog)
 				continue;
 

base-commit: ba65c79fbb813423e7d42d99375e2045b27958a6
prerequisite-patch-id: d89da2e3b7511c5b8132a379b12e4996256ac214
-- 
2.40.1

