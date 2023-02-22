Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E8D69F71F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbjBVOvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231386AbjBVOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:50:57 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1C23BDAA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:50:36 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id 6so7591935wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2m0OKl4nW18kj3TpHqbzbDOvreek3tUnpMdCqgRNLUY=;
        b=VrX7QMEXYkklpuE/QmGcyM+XfZWgdCI6waWCn1IxTVFKfbrjRmBANQ6aupUg2Inyq4
         DlzPZFUgUjfOeGCdWQhU8oaKucowRbPPfxMzVCEW2YDoMmcRWcURQT7sorS486CJG5Nn
         SJl+dQ7BXA53fSPdTpidQwoPr8vs8AcGbbKOGVuv7+62H/sCfca9i3zL4X/ajs2AycfT
         ehEhAosIfas8y4KltM6h0mLijHcYZWvpSedP06ponR1T0mlE8fmMakodzEun3mrtbsPS
         TAB+Ol3GbEM5nEQSSPwwkp0gYNZIlusPrU0JnWtizWLjlZH89iutosstOCVCJbJChqHd
         wM7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2m0OKl4nW18kj3TpHqbzbDOvreek3tUnpMdCqgRNLUY=;
        b=kJoRPgiS4N/KKtVtBr6VpDvp7UI8Yns6sKlhepbx1cvplziWs8wXH82Jax9KnluL7g
         th5GAKTRpUsPViuRXBqE3ljWHJlMp84Xw5WTR8lDO5Igd1zqqMAjs+lLTWUuMlAWepr+
         fjKoC9TcCv+d2SSlbNwuFyTpyliMN4hbdWG1M9V9qxbbQDePoEuwGU0I0q1AZEnO2j9a
         go3f95oKhlGk3NepxFyTwGSLMDxemuVw1G1PlFiMRlSZayocHuQ1fVX7cwxDwuq21mGW
         s/53pw+lIV3sFbAs0i2JN5g2Cwa1vc10e4UvLQErOmE/TPNaS4YRdhD9ulhq+GlSSuxq
         hfNg==
X-Gm-Message-State: AO0yUKWNF/xRRV6EliGhq7s6xAtJjJyoknGk2HVGiycf8DznDf29DDpY
        dUaDv/BVfOfQJar3zap9HZph7A==
X-Google-Smtp-Source: AK7set8Xepbg4AmGPsxdF+FrCpHM2/HH2gMe8NzmWtaFsw7m9Ami5hXizGd4NMJ464FvfP8WDb+HnA==
X-Received: by 2002:a05:6000:3c8:b0:2c5:540b:886c with SMTP id b8-20020a05600003c800b002c5540b886cmr7004009wrg.31.1677077431804;
        Wed, 22 Feb 2023 06:50:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d58c1000000b002c53f5b13f9sm8483402wrf.0.2023.02.22.06.50.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 06:50:31 -0800 (PST)
Message-ID: <80339c7f-1cea-3c97-7dc4-5efb4597cb69@linaro.org>
Date:   Wed, 22 Feb 2023 15:50:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] soundwire: qcom: gracefully handle too many ports in
 DT
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20230222144412.237832-1-krzysztof.kozlowski@linaro.org>
 <20230222144412.237832-2-krzysztof.kozlowski@linaro.org>
 <dc544641-b9f1-96b4-95a1-30fafc0712e5@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <dc544641-b9f1-96b4-95a1-30fafc0712e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 15:47, Konrad Dybcio wrote:
> 
> 
> On 22.02.2023 15:44, Krzysztof Kozlowski wrote:
>> There are two issues related to the number of ports coming from
>> Devicetree when exceeding in total QCOM_SDW_MAX_PORTS.  Both lead to
>> incorrect memory accesses:
>> 1. With DTS having too big value of input or output ports, the driver,
>>    when copying port parameters from local/stack arrays into 'pconfig'
>>    array in 'struct qcom_swrm_ctrl', will iterate over their sizes.
>>
>> 2. If DTS also has too many parameters for these ports (e.g.
>>    qcom,ports-sinterval-low), the driver will overflow buffers on the
>>    stack when reading these properties from DTS.
>>
>> Add a sanity check so incorrect DTS will not cause kernel memory
>> corruption.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
> Fixes: 02efb49aa805 ("soundwire: qcom: add support for SoundWire controller")

Can be... but is it really a bug of the kernel? Issue is visible with
incorrect DTS and it's not the kernel's job to fix it. If DTS has
incorrect values (e.g. IO addresses) system won't work anyway and that's
the same type of bug.

Best regards,
Krzysztof

