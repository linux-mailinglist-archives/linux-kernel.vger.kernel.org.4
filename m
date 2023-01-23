Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DF5677BA6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:50:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjAWMuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbjAWMty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:49:54 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84671114D;
        Mon, 23 Jan 2023 04:49:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674478149; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Bb7+wDR4HhZ+4yPZeTDvI/n5HAUqDx2yxahDWMl9/K4xhBvhwoq7gvn/rOksK3Jdaz
    9RpfYLFqImLDMep2oJ8sHGIIeKvHv6EEDYfljOBIOcrTTSwrpbRAbzOjiCfqkv2LIVSU
    4eac7q6zrHXiKvhbm57yvnElx+z+S7GJXu6KbGu9AwjwlJrC/t6eeGY3/0DpKaCz1X9a
    eMF2k1Pfu+70x2uBCPXvgE4kGFPaeR4naIYkD0jY6ii/JThRC9bNDe5O2vdCYtNrMprs
    uyYO7c4zjHTEimJgu3gyiEw+J3RI8DLfqoNTcbxM+PvLtFZGkDvHnvYPumLdZJd7GtMf
    MItA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1674478149;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=sD2B2ZOQtBqvxHV8WDrINo/9+pIZKRvy/nGecyo3S0o=;
    b=i2zn1vRDDu+vsxX0VYcRCYlvXwyPQs6V+IR8glc/YTkV5fbXpASNMihKjtdQWZGmzN
    cDxJ8Psaqs9935RTM7KlaFtsik7e0xbA09syacnbHTt6BQW4zsQnUM5brVQfPrJdlfj7
    yQH+trIIkg8GYPC8Yws4gRDhFqfqyIWNJT7eg502u/5s1AtsdM/RBDMQQgoKMqePESHN
    JDLlLSSd6vAsLaaH+e6vHCP7aJm5w+Niln2ApkCRIGDhucSe+Zyj5IaUzMAxGCWGpyoZ
    mGP6+QwR2tZEBdDWqEToimpVYIzHtbyKOKdWsua7Xc9XMhtrbK9pAhU1X7LSjBcGbpc9
    dleg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1674478149;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=sD2B2ZOQtBqvxHV8WDrINo/9+pIZKRvy/nGecyo3S0o=;
    b=nk3ux1boGsNtcf4ltzkvj2s81dSMvhXpY7A5851MmYf/yIZ6+1jvm7OJFefNI2fe+f
    ZJJ4NW/EP1qpgpL8OuGqf6OzDfA65PX0Gori51lqErBqoyB3E5NRo3LvWFOEdmGlyPP5
    5xo6k/PIndDgTeqOI6Q5ks6hszQYAaX5CDmGJ6LlJD+UIIu/IK6amahZfFxB5bzVU0ui
    UaI+NIVoAnHNs5LKlUEyxbNBMNBaXyVZYMpDxyY3jzALGq/Ohy0+d2VptT5c9f8nFqyW
    Wi+XVc2AV5iyyKTdmDZIXtDLCpmgOvcaJC3W3BOwdyMWFxGFAbRdBe4WNt3G+G6YUkBe
    oEHg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKjXrKw58qY="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.1.0 AUTH)
    with ESMTPSA id 6630d1z0NCn8AFC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 23 Jan 2023 13:49:08 +0100 (CET)
Date:   Mon, 23 Jan 2023 13:49:02 +0100
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        djakov@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, benl@squareup.com,
        shawn.guo@linaro.org, fabien.parent@linaro.org, leo.yan@linaro.org,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v4 0/6] Add MSM8939 SoC support with two devices
Message-ID: <Y86CPmgvAi+kChQI@gerhold.net>
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <42baa874-c926-9111-b0b3-2df2562d8de6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42baa874-c926-9111-b0b3-2df2562d8de6@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 11:08:28AM +0000, Bryan O'Donoghue wrote:
> V4:
> - Left _AO for wcnss as downstream reference uses this - Bjorn/Bryan

Downstream is just an implementation and contains plenty of misleading
or even wrong information. IMO Bjorn is right here that VDDMX_AO is not
a logical choice.

The _AO (active-only) suffix means that the votes are only applied when
the processor making the vote is "active", that is when the Linux CPUs
are not in deep cpuidle mode.

For WCNSS the goal is to keep the necessary power domains active while
WCNSS is booting up, until it is able to make its own votes (handover).
The WCNSS firmware might then vote for VDDMX_AO internally because VDDMX
is not needed when the WCNSS CPU is suspended.

However, I would expect that the meaning is totally different when the
same vote is made from Linux. When Linux votes for _AO the "active"
state likely refers to the Linux CPUs, instead of the WCNSS CPU when
made from the WCNSS firmware.

Why does it work in downstream then? I would just assume "side effects":
  - Something else votes for VDDMX without _AO while WCNSS is booting
  - The Linux CPUs don't go into deep cpuidle state during startup
    - In particular, note how downstream often has "lpm_levels.sleep_disabled=1"
      on the kernel command line. This disables all cpuidle states until
      late after boot-up when userspace changes this setting. Without
      cpuidle, VDDMX_AO is identical to VDDMX.

Please change it to VDDMX (without _AO). It will most likely not make
any difference, but IMO it is logcially more correct and less
confusing/misleading. :)

> - Leaves dummy power-domain reference in cpu defintion as this is a
>   required property and the dt checker complains - Stephan/Bryan

It's only required though because you forgot to drop the DT schema patch
(3/4) when I suggested half a year ago that you make the MSM8939
cpufreq-qcom-nvmem changes together with the CPR stack [1]. :/

Anyway, it looks like qcom-cpufreq-nvmem.yaml requiring "cpr" power
domain unconditionally is a mistake anyway for multiple platforms.
[2] was recently submitted to fix this so that patch should allow you to
drop the dummy nodes. :)

[1]: https://lore.kernel.org/linux-arm-msm/Ysf8VRaXdGg+8Ev3@gerhold.net/
[2]: https://lore.kernel.org/linux-arm-msm/20230122174548.13758-1-ansuelsmth@gmail.com/

> - Left MDSS interconnects. I don't see a bug to fix here - Stephan/Bryan

Fair enough, if you would like to keep it I will likely send a revert
for the MSM8939 icc_sync_state() though. Because clearly it breaks
setups without a display and I don't see how one would fix that from the
device tree.

Also: The undocumented "register-mem" interconnect is still there. :)

> - power-domain in MDSS - dropped its not longer required after
>   commit a6f033938beb ("dt-bindings: msm: dsi-controller-main: Fix
> power-domain constraint") - Stephan

Thanks!

> - Adds gcc dsi1pll and dsi1pllbyte to gcc clock list.
>   Reviewing the silicon documentation we see dsi0_phy_pll is used to clock
>   GCC_BYTE1_CFG_RCGR : SRC_SEL
>   Root Source Select
>   000 : cxo
>   001 : dsi0_phy_pll_out_byteclk
>   010 : GPLL0_OUT_AUX
>   011 : gnd
>   100 : gnd
>   101 : gnd
>   110 : gnd
>   111 : reserved - Stephan/Bryan
> 

I'm confused. Are you not contradicting yourself here? You say that
dsi0_phy_pll (dsi ZERO) is used to clock GCC_BYTE1_CFG_RCGR. Then why
do you add dsi1_phy_pll (dsi ONE) to the gcc clock list?

To me this looks like a confirmation of what downstream does, that both
DSI byte clocks are actually sourced from the dsi0_phy and the PLL of
dsi1_phy is not used.

Thanks,
Stephan
