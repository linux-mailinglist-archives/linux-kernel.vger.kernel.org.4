Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9209774A1B6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 18:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbjGFQCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 12:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjGFQB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 12:01:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3537C9D;
        Thu,  6 Jul 2023 09:01:56 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366AsPgD018900;
        Thu, 6 Jul 2023 16:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PO4XAjnVnY6u8UJqSeV5G6bMGD02iTtM1xaKKvOeQ00=;
 b=lcR9dWjSJ6e8+6vDWtky95INhimGNZXLTRU/CbUjuHFoKAOocYRZvpazSlw4Rls4WqP7
 Eepp1OiQNzw0dGgTSfkSOJOSQjnMpBYi6ArZ4rlk0Uiza55l9CFe1sQPBPm8KUVeFJfX
 lPoTPTq2buQHtf1xRypKTwOQfaJfeOAhe5EI4exMQfSFaxYa9Fw90p3kIuzJG97b7D0i
 ozXX6mrO8GFtrhF8I1Qgw7cOdlRL+keduomKAEU+6/vkCOkvmOOHtJPZHGkVDdQUsnoZ
 k5fg3oA2+FTZa6ccy5Cf8DIuuAjKRBC1AxxFffIRCclLbK/Oqdw27MnuhRzNU/HIebhz ZA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rn5ht3mhv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Jul 2023 16:01:37 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 366G1Iwv031539
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Jul 2023 16:01:18 GMT
Received: from [10.216.23.31] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 6 Jul
 2023 09:01:13 -0700
Message-ID: <ca0a98a2-1d3c-c02b-914e-3fc577c2d678@quicinc.com>
Date:   Thu, 6 Jul 2023 21:30:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] pstore/ram: Add support for dynamically allocated ramoops
 memory regions
To:     Kees Cook <keescook@chromium.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
CC:     Elliot Berman <quic_eberman@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        Isaac Manjarres <isaacmanjarres@google.com>,
        John Stultz <jstultz@google.com>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        <kernel-team@android.com>, <linux-hardening@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
References: <20230622005213.458236-1-isaacmanjarres@google.com>
 <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com>
 <202306212212.5E53607@keescook> <ZJSES98P+zzrhBI5@google.com>
 <3A2CFB4D-27D0-4FEB-93B4-2F888305DE5A@kernel.org>
 <a2c9417b-3a50-bea4-dd39-2f021c196fa1@quicinc.com>
 <696269e1-8b97-66ed-c9b0-ce1b8d637d24@quicinc.com>
 <bd531778-a587-e4d0-e360-432208f064ea@kernel.org>
 <202307051516.AE6080BF@keescook>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <202307051516.AE6080BF@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: eM7zti1K-13OwIqSe2DdXzwAz2ie5HEa
X-Proofpoint-GUID: eM7zti1K-13OwIqSe2DdXzwAz2ie5HEa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_11,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 mlxlogscore=912 bulkscore=0 lowpriorityscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307060144
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/6/2023 3:51 AM, Kees Cook wrote:
> On Tue, Jul 04, 2023 at 08:07:09AM +0200, Krzysztof Kozlowski wrote:
>> On 26/06/2023 19:34, Mukesh Ojha wrote:
>>> I have tried multiple attempt already to get this patch in
>>>
>>> https://lore.kernel.org/lkml/1675330081-15029-2-git-send-email-quic_mojha@quicinc.com/
>>>
>>> later tried the approach of patch #9 along with minidump series..
>>
>> For all dynamic reserved-memory-ramoops thingy, I think Rob made clear
>> statement:
>>
>> "I don't think dynamic ramoops location should be defined in DT."
>>
>> https://lore.kernel.org/lkml/CAL_JsqKV6EEpsDNdj1BTN6nODb=hsHkzsdkCzzWwnTrygn0K-A@mail.gmail.com/
>>
>> Please do not send three versions of the same patch hoping one will
>> sneak in.
> 
> If I understand correctly, the driving issue here is that minidump wants
> to be able to find the crash report "externally". Perhaps pstore could
> provide either a known symbol that contains the address that was used,
> or could add something to the kernel crash image (like is done for
> KASLR), so that an external consumer of the kernel crash image could
> find it?
> 
> And then the RAM backend for pstore could gain an option for "just
> allocate regular RAM" for holding the dump? In other words, the address
> is chosen by pstore, but an external consumer could still locate it.

Yes, in-short, it wants RAM backend (fs/pstore/ram.c) to use regular ram
instead of fixed ram address range and at the same time it should be
able to query the address used.

So, registering with minidump is what telling upfront what address range
content would we be getting in final crash dump.

-Mukesh

> 
> -Kees
> 
