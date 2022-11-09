Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 480A9622B27
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiKIMNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiKIMNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:13:45 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB7313E96;
        Wed,  9 Nov 2022 04:13:41 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id D58EC42168;
        Wed,  9 Nov 2022 12:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1667996019; bh=gnyEW5Eu0OTfywg6gUByhNDslMLohLF3wbKzed1krRI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=h3elw2oM48eq5CCHoz82Q+1h8J9bP+i/w8c/7Xfq8B388CGOrfdBUbJAZZULJfvbR
         O254Sz8VC5r9h1SPIDRlrhtPBYx8XFLYs03Ixca0EN7fXhr0guYtcUemXRMOasIsld
         JCjlzYeMoLPt9Ze4jpffLqAGF1D2sUtXRa5k8AJDeFLkr0PxQzaP985ui/rVfAGZx5
         OrmWoaLEshw6Ar0GkjZaY6sb3AR1vL41rNECerNapSEl2DNIgLpirOP0MXZW3wUIdY
         lSKThQTNJvlDHz9qStiFmIXf1054pQd+AQ1Rg5Ai21OzCrFbCkU9by0+sixKSncqSl
         SnBuCSkRyUImA==
Message-ID: <3d4536c9-4b3b-8312-4868-5e5b42a87424@marcan.st>
Date:   Wed, 9 Nov 2022 21:13:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v3 4/5] cpufreq: apple-soc: Add new driver to control
 Apple SoC CPU P-states
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024043925.25379-1-marcan@marcan.st>
 <20221024043925.25379-5-marcan@marcan.st> <8635bdocco.wl-maz@kernel.org>
From:   Hector Martin <marcan@marcan.st>
In-Reply-To: <8635bdocco.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 17.27, Marc Zyngier wrote:
> On Mon, 24 Oct 2022 05:39:24 +0100,
> Hector Martin <marcan@marcan.st> wrote:
>>
>> This driver implements CPU frequency scaling for Apple Silicon SoCs,
>> including M1 (t8103), M1 Max/Pro/Ultra (t600x), and M2 (t8112).
>>
>> Each CPU cluster has its own register set, and frequency management is
>> fully automated by the hardware; the driver only has to write one
>> register. There is boost frequency support, but the hardware will only
>> allow their use if only a subset of cores in a cluster are in
>> non-deep-idle. Since we don't support deep idle yet, these frequencies
>> are not achievable, but the driver supports them. They will remain
>> disabled in the device tree until deep idle is implemented, to avoid
>> confusing users.
>>
>> This driver does not yet implement the memory controller performance
>> state tuning that usually accompanies higher CPU p-states. This will be
>> done in a future patch.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>  drivers/cpufreq/Kconfig.arm          |   9 +
>>  drivers/cpufreq/Makefile             |   1 +
>>  drivers/cpufreq/apple-soc-cpufreq.c  | 352 +++++++++++++++++++++++++++
>>  drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
>>  4 files changed, 364 insertions(+)
>>  create mode 100644 drivers/cpufreq/apple-soc-cpufreq.c
>>
> 
> [...]
> 
>> +static struct freq_attr *apple_soc_cpufreq_hw_attr[] = {
>> +	&cpufreq_freq_attr_scaling_available_freqs,
>> +	NULL,
>> +	NULL,
> 
> nit: extra NULL?

That slot gets filled in later if boost is enabled, hence the need for
an extra terminating NULL in that case.

- Hector
