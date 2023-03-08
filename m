Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E6F6B0203
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjCHItp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCHItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:49:36 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347038F70D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:49:35 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3287CcoO005954;
        Wed, 8 Mar 2023 09:49:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=qgGpQ9Kjue7TAs6lkRuEr3B555C9ET7Rts4Y1KA4t9w=;
 b=2nV4R7MWBT6rFWkORYjAdnxjwpAT6202ep3zq0l6rTOhJzqWH20Aabc/izBwzY8l0DJh
 MfjeSacexw9u9sI4l6Tnfv2ozCtaswvhxuirijiKmxn9X2wXkOmyp5zJA9++Y7OrHmGe
 oLSAmi7IBqLa6bXVHxzh8AiOGK/r+8iwzTZg3X6dgn6Y0RjgF9v+yhzbpvqAFIngi1Wj
 cxElKrLLf4Mb4uurnAunV6PKi5uh+Gq1kj1HeyLs/1BrrM+HUtcJx7h/bHQD0yjhdulA
 Qad5aNOqmuOxbmCbRiQ679di7phcxtzAVcgJadiSYXQ5582y8myMfSaxsoqqbp9m7gs0 XQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3p6ffcajdb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Mar 2023 09:49:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0AD3110002A;
        Wed,  8 Mar 2023 09:49:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 04BDF210F82;
        Wed,  8 Mar 2023 09:49:21 +0100 (CET)
Received: from [10.201.21.26] (10.201.21.26) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 8 Mar
 2023 09:49:20 +0100
Message-ID: <2ef16f3f-4293-b804-e31d-352a2c394df8@foss.st.com>
Date:   Wed, 8 Mar 2023 09:49:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] reset: sti: rely on regmap_field_read_poll_timeout for
 ack wait
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230210224332.98482-1-avolmat@me.com>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20230210224332.98482-1-avolmat@me.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.26]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-08_04,2023-03-08_01,2023-02-09_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alain

On 2/10/23 23:43, Alain Volmat wrote:
> Use regmap_field_read_poll_timeout function when waiting for the
> ack bit upon performing the reset control.
> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
>  drivers/reset/sti/reset-syscfg.c | 18 ++++--------------
>  1 file changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/reset/sti/reset-syscfg.c b/drivers/reset/sti/reset-syscfg.c
> index b4b46e0f207e..c1ba04f6f155 100644
> --- a/drivers/reset/sti/reset-syscfg.c
> +++ b/drivers/reset/sti/reset-syscfg.c
> @@ -64,22 +64,12 @@ static int syscfg_reset_program_hw(struct reset_controller_dev *rcdev,
>  		return err;
>  
>  	if (ch->ack) {
> -		unsigned long timeout = jiffies + msecs_to_jiffies(1000);
>  		u32 ack_val;
>  
> -		while (true) {
> -			err = regmap_field_read(ch->ack, &ack_val);
> -			if (err)
> -				return err;
> -
> -			if (ack_val == ctrl_val)
> -				break;
> -
> -			if (time_after(jiffies, timeout))
> -				return -ETIME;
> -
> -			cpu_relax();
> -		}
> +		err = regmap_field_read_poll_timeout(ch->ack, ack_val, (ack_val == ctrl_val),
> +						     100, USEC_PER_SEC);
> +		if (err)
> +			return err;
>  	}
>  
>  	return 0;

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
Thanks
Patrice
