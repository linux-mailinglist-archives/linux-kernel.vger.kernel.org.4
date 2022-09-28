Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5F5ED55A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 08:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiI1GtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 02:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiI1GsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 02:48:00 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E022CE21;
        Tue, 27 Sep 2022 23:46:24 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28S16lQ6005109;
        Wed, 28 Sep 2022 08:45:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=x2KOSmp7c+h6kDDP0gJFixqvBxl8YXw+GY/uBoC7bq0=;
 b=knKiSwyL5i1WME9cxxEqxBm8SVz+IwsaVqvFtzoMkd3F9DmxnonTvYt8FpyDwQwqXdPr
 ZZZeFXSxnv9WpYP1O9j9/7z3EhI7U2oWhs4yqyG3wFBfdl/5ry8v6KWZSgXYSQtIssyu
 eoQ6++JDWI9kqEph2V5+b8R4g1oON8UYv0phOQKbs8xH9EBu96p257UMwRFOzIhwQ3td
 5ON6GpoZZqWKb/so1JMnJIKcefC6gPFI5boLh6nKpM1v4CO0t4u/v47ibv0zwqmbTd8p
 L+xZIPFMTOK6ybT3MQyzEEKIA8PNTHacu5uI+UoY1/Rfpx0e4fHOGhfjFp9ciaSc/z4U ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3jsrsjpyk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 08:45:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6DA1F10002A;
        Wed, 28 Sep 2022 08:45:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5A25E211F23;
        Wed, 28 Sep 2022 08:45:55 +0200 (CEST)
Received: from [10.201.21.72] (10.75.127.120) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Wed, 28 Sep
 2022 08:45:54 +0200
Message-ID: <552281f4-dc8c-7cd7-32af-fa48de5aa414@foss.st.com>
Date:   Wed, 28 Sep 2022 08:45:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] usb: dwc3: st: Fix node's child name
Content-Language: en-US
To:     Felipe Balbi <felipe@balbi.sh>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jerome Audu <jerome.audu@st.com>
References: <20220926124359.304770-1-patrice.chotard@foss.st.com>
 <87o7v0g860.fsf@balbi.sh>
From:   Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <87o7v0g860.fsf@balbi.sh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.120]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-28_02,2022-09-27_01,2022-06-22_01
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe, Krzysztof

On 9/27/22 17:15, Felipe Balbi wrote:
> 
> <patrice.chotard@foss.st.com> writes:
> 
>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> Update node's child name from "dwc3" to "usb", this fixes
>> the following issue:
>>
>> [3.773852] usb-st-dwc3 8f94000.dwc3: failed to find dwc3 core node
>>
>> Fixes: 3120910a099b ("ARM: dts: stih407-family: Harmonize DWC USB3 DT nodes name")
>>
>> Reported-by: Jerome Audu <jerome.audu@st.com>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>  drivers/usb/dwc3/dwc3-st.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-st.c b/drivers/usb/dwc3/dwc3-st.c
>> index 166b5bde45cb..6c14a79279f9 100644
>> --- a/drivers/usb/dwc3/dwc3-st.c
>> +++ b/drivers/usb/dwc3/dwc3-st.c
>> @@ -251,7 +251,7 @@ static int st_dwc3_probe(struct platform_device *pdev)
>>  	/* Manage SoftReset */
>>  	reset_control_deassert(dwc3_data->rstc_rst);
>>  
>> -	child = of_get_child_by_name(node, "dwc3");
>> +	child = of_get_child_by_name(node, "usb");
> 
> there could be DTBs in the wild which have `dwc3' as the child name. It
> seems to me that you should try both names, instead.
> 

As this patch is already merged, i will submit an additional patch which will 
rely on child's compatible string instead of child's node name, as done in other
dwc3 driver.

Thanks
Patrice
