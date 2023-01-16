Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B47D66BC86
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjAPLMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjAPLME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:12:04 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 282A4B44A
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:12:03 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id z11so40271143ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diag.uniroma1.it; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8iSePi43/1oa+PXasTdV2oiRmbbh0AS7xFey01UdB8=;
        b=t8hg+KGoh84kOMTcYtqVrn1jGjAAjFWqVQBvdYr/1UStUvSAZ6BXvorlTMxYWjNhhb
         sAIFjy5UUMwTnsKwwySnFEbhRHN56bE951JfTuKyNKQO1toWG++AOhk6CmIhqWJ7r9Hj
         IZjZO581rCqEOLCtqw5TSP9gm40EgzxbmMnzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8iSePi43/1oa+PXasTdV2oiRmbbh0AS7xFey01UdB8=;
        b=3oTeItlw7bSagIJDSHALF6nDgGbGfe0YTYLTTzB1xdySWu575Z9KJp6tbywalpptMO
         5A5xplQ0WUoq6auwWD0p21Zs8qZavNKdkVryp+OWTeQjaDb6kS434wkfTs1XtChfsSxc
         K/O6bQTSWKSROrGkWotQIlYcrZ3fYWJRfpqYr1KUPB0NeUjEUTym8OETyPO5ofD8jVAt
         pYFYfw9q3KVRR6bygEVB2GUT9y8QItyP4PQFdhhqRq51rK4BzgyHuZ7OoGB6ujJqaaPq
         saCuuBWWVh/m+kNgPocdAsamBnFTVJNNHVWqeFN7hEhdE3F7dKkqbUDDZxuNkuIZVEW3
         Arqg==
X-Gm-Message-State: AFqh2kor6/kzyAUZWeUNu2ZPKQ4cozMt6o0TzORG7X4N63d5Xumd4T8M
        2zGQEnwm25i3/uwdmm6yJI9JXQ==
X-Google-Smtp-Source: AMrXdXv6TFEdiWntsO1tjHxNabDcEcoLUwHotCmNHH/iJGi1E2185mgAXI+YWrRTMFa7kC5MiZeVUQ==
X-Received: by 2002:a05:6402:e0f:b0:468:58d4:a0f2 with SMTP id h15-20020a0564020e0f00b0046858d4a0f2mr87788527edh.23.1673867521686;
        Mon, 16 Jan 2023 03:12:01 -0800 (PST)
Received: from [192.168.17.2] (wolkje-127.labs.vu.nl. [130.37.198.127])
        by smtp.gmail.com with ESMTPSA id dk1-20020a0564021d8100b0049be07c9ff5sm4116903edb.4.2023.01.16.03.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 03:12:01 -0800 (PST)
From:   Pietro Borrello <borrello@diag.uniroma1.it>
Date:   Mon, 16 Jan 2023 11:11:25 +0000
Subject: [PATCH 2/2] HID: check empty report_list in bigben_probe()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230114-hid-fix-emmpty-report-list-v1-2-e4d02fad3ba5@diag.uniroma1.it>
References: <20230114-hid-fix-emmpty-report-list-v1-0-e4d02fad3ba5@diag.uniroma1.it>
In-Reply-To: <20230114-hid-fix-emmpty-report-list-v1-0-e4d02fad3ba5@diag.uniroma1.it>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Kees Cook <keescook@chromium.org>, Hanno Zulla <abos@hanno.de>
Cc:     Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jkl820.git@gmail.com>,
        Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Pietro Borrello <borrello@diag.uniroma1.it>
X-Mailer: b4 0.11.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1673867519; l=1136;
 i=borrello@diag.uniroma1.it; s=20221223; h=from:subject:message-id;
 bh=XYXrgNLtkM9f60Vo/ecJS9HAYWzb6NUELifPUuIruDU=;
 b=vLu1y0BiQa9KA1E8lDi8s2talWDgpEgLlLaAXA2rWuFanZp7a0Pv/AQhZQdS8easf6PqMc60XpAV
 FBCnpj0dAM2Ll3mOUTLNfobbFBjv/3U6c/IVbN7nxAuj+ACK81Uy
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

Add a check for empty report_list in bigben_probe().
The missing check causes a type confusion when issuing a list_entry()
on an empty report_list.
The problem is caused by the assumption that the device must
have valid report_list. While this will be true for all normal HID
devices, a suitably malicious device can violate the assumption.

Fixes: 256a90ed9e46 ("HID: hid-bigbenff: driver for BigBen Interactive PS3OFMINIPAD gamepad")
Signed-off-by: Pietro Borrello <borrello@diag.uniroma1.it>
---
 drivers/hid/hid-bigbenff.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/hid/hid-bigbenff.c b/drivers/hid/hid-bigbenff.c
index e8c5e3ac9fff..e8b16665860d 100644
--- a/drivers/hid/hid-bigbenff.c
+++ b/drivers/hid/hid-bigbenff.c
@@ -344,6 +344,11 @@ static int bigben_probe(struct hid_device *hid,
 	}
 
 	report_list = &hid->report_enum[HID_OUTPUT_REPORT].report_list;
+	if (list_empty(report_list)) {
+		hid_err(hid, "no output report found\n");
+		error = -ENODEV;
+		goto error_hw_stop;
+	}
 	bigben->report = list_entry(report_list->next,
 		struct hid_report, list);
 

-- 
2.25.1
