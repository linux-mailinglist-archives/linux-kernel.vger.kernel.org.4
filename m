Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12E0609B22
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbiJXHRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbiJXHRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:17:32 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC0C52DD2;
        Mon, 24 Oct 2022 00:17:23 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29NLeKsd010847;
        Mon, 24 Oct 2022 09:16:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=RGsQrACxVaiQ/PqYuY2b2GnpiqpCXdRkFoPEvUnvhcw=;
 b=zB9GoWQcvHm20Je2/l5foUJXJkxACJFDuypPhjL11OVGyW36PsI+qBMY57EHuEnJjIzq
 qo4fW5FYlaVE4mGXjqny+4CM2bcBRfjx07DwSvKNCuZIOm5OUPoiAU5UyS4yIdNx3U5w
 FijVzsUL+QZJw2/JzruM4+h447bLSRzkywiMQPIhG/EGwf1HkVfyIRUc4nSHHxvY9bXg
 v07HlHbvGfkAANoBBm2WLms9trQx56j52JOXtAwC3V0HBE8g9hvsP72+2RXV/fnxB1Sv
 QZez3mD2Hj4f97EYdYOc3M69F+NHYNIkazy9Wn+Gn9JKNeBAerFpDthaapYcWyCAfprU Ew== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kc7dk1cb5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 09:16:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E7121100039;
        Mon, 24 Oct 2022 09:16:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A89102132E7;
        Mon, 24 Oct 2022 09:16:48 +0200 (CEST)
Received: from [10.201.21.72] (10.201.21.72) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 09:16:48 +0200
Message-ID: <ff2c969d-532e-8f18-041d-14c34e88eee9@foss.st.com>
Date:   Mon, 24 Oct 2022 09:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] usb: dwc3: st: Rely on child's compatible instead of
 name
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jerome Audu <jerome.audu@st.com>,
        Felipe Balbi <felipe@balbi.sh>
References: <20220930142018.890535-1-patrice.chotard@foss.st.com>
 <Y1PFaOEbPVDN7313@kroah.com>
Content-Language: en-US
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <Y1PFaOEbPVDN7313@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.72]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_01,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/22/22 12:26, Greg Kroah-Hartman wrote:
> On Fri, Sep 30, 2022 at 04:20:18PM +0200, patrice.chotard@foss.st.com wrote:
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> To ensure that child node is found, don't rely on child's node name
>> which can take different value, but on child's compatible name.
>>
>> Fixes: f5c5936d6b4d ("usb: dwc3: st: Fix node's child name")
>> Cc: Jerome Audu <jerome.audu@st.com>
>> Reported-by: Felipe Balbi <felipe@balbi.sh>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>> v3: - rebase on correct branch
>> v2: - add missing reported-by
>>     - add Fixes
>> ---
>>  drivers/usb/dwc3/dwc3-st.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
>> index 6c14a79279f9..fea5290de83f 100644
>> --- a/drivers/usb/dwc3/dwc3-st.c
>> +++ b/drivers/usb/dwc3/dwc3-st.c
>> @@ -251,7 +251,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
>>  	/* Manage SoftReset */
>>  	reset_control_deassert(dwc3_data->rstc_rst);
>>  
>> -	child = of_get_child_by_name(node, "usb");
>> +	child = of_get_compatible_child(node, "snps,dwc3");
>>  	if (!child) {
>>  		dev_err(&pdev->dev, "failed to find dwc3 core node\n");
>>  		ret = -ENODEV;
>> -- 
>> 2.25.1
>>
> 
> Is this still needed for 6.1-final?

Yes, still needed for v6.1.

Thanks
Patrice

> 
> thanks,
> 
> greg k-h
