Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256B970A57D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 07:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjETFHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 01:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjETFHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 01:07:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732D1E40
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:07:35 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-53487355877so1250710a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 22:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1684559255; x=1687151255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLfhWFWhRnJrb9n2LabL3N4xYn3hRlJodRzxs9jLlNk=;
        b=4l1iWqVn+p4B/DtwSZWXKsnFQCuUF7jVLvfWAMgYvf3z6jl5I/1cfqATp6CHfzL56M
         T29X3OfFpeu46dXP0DTGQLlfxbNOWs9f3zsHzicQL3ENGyWbau7Ut2EobPij89dkeNU4
         iLU1zf+6UINJlEppHuxpEE1PI5fEM/n8Xie8+4daA/Fg/+UTw/SvJfuE9cZZ4dROYwF4
         VYybjQy+AXbYWnZjIwNkqfYyLA8P0D5YI+yqbTfueyC//ADlLSyVPtrKebuhYX9pgPfu
         6LFndjfsvt65rHxY1pL6RP8YUMdU1yA9vp4DK/GzNWzkHFwHFs8IIuesqW+4VdjV+Rvy
         Xwwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684559255; x=1687151255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLfhWFWhRnJrb9n2LabL3N4xYn3hRlJodRzxs9jLlNk=;
        b=bmZmtaFng6knJiHnr4u07fddoHN49cCi4OHjkJpoTpudnO+ArXtbBhEXyYCP2nU3PI
         3cN7FCzrJA6D+IVRjYq4ppYWVSzPcj+DKRO+pAAix6r39MCurWcSdySTP3YrSjh2FhZx
         ZKALVE8a/9jrAaU3s506UDSWPpU/cFsbVLtOZRkgFWI8YaFZH9hTuBIfUbgxWZ2S5JEJ
         Cg5QMm3BAA8fHgP962Z2qZiSEqyjy3PEFLD1xpBn1RuYZjQ/w4yH5ArNvSrCsF3eeigv
         iL7zstLwJ9Xn9g9dM5tYCoX2GRhjfLQj+fmRTDPKrweJOaxVoB9Pb5p9/kvk6vhGo5VC
         lqyQ==
X-Gm-Message-State: AC+VfDxdqj+526xhhzKOQYHLcpHKC1rA953HI3V3qu8NgDvU8wG8PlBS
        64HOEZWJC8MIapL4Sqy9sSy1nA==
X-Google-Smtp-Source: ACHHUZ7bE+wcxNdvlZzLrWkKAg8OGy8DsN4IVNhlPJ0NapeY9zgFCUta+vjbokmi2DUOge4yvwP54w==
X-Received: by 2002:a17:90b:4f4e:b0:24e:4231:ec6b with SMTP id pj14-20020a17090b4f4e00b0024e4231ec6bmr4061182pjb.21.1684559254931;
        Fri, 19 May 2023 22:07:34 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id jf9-20020a170903268900b0019e60c645b1sm476725plb.305.2023.05.19.22.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 22:07:34 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     dianders@chromium.org
Cc:     benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, hsinyi@google.com, jikos@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, yangcong5@huaqin.corp-partner.google.com
Subject: [v2 1/2] HID: i2c-hid: elan: Add ili9882t timing
Date:   Sat, 20 May 2023 13:06:48 +0800
Message-Id: <20230520050649.2494497-2-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230520050649.2494497-1-yangcong5@huaqin.corp-partner.google.com>
References: <CAD=FV=VYfPSwar2AXBxB3vX0dV1kjQ5bZMxsEBFhUnMNRXbBCw@mail.gmail.com>
 <20230520050649.2494497-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ili9882t is a TDDI IC ((Touch with Display Driver)). It requires the
panel reset gpio to be high before i2c commands. Use a longer delay in
post_power_delay_ms to ensure the poweron sequence.

Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
---
 drivers/hid/i2c-hid/i2c-hid-of-elan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
index 76ddc8be1cbb..dd2435270e73 100644
--- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
+++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
@@ -105,8 +105,15 @@ static const struct elan_i2c_hid_chip_data elan_ekth6915_chip_data = {
 	.hid_descriptor_address = 0x0001,
 };
 
+static const struct elan_i2c_hid_chip_data ilitek_ili9882t_chip_data = {
+	.post_power_delay_ms = 200,
+	.post_gpio_reset_delay_ms = 180,
+	.hid_descriptor_address = 0x0001,
+};
+
 static const struct of_device_id elan_i2c_hid_of_match[] = {
 	{ .compatible = "elan,ekth6915", .data = &elan_ekth6915_chip_data },
+	{ .compatible = "ilitek,ili9882t", .data = &ilitek_ili9882t_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, elan_i2c_hid_of_match);
-- 
2.25.1

