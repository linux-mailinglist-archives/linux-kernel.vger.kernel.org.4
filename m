Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928BF6A7825
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjCAX7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjCAX7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:59:50 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49AF231DA;
        Wed,  1 Mar 2023 15:59:48 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321NDBjf024013;
        Wed, 1 Mar 2023 23:59:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=y9mJYHxxxpYu0119YRtQFXNT705Ekby7N3mfaX42fkk=;
 b=AeE7wqCly6kRJ9+AkevosJa+26PMhSH6qAJYjs4HZFN+Zket/2CVJoO9zzpwD6u1fXiv
 Bz8gSSjBGWCu4fB9pTfu1uF3O8O7oW0MH1uXfO4yU+6Wyvlf0LQVtuCeesYfFm83VsOS
 kvK54VOnA7s6Ro3IiJXtcxzUE27hxpliURHh77rIZGmUJitMGY1S2sh8pqeFkrDtkHpr
 zzik6pQg8PJra4cTAycfi5V8ffWQljCrxTtRxkFyh3li8LykA5xnR+Q6k8OVOL3gEjzk
 6YjxMOM60ncpeLaDuftoWFpujb33RTMTprQOvvSywd/QV8Ewei1WbHur3MqahQ5929m3 3g== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p20j2jwaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 23:59:15 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 321NxDYH011674
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 23:59:13 GMT
Received: from [10.110.81.49] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Mar 2023
 15:59:12 -0800
Message-ID: <753264d7-a236-0f1d-bb6f-328f5f8c7c0a@quicinc.com>
Date:   Wed, 1 Mar 2023 15:59:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/2] Validating UAPI backwards compatibility
Content-Language: en-US
To:     Mark Wielaard <mark@klomp.org>
CC:     Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <20230301075402.4578-1-quic_johmoo@quicinc.com>
 <CAKwvOdmqShYae=DrwP1JZBYXAYZyDB0SaOkVCvCzQC60MaJcpw@mail.gmail.com>
 <41d287fa-3a0a-cac6-4595-ad47ef873d79@quicinc.com>
 <0c92e7b8-e415-8ad5-14e7-d94f18c3fa25@quicinc.com>
 <b2055eab-4762-5fbf-8ea6-0956a0a2eb58@quicinc.com>
 <20230301235233.GJ12496@gnu.wildebeest.org>
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <20230301235233.GJ12496@gnu.wildebeest.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: FxCyra6Rifl-YbPJZA0V23_6KP3CSoY0
X-Proofpoint-GUID: FxCyra6Rifl-YbPJZA0V23_6KP3CSoY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_15,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 spamscore=0 mlxlogscore=804 priorityscore=1501 impostorscore=0 mlxscore=0
 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010190
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/2023 3:52 PM, Mark Wielaard wrote:
> Hi John,
> 
> On Wed, Mar 01, 2023 at 02:33:00PM -0800, John Moon via Libabigail wrote:
>> With some additional help from Nick offline, we determined that the
>> issue isn't with clang, but with libdw (from elfutils). You need at
>> least libdw version 0.171 for the abidiff tool to work correctly
>> with clang (in this particular case). Ubuntu 18.04 ships with
>> version 0.170.
> 
> I don't remember any specific fixes for clang in libdw for elfutils
> 0.171. But elfutils 0.171 was the first release that supported most of
> DWARF5 (including GNU DebugFission and split dwarf).
> 
>> If there's any interest, it'd be fairly easy to add a check for this
>> condition under the check_deps() function in the script.
> 
> Please do add this check. elfutils 0.170 is almost 6 years old now,
> there have been many, many bug fixes since then (current release is
> 0.188 from Nov 2022).
> 
> Thanks,
> 
> Mark

Okay, I'll add the check in v3 after giving a chance for some other 
reviews. Thanks!
