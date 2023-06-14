Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3A072FF96
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244868AbjFNNLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbjFNNLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:11:11 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0401F2684
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:10:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f8d61cb36cso6957785e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 06:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686748244; x=1689340244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HclWVyX80bhOFPdvQBpaJpPvaaJ2GD6Ys/9aQx4/1wc=;
        b=ZSdd12LYj/Kv9D9GAb3sJ3+7Bo5IpcnzyxCjSPxGpNG5wlx4ijp8JvuERRYOFYjHBo
         7lbCTh+CK/nvTRcuanXk06s+mtaO6/zQDNh7r0YGHkgUQPVw7XJVvjkIQtQ6WjoL7nXz
         +5I4LTQTFfXgukUbcI5rJlZRa7t53ErPqdZdpXrFdPm+nqn4ffXjPEgtOX9jfbnK8isz
         BGHVAeQoSg3/2krtGW3xbIcmE1AN/vKrs5AFcd6cAvBupCU0Ql3pcWlYk4IupDW4pG+B
         d8sD+emx6XWBpqhUK+R4ATqU+gI5lbrnuwiV5E4K4ysRumkgRKcVXfgSFaiWh4kYsk85
         e7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686748244; x=1689340244;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HclWVyX80bhOFPdvQBpaJpPvaaJ2GD6Ys/9aQx4/1wc=;
        b=DbQ7t1nrae4jMeEQ8nPnPmOuLaPZPPPEoGbldjJGVwl+SyU7GTIYMr69ek9uBpFKYf
         vAhmIdJzFTDQr0hr52BCl+ce2XFDEKD6r8z/QJYcCnloGzyIVPLEpCjMj1jUM9gMpeXp
         9odNdB8gYFh2N5ra7jXpJumOJGjlRDoqm0QJ2N1YLBTXkSUuZEoSb+e4BITejuR54+Ss
         uBIiaFAQR3kz4Yf9wAaWT+Xamsi3WJOSEC/nGx72ks7N2+FEWyz0l6WNPmvpiRf42MbL
         LHLatBGJFqG55nvjOHX+44XqjxssWQn4qnVTRvtwm71pzYycJ7E7ti7emRZOpoH1wyT4
         nJZA==
X-Gm-Message-State: AC+VfDx7sSzMS5MqVir6Ly5sxhBJaipxe181ol3wAFNe9IRPCSgnxwy8
        1x/2BUB0acnBvGPyYOVvYmBxtA==
X-Google-Smtp-Source: ACHHUZ4Tu7DdIbjz+CQUImQwiBv2U020Y2/C3uQep0sjkwJlz93iyXariO6Qg3fKaDSpci4DHgQswQ==
X-Received: by 2002:a05:600c:2141:b0:3f8:afe:5c40 with SMTP id v1-20020a05600c214100b003f80afe5c40mr10867975wml.1.1686748244505;
        Wed, 14 Jun 2023 06:10:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id a7-20020a05600c224700b003f60a9ccd34sm17548661wmm.37.2023.06.14.06.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 06:10:44 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 14 Jun 2023 15:10:39 +0200
Subject: [PATCH 1/3] usb: typec: ucsi: call typec_set_mode on non-altmode
 partner change
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230614-topic-sm8550-upstream-type-c-audio-v1-1-15a92565146b@linaro.org>
References: <20230614-topic-sm8550-upstream-type-c-audio-v1-0-15a92565146b@linaro.org>
In-Reply-To: <20230614-topic-sm8550-upstream-type-c-audio-v1-0-15a92565146b@linaro.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1579;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=PGFbR5syJg5NTdmizgxwbBoZ3GYDeK4EiGxX2vNbnno=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkibxReHuJHWn9DyKqKHMz06Y4DW1u0rOTKOJfwIzb
 FgBpCTSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIm8UQAKCRB33NvayMhJ0VwfD/
 sHgM9OXt8gMsAv2gGSYhLccRScaCG/+Z6W1x85rxqst2icVK6hShU50RSvVaRMYzedbI2MNKv7xtG/
 F5mJSNpVubPaUU8XPpiwAMpjLGnUQm8peyOf+z/K5ibXwqNqpCgJGguKD9WsHiwRt/VIug9O16KAth
 wDjK6eEc/hmIVc5ecxrasDNz0MqDroZC55MTwMJTs0/KUlM9Puqh3kczG619xFat+bMHfiMDPiWGYZ
 f0AWFMO+yb7P9hE6DcUWXt4tirFEKrgXi6vFSaqPguShzRGKwLi8eMkaLH7qxtNulQ6kn4A2EK+81k
 SQNz2ILxub286IaifHPO2eHl+mJstwxR3hMjE4cfF5T3J4g2U2yoLeBp+jiEgA+jAOEe6roRAclqEL
 FDTSPOP5cLvKecUHZGK1mNRZ0PanlZWaIc8i71ueKXETeEuNDkblmiEuXKEEf3Ch+wKYn8+LavsOFw
 W50yvT0UM8y+iXkAXxBdwYgMHSMMHeH1nuRDKe43sLXps6MfFpuh3i6kl4Vgy4Csfhez+qilS+IdBv
 aHD3ZWky21K+TgwNrcAL+euKWdn9APOwYDN0uE+CTmI01ouMdFEjhr+ZNWHvm0hMUmDyJ8kpwS+7pc
 kFns3U2Mo7sg3fjaBeFCX0JzvnvJg/siXItbawJL1Npt/f78CZkCdbkgU9Dw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for calling typec_set_mode() for the DEBUG, AUDIO
accessory modes.

Let's also call typec_set_mode() for USB as default and SAFE
when partner is disconnected.

The USB state is only called when ALT mode is specifically
not specified by the partner status flags in order
to leave the altmode handlers setup the proper mode to
switches, muxes and retimers.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 2b472ec01dc4..44f43cdea5c1 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -809,6 +809,23 @@ static void ucsi_partner_change(struct ucsi_connector *con)
 		break;
 	}
 
+	if (con->status.flags & UCSI_CONSTAT_CONNECTED) {
+		switch (UCSI_CONSTAT_PARTNER_TYPE(con->status.flags)) {
+		case UCSI_CONSTAT_PARTNER_TYPE_DEBUG:
+			typec_set_mode(con->port, TYPEC_MODE_DEBUG);
+			break;
+		case UCSI_CONSTAT_PARTNER_TYPE_AUDIO:
+			typec_set_mode(con->port, TYPEC_MODE_AUDIO);
+			break;
+		default:
+			if (UCSI_CONSTAT_PARTNER_FLAGS(con->status.flags) ==
+					UCSI_CONSTAT_PARTNER_FLAG_USB)
+				typec_set_mode(con->port, TYPEC_STATE_USB);
+		}
+	} else {
+		typec_set_mode(con->port, TYPEC_STATE_SAFE);
+	}
+
 	/* Only notify USB controller if partner supports USB data */
 	if (!(UCSI_CONSTAT_PARTNER_FLAGS(con->status.flags) & UCSI_CONSTAT_PARTNER_FLAG_USB))
 		u_role = USB_ROLE_NONE;

-- 
2.34.1

