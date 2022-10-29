Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC3CC6122BE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJ2MFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJ2ME6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:04:58 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB7715FFC;
        Sat, 29 Oct 2022 05:04:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id y16so9680900wrt.12;
        Sat, 29 Oct 2022 05:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYj6Sp/cMz1QQGhnefYTJGzG4F2mZ1RWGEdTPlv3qKQ=;
        b=dBztWbMdS8h8kYTzJohC6XiLtiEU7jiY2iKeUlLFpIZlu0uOolzIB3RdRmnLZHtImj
         tLHvzRD3/Kei173N7Am8Xd3FBCOk2VSiD2KnMI40kCIf1evjqtxSfVCDb8NK3KV6k3GW
         NPQ72X3AQ8lGxV9PnBDkjXJLYAtuVOTXqT4a5dzlBQ5AkQuLSkeUQ2Tl2gK4mOB/30zY
         USbqwfBMeki5H4LfiwLsGIBXFfbwCDWrBCcY12ciV3Dur6o4c7qMfkgYTf0wIr+y59Jg
         0lD4NrWn9Jh3i2A0z3OTxlZnQQi6wkdeRLNP3GSD1psBn74q1oF+qTlQLanJRiBzS4e+
         vdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYj6Sp/cMz1QQGhnefYTJGzG4F2mZ1RWGEdTPlv3qKQ=;
        b=XDwYVbG9urlsdYnw4LwW6JnL6K4a4fSPRdyS/90bzI5idWoRfsu4phXrug2JezaZsq
         38Z8ikewoZLT2kyBnx0+Ht4QnXWC1+4FTjPM4PHobZm0u1LwJkV98Jx4GGmMoIysopEy
         rE27bmUIk0dkUHYukcVCbOuedLY5ZFUrkNf3X5V/zTbNOe5UMUQQ03nWeFQuJX+ipczm
         thsno1AZjshBuA2aV4TuVQEF5z6T9s6ePAd7hMR51sgAiRsS9NjHx/gaWdIyov+JQeoM
         N8wZTCFVkwFDcylRAjgKNk81nZ/jspnGp3GSTxB8ZgoxzsW5lT3fIPFFSld2sYH4sFCv
         XCUA==
X-Gm-Message-State: ACrzQf3005jQ/353c37hM22hQYh8upFUSspYlle+U3Ykp+IvJJzO9jMP
        Tc+xKlNpZQ9ievgEZrcg2Cy7+hKkSAXjwg==
X-Google-Smtp-Source: AMsMyM4OkiA9Gi3OyDCgw8PNiMvDWlI+WrztsTwmStHPclCL2TucObpKPQ8f75eqo+ygMGX7z24VJQ==
X-Received: by 2002:a5d:6484:0:b0:230:7cad:c268 with SMTP id o4-20020a5d6484000000b002307cadc268mr2294941wri.335.1667045077968;
        Sat, 29 Oct 2022 05:04:37 -0700 (PDT)
Received: from eray-Lenovo-Z50-70.. ([188.132.247.187])
        by smtp.googlemail.com with ESMTPSA id z17-20020a05600c0a1100b003b492753826sm1472439wmp.43.2022.10.29.05.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 05:04:37 -0700 (PDT)
From:   =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        ike.pan@canonical.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        hdegoede@redhat.com, mgross@linux.intel.com, pobrn@protonmail.com,
        =?UTF-8?q?Eray=20Or=C3=A7unus?= <erayorcunus@gmail.com>
Subject: [PATCH v2 7/7] platform/x86: ideapad-laptop: Don't expose touchpad attr on IdeaPads with SYNA2B33
Date:   Sat, 29 Oct 2022 15:03:12 +0300
Message-Id: <20221029120311.11152-8-erayorcunus@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221029120311.11152-1-erayorcunus@gmail.com>
References: <20221029120311.11152-1-erayorcunus@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My 520-15IKB (2017) with SYNA2B33 doesn't have working VPCCMD_W_TOUCHPAD command -
it's the touchpad program switches the touchpad instead on Windows. Considering
all IdeaPads with SYNA2B33 touchpad produced in 2017/2018, it's very likely that
none of the IdeaPads with SYNA2B33 support touchpad switching via EC. So let's
add SYNA2B33 to the touchpads not switchable via EC.

Signed-off-by: Eray Orçunus <erayorcunus@gmail.com>
---
 drivers/platform/x86/ideapad-laptop.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index b34fbc4d741c..937126c62a14 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1621,8 +1621,12 @@ static void ideapad_check_features(struct ideapad_private *priv)
 				"Could not find PCI* node in the namespace\n");
 	}
 
-	/* Most ideapads with ELAN0634 touchpad don't use EC touchpad switch */
-	priv->features.touchpad_ctrl_via_ec = !acpi_dev_present("ELAN0634", NULL, -1);
+	/*
+	 * Most ideapads with ELAN0634 and SYNA2B33 touchpads don't use
+	 * EC touchpad switch
+	 */
+	priv->features.touchpad_ctrl_via_ec = !acpi_dev_present("ELAN0634", NULL, -1) &&
+					      !acpi_dev_present("SYNA2B33", NULL, -1);
 
 	if (!read_ec_data(handle, VPCCMD_R_FAN, &val))
 		priv->features.fan_mode = true;
-- 
2.34.1

