Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD1873A98A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjFVUeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjFVUeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:34:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3344CDC;
        Thu, 22 Jun 2023 13:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C34BB618E5;
        Thu, 22 Jun 2023 20:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AECE1C433C8;
        Thu, 22 Jun 2023 20:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687466052;
        bh=Z5y5hDsI2WXqU5W36Hh41r3e9huUDgznGRpPUg89jlU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPKgU8V8Bm+OC675d8kbC5giP4wg168IX3yRQf8iIgbOgedxxh6sD92EQ3G0Hg6eJ
         u49s99n2DiQRRsAM/l6qclvcPRWUdoWIGeSHRLnszmhNHvqPIFCjhrPa6lwSYdKg6F
         FutQTuVJ3egS4jNRduAU3JyYM1SHxMaJEzHuO6S9nUD/ejqspFsBdnuWiYknL/rt+4
         9BpB+1nTM6Q0/KI3BUJ1iLdHnK0vbLUI/C69ULFYK/f+lFIleFW/THdkUDj+M4o/hi
         q19pikCFEdyAW6CupJYkx97lY8Zl/b0o2Dau3kTW2CxRymkq3HOefRN0VGNv+A9lF2
         P+E2CHOJtaD3A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     amit.pundir@linaro.org, Will Deacon <will@kernel.org>,
        sumit.semwal@linaro.org, linux-arm-msm@vger.kernel.org,
        konrad.dybcio@somainline.org, linux-arm-kernel@lists.infradead.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        Stephen Boyd <swboyd@chromium.org>,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: (subset) [PATCH v2 1/4] dt-bindings: firmware: qcom,scm: Document that SCM can be dma-coherent
Date:   Thu, 22 Jun 2023 13:38:10 -0700
Message-ID: <168746628699.107789.12308094014658247045.b4-ty@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230616081440.v2.1.Ie79b5f0ed45739695c9970df121e11d724909157@changeid>
References: <20230616081440.v2.1.Ie79b5f0ed45739695c9970df121e11d724909157@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Jun 2023 08:14:38 -0700, Douglas Anderson wrote:
> Trogdor devices use firmware backed by TF-A instead of Qualcomm's
> normal TZ. On TF-A we end up mapping memory as cacheable. Specifically,
> you can see in Trogdor's TF-A code [1] in qti_sip_mem_assign() that we
> call qti_mmap_add_dynamic_region() with MT_RO_DATA. This translates
> down to MT_MEMORY instead of MT_NON_CACHEABLE or MT_DEVICE.
> 
> Let's allow devices like trogdor to be described properly by allowing
> "dma-coherent" in the SCM node.
> 
> [...]

Applied, thanks!

[1/4] dt-bindings: firmware: qcom,scm: Document that SCM can be dma-coherent
      commit: c0877829ada0406233aee5bd54f6813db79d5f1f
[2/4] arm64: dts: qcom: sc7180: Mark SCM as dma-coherent for IDP
      commit: 9a5f0b11e49e27f0a01a73c31d05df4a95bea3fa
[3/4] arm64: dts: qcom: sc7180: Mark SCM as dma-coherent for trogdor
      commit: a54b7fa6b9ab6b4ecb7d9aba6b1a0ce1bcc961e3
[4/4] arm64: dts: qcom: sc7280: Mark SCM as dma-coherent for chrome devices
      commit: 7b59e8ae92fe089fed8ff1b23e53442ae5b204c9

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
