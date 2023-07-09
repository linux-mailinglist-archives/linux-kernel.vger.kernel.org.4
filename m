Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E3574C80C
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 22:13:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjGIUNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 16:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjGIUNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 16:13:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC37B12A
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 13:13:12 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f766777605so5682916e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jul 2023 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688933591; x=1691525591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7lSjPQNhr0BWjor5LdaN815hU/chfe4hoYUxqnTCAI=;
        b=T5GzhtTyJjxGyLP24p+UvR8XLrB4NVRE7/XTXnHdYuT77xZjInL1SKJoXJXffjIa3e
         hUxY+aw8lZWYqavxNLsCk072IIDUzC27HS4WGJjZhXR6GsfqE10BM1LBkwHterRl5vYD
         ZZpRxt9ZEOzVu8OD6ELJrTwnL7hAce86y6Zu3nEHY41nQRqGO4d2lL6oczaA5sMUXdGZ
         tTI72OzMVuaNd9VhQlcEkzCJSz3O24Yxw8ShDUL5aJ40jVI19BKcsNB816PUuO2Xrh+A
         p5v5DPBxmn7jF+kjqdLcVz+cBYXAEdUdI6eg8XjNXCEM+dl+kHMyU/d/B8Rk+6zwPitS
         WvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688933591; x=1691525591;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c7lSjPQNhr0BWjor5LdaN815hU/chfe4hoYUxqnTCAI=;
        b=QMuBA9SJN9bSZMuGq/v7/bbFCa+zb3jhchM8Q7AQ28tnRddA4iDHjmIxv5IqHPrMgP
         BimHTSbTYmVd8fOwQI8mtZLwrPnQUQqtvSUGAXqyYTcAQWuyQ6ZOYKXuHbnAkvQmES6I
         yOlNFAz1xSEoLwZi25Md4opgVj0uMdSR5WqHa7f+sU1UaLioRZMQuI2gw2lDx39+Ltmn
         Nm7lMYg457I93IqOUVnD7b8EWjHzxiVZVfjggsYqFzNmjljVHem0kvy7PPjCQNnZ5Xi5
         qQavDL/EmZeiSFIJHHAbQP/MgPzSLvVUfVgD5ayMQjbiTVvI44zCyYF0+Mc9rTbuFdq1
         7r5g==
X-Gm-Message-State: ABy/qLY/5DIefT4xWQU9wgSFyFbH4wYuD7zuz4pLPoAOypv4D54wjyBr
        iimjpnTiJvBO2MEZrugYl+sUgg==
X-Google-Smtp-Source: APBJJlFZuEiOyJs+Wxo5yotGxmFY/kIczdsa1ko9Q5u26MRMkHnsWnGRIo9a62sNAbznJh5fjeHpqw==
X-Received: by 2002:a05:6512:3295:b0:4f8:770f:1b0b with SMTP id p21-20020a056512329500b004f8770f1b0bmr7078397lfe.33.1688933591071;
        Sun, 09 Jul 2023 13:13:11 -0700 (PDT)
Received: from lothlorien.lan (dzdqv0yyyyyyyyyyybm5y-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::ab2])
        by smtp.gmail.com with ESMTPSA id c12-20020ac2530c000000b004fb77d6cab3sm1420378lfh.261.2023.07.09.13.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jul 2023 13:13:10 -0700 (PDT)
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
Subject: [PATCH v2 1/2] usb: typec: altmodes/displayport: add support for embedded DP cases
Date:   Sun,  9 Jul 2023 23:13:08 +0300
Message-Id: <20230709201309.274306-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709201309.274306-1-dmitry.baryshkov@linaro.org>
References: <20230709201309.274306-1-dmitry.baryshkov@linaro.org>
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

