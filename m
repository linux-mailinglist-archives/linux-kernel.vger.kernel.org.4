Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861A9674918
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 02:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjATB4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 20:56:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjATB4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 20:56:21 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C7114A203;
        Thu, 19 Jan 2023 17:56:20 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30K1qXsS010072;
        Fri, 20 Jan 2023 01:56:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Uf9p3UpQ/W8ioiTKiv21qSXA80sKShiSGLbzcGVnSTw=;
 b=NsdYt4BB5zJmVFb0QSH9o4QgcKgxVhmfbFAhOZ4Epu/v1CKqMCZtxQRDmRlsBhNmPROv
 zsNY3dpBXUtPFYKalmaeGip2ptGqe81oIvnUeKDaOu0zh7vrPhEtePeh48zIvDaAssUA
 FJeJdXrPn8+yxuV3Rh1VFI2c7fw+mePV+iviBUd9lnGZfx5HRc6/OoGEiSTnVUz86L2j
 BRMpw378ESgFUvnmULqkLNgDyyDCNK4Z/EDD47J0pcb7ZGQQHAO/XUTOuId74VJdX9Cf
 B4D2BSxSrNPWNEKi5i8RGmwaEzLx4jIc6XnXr1S6/9mOhN1PGIYbH5aztVuLQmYUK9Pa 1w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n6yksjnt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 01:56:09 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30K1u8mU019952
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Jan 2023 01:56:08 GMT
Received: from [10.216.23.61] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 19 Jan
 2023 17:56:01 -0800
Message-ID: <8f32c2e5-2743-1017-6a33-4849021c5287@quicinc.com>
Date:   Fri, 20 Jan 2023 07:25:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [RFC v4 2/5] usb: dwc3: core: Refactor PHY logic to support
 Multiport Controller
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>
References: <20230115114146.12628-1-quic_kriskura@quicinc.com>
 <20230115114146.12628-3-quic_kriskura@quicinc.com>
 <20230119220942.ja5gbo3t3fl63gpy@halaney-x13s>
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230119220942.ja5gbo3t3fl63gpy@halaney-x13s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fvz2KVQP9MnYTqPrvVNa5aW0BeTIz-5L
X-Proofpoint-ORIG-GUID: fvz2KVQP9MnYTqPrvVNa5aW0BeTIz-5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_16,2023-01-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301200014
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2023 3:39 AM, Andrew Halaney wrote:
> On Sun, Jan 15, 2023 at 05:11:43PM +0530, Krishna Kurapati wrote:
>> Currently the DWC3 driver supports only single port controller
>> which requires at most one HS and one SS PHY.
>>
>> But the DWC3 USB controller can be connected to multiple ports and
>> each port can have their own PHYs. Each port of the multiport
>> controller can either be HS+SS capable or HS only capable
>> Proper quantification of them is required to modify GUSB2PHYCFG
>> and GUSB3PIPECTL registers appropriately.
>>
>> Add support for detecting, obtaining and configuring phy's supported
>> by a multiport controller and limit the max number of ports
>> supported to 4.
>>
>> Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
>> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
>> ---
>>   drivers/usb/dwc3/core.c | 304 +++++++++++++++++++++++++++++-----------
>>   drivers/usb/dwc3/core.h |  15 +-
>>   drivers/usb/dwc3/drd.c  |  14 +-
>>   3 files changed, 244 insertions(+), 89 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
>> index 476b63618511..7e0a9a598dfd 100644
>> --- a/drivers/usb/dwc3/core.c
>> +++ b/drivers/usb/dwc3/core.c
> 
> <snip>
> 
>> @@ -1575,6 +1690,21 @@ static void dwc3_get_properties(struct dwc3 *dwc)
>>   	dwc->dis_split_quirk = device_property_read_bool(dev,
>>   				"snps,dis-split-quirk");
>>   
>> +
>> +	/*
>> +	 * If no mulitport properties are defined, default
>> +	 * the port count to '1'.
>> +	 */
>> +	ret = device_property_read_u32(dev, "num-ports",
>> +				&dwc->num_ports);
>> +	if (ret)
>> +		dwc->num_ports = 1;
>> +
>> +	ret = device_property_read_u32(dev, "num-ss-ports",
>> +				&dwc->num_ss_ports);
>> +	if (ret)
>> +		dwc->num_ss_ports = 1;
> 
> By using this DT property instead of using the number of each phy type you
> find you can get into situations where you're writing DWC3_GUSB2PHYCFG, etc,
> when there's no phy to go along with it.
> 
Hi Andrew,

  Thanks for the review. Yes, this decoupling is still there and its 
