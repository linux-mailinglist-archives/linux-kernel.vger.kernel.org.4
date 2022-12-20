Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A196E6520FB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 13:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbiLTMvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 07:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiLTMvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 07:51:10 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107E8116C;
        Tue, 20 Dec 2022 04:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1671540668; x=1703076668;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Q0XwAdbmeIP2AoA5Iod6wcH+s5Pr+KDTVxXq0tU1rYA=;
  b=DoGykKbZ2TfvooxrCYC9RREiOH43NFWwY4DnVQ3Ep47m7AhW9CsHaPiO
   30vlTRYv6bgB2dp00dvquG6dqWbRy5Ad8zk2zEyfNZaBNL35Q4YJ8WMAL
   iFVfwvohHD9EMpaeMkVqKtvUYOFeo5MCl71VM+zxQJIsBj7QA3DfGIyk7
   8=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Dec 2022 04:51:05 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.45.79.139])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 04:51:04 -0800
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Tue, 20 Dec
 2022 04:50:58 -0800
Message-ID: <0d683526-5707-d5b4-e96d-b2d982d4b5da@quicinc.com>
Date:   Tue, 20 Dec 2022 18:20:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3 1/2] remoteproc: elf_loader: Update resource table name
 check
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        <linux-remoteproc@vger.kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@quicinc.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <quic_rohkumar@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, <devicetree@vger.kernel.org>,
        <krzysztof.kozlowski@linaro.org>, <mathieu.poirier@linaro.org>,
        <corbet@lwn.net>
References: <1671523269-21154-1-git-send-email-quic_srivasam@quicinc.com>
 <1671523269-21154-2-git-send-email-quic_srivasam@quicinc.com>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1671523269-21154-2-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/20/2022 1:31 PM, Srinivasa Rao Mandadapu wrote:
> Update the way of checking resource table name with prefix
> substring search instead of complete string search.
> In general Qualcomm DSP binary is prepared by combining different ELFs',
> hence section header name (e.g. .resource_table), appended with ELF name
> to differentiate with same section(e.g. resource_table.ac_bin_process) of
> different ELFs'.
> Example readelf output of DSP binary:
>      [60] .start.ac_bin_process PROGBITS
>      [61] .resource_table.ac_bin_process PROGBITS
>      [62] .comment.ac_bin_process PROGBITS
> 

Could we rephrase above like below ? It could be also taken why applying 
the patch.

Update the way of checking resource table name with prefix substring 
search instead of complete string search.

In general, Qualcomm DSP binary is prepared by combining different 
ELF's. Hence, section header name (e.g. .resource_table), appended
with ELF name to differentiate with same section(e.g. 
resource_table.ac_bin_process) of different ELFs'.

Example readelf output of DSP binary:
       [60] .start.ac_bin_process PROGBITS
       [61] .resource_table.ac_bin_process PROGBITS
       [62] .comment.ac_bin_process PROGBITS


Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

Otherwise, LGTM.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh
> ---
>   drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
> index 5a412d7..77330d6 100644
> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> @@ -272,7 +272,7 @@ find_table(struct device *dev, const struct firmware *fw)
>   		u64 offset = elf_shdr_get_sh_offset(class, shdr);
>   		u32 name = elf_shdr_get_sh_name(class, shdr);
>   
> -		if (strcmp(name_table + name, ".resource_table"))
> +		if (!strstarts(name_table + name, ".resource_table"))
>   			continue;
>   
>   		table = (struct resource_table *)(elf_data + offset);
