Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A226BB52F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 14:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjCONvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 09:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjCONva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 09:51:30 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16391B54D;
        Wed, 15 Mar 2023 06:51:23 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d36so24392832lfv.8;
        Wed, 15 Mar 2023 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678888282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LPqzmTzeR64UgWjKdiepqf9072TIZPdOTEG0IRI2qM=;
        b=KW8A7CP/ivTmXI71sqXwlrPI6QQ0bjZkFCk79qvwLFGrCnfOoV6IDva97eDzyzwUh1
         sAMDAwrkuV8ByrzsRbS/dCgbWBdQUTFpZ3fJrbhCHQWflqjS0u9pmCcXVDExu8CU+yC8
         3XrZ/GhiVqmWT5PX6lU8Qam4jpPy52stRfl4UBXkOTZe6TyUOisqeZIdkTBw35ESC/Pk
         oBmQrA4huxgXFMusp8ggXyjabGhOdatFlZRHWOW/aAsRX9a6Hp+qf+OhNULFisy+VQUu
         FjzhutNu8kHI6+56QZZZZNVoAZ+1t/J+IvA63tPD/+RJPHOFR6deL91n2gs/TZ0loSmF
         siVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678888282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LPqzmTzeR64UgWjKdiepqf9072TIZPdOTEG0IRI2qM=;
        b=nqCdcJ1L5HHeQnGBFdYskeaum9Cx1Al/hncsV42YItd2vlrmxHmKrSX4TTJnD4OOK7
         16Zxsz3NsqGx+Zh6iQS4/vEPqD9DLOOw/u4MA+KOauOU7aJYmE3Wts9yp9O/JzjdRRbc
         0btBT2Jjtxi6N7efkUqAse2IsV5IT+lBzMpAJ2aRJUQh24VdwKWq0iM56U63e0SnkLak
         ZH6xbBWKhwbS1CModrr9SQcbTrFoYv/N9L/Fxb1zrX3Mz2+/0hK2d2MO58J2FxgVjQNn
         HrUZ6jbFVFpFBjSsQveQILIXy7QEduM4m44REH/ZCDiuq3VMt+KiRVYfUls2IO5sWI4s
         AlWg==
X-Gm-Message-State: AO0yUKXNtH9+YVx2eMOyaoXffEA/M+AuvRmzHP1Rl0hOzWzy1lZP1030
        ykko7hAA6MoHURzS5apNNiM=
X-Google-Smtp-Source: AK7set8tgh0+uDN6B3KQerWnMOpSS8b5YgkQbTwrdGp4i+L3fO1DABQN5i3lRHWdlEbI1RIx+cVjHQ==
X-Received: by 2002:ac2:46c7:0:b0:4e8:5392:492c with SMTP id p7-20020ac246c7000000b004e85392492cmr1456797lfo.43.1678888281632;
        Wed, 15 Mar 2023 06:51:21 -0700 (PDT)
Received: from ruslan.. ([178.176.76.115])
        by smtp.gmail.com with ESMTPSA id b5-20020ac25625000000b004e84a8c3d86sm832460lff.42.2023.03.15.06.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:51:21 -0700 (PDT)
From:   Kasumov Ruslan <xhxgldhlpfy@gmail.com>
To:     Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        Kasumov Ruslan <s02210418@gse.cs.msu.ru>
Subject: [PATCH v2] iio: adc: qcom-pm8xxx-xoadc: Remove useless condition in pm8xxx_xoadc_parse_channel()
Date:   Wed, 15 Mar 2023 16:51:14 +0300
Message-Id: <20230315135114.22684-1-xhxgldhlpfy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230314193709.15208-1-xhxgldhlpfy@gmail.com>
References: 
MIME-Version: 1.0
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

The left side of the loop condition never becomes false.
hwchan cannot be NULL, because it points to elements of the
hw_channels array that takes one of 4 predefined values:
pm8018_xoadc_channels, pm8038_xoadc_channels,
pm8058_xoadc_channels, pm8921_xoadc_channels.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Kasumov Ruslan <s02210418@gse.cs.msu.ru>
---
v2: Removed "Fixes" tag as Andi Shyti <andi.shyti@kernel.org> suggested.
 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index eb424496ee1d..64a3aeb6261c 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -758,7 +758,7 @@ static int pm8xxx_xoadc_parse_channel(struct device *dev,
 	/* Find the right channel setting */
 	chid = 0;
 	hwchan = &hw_channels[0];
-	while (hwchan && hwchan->datasheet_name) {
+	while (hwchan->datasheet_name) {
 		if (hwchan->pre_scale_mux == pre_scale_mux &&
 		    hwchan->amux_channel == amux_channel)
 			break;
-- 
2.34.1

