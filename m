Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CBD6830E7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjAaPI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbjAaPIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:08:02 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763F959243;
        Tue, 31 Jan 2023 07:05:30 -0800 (PST)
Received: by mail-ot1-f48.google.com with SMTP id n25-20020a9d7119000000b0068bd8c1e836so1281989otj.3;
        Tue, 31 Jan 2023 07:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lq3OL8h9vdEYAdxMr2B4vcqKQPH7f6WxjeGzTRkPQws=;
        b=dUac5rzNXEGEKwkTvh0KS+D6Qc3O9c68ID+AU6dRXQJW4rbyvkRLVJu47a1JRWPH4H
         MLjDbAe8xUh8CCvvVvF0JFOSfR57jELqy8zwlj3pHErKBGI9xbQVMOM3xzBmmdJrz4wS
         mxz2AiPiQUWMLkOBgNigs1GBpIlEkfeVBewzJwAb2AUuGU5muv/MVu1M51mpYnT7VW5W
         G2jBgyehzGDLe+wPeLQFyPc43g7feAr97WpSMEAYDyINUpQL19YaFJpQ6PJLy/75fnOT
         gQaaIWgb+rA6Lhe+bSovUWqJSPt0DvLkdV46GYPMYXTJ6viNUK5lQgIwI6B+wUgxS4uN
         KY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lq3OL8h9vdEYAdxMr2B4vcqKQPH7f6WxjeGzTRkPQws=;
        b=QMGE4XbL0lmfyNQi4/fmNRmynwC30uVjGUDbCmG/PImu8GdvmTrksSEAlvfG3KmLq/
         7uaDDEbNi14DYvLxhphCeg5Spunma09zPy+2so4pyrCCUokwT2CzDPIq1oJUGYYlcUjn
         HR0o7Tm2oO7vHMkHcLouO2616Uyw8rcm7CRr5B7tmLKULUUglmMav7Y9asExBAQ+KgvM
         kTzt7vbieKfo8PiSBKExtzjkVm+5a5DJhjufPdbZZtvcm3M/MX997mvIJ6dhkDq4iKO4
         OYijrOKLwd5XvTZH/KaxCIMRITWmlNzzFqbRaUe2ZBoE7mANzEmQuiLOljss6OuLX584
         +7/Q==
X-Gm-Message-State: AO0yUKVLE7hLcvj00NBYHhCilkIp+X4mhJVOwiq51hek/Kyu4fWZuoCK
        gB+er5NDDAfMldC10snlN4c=
X-Google-Smtp-Source: AK7set+RwYlttlhtFhjsEolM0kCW5UgRsBFJRJ9MkY5Sixlj0wy5HTBYJsRtTxzgxAPBZ/mJLPvWtw==
X-Received: by 2002:a9d:7844:0:b0:686:50ca:7404 with SMTP id c4-20020a9d7844000000b0068650ca7404mr5801228otm.4.1675177411996;
        Tue, 31 Jan 2023 07:03:31 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z9-20020a9d71c9000000b0068bbaf7a1b0sm1450396otj.34.2023.01.31.07.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:03:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 07:03:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Russ Weight <russell.h.weight@intel.com>,
        Tianfei zhang <tianfei.zhang@intel.com>
