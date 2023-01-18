Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C79467219C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 16:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjARPnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 10:43:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjARPnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 10:43:22 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D6F2B60D;
        Wed, 18 Jan 2023 07:43:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674056597; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=EA7ps0F7S1sfJyw0zKoEkokxSF7bjf2J9HOe1KYFXsXuEDd6UupDnVuzwrFTxYn6KB
    kV8q6GFDwZU+p+XgRxEHJYFIVJAxFUnaeIxZnShl2QX4AIYbKzcp0NmVnagOk9x9EOWZ
    NEYMoAHAO/pVitG5pdkc6CRriu2mCYRn888NC0bZ0r1RU2ylSh7z9CtpNHOGNIgE2dyU
    jb/nUzu+FsysWnN//VKR+zhZruDKGWtFpphZ07cRIZ95pyriNND0BkMtPUPYR/IweQYP
    XWkgaFyZ2Tjhf9Xkp3nWSagSqSaLY2MuuKOyTIALp96F4y94DpRC8WHwjFqmFu3LpMDi
    lrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1674056597;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Xk+u4Od71sEXJd5Tz3OHlg0hDar5B+RACjEct3dMYC8=;
    b=FhpgLNwtbNAFXCObLPZpRMOOJM2ZZq42QW3/Cs8AcSWs80BB4ofLkLuEPkaXCENa04
    W0biXV6O3TdOAzGNYg+pfb9lqZPPf4wzGSIMJcYJ9PPb6dP78BaXvh42aPv0N99YaPsT
    ibTWr1+7WmkAMKyWQAbStDNuk7FFR/PHDzBuTSnukfF1tHaMyqM2qvfozNydwtnBkgcS
    ldTzlTglmBBaOVjivBQ3WPWqTYuRH37+6QL4ifRaVurRqK2RKA2HfGuJYp5UBjnatw7J
    W46RcpQCrb0uNx1S8F5vOEg2/MtoG+Ej5/G0vfDWhG7gXZ8E6dO2FAkeQIw/ZkPT+L9I
    yNTg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1674056597;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=Xk+u4Od71sEXJd5Tz3OHlg0hDar5B+RACjEct3dMYC8=;
    b=KmJZqf288rSrsDCCOxTHpRUm8aE/3mar7UCDb71GQEkTtHKLb8BEs9wVXrde4PCkQG
    W1SyhOKSBW1SFxLJvvy7/3XAnqx+dG2qIvvWGpAAtkPAsgN7vn1reApmPjTaRP6N09LN
    EMPsmlTJ3Zr1dlW3Z0e1psfZriGHM+SOmZnzMbG8bPBMdCvGjdrIPaYn3OIwQd8RrfTt
    OhKKpKpzAuIrsBz6edG2MhSg2+k9lVvMSK33M6nA/UwyVFdAthtqTW2VznyShuRp05jA
    nax+vUDFOdMhvDlevXscywg1ZaM8f4L2BzY+qTqAK3vygvddPcSJriCwlXMPLp+AXxaZ
    FkZg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJAhdlWx/bI"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.0.0 DYNA|AUTH)
    with ESMTPSA id 92895dz0IFhH063
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 18 Jan 2023 16:43:17 +0100 (CET)
Date:   Wed, 18 Jan 2023 16:43:09 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/8] dt-bindings: arm: qcom: Document MSM8939 SoC
 binding
Message-ID: <Y8gTjSkecPvvZtYg@gerhold.net>
References: <20230117024846.1367794-1-bryan.odonoghue@linaro.org>
 <20230117024846.1367794-2-bryan.odonoghue@linaro.org>
 <Y8eyIO8BqKzvulbB@gerhold.net>
 <7822949a-c373-3028-6a42-66a04245e93b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7822949a-c373-3028-6a42-66a04245e93b@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:05:50PM +0000, Bryan O'Donoghue wrote:
> On 18/01/2023 08:47, Stephan Gerhold wrote:
> > On Tue, Jan 17, 2023 at 02:48:39AM +0000, Bryan O'Donoghue wrote:
> > > Document the MSM8939 and supported boards in upstream Sony "Tulip" M4 Aqua
> > > and Square APQ8039 T2.
> > > 
> > > MSM8939 is one of the older SoCs so we need to expand the list of
> > > qcom,board-ids to allow for the bootloader DTS board-id matching
> > > dependency.
> > > 
> > 
> > The original LK bootloaders cannot boot your msm8939.dtsi correctly,
> > because a spin-table implementation is required to get the other CPU
> > cores up. This means that a modified bootloader is always needed from
> > the upstream point of view, since I doubt anyone wants to use these
> > devices with a single core only. lk2nd (as the primary spin-table
> > implementation right now) has never required qcom,board-ids and any
> > custom LK would be easy to patch to ignore these.
> 
> The system boots just fine with the shipped LK. We get display, USB, SD,
> WiFi.
> 
> We just don't support booting the second cluster via any other means than
> lk2nd right now.
> 
> You could also not use lk2nd, stick with your default LK and import LPM
> patches.
> 

My point is: If you import out of tree LPM patches you can also just
import an extra patch that adds the qcom,board-id property where needed.

The qcom,board-id is only needed/used in configurations where you need
to add those extra LPM patches on top anyway. Those configurations are
(sadly) not supported from the upstream point of view, since only PSCI
or spin-table are supposed to be used for CPU bring-up/idle.

Anyway, for me personally there is no difference if the funky
qcom,board-id properties are there or not, so I'll leave it up to
Rob/Krzysztof to decide if the board-id exception is warranted here or
not. :)

Thanks,
Stephan
