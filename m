Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433CC5E539A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 21:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIUTKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 15:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiIUTKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 15:10:31 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65816558DB;
        Wed, 21 Sep 2022 12:10:29 -0700 (PDT)
Received: from g550jk.localnet (212095005231.public.telering.at [212.95.5.231])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id F1A9FC5E3A;
        Wed, 21 Sep 2022 19:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1663787397; bh=UIzBjzoTqklLqiQ9/Cuhhf4QvIIw003uST1mFzwNLwc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=DFyNaXlTtdGlAKD/8uiizP/ppJ1+Cp7QsRmo2GlSGRfUe1R6sA1fJMZJAHNH99Gob
         LCtaTNpwA/I9QIP8GvUCRqWcmMaqoP9mJM6nFRkt+UHXX5V8B0292gJHEtxxGFkTdI
         ZyZwzJF46lomtyrAWbjU2bmKPC/iadPU0NOc4fXw=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 0/3] ARM/hwlock: qcom: switch TCSR mutex to MMIO (msm8974)
Date:   Wed, 21 Sep 2022 21:09:55 +0200
Message-ID: <4768567.31r3eYUQgx@g550jk>
In-Reply-To: <20220920150414.637634-1-krzysztof.kozlowski@linaro.org>
References: <20220920150414.637634-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        SPF_HELO_NONE,SPF_PASS,T_PDS_OTHER_BAD_TLD autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Dienstag, 20. September 2022 17:04:11 CEST Krzysztof Kozlowski wrote:
> Hi,
> 
> Remaining patches from v3:
> https://lore.kernel.org/all/20220909092035.223915-1-krzysztof.kozlowski@lina
> ro.org/
> 
> Not tested on hardware. Please kindly provide tests.

With these patches on top of 5.19.9 everything incl. modem still seems to work 
fine on msm8974pro-fairphone-fp2:

(2/3 & 3/3 from this series)
ARM: dts: qcom: msm8974: add missing TCSR syscon compatible
ARM: dts: qcom: msm8974: switch TCSR mutex to MMIO

(picked from linux-next)
hwspinlock: qcom: Add support for mmio usage to sfpb-mutex
hwspinlock: qcom: correct MMIO max register for newer SoCs
hwspinlock: qcom: add support for MMIO on older SoCs

Tested-by: Luca Weiss <luca@z3ntu.xyz> # fairphone-fp2

Regards
Luca

> 
> Changes since v3
> ================
> 1. Drop applied patches - remaining is only msm8974.
> 2. Add syscon to TCSR mutex regs, after talk with Bjorn.
> 3. New patch: bindings.
> 
> Changes since v2
> ================
> 1. Rebase on current MFD changes.
> 2. Add Rb tag.
> 3. Split MFD patch to separate patchset:
> https://lore.kernel.org/linux-devicetree/20220909091056.128949-1-krzysztof.k
> ozlowski@linaro.org/T/#u
> 
> Changes since v1
> ================
> 1. Use existing qcom,tcsr-msm8974 compatible.
> 2. Fix few other TCSR syscon compatibles (new patches: ipq6018, msm8953,
>    qcs404, msm8996).
> 3. New patch: dt-bindings: mfd: qcom,tcsr: drop simple-mfd from IPQ6018
> 4. New patch: dt-bindings: mfd: qcom,tcsr: add QCS404
> 
> Dependencies
> ============
> 1. DT bindings and driver patches can go via hwlock. DTS via Bjorn/Qualcomm.
> 
> 2. The last five DTS commits (ARM and arm64) named "switch TCSR mutex to
> MMIO" depend on driver support. The changes are not bisectable, just like
> previously such changes were not bisectable:
>   
> https://lore.kernel.org/all/20200622075956.171058-5-bjorn.andersson@linaro.
> org/ Therefore these changes could wait for next release.
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (3):
>   dt-bindings: hwlock: qcom-hwspinlock: add syscon to MSM8974
>   ARM: dts: qcom: msm8974: add missing TCSR syscon compatible
>   ARM: dts: qcom: msm8974: switch TCSR mutex to MMIO
> 
>  .../bindings/hwlock/qcom-hwspinlock.yaml         |  6 +++++-
>  arch/arm/boot/dts/qcom-msm8974.dtsi              | 16 +++++-----------
>  2 files changed, 10 insertions(+), 12 deletions(-)