Subject: Re: [PATCH] hwmon: intel-m10-bmc-hwmon: Add N6000 sensors
Message-ID: <20230131150330.GA3591577@roeck-us.net>
References: <20230131135450.43072-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230131135450.43072-1-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:54:50PM +0200, Ilpo Järvinen wrote:
> From: Tianfei zhang <tianfei.zhang@intel.com>
> 
> Add sensors supported by N6000 card with MAX10 BMC to monitor
> temperature, voltage, current, and power on board.
> 
> Signed-off-by: Tianfei zhang <tianfei.zhang@intel.com>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/intel-m10-bmc-hwmon.c | 229 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 229 insertions(+)
> 
> diff --git a/drivers/hwmon/intel-m10-bmc-hwmon.c b/drivers/hwmon/intel-m10-bmc-hwmon.c
> index 6e82f7200d1c..2f0323c14bab 100644
> --- a/drivers/hwmon/intel-m10-bmc-hwmon.c
> +++ b/drivers/hwmon/intel-m10-bmc-hwmon.c
> @@ -340,6 +340,231 @@ static const struct m10bmc_hwmon_board_data n5010bmc_hwmon_bdata = {
>  	.hinfo = n5010bmc_hinfo,
>  };
>  
> +static const struct m10bmc_sdata n6000bmc_temp_tbl[] = {
> +	{ 0x444, 0x448, 0x44c, 0x0, 0x0, 500, "FPGA E-TILE Temperature #1" },
> +	{ 0x450, 0x454, 0x458, 0x0, 0x0, 500, "FPGA E-TILE Temperature #2" },
> +	{ 0x45c, 0x460, 0x464, 0x0, 0x0, 500, "FPGA E-TILE Temperature #3" },
> +	{ 0x468, 0x46c, 0x470, 0x0, 0x0, 500, "FPGA E-TILE Temperature #4" },
> +	{ 0x474, 0x478, 0x47c, 0x0, 0x0, 500, "FPGA P-TILE Temperature" },
> +	{ 0x484, 0x488, 0x48c, 0x0, 0x0, 500, "FPGA FABRIC Digital Temperature #1" },
> +	{ 0x490, 0x494, 0x498, 0x0, 0x0, 500, "FPGA FABRIC Digital Temperature #2" },
> +	{ 0x49c, 0x4a0, 0x4a4, 0x0, 0x0, 500, "FPGA FABRIC Digital Temperature #3" },
> +	{ 0x4a8, 0x4ac, 0x4b0, 0x0, 0x0, 500, "FPGA FABRIC Digital Temperature #4" },
> +	{ 0x4b4, 0x4b8, 0x4bc, 0x0, 0x0, 500, "FPGA FABRIC Digital Temperature #5" },
> +	{ 0x4c0, 0x4c4, 0x4c8, 0x0, 0x0, 500, "FPGA FABRIC Remote Digital Temperature #1" },
> +	{ 0x4cc, 0x4d0, 0x4d4, 0x0, 0x0, 500, "FPGA FABRIC Remote Digital Temperature #2" },
> +	{ 0x4d8, 0x4dc, 0x4e0, 0x0, 0x0, 500, "FPGA FABRIC Remote Digital Temperature #3" },
> +	{ 0x4e4, 0x4e8, 0x4ec, 0x0, 0x0, 500, "FPGA FABRIC Remote Digital Temperature #4" },
> +	{ 0x4f0, 0x4f4, 0x4f8, 0x52c, 0x0, 500, "Board Top Near FPGA Temperature" },
> +	{ 0x4fc, 0x500, 0x504, 0x52c, 0x0, 500, "Board Bottom Near CVL Temperature" },
> +	{ 0x508, 0x50c, 0x510, 0x52c, 0x0, 500, "Board Top East Near VRs Temperature" },
> +	{ 0x514, 0x518, 0x51c, 0x52c, 0x0, 500, "Columbiaville Die Temperature" },
> +	{ 0x520, 0x524, 0x528, 0x52c, 0x0, 500, "Board Rear Side Temperature" },
> +	{ 0x530, 0x534, 0x538, 0x52c, 0x0, 500, "Board Front Side Temperature" },
> +	{ 0x53c, 0x540, 0x544, 0x0, 0x0, 500, "QSFP1 Case Temperature" },
> +	{ 0x548, 0x54c, 0x550, 0x0, 0x0, 500, "QSFP2 Case Temperature" },
> +	{ 0x554, 0x0, 0x0, 0x0, 0x0, 500, "FPGA Core Voltage Phase 0 VR Temperature" },
> +	{ 0x560, 0x0, 0x0, 0x0, 0x0, 500, "FPGA Core Voltage Phase 1 VR Temperature" },
> +	{ 0x56c, 0x0, 0x0, 0x0, 0x0, 500, "FPGA Core Voltage Phase 2 VR Temperature" },
> +	{ 0x578, 0x0, 0x0, 0x0, 0x0, 500, "FPGA Core Voltage VR Controller Temperature" },
> +	{ 0x584, 0x0, 0x0, 0x0, 0x0, 500, "FPGA VCCH VR Temperature" },
> +	{ 0x590, 0x0, 0x0, 0x0, 0x0, 500, "FPGA VCC_1V2 VR Temperature" },
> +	{ 0x59c, 0x0, 0x0, 0x0, 0x0, 500, "FPGA VCCH, VCC_1V2 VR Controller Temperature" },
> +	{ 0x5a8, 0x0, 0x0, 0x0, 0x0, 500, "3V3 VR Temperature" },
> +	{ 0x5b4, 0x0, 0x0, 0x0, 0x0, 500, "CVL Core Voltage VR Temperature" },
> +	{ 0x5c4, 0x5c8, 0x5cc, 0x5c0, 0x0, 500, "FPGA P-Tile Temperature [Remote]" },
> +	{ 0x5d0, 0x5d4, 0x5d8, 0x5c0, 0x0, 500, "FPGA E-Tile Temperature [Remote]" },
> +	{ 0x5dc, 0x5e0, 0x5e4, 0x5c0, 0x0, 500, "FPGA SDM Temperature [Remote]" },
> +	{ 0x5e8, 0x5ec, 0x5f0, 0x5c0, 0x0, 500, "FPGA Corner Temperature [Remote]" },
> +};
> +
> +static const struct m10bmc_sdata n6000bmc_in_tbl[] = {
> +	{ 0x5f4, 0x0, 0x0, 0x0, 0x0, 1, "Inlet 12V PCIe Rail Voltage" },
> +	{ 0x60c, 0x0, 0x0, 0x0, 0x0, 1, "Inlet 12V Aux Rail Voltage" },
> +	{ 0x624, 0x0, 0x0, 0x0, 0x0, 1, "Inlet 3V3 PCIe Rail Voltage" },
> +	{ 0x63c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA Core Voltage Rail Voltage" },
> +	{ 0x644, 0x0, 0x0, 0x0, 0x0, 1, "FPGA VCCH Rail Voltage" },
> +	{ 0x64c, 0x0, 0x0, 0x0, 0x0, 1, "FPGA VCC_1V2 Rail Voltage" },
> +	{ 0x654, 0x0, 0x0, 0x0, 0x0, 1, "FPGA VCCH_GXER_1V1, VCCA_1V8 Voltage" },
> +	{ 0x664, 0x0, 0x0, 0x0, 0x0, 1, "FPGA VCCIO_1V2 Voltage" },
> +	{ 0x674, 0x0, 0x0, 0x0, 0x0, 1, "CVL Non Core Rails Inlet Voltage" },
> +	{ 0x684, 0x0, 0x0, 0x0, 0x0, 1, "MAX10 & Board CLK PWR 3V3 Inlet Voltage" },
> +	{ 0x694, 0x0, 0x0, 0x0, 0x0, 1, "CVL Core Voltage Rail Voltage" },
> +	{ 0x6ac, 0x0, 0x0, 0x0, 0x0, 1, "Board 3V3 VR Voltage" },
> +	{ 0x6b4, 0x0, 0x0, 0x0, 0x0, 1, "QSFP 3V3 Rail Voltage" },
> +	{ 0x6c4, 0x0, 0x0, 0x0, 0x0, 1, "QSFP (Primary) Supply Rail Voltage" },
> +	{ 0x6c8, 0x0, 0x0, 0x0, 0x0, 1, "QSFP (Secondary) Supply Rail Voltage" },
> +	{ 0x6cc, 0x0, 0x0, 0x0, 0x0, 1, "VCCCLK_GXER_2V5 Voltage" },
> +	{ 0x6d0, 0x0, 0x0, 0x0, 0x0, 1, "AVDDH_1V1_CVL Voltage" },
> +	{ 0x6d4, 0x0, 0x0, 0x0, 0x0, 1, "VDDH_1V8_CVL Voltage" },
> +	{ 0x6d8, 0x0, 0x0, 0x0, 0x0, 1, "VCCA_PLL Voltage" },
> +	{ 0x6e0, 0x0, 0x0, 0x0, 0x0, 1, "VCCRT_GXER_0V9 Voltage" },
> +	{ 0x6e8, 0x0, 0x0, 0x0, 0x0, 1, "VCCRT_GXPL_0V9 Voltage" },
> +	{ 0x6f0, 0x0, 0x0, 0x0, 0x0, 1, "VCCH_GXPL_1V8 Voltage" },
> +	{ 0x6f4, 0x0, 0x0, 0x0, 0x0, 1, "VCCPT_1V8 Voltage" },
> +	{ 0x6fc, 0x0, 0x0, 0x0, 0x0, 1, "VCC_3V3_M10 Voltage" },
> +	{ 0x700, 0x0, 0x0, 0x0, 0x0, 1, "VCC_1V8_M10 Voltage" },
> +	{ 0x704, 0x0, 0x0, 0x0, 0x0, 1, "VCC_1V2_EMIF1_2_3 Voltage" },
> +	{ 0x70c, 0x0, 0x0, 0x0, 0x0, 1, "VCC_1V2_EMIF4_5 Voltage" },
> +	{ 0x714, 0x0, 0x0, 0x0, 0x0, 1, "VCCA_1V8 Voltage" },
> +	{ 0x718, 0x0, 0x0, 0x0, 0x0, 1, "VCCH_GXER_1V1 Voltage" },
> +	{ 0x71c, 0x0, 0x0, 0x0, 0x0, 1, "AVDD_ETH_0V9_CVL Voltage" },
> +	{ 0x720, 0x0, 0x0, 0x0, 0x0, 1, "AVDD_PCIE_0V9_CVL Voltage" },
> +};
> +
> +static const struct m10bmc_sdata n6000bmc_curr_tbl[] = {
> +	{ 0x600, 0x604, 0x608, 0x0, 0x0, 1, "Inlet 12V PCIe Rail Current" },
> +	{ 0x618, 0x61c, 0x620, 0x0, 0x0, 1, "Inlet 12V Aux Rail Current" },
> +	{ 0x630, 0x634, 0x638, 0x0, 0x0, 1, "Inlet 3V3 PCIe Rail Current" },
> +	{ 0x640, 0x0, 0x0, 0x0, 0x0, 1, "FPGA Core Voltage Rail Current" },
> +	{ 0x648, 0x0, 0x0, 0x0, 0x0, 1, "FPGA VCCH Rail Current" },
> +	{ 0x650, 0x0, 0x0, 0x0, 0x0, 1, "FPGA VCC_1V2 Rail Current" },
> +	{ 0x658, 0x65c, 0x660, 0x0, 0x0, 1, "FPGA VCCH_GXER_1V1, VCCA_1V8 Current" },
> +	{ 0x668, 0x66c, 0x670, 0x0, 0x0, 1, "FPGA VCCIO_1V2 Current" },
> +	{ 0x678, 0x67c, 0x680, 0x0, 0x0, 1, "CVL Non Core Rails Inlet Current" },
> +	{ 0x688, 0x68c, 0x690, 0x0, 0x0, 1, "MAX10 & Board CLK PWR 3V3 Inlet Current" },
> +	{ 0x698, 0x0, 0x0, 0x0, 0x0, 1, "CVL Core Voltage Rail Current" },
> +	{ 0x6b0, 0x0, 0x0, 0x0, 0x0, 1, "Board 3V3 VR Current" },
> +	{ 0x6b8, 0x6bc, 0x6c0, 0x0, 0x0, 1, "QSFP 3V3 Rail Current" },
> +};
> +
> +static const struct m10bmc_sdata n6000bmc_power_tbl[] = {
> +	{ 0x724, 0x0, 0x0, 0x0, 0x0, 1, "Board Power" },
> +};
> +
> +static const struct hwmon_channel_info *n6000bmc_hinfo[] = {
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
> +			   HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL,
> +			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MAX_HYST |
> +			   HWMON_T_CRIT | HWMON_T_CRIT_HYST | HWMON_T_LABEL),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL,
> +			   HWMON_I_INPUT | HWMON_I_LABEL),
> +	HWMON_CHANNEL_INFO(curr,
> +			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
> +			   HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
> +			   HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
> +			   HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
> +			   HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
> +			   HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
> +			   HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
> +			   HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_LABEL,
> +			   HWMON_C_INPUT | HWMON_C_MAX | HWMON_C_CRIT |
> +			   HWMON_C_LABEL),
> +	HWMON_CHANNEL_INFO(power,
> +			   HWMON_P_INPUT | HWMON_P_LABEL),
> +	NULL
> +};
> +
> +static const struct m10bmc_hwmon_board_data n6000bmc_hwmon_bdata = {
> +	.tables = {
> +		[hwmon_temp] = n6000bmc_temp_tbl,
> +		[hwmon_in] = n6000bmc_in_tbl,
> +		[hwmon_curr] = n6000bmc_curr_tbl,
> +		[hwmon_power] = n6000bmc_power_tbl,
> +	},
> +
> +	.hinfo = n6000bmc_hinfo,
> +};
> +
>  static umode_t
>  m10bmc_hwmon_is_visible(const void *data, enum hwmon_sensor_types type,
>  			u32 attr, int channel)
> @@ -549,6 +774,10 @@ static const struct platform_device_id intel_m10bmc_hwmon_ids[] = {
>  		.name = "n5010bmc-hwmon",
>  		.driver_data = (unsigned long)&n5010bmc_hwmon_bdata,
>  	},
> +	{
> +		.name = "n6000bmc-hwmon",
> +		.driver_data = (unsigned long)&n6000bmc_hwmon_bdata,
> +	},
>  	{ }
>  };
>  
