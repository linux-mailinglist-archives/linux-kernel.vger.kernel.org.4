Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AF769C353
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 00:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBSXMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 18:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjBSXMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 18:12:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C791A4BC;
        Sun, 19 Feb 2023 15:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=61kCo1zYpbrwRC7wH53tCeZnAWFHSSME3wU/4gMA1YE=; b=fQo4xE4Ne8k5eIMZh3dyAkF5GN
        s6qojsaPJgoa4Q0WjJ/sac7iUNnoEM9lS1bNJL/SiysV8TjbMqR+4/xiXqwHcs7gtooBlwWUVEnk4
        GpnDYQjwhbmwyRnuekXh8Hc74d6k6a0KPD23pBo7wHDK7tj3ApCh8lGzL/NVlk6Sr3DwCrWH2aR+6
        jyTSMyMX3g6kbvpJFmNGuUiK/18DwHwMkN5VCgSW1iq635OwEeaRkA5ILCTikJCVA+ym19QEyDXEP
        QwwGOiu05Olja35FpQYCclgJ2ZlWuycKd3S3rDa/cp0U2GWwqJ5OV0b4SFEdiVH+XI+YDCg79r502
        tRE7WzRw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTsqr-002T8q-PC; Sun, 19 Feb 2023 23:12:13 +0000
Message-ID: <c10c0003-fd36-96f8-73d1-1a975330eb53@infradead.org>
Date:   Sun, 19 Feb 2023 15:12:12 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] drm/msm: fix new Konfig dependency warning
Content-Language: en-US
To:     Rob Clark <robdclark@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
References: <20230219185401.10479-1-rdunlap@infradead.org>
 <CAF6AEGv7xU2vhSi95MbsjzpRv4ANQ-vOOrchjJ=-uwW9f2q6Eg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAF6AEGv7xU2vhSi95MbsjzpRv4ANQ-vOOrchjJ=-uwW9f2q6Eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/23 15:09, Rob Clark wrote:
> On Sun, Feb 19, 2023 at 10:54 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> DEVFREQ_GOV_SIMPLE_ONDEMAND depends on PM_DEVFREQ, so in order to
>> select the former safely, this symbol should also depend on
>> PM_DEVFREQ to avoid a Kconfig dependency warning.
>>
>> WARNING: unmet direct dependencies detected for DEVFREQ_GOV_SIMPLE_ONDEMAND
>>   Depends on [n]: PM_DEVFREQ [=n]
>>   Selected by [m]:
>>   - DRM_MSM [=m] && HAS_IOMEM [=y] && DRM [=m] && (ARCH_QCOM || SOC_IMX5 || COMPILE_TEST [=y]) && COMMON_CLK [=y] && IOMMU_SUPPORT [=y] && (QCOM_OCMEM [=n] || QCOM_OCMEM [=n]=n) && (QCOM_LLCC [=y] || QCOM_LLCC [=y]=n) && (QCOM_COMMAND_DB [=n] || QCOM_COMMAND_DB [=n]=n)
>>
> 
> Actually, I fixed devfreq[1] so that we no longer depend on
> DEVFREQ_GOV_SIMPLE_ONDEMAND .. probably we should just drop
> DEVFREQ_GOV_SIMPLE_ONDEMAND from the kconfig instead, sorry I forgot
> to do that already

OK, I'll resend the patch with that change, unless you want to handle it...

Thanks.

> BR,
> -R
> 
> [1] https://patchwork.freedesktop.org/series/113232/
> 
>> Fixes: 6563f60f14cb ("drm/msm/gpu: Add devfreq tuning debugfs")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Rob Clark <robdclark@gmail.com>
>> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Cc: Sean Paul <sean@poorly.run>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: linux-arm-msm@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: freedreno@lists.freedesktop.org
>> ---
>>  drivers/gpu/drm/msm/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff -- a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
>> --- a/drivers/gpu/drm/msm/Kconfig
>> +++ b/drivers/gpu/drm/msm/Kconfig
>> @@ -9,6 +9,7 @@ config DRM_MSM
>>         depends on QCOM_OCMEM || QCOM_OCMEM=n
>>         depends on QCOM_LLCC || QCOM_LLCC=n
>>         depends on QCOM_COMMAND_DB || QCOM_COMMAND_DB=n
>> +       depends on PM_DEVFREQ
>>         select IOMMU_IO_PGTABLE
>>         select QCOM_MDT_LOADER if ARCH_QCOM
>>         select REGULATOR

-- 
~Randy
