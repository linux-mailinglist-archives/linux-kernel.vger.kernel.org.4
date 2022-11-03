Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637836178AB
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiKCI2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiKCI15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:27:57 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E9F64FA;
        Thu,  3 Nov 2022 01:27:56 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A34rkAw015686;
        Thu, 3 Nov 2022 08:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OpdPFbda9j2kt9BTHRfHVxmgMJKtvg8swA1CM+MAqqM=;
 b=mAGFsv0FbaH38FtBKq5DJylIrSwq8/LaRnun1twd0irkSvRFrNMhpGgng26uKQuyG8Ln
 gUfCYVYLwim3jvSnDTJ1BjBPlqae8IZV9Nc7xRPzL+mZ84oGLoc6NwIkQ9cmz5F+KPZV
 VeiXeTo8jBTqu7PkmxpLGZpMze9UN/2NMvOqmXZOFWv14RzU6yG8smHc9J47rFfOGWOx
 E8pqeYIALyeeOWDv9myn//hwmf7iq1gGvgsAr04Z41YdGUTlh/UCeBBOdR01Oe64BUWp
 awRJmmeC87qHUcN5uSZX2b1eQ8Q4lwrwVWuw8UuWbF4pKwADeHAwcjxo4OzIRJhh/taH Qw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3km7018s1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 08:27:47 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2A38RkFT019501
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Nov 2022 08:27:46 GMT
Received: from [10.206.64.67] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 3 Nov 2022
 01:27:44 -0700
Message-ID: <b1d79689-da3e-403b-647a-679fe7225a20@quicinc.com>
Date:   Thu, 3 Nov 2022 13:57:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH] wifi: ath11k: Trigger sta disconnect on hardware restart
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_mpubbise@quicinc.com>
References: <20221102061423.1032-1-quic_youghand@quicinc.com>
 <166740851734.26077.10462970085577578665.kvalo@kernel.org>
