Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3076C6F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232535AbjCWRb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjCWRbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:31:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD292BF26
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:31:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o2so15580078plg.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679592688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItXOwha8h+SsgLUIpHMGhHvifqAv9ElkC8GCOIPwlBw=;
        b=dlcfhiyu360dY4oLMEki5fh68mVrzK1golDy+8Cl/tA1wIHUAz5UypP9RbEfsj/oPz
         Q192lYMSR1A2uPv9Q7Edridi1TOXxy/UISMuh1Q1qYdm+3okAQFuaxPQ4WJ3XTS9J1fj
         arFPfu9+Wy9gvejEE21dWL8FGSCl5kOrmFnEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679592688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ItXOwha8h+SsgLUIpHMGhHvifqAv9ElkC8GCOIPwlBw=;
        b=NYZ+48jidcMFcxiWF0PLvXGLWGtL+ZeBVpqzSdgMUXhibpNda//4hy8+D9kELuEFeF
         IJZGOJnVEofwlJY9ZK2n3/lYfDRuvWSsV3CNAd1A72YehNXYsoruJxktBeKEpjfGdPGL
         rnYTn0GbJymPeh27Q5alqxy8AZLLXxw9js7jYLmMyUNYShSwy5euXr/SJeYcrQbgLCN/
         BqxxfQQv7/Go7JI+56CLr0M0P6QQelaywrW0EdL/aJGJKtLel0UodXqPGXVSvL3rzl2Y
         EuPsHQVcFxo7VVCQxkJsaPelIqVl5F1gYw8l1y2Rnff2wrO6/edi9gAxs8cj96fzKj3F
         YC9A==
X-Gm-Message-State: AO0yUKUREfoNL4Ylrfg3Ztkdlly6QI273VGnAUC0m/7mfYBAmUvoIq4m
        rV/QZC7ZVZ9R6i+JhMMG5plwhg==
X-Google-Smtp-Source: AK7set9xgENCrOfo90ZpjRRQSLIrRXwbPcZgC3d88EUdy4NyQal6IFhJCQ1/Qsa1/qHZs38tljQAcQ==
X-Received: by 2002:a05:6a20:8b82:b0:d9:7fcf:1076 with SMTP id m2-20020a056a208b8200b000d97fcf1076mr374864pzh.25.1679592687986;
        Thu, 23 Mar 2023 10:31:27 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:16d3:ef20:206a:6521])
        by smtp.gmail.com with ESMTPSA id x13-20020a62fb0d000000b0061a6f4c1b2bsm12613546pfm.171.2023.03.23.10.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 10:31:27 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-gpio@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/14] pinctrl: qcom: Support OUTPUT_ENABLE; deprecate INPUT_ENABLE
Date:   Thu, 23 Mar 2023 10:30:12 -0700
Message-Id: <20230323102605.8.Id740ae6a993f9313b58add6b10f6a92795d510d4@changeid>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
In-Reply-To: <20230323173019.3706069-1-dianders@chromium.org>
References: <20230323173019.3706069-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm pinctrl driver has been violating the documented meaning
of PIN_CONFIG_INPUT_ENABLE. That documentation says:

  Note that this does not affect the pin's ability to drive output.

...yet the Qualcomm driver's sole action when asked to "enable input"
on a pin is to disable its output.

The Qualcomm driver's implementation stems from the fact that
"output-disable" is a "new" property from 2017. It was introduced in
commit 425562429d4f ("pinctrl: generic: Add output-enable
property"). The "input-enable" handling in Qualcomm drivers is from
2015 introduced in commit 407f5e392f9c ("pinctrl: qcom: handle
input-enable pinconf property").

Let's change the Qualcomm driver to move us in the right direction. As
part of this:
1. We'll now support PIN_CONFIG_OUTPUT_ENABLE
2. We'll still support using PIN_CONFIG_INPUT_ENABLE to disable a
   pin's output (in violation of the docs) with a big comment in the
   code. This is needed because old device trees have "input-enable"
   in them and, in some cases, people might need the old
   behavior. While we could programmatically change all old device
   trees, it doesn't really hurt to keep supporting the old behavior
   and we're _supposed_ to try to be compatible with old device trees
   anyway.

It can also be noted that the PIN_CONFIG_INPUT_ENABLE handling code
seems to have purposefully ignored its argument. That means that old
boards that had _either_ "input-disable" or "input-enable" in them
would have had the effect of disabling a pin's output. While we could
change this behavior, since we're only leaving the
PIN_CONFIG_INPUT_ENABLE there for backward compatibility we might as
well be fully backward compatible.

NOTE: despite the fact that we'll still support
PIN_CONFIG_INPUT_ENABLE for _setting_ config, we take it away from
msm_config_group_get(). This appears to be only used for populating
debugfs and fixing debugfs to "output enabled" where relevant instead
of "input enabled" makes more sense and has more truthiness.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/pinctrl/qcom/pinctrl-msm.c | 36 +++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index daeb79a9a602..4515f375c5e8 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -323,6 +323,7 @@ static int msm_config_reg(struct msm_pinctrl *pctrl,
 		break;
 	case PIN_CONFIG_OUTPUT:
 	case PIN_CONFIG_INPUT_ENABLE:
+	case PIN_CONFIG_OUTPUT_ENABLE:
 		*bit = g->oe_bit;
 		*mask = 1;
 		break;
@@ -414,11 +415,9 @@ static int msm_config_group_get(struct pinctrl_dev *pctldev,
 		val = msm_readl_io(pctrl, g);
 		arg = !!(val & BIT(g->in_bit));
 		break;
-	case PIN_CONFIG_INPUT_ENABLE:
-		/* Pin is output */
-		if (arg)
+	case PIN_CONFIG_OUTPUT_ENABLE:
+		if (!arg)
 			return -EINVAL;
-		arg = 1;
 		break;
 	default:
 		return -ENOTSUPP;
@@ -502,9 +501,36 @@ static int msm_config_group_set(struct pinctrl_dev *pctldev,
 			arg = 1;
 			break;
 		case PIN_CONFIG_INPUT_ENABLE:
-			/* disable output */
+			/*
+			 * According to pinctrl documentation this should
+			 * actually be a no-op.
+			 *
+			 * The docs are explicit that "this does not affect
+			 * the pin's ability to drive output" but what we do
+			 * here is to modify the output enable bit. Thus, to
+			 * follow the docs we should remove that.
+			 *
+			 * The docs say that we should enable any relevant
+			 * input buffer, but TLMM there is no input buffer that
+			 * can be enabled/disabled. It's always on.
+			 *
+			 * The points above, explain why this _should_ be a
+			 * no-op. However, for historical reasons and to
+			 * support old device trees, we'll violate the docs
+			 * still affect the output.
+			 *
+			 * It should further be noted that this old historical
+			 * behavior actually overrides arg to 0. That means
+			 * that "input-enable" and "input-disable" in a device
+			 * tree would _both_ disable the output. We'll
+			 * continue to preserve this behavior as well since
+			 * we have no other use for this attribute.
+			 */
 			arg = 0;
 			break;
+		case PIN_CONFIG_OUTPUT_ENABLE:
+			arg = !!arg;
+			break;
 		default:
 			dev_err(pctrl->dev, "Unsupported config parameter: %x\n",
 				param);
-- 
2.40.0.348.gf938b09366-goog

