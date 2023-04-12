Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 790DB6DFB7C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjDLQhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDLQho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:37:44 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8531135BE;
        Wed, 12 Apr 2023 09:37:42 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33CDeJNg014881;
        Wed, 12 Apr 2023 16:37:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=nUjuUXT2LfpQFIC3IgyPeCr2vhqDD5uMV2tFPA28YNI=;
 b=dZk3zVj8VmEC8KXdlZSUPReD3EkT1M1T8JsEz+mHUwSdA37BMptaITo83QO9aQf58piB
 oUiOe0Je9Ch9wWIY/NqbtKMW5f2WGD0ajHCZ5QuvS1SjymSCh/br/C9W/mszQIlJE40I
 0L62HyoMyB6BfuWhQY5KQYjVcgjX7ZyItiPQVMYBrGlDzWB/t18R1bGrKJaMwHcrnRn+
 vALU0c1jFS4KVsbemyMvHhYrguY6jDJxq5uSnS6WPKxBqr5gAODUEmCSVFBwcXaoXznL
 GcsuqbOAxxGLOjdiZEiL//aqGDpJ40hF+0eHrhM904tBANris8kyHMZuJIeDbc3X156x qQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pwe6m2acd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 16:37:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33CGbJoB016406
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 16:37:19 GMT
Received: from [10.110.32.64] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 12 Apr
 2023 09:37:17 -0700
Message-ID: <d34a6b09-8244-49e2-2d7a-eee5fd5ca5b7@quicinc.com>
Date:   Wed, 12 Apr 2023 09:37:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
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
        Elliot Berman <quic_eberman@quicinc.com>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>
References: <20230407203456.27141-1-quic_johmoo@quicinc.com>
 <20230407203456.27141-2-quic_johmoo@quicinc.com>
 <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
 <2023041015-lunar-dandelion-1b4e@gregkh>
 <ae44540f-8947-8efb-fb8d-45a84bd3fef3@quicinc.com>
 <2023041136-donator-faceplate-5f91@gregkh>
 <bcdcee9b-f213-bc3c-d300-92a1e0138187@quicinc.com>
 <2023041209-armed-overlaid-3d3d@gregkh>
Content-Language: en-US
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <2023041209-armed-overlaid-3d3d@gregkh>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: P7YGYhDWoYAG8nQiV_dnGDHI4va2VI3K
X-Proofpoint-ORIG-GUID: P7YGYhDWoYAG8nQiV_dnGDHI4va2VI3K
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-12_07,2023-04-12_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=833 suspectscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304120144
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/2023 11:14 PM, Greg Kroah-Hartman wrote:
>> Would you find the tool more useful if it simply filtered out all instances
>> where the size of the type did not change? This would filter out the
>> following which the tool currently flags:
>>
>> - enum expansions
>> - reserved field expansions
>> - expansions of a struct with a flex array at the end
>> - type changes
>> - re-ordering of existing members
>> - ...others?
> 
> Obviously not, as some of those are real breakages, and some are not at
> all.
> 
> Please understand what is an abi breakage.  Adding new enums is not.
> Using a reserved field is not.  Reording existing members IS.
> 

Yes, understood that method would miss certain classes of breakages. I 
was suggesting it as a way to improve the signal-to-noise ratio of the 
tool since we don't currently have an algorithm for determining 
breakages with 100% accuracy.

We'll work internally and with the libabigail team to improve the story 
here and get back to you. Thanks for the discussion!

- John
