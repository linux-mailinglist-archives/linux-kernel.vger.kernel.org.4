Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEE65BF840
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 09:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiIUHv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 03:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiIUHvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 03:51:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6BF85F99;
        Wed, 21 Sep 2022 00:51:10 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EE2A86601FFC;
        Wed, 21 Sep 2022 08:51:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663746668;
        bh=BNV50hEdKXctIBRcQ+PptlssxFpSxId9klX7ELMc9cg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fqBbICgEmlslGqp+WPNr9vxlOrn61Ws1p1ZaC7NvtoTORIu4Lm+L9LzDRNti66UYM
         ao0YF+I8tHNRjFZzZmbA9PH5B2c8dm5l97gINKjjYgY3yBs/kQndbLxaG9jmnbFqCO
         ZLZ33It1SYQmu3TOJCujlWvXCpGXTPZXlnCm7VXSdbrJvm8FWOIPcTyhS1hrsbJ2f1
         ElUUmpKCl3Tqe3hF6Gie3fPKj7ygyCYTpJTJvhVzp7o5xoxauuiFF6L4SY67/8WDyl
         3sDYINIDWolIr4o9rYUvsXHWG2KV4FBNG4/yr2MvMeUrfu1sdd5ZboEEIeZ7gysgjK
         aNtfM9ccVeBqw==
Message-ID: <1a845259-fce2-d239-588b-a70ea5b19680@collabora.com>
Date:   Wed, 21 Sep 2022 09:51:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 1/3] clk: qcom: gdsc: Fix the handling of PWRSTS_RET
 support
To:     Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, mka@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, quic_kriskura@quicinc.com,
        dianders@chromium.org, linux-clk@vger.kernel.org
References: <20220920111517.10407-1-quic_rjendra@quicinc.com>
 <d813e8a5-9eba-b3f7-2eee-cd721d120a30@collabora.com>
 <096205ee-2c8a-facf-87ce-2309c63d2400@quicinc.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <096205ee-2c8a-facf-87ce-2309c63d2400@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/09/22 15:39, Rajendra Nayak ha scritto:
> 
> On 9/20/2022 6:09 PM, AngeloGioacchino Del Regno wrote:
>> Il 20/09/22 13:15, Rajendra Nayak ha scritto:
>>> GDSCs cannot be transitioned into a Retention state in SW.
>>> When either the RETAIN_MEM bit, or both the RETAIN_MEM and
>>> RETAIN_PERIPH bits are set, and the GDSC is left ON, the HW
>>> takes care of retaining the memory/logic for the domain when
>>> the parent domain transitions to power collapse/power off state.
>>>
>>> On some platforms where the parent domains lowest power state
>>> itself is Retention, just leaving the GDSC in ON (without any
>>> RETAIN_MEM/RETAIN_PERIPH bits being set) will also transition
>>> it to Retention.
>>>
>>> The existing logic handling the PWRSTS_RET seems to set the
>>> RETAIN_MEM/RETAIN_PERIPH bits if the cxcs offsets are specified
>>> but then explicitly turns the GDSC OFF as part of _gdsc_disable().
>>> Fix that by leaving the GDSC in ON state.
>>>
>>> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
>>> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>> ---
>>> v3:
>>> Updated changelog
>>>
>>> There are a few existing users of PWRSTS_RET and I am not
>>> sure if they would be impacted with this change
>>>
>>> 1. mdss_gdsc in mmcc-msm8974.c, I am expecting that the
>>> gdsc is actually transitioning to OFF and might be left
>>> ON as part of this change, atleast till we hit system wide
>>> low power state.
>>> If we really leak more power because of this
>>> change, the right thing to do would be to update .pwrsts for
>>> mdss_gdsc to PWRSTS_OFF_ON instead of PWRSTS_RET_ON
>>> I dont have a msm8974 hardware, so if anyone who has can report
>>> any issues I can take a look further on how to fix it.
>>
>> I think that the safest option is to add a PWRSTS_RET_HW_CTRL flag (or similar),
>> used for the specific cases of SC7180 and SC7280 (and possibly others) where the
>> GDSC is automatically transitioned to a Retention state by HW control, with no
>> required software (kernel driver) intervention.
> 
> Having a PWRSTS_RET_HW_CTRL flag would make sense if there was also a
> PWRSTS_RET_SW_CTRL way of achieving Retention state, but FWIK there isn't.
> I am sure that's the way it is on 8974 as well, I just don't have hardware to
> confirm.
> 
>>
>>>
>>> 2. gpu_gx_gdsc in gpucc-msm8998.c and
>>>     gpu_gx_gdsc in gpucc-sdm660.c
>>> Both of these seem to add support for 3 power state
>>> OFF, RET and ON, however I dont see any logic in gdsc
>>> driver to handle 3 different power states.
>>> So I am expecting that these are infact just transitioning
>>> between ON and OFF and RET state is never really used.
>>> The ideal fix for them would be to just update their resp.
>>> .pwrsts to PWRSTS_OFF_ON only.
>>
>> static int gdsc_init(struct gdsc *sc)
>> {
>>
>>      ...
>>
>>      if (on || (sc->pwrsts & PWRSTS_RET))
>>          gdsc_force_mem_on(sc);
>>      else
>>          gdsc_clear_mem_on(sc);
>>
>>      ...
>> }
>>
>> On MSM8998 and SDM630/636/660, we're reaching that point with a GDSC that is
>> left OFF from the bootloader, but we want (at least for 630/660) memretain
>> without periph-retain: this is required to make the hypervisor happy.
> 
> Ideally setting the memretain bits while the GDSC is OFF should have no affect
> at all. Is this for the gpu_gx_gdsc on 630/660? Is this needed only at the init
> time (when the bootloader has left it OFF) or is it needed everytime the kernel
> turns it OFF too?

Even though I don't remember the flow in a clear way (this entire thing was done
years ago), I'm sure that for PWRSTS_OFF memretain can be cleared, so, the current
flow that we have in gdsc.c does work correctly.

Ideally, I agree with you that the memretain bits should have no effect at all
while the GDSC is OFF, but that's the situation on these platforms.

> How did we come up with this trick to keep the hypervisor happy, was it picked
> up from some downstream reference code?

Yes, it was found in various releases of the downstream kernel for 8998/630/660.

> 
>>
>> Regards,
>> Angelo
>>

