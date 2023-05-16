Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30E770423D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 02:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245554AbjEPAU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 20:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245312AbjEPAUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 20:20:25 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43297289
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:20:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-644d9bf05b7so7730194b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 17:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684196423; x=1686788423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8NTpr8qNiWGggQwGnuWCOmOJ8isCIuCvJD5KAIya3ZY=;
        b=OorFhxs4iWBxONb5AwKmj083FRlcsY+o5/PpHIbSffcqkmzv6lJdBMeys9uniTMsRV
         m+Ja/w4bXKQvaPT9M//WJFUuL1mNpRoXRgJZwEzIZ9LqlejUObkwVI1gmQ2vMBlgWoSV
         0mcJEmNrw2Lccl7iTgFbC9C4uRUJLxpZ1pl4s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684196423; x=1686788423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NTpr8qNiWGggQwGnuWCOmOJ8isCIuCvJD5KAIya3ZY=;
        b=Og4ZclwOBUUqxBbrx3qdcYLt8FkC9+jZKNcV1dTV2Gl+v1ylEYm/iVQqWwzgTek2UK
         AXom88RQrSLok02zuG0k1oBnKEwKKgEbtRBxhppRdPJHaBj9c5A/BcAhjYFgAmqq0nHf
         3sXgEoqY6yPkIw+88wXzIdDaTdDigFRq3Clsx4JQjtf1C/DcSSzbga39NBCaHenL0ogW
         LKWcZVFtK6jEBDwzwdP26jAkAXtMJc42OLdsuwNoKJp2QyUz+83ypG2TOdbzTGZo2TaN
         QKt5xUvGZ34JSuOQEBlAHjUwrgYe6yQpq9Uei7e8BuwgHNg2fkUg9KjX4EHHxo/aWIVz
         spwA==
X-Gm-Message-State: AC+VfDwiTdUO+BGc0E/toZdz3oSJvo6YURw6JNGWw19LCVnVwM5ocbXL
        uDUdUzdkjeY0zdihDsx53XGIfg==
X-Google-Smtp-Source: ACHHUZ6yfuJB7fvYwj5JhgzpgR7dWrzQYexm+UYmQiiQuWMWF+jwgGxfttVyMplEr5VLC+60Kap2mQ==
X-Received: by 2002:a05:6a00:2313:b0:64a:fa71:a98f with SMTP id h19-20020a056a00231300b0064afa71a98fmr13472377pfh.13.1684196423149;
        Mon, 15 May 2023 17:20:23 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:9d:2:9f33:9d98:277a:d4cd])
        by smtp.gmail.com with ESMTPSA id t9-20020a62ea09000000b0064559b58eb8sm12286103pfh.154.2023.05.15.17.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 17:20:22 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        cros-qcom-dts-watchers@chromium.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sc7180-lite: Fix SDRAM freq for misidentified sc7180-lite boards
Date:   Mon, 15 May 2023 17:19:29 -0700
Message-ID: <20230515171929.1.Ic8dee2cb79ce39ffc04eab2a344dde47b2f9459f@changeid>
X-Mailer: git-send-email 2.40.1.606.ga4b1b128d6-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In general, the three SKUs of sc7180 (lite, normal, and pro) are
handled dynamically.

The cpufreq table in sc7180.dtsi includes the superset of all CPU
frequencies. The "qcom-cpufreq-hw" driver in Linux shows that we can
dynamically detect which frequencies are actually available on the
currently running CPU and then we can just enable those ones.

The GPU is similarly dynamic. The nvmem has a fuse in it (see
"gpu_speed_bin" in sc7180.dtsi) that the GPU driver can use to figure
out which frequencies to enable.

There is one part, however, that is not so dynamic. The way SDRAM
frequency works in sc7180 is that it's tied to cpufreq. At the busiest
cpufreq operating points we'll pick the top supported SDRAM frequency.
They ramp down together.

For the "pro" SKU of sc7180, we only enable one extra cpufreq step.
That extra cpufreq step runs SDRAM at the same speed as the step
below. Thus, for normal and pro things are OK. There is no sc7180-pro
device tree snippet.

For the "lite" SKU if sc7180, however, things aren't so easy. The
"lite" SKU drops 3 cpufreq entries but can still run SDRAM at max
frequency. That messed things up with the whole scheme. This is why we
added the "sc7180-lite" fragment in commit 8fd01e01fd6f ("arm64: dts:
qcom: sc7180-lite: Tweak DDR/L3 scaling on SC7180-lite").

When the lite scheme came about, it was agreed that the WiFi SKUs of
lazor would _always_ be "lite" and would, in fact, be the only "lite"
devices. Unfortunately, this decision changed and folks didn't realize
that it would be a problem. Specifically, some later lazor WiFi-only
devices were built with "pro" CPUs.

Building WiFi-only lazor with "pro" CPUs isn't the end of the world.
The SDRAM will ramp up a little sooner than it otherwise would, but
aside from a small power hit things work OK. One problem, though, is
that the SDRAM scaling becomes a bit quirky. Specifically, with the
current tables we'll max out SDRAM frequency at 2.1GHz but then
_lower_ it at 2.2GHz / 2.3GHz only to raise it back to max for 2.4GHz
and 2.55GHz.

Let's at least fix this so that the SDRAM frequency doesn't go down in
that quirky way. On true "lite" SKUs this change will be a no-op
because the operating points we're touching are disabled. This change
is only useful when a board that thinks it has a "lite" CPU actually
has a "normal" or "pro" one stuffed.

Fixes: 8fd01e01fd6f ("arm64: dts: qcom: sc7180-lite: Tweak DDR/L3 scaling on SC7180-lite")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sc7180-lite.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
index d8ed1d7b4ec7..4b306a59d9be 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-lite.dtsi
@@ -16,3 +16,11 @@ &cpu6_opp11 {
 &cpu6_opp12 {
 	opp-peak-kBps = <8532000 23347200>;
 };
+
+&cpu6_opp13 {
+	opp-peak-kBps = <8532000 23347200>;
+};
+
+&cpu6_opp14 {
+	opp-peak-kBps = <8532000 23347200>;
+};
-- 
2.40.1.606.ga4b1b128d6-goog

