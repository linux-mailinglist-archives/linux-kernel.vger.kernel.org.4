Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC056A6BB8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjCALcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:32:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjCALcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:32:03 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69413B663;
        Wed,  1 Mar 2023 03:32:01 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32190x7X010228;
        Wed, 1 Mar 2023 12:31:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=kvaNAaGstfcGr1zESkccFFSvJijgyDAnYx+N91CVutE=;
 b=6MxgI9rBdFCJwO3lOucTGgRIb9hREKDBtSOO2VfJ0W+cCbPJV0LbmYIhphb7q+679p0s
 KxkokDuwIGhiYmU2vdJ54jKlZEV+a/1FAOJo09Wd2ctJjDx3wnA+K2TB3LUzRrK9vqXF
 b4fa/UVVHtRfgh+vxQJ4X0uPzBjJpNzzF5KcpTuCOlG2DIe4pjzhDLbSAWFA6mX719Zs
 XI6+3VQutcWZW0BPdABC+TwC2b+kowOirTGptZHwFQzeplLYd3OocbhHP/EHGYzztWrJ
 APdtQR3tYX8NvBDAnoJ9sJFp0+EeIjJlJhZj41WncmTE9J36QJYNwj7V7BFveFONS6JQ wg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ny8mr91a3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 12:31:52 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4C08A10002A;
        Wed,  1 Mar 2023 12:31:51 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 027D521A205;
        Wed,  1 Mar 2023 12:31:51 +0100 (CET)
Received: from [10.252.18.210] (10.252.18.210) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Wed, 1 Mar
 2023 12:31:48 +0100
Message-ID: <2b56f248-15b7-e7a5-bf90-6ba90ba78740@foss.st.com>
Date:   Wed, 1 Mar 2023 12:31:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if
 role-switch-default-mode="host"
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Ziyang Huang <hzyitc@outlook.com>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <SG2PR01MB204837BF68EDB0E343D2A375C9A59@SG2PR01MB2048.apcprd01.prod.exchangelabs.com>
 <BYAPR12MB33996D70422B24DE982F3B4AA7AA9@BYAPR12MB3399.namprd12.prod.outlook.com>
 <0ffed85a-6bc9-b51e-c431-a23b9bf3919c@foss.st.com>
Content-Language: en-US
From:   Amelie Delaunay <amelie.delaunay@foss.st.com>
In-Reply-To: <0ffed85a-6bc9-b51e-c431-a23b9bf3919c@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.18.210]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_08,2023-03-01_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/23 12:26, Fabrice Gasnier wrote:
> On 2/22/23 08:00, Minas Harutyunyan wrote:
>> Hi Amelie,
>>
>> Could you please review and test this patch on your setup.
>> Doesn't broke anything.
>>
> 
> Hi Minas,
> 
> I tested at my end on behalf of Amelie.
> Of course I let her possibly comment.
> 
> This doesn't break anything on existing boards. I also tested the
> example described by Ziyang in the commit message.
> 
> You can add my:
> Tested-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> 

Thanks Fabrice for testing!

You can also add my:
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

Regards,
Amelie

> Thanks & BR,
> Fabrice
> 
>> Thanks,
>> Minas
>>
>> On 2/21/2023 2:30 PM, Ziyang Huang <hzyitc@outlook.com> wrote:
>>> From: Ziyang Huang <hzyitc@outlook.com>
>>> Sent: Tuesday, February 21, 2023 2:30 PM
>>> To: Minas Harutyunyan <hminas@synopsys.com>
>>> Cc: gregkh@linuxfoundation.org; fabrice.gasnier@foss.st.com;
>>> amelie.delaunay@foss.st.com; linux-usb@vger.kernel.org; linux-
>>> kernel@vger.kernel.org; Ziyang Huang <hzyitc@outlook.com>
>>> Subject: [PATCH v2] usb: dwc2: drd: fix inconsistent mode if role-switch-
>>> default-mode="host"
>>>
>>> Some boards might use USB-A female connector for USB ports, however, the
>>> port could be connected to a dual-mode USB controller, making it also
>>> behaves as a peripheral device if male-to-male cable is connected.
>>>
>>> In this case, the dts looks like this:
>>>
>>> 	&usb0 {
>>> 		status = "okay";
>>> 		dr_mode = "otg";
>>> 		usb-role-switch;
>>> 		role-switch-default-mode = "host";
>>> 	};
>>>
>>> After boot, dwc2_ovr_init() sets GOTGCTL to GOTGCTL_AVALOVAL and call
>>> dwc2_force_mode() with parameter host=false, which causes inconsistent mode
>>> - The hardware is in peripheral mode while the kernel status is in host
>>> mode.
>>>
>>> What we can do now is to call dwc2_drd_role_sw_set() to switch to device
>>> mode, and everything should work just fine now, even switching back to
>>> none(default) mode afterwards.
>>>
>>> Fixes: e14acb876985 ("usb: dwc2: drd: add role-switch-default-node support")
>>> Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
>>> ---
>>> Changes since v1
>>> - Use corrent name in Signed-off-by
>>>
>>> drivers/usb/dwc2/drd.c | 3 ++-
>>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/usb/dwc2/drd.c b/drivers/usb/dwc2/drd.c index
>>> d8d6493bc457..a8605b02115b 100644
>>> --- a/drivers/usb/dwc2/drd.c
>>> +++ b/drivers/usb/dwc2/drd.c
>>> @@ -35,7 +35,8 @@ static void dwc2_ovr_init(struct dwc2_hsotg *hsotg)
>>>
>>> 	spin_unlock_irqrestore(&hsotg->lock, flags);
>>>
>>> -	dwc2_force_mode(hsotg, (hsotg->dr_mode == USB_DR_MODE_HOST));
>>> +	dwc2_force_mode(hsotg, (hsotg->dr_mode == USB_DR_MODE_HOST) ||
>>> +				(hsotg->role_sw_default_mode == USB_DR_MODE_HOST));
>>> }
>>>
>>> static int dwc2_ovr_avalid(struct dwc2_hsotg *hsotg, bool valid)
>>> --
>>> 2.34.1
>>
