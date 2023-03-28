Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0D86CBBCA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjC1KDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjC1KDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:03:04 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75E25FC0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:03:02 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id q16so15032642lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679997781;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LyqTQFK+uVxsQYwyzlRv5E2d4XzzuOepwBhUJm638mk=;
        b=PAcNESty8n7ZDp/KEZo9JNWQa6AN4XTktJyIb1sZ/X4ENi7kKl3q7x+l/74NA5lm+t
         keIv6Tu6cu4i9sh9bS7QAeLG7xv4mWlpIGadaQe4lMeh4hPhpMeOQVl7c4O7Wpozd+BJ
         sRMCiTdlHUNksMFbc5kKk7axX9fEoOMl+HDYnVv0teDq1acidnFK7GH/IzD9xkaFRbSi
         pxKZYsbZN7sKHRyHTqQg+EhVF8AVrKoRGsaovmlPXIi6N4ixUqh+45OnD8oG+BFZzmuj
         hVZKouzjEvDsBxzB6rA9XRz4+Gaj13neYe0lOlwV8/sZOSgcpEyOQuRxZY2ENzD3EXCR
         jIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997781;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LyqTQFK+uVxsQYwyzlRv5E2d4XzzuOepwBhUJm638mk=;
        b=ekmgSiH/0SyJF5Dgn1RpG0hx5QYGRgf104tH1wm/BF9ExTaoF75heUPHtnMEPJubK2
         +6mDFUnj5Nv/6P58gtOHU5NnuiWE7pmJk3j7mNFefjDnosZKMbRUyTKJUpxfgKGTSW9V
         0/nUhfKdEzrloDuPmf6P3McSqqyTCtiOqOlb0SNN4F+QUO8yIswjjSciDcvilIse+7Y+
         +qTCCkseQXi8j6NpLGqnr7N3U7lyQmpvzW7/JaSfkI1FzwHC1AEUFN2uou4agEkx+k3S
         BUoRMOFryUmfeoqAh3PY8kSP5W0HEoMaHHIyuBAAL0jMLu3G87suOJREXCQkEl69y29C
         r6SQ==
X-Gm-Message-State: AAQBX9eyY2WejY2FkGTHPus/I3ZRiN32few45CCnkjohhThmmYRCU8sW
        UnWcnt3ZOhWBNddEDfKoDMJ3i6R+oc1047Ronlg=
X-Google-Smtp-Source: AKy350YGbDiP4mhI2oNX77LkOc1pOGIfCa8AEk/jlSS+DxHtn2jn82eGU9gBAH+BT52Bo/Vvx30jcw==
X-Received: by 2002:ac2:44b4:0:b0:4eb:c85:bdc2 with SMTP id c20-20020ac244b4000000b004eb0c85bdc2mr3113821lfm.2.1679997780947;
        Tue, 28 Mar 2023 03:03:00 -0700 (PDT)
Received: from [192.168.1.101] (abxj225.neoplus.adsl.tpnet.pl. [83.9.3.225])
        by smtp.gmail.com with ESMTPSA id f10-20020ac24e4a000000b004db3e330dcesm5008471lfr.178.2023.03.28.03.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 03:03:00 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 0/2] Resolve MPM register space situation
Date:   Tue, 28 Mar 2023 12:02:51 +0200
Message-Id: <20230328-topic-msgram_mpm-v1-0-1b788a5f5a33@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEu7ImQC/x2N0QrCMAwAf2Xk2cBsh1R/RUTaGLfA2pVmijD27
 ws+3sFxGyg3YYVbt0Hjr6gsxeB86oCmWEZGeRmD653vvQu4LlUIs44t5meuGekSQmKfyF0HsCx
 FZUwtFposLJ95Nlkbv+X3/9wf+34ARPLR+3cAAAA=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679997779; l=1895;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=lF/bvkNJ7NLlgQqY7yN7AeVawfTeX3/WEciMsVGTE3U=;
 b=fcbsdJo5+WcFlPqfdWkwDg2oF4yvKNoIHpAZnGXRnPm4LbzWTwVvxhKLcC5BFQOdRQ45U5uZjkeJ
 hcTDCb0iAdJYaWg+95rEY7hXkXk3FcpPviMvbKzTRNnaZrbl17JO
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MPM (and some other things, irrelevant to this patchset) resides
(as far as the ARM cores are concerned, anyway) in a MMIO-mapped region
that's a portion of the RPM (low-power management core)'s RAM, known
as the RPM Message RAM. Representing this relation in the Device Tree
creates some challenges, as one would either have to treat a memory
region as a bus, map nodes in a way such that their reg-s would be
overlapping, or supply the nodes with a slice of that region.

This series implements the third option, by adding a qcom,rpm-msg-ram
property, which has been used for some drivers poking into this region
before. Bindings ABI compatibility is preserved through keeping the
"normal" (a.k.a read the reg property and map that region) way of
passing the register space.

Example representation with this patchset:

/ {
	[...]

	mpm: interrupt-controller {
		compatible = "qcom,mpm";
		qcom,rpm-msg-ram = <&apss_mpm>;
		[...]
	};

	[...]

	soc: soc@0 {
		[...]

		rpm_msg_ram: sram@45f0000 {
			compatible = "qcom,rpm-msg-ram", "mmio-sram";
			reg = <0 0x045f0000 0 0x7000>;
			#address-cells = <1>;
			#size-cells = <1>;
			ranges = <0 0x0 0x045f0000 0x7000>;

			apss_mpm: sram@1b8 {
				reg = <0x1b8 0x48>;
			};
		};
	};
};

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: interrupt-controller: mpm: Allow passing reg through phandle
      irqchip: irq-qcom-mpm: Support passing a slice of SRAM as reg space

 .../bindings/interrupt-controller/qcom,mpm.yaml    |  6 ++++-
 drivers/irqchip/irq-qcom-mpm.c                     | 30 ++++++++++++++++++----
 2 files changed, 30 insertions(+), 6 deletions(-)
---
base-commit: a6faf7ea9fcb7267d06116d4188947f26e00e57e
change-id: 20230328-topic-msgram_mpm-c688be3bc294

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