fine I believe.

> I ran into this when testing on sa8540p-ride, which only uses one of the
> ports on the multiport controller. I didn't enable the other phys (not
> sure if that was smart or not) and overrode phy-names/phys, but did not
> override num-ports/num-ss-ports, which resulted in that. Nothing bad
> happened on a quick test.. but I thought I'd highlight that as another
> downside of decoupling this value from the number of phys you grab.
> 
If we do not override phy-names or num-ports/num-ss-ports info in DT, 
they are just defaulted to '1' and as per the current logic only port-1 
registers must be configured. Isn't that the case happening ?

> Here's a patch enabling sa8540p-ride, I'd love if you'd add it to the
> series (probably needs clean up after review, and will definitely need
> alteration after you update the dt-binding again). If not I'll continue
> to test/review so please CC me!:
> 
> 
Sure, I can add this patch (probably will add the other phy's too) 
during the final submission.

>  From dcb27d07f079194ebd7efe1c9bec64da78beb290 Mon Sep 17 00:00:00 2001
> From: Andrew Halaney <ahalaney@redhat.com>
> Date: Thu, 19 Jan 2023 14:53:38 -0600
> Subject: [PATCH] arm64: dts: qcom: sa8540p-ride: Enable usb_2
> Content-type: text/plain
> 
> There is now support for the multiport USB controller this uses
> so enable it.
> 
> The board only has a single port hooked up (despite it being wired up to
> the multiport IP on the SoC). There's also a USB 2.0 mux hooked up,
> which by default on boot is selected to mux properly. Grab the gpio
> controlling that and ensure it stays in the right position so USB 2.0
> continues to be routed from the external port to the SoC.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>   arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 24 +++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index 97957f3baa64..56d4f43faa1e 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -246,6 +246,21 @@ &usb_0_qmpphy {
>   	status = "okay";
>   };
>   
> +&usb_2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&usb2_en_state>;
> +
> +	status = "okay";
> +};
> +
> +&usb_2_dwc3 {
> +	dr_mode = "host";
> +	num-ports = <1>;
> +	num-ss-ports = <1>;

More over, if this is a multiport controller and you are using only 
port-1, it is as good as a single port controller I believe and the 
normal DT convention must work. Adding these properties as "1" is not 
required as the driver logic defaults them to "1" if they are not found.

Just to add a point here (as I was not clear in DT Binding description, 
My bad), the num-ports and num-ss-ports must indicate the HS/SS Phys 
present on HW whether they are used in DT or not. Just to cover all 
cases which user can use [1].

[]1: 
https://lore.kernel.org/all/4eb26a54-148b-942f-01c6-64e66541de8b@quicinc.com/

Regards,
Krishna,

> +	phy-names = "usb2-phy", "usb3-phy";
> +	phys = <&usb_2_hsphy0>, <&usb_2_qmpphy0>;
> +};
> +
>   &usb_2_hsphy0 {
>   	vdda-pll-supply = <&vreg_l5a>;
>   	vdda18-supply = <&vreg_l7g>;
> @@ -313,4 +328,13 @@ wake-pins {
>   			bias-pull-up;
>   		};
>   	};
> +
> +	usb2_en_state: usb2-en-state {
> +		/* TS3USB221A USB2.0 mux select */
> +		pins = "gpio24";
> +		function = "gpio";
> +		drive-strength = <2>;
> +		bias-disable;
> +		output-low;
> +	};
>   };
