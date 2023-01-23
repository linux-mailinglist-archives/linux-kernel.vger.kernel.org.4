Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3DB1677D61
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:01:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbjAWOAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:00:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbjAWOAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:00:39 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABCF324124;
        Mon, 23 Jan 2023 06:00:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674482421; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=i8g+OYD4qLJslVd2a7zsTaUeG+ayTHTbXVMmNWT9D8BB1E/NbU37uOdnAdq7HuDj2C
    a9t0zS0mHoyl+kGCwNXhjSwQoNO8nT0h+7nff4lC+6IU+snioB9KnCC/wll3zCAWVRmM
    EPEKLPP57R6f/ZqpkcsLRAa9FWjNv7ErU3YvRbvpstsCnDuW2NvMuqe3JlRLX1QZBUPD
    dDtmlS3iH1610aDtH0xUxcaz0rJ0bwEa1v5QsbFs5kURBXF5eDufUp8iPAtnBCib0xtO
    FXiuHigQbjjQf7Kag14FpaLnq0HqKYiZNxF+FjOMRU4D61caejPsC+NmVbm+MVcGIBZW
    yReQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1674482421;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MzmR+pdf6WvdnGo11VA79zzyz+QelUpUAN/r6350yD0=;
    b=Lb+qFbKItS6dgtd2zh82ALVctzo0iiYXbuXUqwhyQPe0w81sddA5Z5z/bw200DdpKk
    35CfHQClt2jAWXS+S2XVdfJ4xuO17ZxpIrtk0TYyLDx96lGwhSzgVR7Ey20x0ilvtV6U
    zMmLp0gmIRBPYhFWy9voiWT6bkIBc4U4Jh4WJVpHsN7WSvb9DLyxHs8QaCVAwT4foJG3
    beCbJ40kt1/HNayQpYwyeTFXa8m/o/j9uAtoVfa8HPv6n/TYbJQi1zW+Exiz4nSLh/eG
    9NMFo9qXqRQrveMR8aLQTcj77jsLs6efPSfENGQ/0Hr9hoB7wiqYWtFRLGg3IHV1KVUl
    pfhA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1674482421;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=MzmR+pdf6WvdnGo11VA79zzyz+QelUpUAN/r6350yD0=;
    b=cFzH8aoau9UDu1+da4fdxCnPDKNnB6xsZoLQbyFNOKrcdmEDxbp8AMVJNx7Kgrdik8
    011YOEH9xuOvBNmR7eh5P4CljuMDMOVfrOlRbrncvgl8NtQGYDuV4r+udTCFrgHCQPeb
    0UqkwB9lXcrP4ZPZhmem+XHW4Avu48ZTJu8x/3fKTr5Je/xgYJNOAGEHR+JtKxH8r/M7
    xAcUpT5FYAaFTMKbx//FhIiqln9SLyDCrsvARvRh+LQc3XRNmNwe6BY+tJKGj2EvVEwc
    yA/eoIU5Km6tNpWyv2emNpNBykuPWw/60hoQ2amntjNxa59+dS0gOIKJNcsoG22cEFvQ
    oK8w==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u267FZF9PwpcNKjXrKw58qY="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.2.1 AUTH)
    with ESMTPSA id hf4e4dz0NE0K0OQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 23 Jan 2023 15:00:20 +0100 (CET)
Date:   Mon, 23 Jan 2023 15:00:14 +0100
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
Message-ID: <Y86S7h/QxqXoKS1U@gerhold.net>
References: <20230123023127.1186619-1-bryan.odonoghue@linaro.org>
 <42baa874-c926-9111-b0b3-2df2562d8de6@linaro.org>
 <Y86CPmgvAi+kChQI@gerhold.net>
 <45800033-e2ae-09c8-b8a2-e97afb6508fd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45800033-e2ae-09c8-b8a2-e97afb6508fd@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 01:23:22PM +0000, Bryan O'Donoghue wrote:
> On 23/01/2023 12:49, Stephan Gerhold wrote:
> > It's only required though because you forgot to drop the DT schema patch
> > (3/4) when I suggested half a year ago that you make the MSM8939
> > cpufreq-qcom-nvmem changes together with the CPR stack [1]. :/
> 
> Didn't forget, tested that and as I recall there are side-effects removing
> 8939 from drivers/cpufreq/cpufreq-dt-platdev.c - not all processors were
> booted.
> 

The cpufreq-dt-platdev.c addition for MSM8939 does not exist upstream
because you dropped it in your v3 back then. You just kept the DT schema
part. I don't have that addition and have no problems with SMP boot so
I would say it works fine without.

> > Anyway, it looks like qcom-cpufreq-nvmem.yaml requiring "cpr" power
> > domain unconditionally is a mistake anyway for multiple platforms.
> > [2] was recently submitted to fix this so that patch should allow you to
> > drop the dummy nodes. 😄
> > 
> > [1]:https://lore.kernel.org/linux-arm-msm/Ysf8VRaXdGg+8Ev3@gerhold.net/
> > [2]:https://lore.kernel.org/linux-arm-msm/20230122174548.13758-1-ansuelsmth@gmail.com/
> 
> 8939 _is_ a CPR device, I think qcs404 comes from msm893x IP.
> 
> To me it makes more sense to stub CPR in the DTS than to, wrongly declare
> the 8939 a non-CPR device.
> 

It is not clear yet which power domains 8939 needs to list for the CPUs.
The conclusion of the previous discussion of CPR for MSM8916 was that
the VDDMX requirements would be best handled separately from the CPR
driver, by listing it as separate power domain for all CPUs [3].

Unless this conclusion changes with your CPR patch set this means that
both the DTS and the DT schema will need changes anyway, because you
wouldn't need power-domain-names = "cpr", but rather

	power-domains = <&rpmpd MSM8939_VDDMX_AO>, <&vreg_dummy>;
	power-domain-names = "mx", "cpr";

QCS404 is a different situation in this case because it does not have
the requirement of voting for VDDMX states.

IMO this means that listing only "cpr" there with a dummy node is more
confusing than helpful right now. (I can explain this further if you
want, but I think I tend to write too long answers...)

Thanks,
Stephan

[3]: https://lore.kernel.org/linux-arm-msm/20200403175934.GA96064@gerhold.net/