From:   "Youghandhar Chintala (Temp)" <quic_youghand@quicinc.com>
In-Reply-To: <166740851734.26077.10462970085577578665.kvalo@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1Lqaolrq8fMbLyCXVaXjsYFhtoNYJ6Bm
X-Proofpoint-GUID: 1Lqaolrq8fMbLyCXVaXjsYFhtoNYJ6Bm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-02_15,2022-11-02_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211030059
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/2/2022 10:32 PM, Kalle Valo wrote:
> Youghandhar Chintala <quic_youghand@quicinc.com> wrote:
>
>> Currently after the hardware restart triggered from the driver, the
>> station interface connection remains intact, since a disconnect trigger
>> is not sent to userspace. This can lead to a problem in targets where
>> the wifi mac sequence is added by the firmware.
>>
>> After the target restart, its wifi mac sequence number gets reset to
>> zero. Hence AP to which our device is connected will receive frames with
>> a  wifi mac sequence number jump to the past, thereby resulting in the
>> AP dropping all these frames, until the frame arrives with a wifi mac
>> sequence number which AP was expecting.
>>
>> To avoid such frame drops, its better to trigger a station disconnect
>> upon target hardware restart which can be done with API
>> ieee80211_reconfig_disconnect exposed to mac80211.
>>
>> The other targets are not affected by this change, since the hardware
>> params flag is not set.
>>
>> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-00887-QCAMSLSWPLZ-1
>>
>> Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
> Fails to compile:
>
> In file included from ./include/linux/wait.h:7,
>                   from ./include/linux/wait_bit.h:8,
>                   from ./include/linux/fs.h:6,
>                   from ./include/linux/highmem.h:5,
>                   from ./include/linux/bvec.h:10,
>                   from ./include/linux/skbuff.h:17,
>                   from ./include/linux/if_ether.h:19,
>                   from ./include/net/mac80211.h:18,
>                   from drivers/net/wireless/ath/ath11k/mac.c:7:
> drivers/net/wireless/ath/ath11k/mac.c: In function 'ath11k_mac_op_reconfig_complete':
> drivers/net/wireless/ath/ath11k/mac.c:8049:45: error: 'arvif' undeclared (first use in this function)
>   8049 |                         list_for_each_entry(arvif, &ar->arvifs, list) {
>        |                                             ^~~~~
> ./include/linux/list.h:674:14: note: in definition of macro 'list_for_each_entry'
>    674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>        |              ^~~
> drivers/net/wireless/ath/ath11k/mac.c:8049:45: note: each undeclared identifier is reported only once for each function it appears in
>   8049 |                         list_for_each_entry(arvif, &ar->arvifs, list) {
>        |                                             ^~~~~
> ./include/linux/list.h:674:14: note: in definition of macro 'list_for_each_entry'
>    674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>        |              ^~~
> In file included from ./include/linux/bits.h:22,
>                   from ./include/linux/ratelimit_types.h:5,
>                   from ./include/linux/printk.h:9,
>                   from ./include/asm-generic/bug.h:22,
>                   from ./arch/x86/include/asm/bug.h:87,
>                   from ./include/linux/bug.h:5,
>                   from ./include/net/mac80211.h:16:
> ././include/linux/compiler_types.h:298:27: error: expression in static assertion is not an integer
>    298 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>     78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>        |                                                        ^~~~
> ./include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>     19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>        |         ^~~~~~~~~~~~~
> ./include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>     19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>        |                       ^~~~~~~~~~~
> ./include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>    520 |         container_of(ptr, type, member)
>        |         ^~~~~~~~~~~~
> ./include/linux/list.h:531:9: note: in expansion of macro 'list_entry'
>    531 |         list_entry((ptr)->next, type, member)
>        |         ^~~~~~~~~~
> ./include/linux/list.h:674:20: note: in expansion of macro 'list_first_entry'
>    674 |         for (pos = list_first_entry(head, typeof(*pos), member);        \
>        |                    ^~~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath11k/mac.c:8049:25: note: in expansion of macro 'list_for_each_entry'
>   8049 |                         list_for_each_entry(arvif, &ar->arvifs, list) {
>        |                         ^~~~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:298:27: error: expression in static assertion is not an integer
>    298 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
>        |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
>     78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
>        |                                                        ^~~~
> ./include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
>     19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>        |         ^~~~~~~~~~~~~
> ./include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
>     19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>        |                       ^~~~~~~~~~~
> ./include/linux/list.h:520:9: note: in expansion of macro 'container_of'
>    520 |         container_of(ptr, type, member)
>        |         ^~~~~~~~~~~~
> ./include/linux/list.h:564:9: note: in expansion of macro 'list_entry'
>    564 |         list_entry((pos)->member.next, typeof(*(pos)), member)
>        |         ^~~~~~~~~~
> ./include/linux/list.h:676:20: note: in expansion of macro 'list_next_entry'
>    676 |              pos = list_next_entry(pos, member))
>        |                    ^~~~~~~~~~~~~~~
> drivers/net/wireless/ath/ath11k/mac.c:8049:25: note: in expansion of macro 'list_for_each_entry'
>   8049 |                         list_for_each_entry(arvif, &ar->arvifs, list) {
>        |                         ^~~~~~~~~~~~~~~~~~~
> make[6]: *** [scripts/Makefile.build:250: drivers/net/wireless/ath/ath11k/mac.o] Error 1
> make[5]: *** [scripts/Makefile.build:500: drivers/net/wireless/ath/ath11k] Error 2
> make[4]: *** [scripts/Makefile.build:500: drivers/net/wireless/ath] Error 2
> make[3]: *** [scripts/Makefile.build:500: drivers/net/wireless] Error 2
> make[2]: *** [scripts/Makefile.build:500: drivers/net] Error 2
> make[1]: *** [scripts/Makefile.build:500: drivers] Error 2
> make: *** [Makefile:1992: .] Error 2
>
> Patch set to Changes Requested.


Apologies Kalle. Will post next version of patch with fix.

Regards,

Youghandhar

