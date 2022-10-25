Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B5E60D65B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 23:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbiJYVyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 17:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232489AbiJYVx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 17:53:59 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 244E3DCAC1;
        Tue, 25 Oct 2022 14:53:59 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id u7so9838144qvn.13;
        Tue, 25 Oct 2022 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbJ4NnkX10m24RxHBmbWMMu5R35w6r62mB5Wio3Au8c=;
        b=hsFhDtkVpw7AcamuE84jbXKnhKkYKslDqV2q/w78XffWLozsiJeEJTAcjio+cY+yun
         OE/zWcP7eJma7qzpPjv/jTubF+EK0DUpoUtjeKI2IUDlRQpQF0aqDgTa6cCPgVUCsYYs
         jIc0SssV0OF1a0uLJrbxplHeyFw4KCSOiT95zz33vVroqXYQQqEi87gWqNV3T4Z7+G8y
         eaAA0J/PR1XOVD7CFyMe7GIEGU72htIDfpTrZMNJwfCS5suEcsDHdkUlS5UjFnunmmW6
         jb9zqH/HOiSE3G1vxbFWROPLocV3xTgXm7BywM+SNuconT3YvuExN94WpPqd71in+Rxy
         Ee7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbJ4NnkX10m24RxHBmbWMMu5R35w6r62mB5Wio3Au8c=;
        b=lwBi46d7gSRtMiNA16wAWmUjTZs2ay2IvdkD2bvt/o6CWAS+P8pjDnAKT1ARA4cvt1
         rtbApmr6ZDreZ53BbAFltBp3fBNVZVQj3oFUTCAGvK0Vo17nEE2ewJN/rccc/083G3mv
         ROK15eEQ7kYda01enxGjofGJdb6irSSJ2w4x5X/95FaXj6ofyrnKsL2AmtRio20U3E9o
         wJ1Bt2GX9Ma/K9/oFFz5HWlf+ySAiJ+8N1Yflju57NS2b4GFv2hAlRsPl0CUnFcF15gt
         sEKe+Yd808pR0iy9f/H/0ccq2PNauNOL0IOXg3Jkr2WI29MjSNHfpZB1v4tyikmOqdyG
         J5vA==
X-Gm-Message-State: ACrzQf3/i62fn1OknSWZ55g5kYYb4eWgOs0UEegR2J35vs5fSZkJkqbY
        THvXOOPuJzMv8JUX2k4S6AU=
X-Google-Smtp-Source: AMsMyM7Wy1KrPV3TkDFznjkCC4Xdv4PStoiHYJHZ4CIWBxZM1wUEjNN9CENYYovvMCtkLaQ7Vrv3Jw==
X-Received: by 2002:a05:6214:c89:b0:4b1:99b8:9260 with SMTP id r9-20020a0562140c8900b004b199b89260mr33926268qvr.116.1666734838184;
        Tue, 25 Oct 2022 14:53:58 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id e7-20020ac85987000000b0039cbb50951asm2318590qte.24.2022.10.25.14.53.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 14:53:57 -0700 (PDT)
Message-ID: <6268199c-78ca-8f55-0377-c14bb0299443@gmail.com>
Date:   Tue, 25 Oct 2022 14:53:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3 6/7] mmc: sdhci_am654: Fix SDHCI_RESET_ALL for CQHCI
Content-Language: en-US
To:     Brian Norris <briannorris@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        linux-mmc@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, Haibo Chen <haibo.chen@nxp.com>,
        Andy Gross <agross@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Faiz Abbas <faiz_abbas@ti.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20221024175501.2265400-1-briannorris@chromium.org>
 <20221024105229.v3.6.I35ca9d6220ba48304438b992a76647ca8e5b126f@changeid>
 <5b91c0eb-52aa-8431-c286-81b7feae84ce@intel.com>
 <Y1hY57vkkOhybwE1@google.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Y1hY57vkkOhybwE1@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 14:45, Brian Norris wrote:
> On Tue, Oct 25, 2022 at 04:10:44PM +0300, Adrian Hunter wrote:
>> On 24/10/22 20:55, Brian Norris wrote:
>>> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
>>> index 8f1023480e12..6a282c7a221e 100644
>>> --- a/drivers/mmc/host/sdhci_am654.c
>>> +++ b/drivers/mmc/host/sdhci_am654.c
> 
>>> @@ -378,7 +379,7 @@ static void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
>>>   	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>   	struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
>>>   
>>> -	sdhci_reset(host, mask);
>>> +	sdhci_and_cqhci_reset(host, mask);
>>>   
>>>   	if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
>>>   		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>>
>> What about sdhci_reset in sdhci_am654_ops ?
> 
> Oops, I think you caught a big fallacy in some of my patches: I assumed
> there was a single reset() implementation in a given driver (an unwise
> assumption, I realize). I see at least sdhci-brcmstb.c also has several
> variant ops that call sdhci_reset(), and I should probably convert them
> too.

You got it right for sdhci-brcmstb.c because "supports-cqe" which gates 
the enabling of CQE can only be found with the "brcm,bcm7216-sdhci" 
compatible which implies using brcmstb_reset().
-- 
Florian

