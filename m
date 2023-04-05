Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE50E6D839E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbjDEQ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjDEQ0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:26:10 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D9BE4B;
        Wed,  5 Apr 2023 09:26:07 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 335EXiX3023638;
        Wed, 5 Apr 2023 16:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=QNwGQCcewi+A9hhC1YukXd0m9GvUUdeS8CRiiYHOuII=;
 b=shk6KC+/XkX9q6H5Qv0hlbifg5Q3cZBp1Ys+DdeJ76bCvwSEcC1GrIHYUNhvH4dEcbri
 W6DFRot4JvSfJjttAoFI3Tc1uG3OhsaUkP6GcAaS0AT8YoPM1Qp5YBy8IPqy6V4UfXXD
 HfDKVKPvnbyo7cMNzqZPzfXcdNaL0P1h/NouDmXEmTm/DTRio0+wHYY10rE0J0VrajnV
 TOOJFmfSE82DSdpTwGb6jHB0felyTn5sW27bqCfi7tcDKjO8iEskshu1grDlTfkOgL6U
 bkfLahApD3fWBq17MpZ6Eg3ASz/FQOqP7hGOPYQwibkFmrW8uytqje+mMpg2Q8Zg1Mq8 HQ== 
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ps75jhm8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 16:26:02 +0000
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 335ES8Vj009629;
        Wed, 5 Apr 2023 16:26:01 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([9.208.129.119])
        by ppma04wdc.us.ibm.com (PPS) with ESMTPS id 3ppc87y6gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 05 Apr 2023 16:26:01 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 335GQ0kM34472318
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 5 Apr 2023 16:26:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BA5E5805C;
        Wed,  5 Apr 2023 16:26:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CDA65805A;
        Wed,  5 Apr 2023 16:26:00 +0000 (GMT)
Received: from [9.160.127.161] (unknown [9.160.127.161])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  5 Apr 2023 16:25:59 +0000 (GMT)
Message-ID: <bc6564dc-3bfd-298b-43a8-b5a629f4631f@linux.ibm.com>
Date:   Wed, 5 Apr 2023 11:25:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] leds: Ensure hardware blinking turns off when requested
To:     pavel@ucw.cz
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220520171134.31415-1-eajames@linux.ibm.com>
Content-Language: en-US
From:   Eddie James <eajames@linux.ibm.com>
In-Reply-To: <20220520171134.31415-1-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kzLJbnNLsHHO4xFA8-ESx998SlxvHJbq
X-Proofpoint-ORIG-GUID: kzLJbnNLsHHO4xFA8-ESx998SlxvHJbq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-05_11,2023-04-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 adultscore=0 priorityscore=1501 clxscore=1011 malwarescore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0
 mlxlogscore=788 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304050146
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/20/22 12:11, Eddie James wrote:
> If an LED is blinking through the hardware and the trigger is deactivated,
> the driver will set the brightness to 0 to disable blinking. However, if
> the LED driver doesn't support non-blocking operations, the request for
> setting brightness to 0 will get queued. Then if a user requests a new
> non-zero brightness before the request for 0 brightness is executed, the
> LED blinking will not get disabled since the brightness will simply be
> updated.
> Fix this by flushing the workqueue before updating the requested
> brightness.


I just realized this never made it anywhere. Pavel, any thoughts?


Thanks,

Eddie


>
> Fixes: 4d71a4a12b13 ("leds: Add support for setting brightness in a synchronous way")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>   drivers/leds/led-class.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
> index 6a8ea94834fa..861a1cb5df5b 100644
> --- a/drivers/leds/led-class.c
> +++ b/drivers/leds/led-class.c
> @@ -55,6 +55,8 @@ static ssize_t brightness_store(struct device *dev,
>   
>   	if (state == LED_OFF)
>   		led_trigger_remove(led_cdev);
> +	/* flush out any request to disable blinking */
> +	flush_work(&led_cdev->set_brightness_work);
>   	led_set_brightness(led_cdev, state);
>   	flush_work(&led_cdev->set_brightness_work);
>   
