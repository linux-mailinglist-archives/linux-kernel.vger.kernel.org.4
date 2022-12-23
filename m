Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF0E654E54
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:27:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236182AbiLWJ1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLWJ1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:27:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2020836D7C;
        Fri, 23 Dec 2022 01:27:01 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1EF056602CE0;
        Fri, 23 Dec 2022 09:26:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671787619;
        bh=E1AtAP8t04wkzu6WeHM2BkXITsnCjN59DnHyrF0N5Ds=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=McUWUJBisrjCwKxmZRsTq9xcBctF1QsYnXNByR7B8uWzC3QbX+m3Iya3/Dbt/jL51
         Z6QFqTPENgjP58lr1GVMBZIEKKxbQTVvaiDEbLcnc9YMiDV//LMhy2LiI1bJEjZPbz
         p/05n77Sbl2cp1O7O1pNGeY+n2Asby+5jszV+OpT6GrTiXGELYjTK9/icWaIUoDmgI
         3+TjR3pVv9CmYITcGoEExsu5cnTIifm1s850t1LCkdSVu84fI1LE5DHAHOsJQqCQ0V
         FOBvcxHgUfGyHa8ujsm4Zfg5qxWUMCDaRvnT0lrWeL4LZC9aosmDwOARngBxLAOLwH
         rMmG39lsrwmRg==
Message-ID: <c4b75af0-76d7-7eb7-f0e5-53c7edd13304@collabora.com>
Date:   Fri, 23 Dec 2022 10:26:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] clk: qcom: dispcc-sm6125: Fix compatible string to match
 bindings
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>,
        phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221222210140.278077-1-marijn.suijten@somainline.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221222210140.278077-1-marijn.suijten@somainline.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 22/12/22 22:01, Marijn Suijten ha scritto:
> According to generic rules the SoC name should be first:
> 
>          arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dtb: clock-controller@5f00000: compatible: 'oneOf' conditional failed, one must be fixed:
>                  'qcom,dispcc-sm6125' does not match '^qcom,(apq|ipq|mdm|msm|qcm|qcs|sa|sc|sdm|sdx|sm)[0-9]+-.*$'
> 
> And this is already reflected by the bindings submitted prior to the
> addition of this driver.  Any DTS following these rules will end up with
> a non-probing driver because of this mismatch.
> 
> Fixes: 6e87c8f07407 ("clk: qcom: Add display clock controller driver for SM6125")
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

Since there's no devicetree that is currently using the wrong compatible, you
are *not* breaking anything - hence fixing that issue without any regression.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


