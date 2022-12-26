Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709A2656037
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 06:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbiLZFr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 00:47:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiLZFrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 00:47:53 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A913F260E;
        Sun, 25 Dec 2022 21:47:52 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id u7so9940281plq.11;
        Sun, 25 Dec 2022 21:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7wEGGRHRkx/TYRoHQuQncfk8iOkoqIh2z64vF46qnf0=;
        b=mvnKo8Dht5BCyRbWOJ6vL4yn9X6VUG0JbqB3eNm8lm8pZuRyXvqPTdmHGWLb7j5yzB
         oLpOeYvyxk48FOQ4mbwf68Yvj57sUDZqE2FVmvyftvQsO7AeAyHcMigDWwm2zqLFCWeF
         /zmcTYHXXUopTq4fnuZBTTi4pt6PXjOAtWARo6FRbtykNX3a9YNZJriT9Hfbeiee8SsX
         heRXfpRv9rgMp2Lg5FtuyzvPoce3WVxILoi0VPVfISPPm+Nk5J58ldCo+bsV1O8LTEHm
         WKBzPon997+hnqDbNOXjY54l8/Bez+EF2k1Bb5sMAoZ5vPRBANnKu61nBzgMSzc1Dmrd
         XBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7wEGGRHRkx/TYRoHQuQncfk8iOkoqIh2z64vF46qnf0=;
        b=tuxQMq5Pk5ZR7O1WjVJc9AF7bjv/LNI8Ybuqhqr1+bS7K6KvSQAYaJ0kUVb+QrPiAQ
         BLyyawHJGOPLx9GAk77Zq2H+cOvJu6dUIg3GIzQhzLwtzptmYjV1yESWyUy3f+5uVKlF
         45O46rpL7DQjUexW9x0Ulv0N/XSBUvqWGNj63NzjjMg2tkpcsmWxPm/gvq65YpKW4/Ru
         ruTTnoDLQjCTlKIiH3mGSqsxXMECimJhxw+YEyUqYeQ1ZKfjIpc15RUr+l6z+qVfW1CH
         uhpOJgrCc5gZpaTbi1so1PCXB7sx5bw/YwcxIueDXyN9FQ3KmOHSLPtR9H0QmVwovGE+
         Wnng==
X-Gm-Message-State: AFqh2kp8fybvw4GPCxHvlm6Iw3cUbm7w/fYJ2+2+3dhM5KL/PNaQv2v6
        aNs7yQawnXG2RLp8zAm5Cvg=
X-Google-Smtp-Source: AMrXdXs7+NiJLm422uByXe9Fru36TSxkliQGdLRp8JIE/sc04ObaCwZkPx97G+RoodJZ3fwcZbCOmQ==
X-Received: by 2002:a05:6a21:169b:b0:aa:7346:2d94 with SMTP id np27-20020a056a21169b00b000aa73462d94mr22372940pzb.25.1672033672186;
        Sun, 25 Dec 2022 21:47:52 -0800 (PST)
Received: from localhost.localdomain (1-34-79-176.hinet-ip.hinet.net. [1.34.79.176])
        by smtp.gmail.com with ESMTPSA id h35-20020a632123000000b004785d99321asm5618242pgh.86.2022.12.25.21.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 21:47:51 -0800 (PST)
From:   Potin Lai <potin.lai.pt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai.pt@gmail.com>
Subject: [PATCH 2/2] ARM: dts: aspeed: bletchley: enable wdtrst1
Date:   Mon, 26 Dec 2022 13:45:35 +0800
Message-Id: <20221226054535.2836110-3-potin.lai.pt@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221226054535.2836110-1-potin.lai.pt@gmail.com>
References: <20221226054535.2836110-1-potin.lai.pt@gmail.com>
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

Enable WDTRST1 external signal to send a reset pluse to peripherals while
BMC reset.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
index 791f83aaac50..050ed7e810fa 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dts
@@ -1064,3 +1064,14 @@ pinctrl_gpiov2_unbiased_default: gpiov2 {
 		bias-disable;
 	};
 };
+
+&wdt1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdtrst1_default>;
+	aspeed,reset-type = "soc";
+	aspeed,external-signal;
+	aspeed,ext-push-pull;
+	aspeed,ext-active-high;
+	aspeed,ext-pulse-duration = <256>;
+};
-- 
2.31.1

