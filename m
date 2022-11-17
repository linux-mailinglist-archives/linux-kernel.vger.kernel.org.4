Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB2A62D622
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 10:13:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbiKQJNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 04:13:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234652AbiKQJNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 04:13:04 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B065A6EC;
        Thu, 17 Nov 2022 01:13:00 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1D3A26602A93;
        Thu, 17 Nov 2022 09:12:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668676378;
        bh=SFQur8w++WtWtWUmeDZl15V5obNwof6k6WSAyb01Oh8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D79JYLyaGrPA+2WCDS3MxkJN5sbYA0Pg4beN0zs16QnCAoEYlv4MGG8nVtbKLZ70I
         cP6P3XCb0SX45eJE3DzadkSxOCWvpjAvIBy0nDs6dNCEUNXtuYh8+rHuMxXlp00peH
         9qOD7ncgQFqPZCikksyI9Ly8hbe8mQzptegoiqxwWLxLqlf7zQlPqQhgDApOrNMo0X
         d14of/UE8CcsO6SNNhO/JjGyyWcoCqsyi9BXuDMZPstzjN8UNdKccth8rUTulel4Ug
         7mTkXIIYrasWYGTPJpXrx/kGs2bXk3KyjB85RH0WMtUJVDWkEzuidOony21549AbdA
         F5LL75dHtm+ew==
Message-ID: <42d55695-9db0-b835-4837-8dae6e76046c@collabora.com>
Date:   Thu, 17 Nov 2022 10:12:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 2/2] soc: qcom: Add Qualcomm Ramp Controller driver
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, agross@kernel.org
Cc:     andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, marijn.suijten@somainline.org,
        kernel@collabora.com
References: <20221115154555.324437-1-angelogioacchino.delregno@collabora.com>
 <20221115154555.324437-3-angelogioacchino.delregno@collabora.com>
 <555fbc95-c002-7705-0639-9deb701ad513@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <555fbc95-c002-7705-0639-9deb701ad513@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 16/11/22 14:46, Dmitry Baryshkov ha scritto:
> On 15/11/2022 18:45, AngeloGioacchino Del Regno wrote:
>> The Ramp Controller is used to program the sequence ID for pulse
>> swallowing, enable sequence and linking sequence IDs for the CPU
>> cores on some Qualcomm SoCs.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/soc/qcom/Kconfig           |   9 +
>>   drivers/soc/qcom/Makefile          |   1 +
>>   drivers/soc/qcom/ramp_controller.c | 331 +++++++++++++++++++++++++++++
>>   3 files changed, 341 insertions(+)
>>   create mode 100644 drivers/soc/qcom/ramp_controller.c
>>
> 
> I'd allow myself to re-ask the same questions here:
> 
> Generic question. regarding this controller. If it is supposed to work
> close to DVCS, etc. Does ramp controller need any programming when
> changing speed and/or APC voltage?
> Is it necessary to turn ramp on and off during the runtime?
> 

No, it's a set-and-forget type of programming. Turning that on/off during
runtime is self-managed and, after the initial setting that this driver,
no further action is required - or at least not from Linux.

Cheers!
Angelo
