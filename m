Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FCF693557
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 01:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBLACD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 19:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLACB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 19:02:01 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6FB17CF5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 16:02:00 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id rp23so24050064ejb.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 16:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T3r+eTvnlGs8QcGyNkshXzIKLhYWVKGI3usj0gYt2FY=;
        b=kWIoaSj6enzBwf+x64KfQyC0RP67sigOlOw2oD7U6bYyaI0wwrT/+effeNtLIM92Kq
         4wAClHpRIR5gGqrexz8sSFeUbXyYAJmRrS8G6qVKhO0fd/5lOZvLY1aYY/Unq4hmLPJ7
         zgFqkU9ztEEsFiWwx4ys3Ekx/nDMZdSrRzq0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3r+eTvnlGs8QcGyNkshXzIKLhYWVKGI3usj0gYt2FY=;
        b=zXHZVyAsdlrI8RDDis378twwAJ7POKIsKUxfeooopJWwZgyAuesQtWp0QRfBuWGPFR
         8xmAQHU/Fy+QFIm0sZkJio/Ka32FgyES6k2SjBEPZJRotMJTfmnVEB+4oRXpmm0d/l9O
         Q0rT81l0VtNjVJA0UuHLoTJZ/LRWTMezcTZYXIT6sTuI8QmddxYrqbnUXfnGZJZ60bn9
         6knGavRebAxIKqtgcuGeGxh4o+LLp9uOVzH2gmh3riAy0OF5oaQv5SPJdx8Z6Zx92F2R
         3wUBgPzggOsotT+J4MvfbSUBitstwkwmNvi3ELMzoHPtfYy1sV2ud26/MW0RAPhrLn6p
         GXDg==
X-Gm-Message-State: AO0yUKXmTeL2lKml8ay6Mkz2Jb2ZJZuc1+eYeNQwCK0X/BxJq1MAlW7B
        BdK/BHrgN2tQEpdLHi8lbOWokg==
X-Google-Smtp-Source: AK7set9EK+vyra7QeT1gZqMKjeKcxB+R1wXEVj8oB9apMhijIyinA0ZI605EO1Ho0RnWdXSLqX+Usg==
X-Received: by 2002:a17:907:7292:b0:8ae:b008:9b5a with SMTP id dt18-20020a170907729200b008aeb0089b5amr18319425ejc.69.1676160118803;
        Sat, 11 Feb 2023 16:01:58 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id e26-20020a170906081a00b008786675d086sm4528513ejd.29.2023.02.11.16.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 16:01:58 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Sun, 12 Feb 2023 00:01:44 +0000
Subject: [PATCH] hid: bigben_probe(): validate report count
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230211-bigben-oob-v1-1-d2849688594c@diag.uniroma1.it>
X-B4-Tracking: v=1; b=H4sIAGcs6GMC/x2NQQrDMAzAvlJ8nqFJoJR9ZexgJ17rQ5NhjzEo/
 XvTHYUQ2sHFVBzuww4mX3VttUO4DZBXqougls4Qx5jGGAKyLiwVW2OcS5kmSjllTtADJhdko5r
 XK9nIP2KXeJu89Pe/PJ7HcQIp50W/dQAAAA==
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hanno Zulla <abos@hanno.de>
Cc:     Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676160118; l=1756;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=OMPSYVhRYvHcvLfwdtmJ6/cpcLtWq4w/RyrWibXaM/I=;
 b=dWexqHTyKpOl7IPyHQ7cKPYRWXEJHens+O5S1u3cBff8Mrv9LF/xlp9sbWMF4EdFHCWq4OLI9XuC
 pUsTkf/7CJsHjloeR9eMjGv69TESoDg8Qj/vS92OBI62NTtm/OJ4
X-Developer-Key: i=borrello@diag.uniroma1.it; a=ed25519;
 pk=4xRQbiJKehl7dFvrG33o2HpveMrwQiUPKtIlObzKmdY=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bigben_probe() does not validate that the output report has the
needed report values in the first field.
A malicious device registering a report with one field and a single
value causes an head OOB write in bigben_worker() when
accessing report_field->value[1] to report_field->value[7].
Use hid_validate_values() which takes care of all the needed checks.

Fixes: 256a90ed9e46 ("HID: hid-bigbenff: driver for BigBen Interactive PS3OFMINIPAD gamepad")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 drivers/hid/hid-bigbenff.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
index e8b16665860d..1d0033a008ac 100644
--- a/drivers/hid/hid-bigbenff.c
+++ b/drivers/hid/hid-bigbenff.c
@@ -318,7 +318,6 @@ static int bigben_probe(struct hid_device *hid,
 {
 	struct bigben_device *bigben;
 	struct hid_input *hidinput;
-	struct list_head *report_list;
 	struct led_classdev *led;
 	char *name;
 	size_t name_sz;
@@ -343,14 +342,12 @@ static int bigben_probe(struct hid_device *hid,
 		return error;
 	}
 
-	report_list = &hid->report_enum[HID_OUTPUT_REPORT].report_list;
-	if (list_empty(report_list)) {
+	bigben->report = hid_validate_values(hid, HID_OUTPUT_REPORT, 0, 0, 8);
+	if (!bigben->report) {
 		hid_err(hid, "no output report found\n");
 		error = -ENODEV;
 		goto error_hw_stop;
 	}
-	bigben->report = list_entry(report_list->next,
-		struct hid_report, list);
 
 	if (list_empty(&hid->inputs)) {
 		hid_err(hid, "no inputs found\n");

---
base-commit: 4ec5183ec48656cec489c49f989c508b68b518e3
change-id: 20230211-bigben-oob-8dd66a3c3cb3

Best regards,
-- 
Pietro Borrello <borrello@diag.uniroma1.it>

