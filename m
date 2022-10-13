Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB35FE54B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJMWc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiJMWcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:32:53 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030BB18D81F;
        Thu, 13 Oct 2022 15:32:51 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29DLcpkw013489;
        Thu, 13 Oct 2022 22:32:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=WjoqOb5T3QLlzOWNlulzKGBqyMjswsMVvSjUFw9nmcc=;
 b=kb5Nx9N9rz6JxdQQf1P82/TQqAcmGeE2dBWph29qjg+5coCfCxWkLjjVQAVEg4h3xf0c
 aWM4qlP76CtAqZPqxEI8Y/iuOGJ1ExMCa4ppCdtAO8sDXKiLDnuJEMmqLfALz+zd/q6X
 TV0ZMYnBetPFcVmGnP/Vl8NkmHM3WL/D/mBabW2Q03u5q/29xuLGlI/+1IOpxiD941ZV
 +Bo2MSN97QCPpe/nF7EdW2T6lh/RvGMhPWZzkhClt8k0wnm5+77Ect8mdyvuRVu4JlNa
 G6Du5p63wxrVQg/GlZXf98yqA/VNfHNC9J+UhmwilVmY8yOtW2ZHO8WrZtovsCvc7agQ 3A== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k6ae42wvw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 22:32:35 +0000
Received: from nasanex01b.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29DMWYTp012213
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 22:32:34 GMT
Received: from [10.110.38.147] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 13 Oct
 2022 15:32:33 -0700
Message-ID: <c0b57108-38b7-6d86-7dc5-18ab75f48de7@quicinc.com>
Date:   Thu, 13 Oct 2022 15:32:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 10/13] gunyah: rsc_mgr: Add resource manager RPC core
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
CC:     Murali Nalajala <quic_mnalajal@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>,
        Carl van Schaik <quic_cvanscha@quicinc.com>,
        Prakruthi Deepak Heragu <quic_pheragu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221011000840.289033-1-quic_eberman@quicinc.com>
 <20221011000840.289033-11-quic_eberman@quicinc.com>
 <9a42be23-e035-0944-ba62-f6af6b7acc0d@linaro.org>
From:   Elliot Berman <quic_eberman@quicinc.com>
In-Reply-To: <9a42be23-e035-0944-ba62-f6af6b7acc0d@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: d_4jtkHbI3GItQya3E6pmUvA5PyC6f7r
X-Proofpoint-GUID: d_4jtkHbI3GItQya3E6pmUvA5PyC6f7r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-13_08,2022-10-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2209130000 definitions=main-2210130125
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2022 3:52 PM, Dmitry Baryshkov wrote:
> On 11/10/2022 03:08, Elliot Berman wrote >> diff --git a/drivers/virt/gunyah/Makefile b/drivers/virt/gunyah/Makefile
>> index dc081e2dc02b..2cae8ea5bc7d 100644
>> --- a/drivers/virt/gunyah/Makefile
>> +++ b/drivers/virt/gunyah/Makefile
>> @@ -1,2 +1,5 @@
>>   gunyah-y += gunyah.o
>>   obj-$(CONFIG_GUNYAH) += gunyah.o
>> +
>> +gunyah_rsc_mgr-y += rsc_mgr.o
>> +obj-$(CONFIG_GUNYAH_RESORUCE_MANAGER) += gunyah_rsc_mgr.o
> 
> You know, you don't have to do this...
> 

Other places, it's debatable. Here though, I think I do :)

This ends up being a proper composite module in the next patch in series:

-gunyah_rsc_mgr-y += rsc_mgr.o
+gunyah_rsc_mgr-y += rsc_mgr.o rsc_mgr_rpc.o


>> +
>> +static int gh_msgq_platform_probe_direction(struct platform_device 
>> *pdev,
>> +                u8 gh_type, int idx, struct gunyah_resource *ghrsc)
>> +{
>> +    int ret;
>> +    struct device_node *node = pdev->dev.of_node;
>> +
>> +    ghrsc->type = gh_type;
>> +
>> +    ghrsc->irq = platform_get_irq(pdev, idx);
>> +    if (ghrsc->irq < 0) {
>> +        dev_err(&pdev->dev, "Failed to get irq%d: %d\n", idx, 
>> ghrsc->irq);
>> +        return ghrsc->irq;
>> +    }
>> +
>> +    ret = of_property_read_u64_index(node, "reg", idx, &ghrsc->capid);
> 
> Is there any reason why can't you use platform_get_resource() here?
> 

These don't show up as resources because size-cells = 0.

