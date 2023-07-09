Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581B474C0BB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 05:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGIDsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 23:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjGIDsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 23:48:12 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78181E4D
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 20:48:11 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso5090072e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jul 2023 20:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688874489; x=1691466489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7lSjPQNhr0BWjor5LdaN815hU/chfe4hoYUxqnTCAI=;
        b=k3IRY5xwt8qJIv7SfJiV73BLBZgOE7DBWFEiap7mJyO/HbBphYtUffF1Jlup/HJrEs
         /JjyZzFYlvaXKS9K0P433ZpGG7vnO6bVweICxU7jBwIn8ZtljMASfo8Om07veq/h9ZGK
         sQIkamitoxVnF8DeYjDEvD4mHNcq4CEG9z3V/4/KDIbk7/0IqhDgKc9HLOH2XgQFkGQo
         cN0JwDH0qY6DAWunwHNTrQFlThCKDvI2KQ+P50qQbvO4KZ+DnBMxU9WIyJ3KEqyTJwE4
         6xKmkeIQmeJZ/kYdXwvaZBLJ844U7JCjAiEFAqoaFZV1no/uRpF41v5qpTBY3j/lC620
         fK5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688874489; x=1691466489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7lSjPQNhr0BWjor5LdaN815hU/chfe4hoYUxqnTCAI=;
        b=PasZ32K5LncMFyAjpAg2Cn/DoGoeAOgm2WCK3ccZWVGWIMHOpNsYkeFOre2WMxfV6d
         1k87AA0ksOVETgnnRc6xHnvQ5whzSfYBCE+rISvuCsPL7rzFub5Qvrf3em3+ZqhsAoTd
         8kFaWu/UIrUNvgAav9wnXz+AookQc20SEbTKfHogMd7fDWeKcc7662r/EqK8+uD9rgFW
         9lyHrmVUDI5MY1dMcfMTwnlg78skN3recdHYpnRyKWTTTyH1zw2TuUCH3jHAt+PzSc+2
         yjotOc54Bl4ugOmk3V8Hyv9D6TwzUVPaIw8jmwl72eXidVZoFZcLCqrwGJl5sWlK+Vkd
         sbEg==
X-Gm-Message-State: ABy/qLbpEhh+CowZ3Y7poKHD30YSgi7zqf5bbozU5fh4MZ6EhqvPIzPV
        qQYpxis3sF0cGwKowjNj768sVg==
X-Google-Smtp-Source: APBJJlGBWLJww4zVZJn5slMiO1WRJFBNn0Jw1gOm5v8j+Z/fPCJHt1d9NrO2xEnhmnI4idxJcFQ0iw==
X-Received: by 2002:a19:e059:0:b0:4f8:6d54:72f9 with SMTP id g25-20020a19e059000000b004f86d5472f9mr6239729lfj.61.1688874489726;
        Sat, 08 Jul 2023 20:48:09 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id u23-20020a2e9b17000000b002b70206cd45sm1398633lji.90.2023.07.08.20.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 20:48:09 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/2] usb: typec: altmodes/displayport: add support for embedded DP cases
Date:   Sun,  9 Jul 2023 06:48:07 +0300
Message-Id: <20230709034808.4049383-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709034808.4049383-1-dmitry.baryshkov@linaro.org>
References: <20230709034808.4049383-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the embedded cases, the DisplayPort connector is handled by the TCPM
itself. Fallback to the controller fwnode for HPD notifications to
support such usecases without requiring additional DT properties.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/altmodes/displayport.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 4e5aa17ce4c8..699438c7755e 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -578,7 +578,10 @@ int dp_altmode_probe(struct typec_altmode *alt)
 	alt->ops = &dp_altmode_ops;
 
 	fwnode = dev_fwnode(alt->dev.parent->parent); /* typec_port fwnode */
-	dp->connector_fwnode = fwnode_find_reference(fwnode, "displayport", 0);
+	if (fwnode_property_present(fwnode, "displayport"))
+		dp->connector_fwnode = fwnode_find_reference(fwnode, "displayport", 0);
+	else
+		dp->connector_fwnode = fwnode_handle_get(fwnode); /* embedded DP */
 	if (IS_ERR(dp->connector_fwnode))
 		dp->connector_fwnode = NULL;
 
-- 
2.39.2

