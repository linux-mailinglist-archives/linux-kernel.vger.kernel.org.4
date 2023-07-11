Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27FBE74EF38
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjGKMow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGKMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:44:51 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E28135;
        Tue, 11 Jul 2023 05:44:46 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36BAsA9c018387;
        Tue, 11 Jul 2023 14:44:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=KAQ5mo9Y9ZW1sEmuX5Y0KnUO9RyWdVSJDo4cz7iaBa8=;
 b=vvBfCkcn60PsfTF26q+SqjWgHs5zrl7Fy2PR6OhmmyjlGIO8jWB7sGBwVy4aaizYI+8y
 lmsqdDtNhc/g0A5Ex9cHVH8FugSYIHpGQ5ZLD2ZKyLT44syd/qTcvLFvH610UgFdbmyK
 1AE/v21SCa4BABpJpET45QpfP+XvBLugFoafh6lMNhPbWoie6E3CltxG9jLQON7LCvA/
 SmNsgEsYwYll5slPkWhlqW5zm4c81sg1MTPj00KG70Zcdy3P7l8OxMp6WMzcWPLkB73n
 vVHxceVtVqcQv/r96Rr5wtCkT2EAlJ8sZMQD1hlpcz1vMaIEN5S5bSjuNQhtmxUukne9 zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rs311t8a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 14:44:41 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BA798100053;
        Tue, 11 Jul 2023 14:44:40 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3CE832248C6;
        Tue, 11 Jul 2023 14:44:40 +0200 (CEST)
Received: from [10.129.166.114] (10.129.166.114) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 11 Jul
 2023 14:44:40 +0200
Message-ID: <a17d8f1b-31bb-bc49-6fa3-42c55509f7b9@foss.st.com>
Date:   Tue, 11 Jul 2023 14:44:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] media: i2c: st_mipid02: cascade s_stream call to the
 source subdev
To:     Alain Volmat <alain.volmat@foss.st.com>,
        Sylvain Petinot <sylvain.petinot@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
CC:     <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230711123211.794838-1-alain.volmat@foss.st.com>
 <20230711123211.794838-2-alain.volmat@foss.st.com>
Content-Language: en-US
From:   Benjamin Mugnier <benjamin.mugnier@foss.st.com>
In-Reply-To: <20230711123211.794838-2-alain.volmat@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.129.166.114]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_06,2023-07-11_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain,

Thank you for your patch. LGTM.

Reviewed-By: Benjamin Mugnier <benjamin.mugnier@foss.st.com>

On 7/11/23 14:32, Alain Volmat wrote:
> Cascade the s_stream call to the source subdev whenever the bridge
> streaming is enable / disabled.
> 
> Signed-off-by: Alain Volmat <alain.volmat@foss.st.com>
> ---
>  drivers/media/i2c/st-mipid02.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/media/i2c/st-mipid02.c b/drivers/media/i2c/st-mipid02.c
> index 906553a28676..703d2f06f552 100644
> --- a/drivers/media/i2c/st-mipid02.c
> +++ b/drivers/media/i2c/st-mipid02.c
> @@ -547,6 +547,13 @@ static int mipid02_stream_disable(struct mipid02_dev *bridge)
>  	struct i2c_client *client = bridge->i2c_client;
>  	int ret;
>  
> +	if (!bridge->s_subdev)
> +		goto error;
> +
> +	ret = v4l2_subdev_call(bridge->s_subdev, video, s_stream, 0);
> +	if (ret)
> +		goto error;
> +
>  	/* Disable all lanes */
>  	ret = mipid02_write_reg(bridge, MIPID02_CLK_LANE_REG1, 0);
>  	if (ret)
> @@ -633,6 +640,10 @@ static int mipid02_stream_enable(struct mipid02_dev *bridge)
>  	if (ret)
>  		goto error;
>  
> +	ret = v4l2_subdev_call(bridge->s_subdev, video, s_stream, 1);
> +	if (ret)
> +		goto error;
> +
>  	return 0;
>  
>  error:

-- 
Regards,

Benjamin
