Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF63671DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjARNYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjARNXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:23:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F98F2A14C;
        Wed, 18 Jan 2023 04:50:43 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CEEA16602DFF;
        Wed, 18 Jan 2023 12:50:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674046242;
        bh=oeiaamJgDNdwr5Xa4TX2CMdpkyV4DV3G1iGY486t7oc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C66exSRmLAFtEfVKiRKdLHOOkLp00xNHSfwfEoiS8EQ5NgcS1lDJl2gfUi5B7DN16
         ziuNv8KKiKqJEXzyCLFCc2AtUsEhimxWLXoIAk4WqmXzWW8i/8HS//173RFR+3ByOE
         YhEYpXOh2xA1NsCadN5P0YjedH/7ppENuA5ZPiQxdtEu+U92+6hq7+vLDQkmN3L4/l
         gPugrV7OooJfs2YQIhjOVrk7FaCF0YIj1aGFFxwif7qmYfZIAtuLFUe+0/TgG7EwBe
         iZbJe0aVdGLXNY7coePIfuwLMYywKHcI4oJsdMoW/G026gMqBFfZDB3dm3q7yQov5I
         UUwkD9x9IBqQw==
Message-ID: <dfecf744-30c6-e9b5-5a75-045aca840cae@collabora.com>
Date:   Wed, 18 Jan 2023 13:50:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v9 5/6] soc: qcom: Add support for Core Power Reduction
 v3, v4 and Hardened
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <20230116093845.72621-1-konrad.dybcio@linaro.org>
 <20230116093845.72621-6-konrad.dybcio@linaro.org>
 <5ced2e01-367f-5e0d-8120-aa5ef4d4eeab@gmail.com>
 <233f0d52-4f9d-a512-0450-77e2fb4da878@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <233f0d52-4f9d-a512-0450-77e2fb4da878@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

..snip..

>>> +
>>> +static const struct cpr_desc sdm630_cpr_desc = {

..snip..

>>> +    },
>>> +};
>>
>> Hi Konrad, I am trying to add IPQ8074 support to CPR as its the last thing
>> missing for upstream CPU scaling, and I really want to get rid of the downstream driver.
>>
>> However, I am having hard time figuring some of these parameters, some are easy to
>> read from the DTS or driver defines, however arent the fuse corners supposed to be read
>> from the fuses and not hardcocded in the thread structures?
> They reside in socname-regulator.dtsi most of the time.
> Some parameters are read from fuses (per-unit capabilities
> that let your specific chip run at a specific voltage offset),
> but there's also some per-SoC-model data that needs to be
> taken into account when performing the calculations.. This
> is actually a smart move from Qualcomm (well, for them
> anyway), as they put as little data in fuses as possible,
> saving them space on this tiiiiny ROM.
> 
>>
>> Mind you, I dont have any docs so I am mostly using the downstream kernel as the reference.
> This driver doesn't do anything more than its downstream
> counterpart, everything we need should be there on msm-X.Y.
> 
> One flaw in this revision is that it doesn't yet support
> multiple speed bins, so if your SoC has n of those, you
> may get confused by n sets of values.. This is easy to
> improve on in future, but this initial submission is
> already very fat to begin with..
> 
> 

Hello Robert, Konrad,

since it is a bit difficult to find and follow discussions started/written in
a random place of a file (and reviews, as well), can you please cut off the
unnecessary text before sending out a reply?

Anyway, the fuse corners are actually read from fuses; the values that you see
hardcoded are references and safety min/max values which purpose is to both
perform calculation after fuse reading and to ensure safety (example: you put
a wrong bits range to read from fuses, the driver saves you by refusing to set
a very high voltage on the CPU core[s]).

As for where to find the values, I personally don't precisely remember, as that
was done more than 1.5 years ago, but what I recall is that they're scattered
across multiple files, including devicetree and drivers.

I also remember that I had to add debugging prints to the downstream driver in
order to get one of the values right... but that may have been due to MSM8998
values being a bit strange.

Thanks,
Angelo

