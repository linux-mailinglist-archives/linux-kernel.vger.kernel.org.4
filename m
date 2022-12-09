Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4275C648714
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 17:55:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiLIQzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 11:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIQzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 11:55:23 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23C4941AB;
        Fri,  9 Dec 2022 08:55:22 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id BA1C9CA44B;
        Fri,  9 Dec 2022 16:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1670604890; bh=JPxISEVGZ3issJ6dY6iVzvmxKxEEeRMzlzxN/ukUT/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Z70cN0BCSwfeW8Vsj/KfBq/QdTsGv9w/ZxNzZNuZK7BQVU4SGMbcosSXRPNiGLGtN
         9PbrJVLFHS3iUh/C+2nxTB3/VU0Rybvn5pHYtfyoR9nhpF9Y441j8NvqUEvxKwye5r
         CvDfv5l+Vfy806NOaQ5bS9qhLovI5HMF0kHMrKa8=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: Add configuration for PMI8950 peripheral
Date:   Fri, 09 Dec 2022 17:54:50 +0100
Message-ID: <5740737.DvuYhMxLoT@g550jk>
In-Reply-To: <20221208112055.m7sqg3ysxzskqjp4@SoMainline.org>
References: <20221101161801.1058969-1-luca@z3ntu.xyz> <36eb03e8-aace-f7ce-edc8-53715021c0ea@linaro.org> <20221208112055.m7sqg3ysxzskqjp4@SoMainline.org>
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

On Donnerstag, 8. Dezember 2022 12:20:55 CET Marijn Suijten wrote:
> On 2022-12-08 11:23:17, Krzysztof Kozlowski wrote:
> > On 08/12/2022 11:12, Marijn Suijten wrote:
> > > On 2022-12-04 17:19:05, Luca Weiss wrote:
> > >> On Freitag, 2. Dezember 2022 10:36:58 CET Marijn Suijten wrote:
> > >> [..]
> > >> 
> > >> So the way this patch does it is good or does it need changes?
> > > 
> > > Except the typo(s?) pointed out in my first reply, this is good to go.
> > > 
> > > If we stick with generic adc-chan node names that should be documented
> > > in the bindings IMO, as it is currently only captured implicitly in the
> > > examples.  Krzysztof, what is your thought on this?
> > 
> > If I understand correctly, the outcome of other discussion [1] was to
> > use labels and generic node names.
> 
> The outcome was to use labels in the driver and disregard node names as
> the new fwnode API clobbers those names by including the @xx register
> bit.
> 
> (I'll follow up with Jonathan whether or not to remove the current
> fallback to node names, as [1] ended up discussing many different issues
> and nits)
> 
> > In such case the patch was correct
> > (except other comments).
> 
> As a consequence it _doesn't matter_ how nodes are named, and we _can_
> use generic node names.  My question for you is whether we should, and
> if we should lock that in via dt-bindings to guide everyone towards
> using labels (which i did _not_ do in the recently-landed PM8950 and
> PM6125, but will send followup for).

FYI the patch has been merged already and is now in linux-next
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/arm64/boot/dts/qcom/pmi8950.dtsi?id=0d97fdf380b478c358c94f50f1b942e87f407b9b

If you have any changes that need to be done please send a follow-up patch.

Regards
Luca

> 
> > [1]
> > https://lore.kernel.org/linux-arm-msm/20221112162719.0ac87998@jic23-huawei
> > /
> 
> - Marijn




