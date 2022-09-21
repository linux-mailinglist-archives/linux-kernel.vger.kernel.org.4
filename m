Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E5C5E54CC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 22:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiIUUzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 16:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIUUzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 16:55:20 -0400
Received: from proxmox1.postmarketos.org (proxmox1.postmarketos.org [213.239.216.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AB2A2AE3B;
        Wed, 21 Sep 2022 13:55:17 -0700 (PDT)
Received: from [192.168.20.2] (unknown [77.239.252.99])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by proxmox1.postmarketos.org (Postfix) with ESMTPSA id 88F6B14023D;
        Wed, 21 Sep 2022 20:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
        s=donut; t=1663793715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nGYXTPOt3zCzwp92JW8LyqdaThQz7kjvGR8CDOfHJf0=;
        b=khdERCMXn98k8bYp7rsHWjm6DOW67jNr8VfAlgsY+kvPG+JkChAH2wwgUKv2EcbPf9+ei2
        E/rYR2CbZriDsixJ2oMihcGo8PMGaHW7alVasFOJRvRO+VzfAoNqMqeKBSAwPmxwOY4swh
        QNL8g8wjbyPhbZWU//9qGeJ5aidaaD4=
Message-ID: <37ebdd21-e46a-fac9-7e87-57042ab67d5c@postmarketos.org>
Date:   Wed, 21 Sep 2022 23:55:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v4 3/3] ARM: dts: qcom: msm8974: switch TCSR mutex to MMIO
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220920150414.637634-1-krzysztof.kozlowski@linaro.org>
 <20220920150414.637634-4-krzysztof.kozlowski@linaro.org>
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <20220920150414.637634-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20.09.2022 18:04, Krzysztof Kozlowski wrote:

> -	tcsr_mutex: tcsr-mutex {
> -		compatible = "qcom,tcsr-mutex";
> -		syscon = <&tcsr_mutex_block 0 0x80>;

I'm looking and don't understand where does this information go, is it 
lost in the conversion? I mean those "0 0x80" parameters to syscon 
reference.

Looking at the code of qcom_hwspinlock driver those seem to be read by 
qcom_hwspinlock_probe_syscon() [1] using  of_property_read_u32_index() 
as base and stride values and those would be 0 nad 0x80 respectively as 
is now.

But without syscon reference, in mmio mode, code goes through 
qcom_hwspinlock_probe_mmio() few lines below, which says

	/* All modern platform has offset 0 and stride of 4k */
	*offset = 0;
	*stride = 0x1000;

So after this conversion stride value will jump from 0x80  to 0x1000, 
which does not seem to be 1 to 1 identical conversion to me, unless I am 
missing something.

Perhaps msm8974 does not fall into category of "All modern platform"?


[1] 
https://elixir.bootlin.com/linux/latest/source/drivers/hwspinlock/qcom_hwspinlock.c#L73

-- 
Regards
Alexey Minnekhanov
