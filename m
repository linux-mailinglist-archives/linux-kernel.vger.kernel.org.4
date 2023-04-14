Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917866E28E5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 19:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjDNRBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 13:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbjDNRBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 13:01:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D049359EE;
        Fri, 14 Apr 2023 10:01:17 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGnjFl014262;
        Fri, 14 Apr 2023 17:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=L3vpeRMuOc5IfcvR3N45isiunZ5Yl50NdibhXSiD3nw=;
 b=cesS/IZWcbwkyJipXzw6LPInHXrFvUs5GMdpec+tOWT9CUECfXhLi7dij3HYooMtuxa+
 jZUbpCSOPco+Rjjt5aUmG/LdjVV4fTA7Lxds3MsV6FDxXHJiW/LPD4xQ19YZxGZ/pRQ1
 3mBcMEOLITbhTavwKpRtW4R1ePMvC+qL1yEcCiWQ/a3+ZTCLeksLD7Ny0Nvtn+HMzHRi
 3YwXqLgecwmO1F/ndGElqv3rw3jYRl+3ZkY1fieJd1HDzlOHrqlAhDcbq8WkYfSkLWfW
 TxA2a/lEg9jFPoeAANvlClevsLizQltJkJsG5MYSA524QtMUiwoHIA7A+sMg/a/q41Rc XA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxe66kkx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 17:01:10 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EH19nN026081
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 17:01:09 GMT
Received: from [10.216.0.144] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 10:01:04 -0700
Message-ID: <ffd543a8-769d-a159-16c1-6309388d16e6@quicinc.com>
Date:   Fri, 14 Apr 2023 22:31:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 0/3] spi: Add DMA mode support to spi-qcom-qspi
Content-Language: en-CA
To:     Doug Anderson <dianders@chromium.org>
CC:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_msavaliy@quicinc.com>, <mka@chromium.org>,
        <swboyd@chromium.org>, <quic_vtanuku@quicinc.com>
References: <1681481153-24036-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=XU_SWzJTmtqoZZ1eTDu3WcWQOAFbkBS=Juaz9_DivZSg@mail.gmail.com>
 <CAD=FV=W8ML4A9Yp3o1PzO1xRSJ3Z+9g-SdMDwLTMqhmMw0q99g@mail.gmail.com>
From:   Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
In-Reply-To: <CAD=FV=W8ML4A9Yp3o1PzO1xRSJ3Z+9g-SdMDwLTMqhmMw0q99g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: JiqJArLwzHREXkDPU5iaPVYy35xWbHe6
X-Proofpoint-ORIG-GUID: JiqJArLwzHREXkDPU5iaPVYy35xWbHe6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_09,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=726 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304140150
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/2023 10:12 PM, Doug Anderson wrote:
> Hi,
>
> On Fri, Apr 14, 2023 at 8:48 AM Doug Anderson <dianders@chromium.org> wrote:
>> Hi,
>>
>> On Fri, Apr 14, 2023 at 7:06 AM Vijaya Krishna Nivarthi
>> <quic_vnivarth@quicinc.com> wrote:
>>> There are large number of QSPI irqs that fire during boot/init and later
>>> on every suspend/resume.
>>> This could be made faster by doing DMA instead of PIO.
>>> Below is comparison for number of interrupts raised in 2 acenarios...
>> s/acenarios/scenarios
>>
>>> Boot up and stabilise
>>> Suspend/Resume
>>>
>>> Sequence   PIO    DMA
>>> =======================
>>> Boot-up    69088  19284
>>> S/R        5066   3430
>>>
>>> Though we have not made measurements for speed, power we expect
>>> the performance to be better with DMA mode and no regressions were
>>> encountered in testing.
>> Measuring the speed isn't really very hard, so I gave it a shot.
>>
>> I used a truly terrible python script to do this on a Chromebook:
>>
>> --
>>
>> import os
>> import time
>>
>> os.system("""
>> stop ui
>> stop powerd
>>
>> cd /sys/devices/system/cpu/cpufreq
>> for policy in policy*; do
>>    cat ${policy}/cpuinfo_max_freq > ${policy}/scaling_min_freq
>> done
>> """)
>>
>> all_times = []
>> for i in range(1000):
>>    start = time.time()
>>    os.system("flashrom -p host -r /tmp/foo.bin")
>>    end = time.time()
>>
>>    all_times.append(end - start)
>>    print("Iteration %d, min=%.2f, max=%.2f, avg=%.2f" % (
>>        i, min(all_times), max(all_times), sum(all_times) / len(all_times)))
>>
>> --
>>
>> The good news is that after applying your patches the loop runs _much_ faster.
>>
>> The bad news is that it runs much faster because it very quickly fails
>> and errors out. flashrom just keeps reporting:
>>
>> Opened /dev/mtd0 successfully
>> Found Programmer flash chip "Opaque flash chip" (8192 kB,
>> Programmer-specific) on host.
>> Reading flash... Cannot read 0x001000 bytes at 0x000000: Connection timed out
>> read_flash: failed to read (00000000..0x7fffff).
>> Read operation failed!
>> FAILED.
>> FAILED
>>
>> I went back and tried v1, v2, and v3 and all three versions fail.
> Ah, I see what's likely the problem. Your patch series only adds the
> "iommus" for sc7280 but I'm testing on sc7180. That means:
>
> 1. You need to add the iommus to _all_ the boards that have qspi. That
> means sc7280, sc7180, and sdm845.
>
> 2. Ideally the code should still be made to work (it should fall back
> to PIO mode) if DMA isn't properly enabled. That would keep old device
> trees working, which we're supposed to do.


Thank you very much for the review, script, test and quick debug.
Will check same and update a v4.

-Vijay/


> -Doug
