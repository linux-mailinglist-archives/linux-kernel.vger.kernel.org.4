Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D9D690BE1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjBIOfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjBIOew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:34:52 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1351F5C9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:34:51 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4PCKBx2BsCz1S5Gk
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:34:49 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:in-reply-to:from
        :references:to:content-language:subject:user-agent:mime-version
        :date:message-id; s=dkim; t=1675953288; x=1676817289; bh=OtwHaQd
        43ev0CTnwqIm/FUCsnnqbo5VRlxBW82fmyng=; b=H45rGLKnOkvzxImDk3fnZ7B
        PaQmSau8WRULXMxDKa2GyRi0GarWzEdFJm6F234o6B1a1pSKi/NGa8vap4goDoQG
        RoLr4F4qpmeWfor/YEdkU8RqEdgt/rh5I0FnuYt1af0u0bp4/WRXvdI3/qkF+bQT
        RGIrEs/k5zE2wbVid1TkcQFJ0aPmuuWo+K0J03jhijsN5U0UC5AM79z3PC019cN0
        FReRT4iwjQyZax9lEdnIZggVjpt42L1vum6bewMifqlXBdUgm9ByVRFuRIXiLVgd
        QyI+LReM82T+ip68VXqcbtDFig+3Nk66rfLhHi3VSIcDOEwS3ZIQnjJ98UVyvAg=
        =
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WOPhAXx4-T0C for <linux-kernel@vger.kernel.org>;
        Thu,  9 Feb 2023 09:34:48 -0500 (EST)
Received: from [192.168.4.25] (unknown [190.196.95.28])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4PCKBY4Xnbz1S5Gh;
        Thu,  9 Feb 2023 09:34:21 -0500 (EST)
Message-ID: <bb6f8a51-cec8-02cc-8ac1-3cd714a2e59a@mint.lgbt>
Date:   Thu, 9 Feb 2023 11:34:17 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 3/6] phy: qcom-qmp: Add SM6125 UFS PHY support
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, bvanassche@acm.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
References: <20230108195336.388349-1-they@mint.lgbt>
 <20230108195336.388349-4-they@mint.lgbt>
 <CAA8EJpp-RwPOv61MtoXYb3Tuy5LDWWBCvYSrGUOvg8vWhid_tw@mail.gmail.com>
From:   Lux Aliaga <they@mint.lgbt>
In-Reply-To: <CAA8EJpp-RwPOv61MtoXYb3Tuy5LDWWBCvYSrGUOvg8vWhid_tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 16:31, Dmitry Baryshkov wrote:

> On Sun, 8 Jan 2023 at 21:54, Lux Aliaga <they@mint.lgbt> wrote:
>> The SM6125 UFS PHY is compatible with the one from SM6115. Add a
>> compatible for it and modify the config from SM6115 to make them
>> compatible with the SC8280XP binding
>>
>> Signed-off-by: Lux Aliaga <they@mint.lgbt>
>> Reviewed-by: Martin Botka <martin.botka@somainline.org>
>> ---
>>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> index 318eea35b972..f33c84578940 100644
>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
>> @@ -693,6 +693,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_cfg = {
>>   static const struct qmp_phy_cfg sm6115_ufsphy_cfg = {
>>          .lanes                  = 1,
>>
>> +       .offsets                = &qmp_ufs_offsets_v5,
> Please don't randomly reuse generation-specific structures. This
> structure is clearly related to v5, while the PHY is from the v2
> generation.

I'm a bit confused here. When referencing back to downstream the driver 
used has the suffix "v3-660". Should I use that suffix to name these 
offsets? Because I'm not too sure if this is from the v2 generation due 
to how it's named there.

>> +
>>          .serdes_tbl             = sm6115_ufsphy_serdes_tbl,
>>          .serdes_tbl_num         = ARRAY_SIZE(sm6115_ufsphy_serdes_tbl),
>>          .tx_tbl                 = sm6115_ufsphy_tx_tbl,
>> @@ -1172,6 +1174,9 @@ static const struct of_device_id qmp_ufs_of_match_table[] = {
>>          }, {
>>                  .compatible = "qcom,sm6115-qmp-ufs-phy",
>>                  .data = &sm6115_ufsphy_cfg,
>> +       }, {
>> +               .compatible = "qcom,sm6125-qmp-ufs-phy",
>> +               .data = &sm6115_ufsphy_cfg,
>>          }, {
>>                  .compatible = "qcom,sm6350-qmp-ufs-phy",
>>                  .data = &sdm845_ufsphy_cfg,
>> --
>> 2.39.0
>>
>
-- 
Lux Aliaga
https://nixgoat.me/

