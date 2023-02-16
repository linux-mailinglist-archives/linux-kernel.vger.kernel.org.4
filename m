Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941C9699B6C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjBPRlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:41:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjBPRlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:41:15 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976B33B855;
        Thu, 16 Feb 2023 09:41:13 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31G47P9d017065;
        Thu, 16 Feb 2023 17:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=2qzEUuV7n8pAGi2RGWf50M997hHG2Iw8kV9N8cxf5BY=;
 b=m3PLxpH6b+QaWZSgqV9wc7WiRw7pEK9qez0K8X0TalKmtaZpKJqYOqZOYr6YRtQAUruF
 PC5xJd2tRl7ENQO7EQjaMDGdTluzTYtKSQ2GhFOvGwmVbceOaF1ObqEUlU65Q1Mlw99F
 13oVmOwLXDu41Wpxu7+61BRNtiLa7NFrcYipcSfwetV5UT1OlF/wFdB7f2nbn4t2R83D
 kRPzYk4DehEYpb/CwRnsJL/0Lcup/Pa+bQmFDfBJ7sbZ+9gtCyWaGBHChtHJRrhUZmcd
 ogVSukOPo72BqiyFyr5bQbyKG6fJBqJ+ivx9y+IoPWmxbxl5ZMqwtPqDhr6FEZqWEZv3 ww== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ns343bbb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 17:40:55 +0000
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31GHesgZ009492
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Feb 2023 17:40:54 GMT
Received: from [10.110.95.168] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 16 Feb
 2023 09:40:53 -0800
Message-ID: <b04aef26-ee0d-af01-3aa1-a0c77d9cbaf3@quicinc.com>
Date:   Thu, 16 Feb 2023 09:40:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 08/26] gunyah: rsc_mgr: Add resource manager RPC core
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Alex Elder <elder@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Arnd Bergmann" <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230214211229.3239350-1-quic_eberman@quicinc.com>
 <20230214212327.3310128-1-quic_eberman@quicinc.com>
 <Y+3QqdQVH5BTbnaP@kroah.com>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <Y+3QqdQVH5BTbnaP@kroah.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PF4GoKGtM-5nQH14pMTEY9-9Gnxe-O_V
X-Proofpoint-GUID: PF4GoKGtM-5nQH14pMTEY9-9Gnxe-O_V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-16_14,2023-02-16_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=859 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302160152
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/2023 10:43 PM, Greg Kroah-Hartman wrote:
> On Tue, Feb 14, 2023 at 01:23:25PM -0800, Elliot Berman wrote:
>> +struct gh_rm {
>> +	struct device *dev;
> 
> What device does this point to?
> 

The platform device.

>> +	struct gunyah_resource tx_ghrsc, rx_ghrsc;
>> +	struct gh_msgq msgq;
>> +	struct mbox_client msgq_client;
>> +	struct gh_rm_connection *active_rx_connection;
>> +	int last_tx_ret;
>> +
>> +	struct idr call_idr;
>> +	struct mutex call_idr_lock;
>> +
>> +	struct kmem_cache *cache;
>> +	struct mutex send_lock;
>> +	struct blocking_notifier_head nh;
>> +};
> 
> This obviously is the "device" that your system works on, so what are
> the lifetime rules of it?  Why isn't is just a real 'struct device' in
> the system instead of a random memory blob with a pointer to a device?
> 
> What controls the lifetime of this structure and where is the reference
> counting logic for it?
> 

The lifetime of the structure is bound by the platform device that above 
struct device *dev points to. get_gh_rm and put_gh_rm increments the 
device ref counter and ensures lifetime of the struct is also extended.

> And why no documentation for this core structure?
> 

Sure, I will add.

> thanks,
> 
> greg k-h
