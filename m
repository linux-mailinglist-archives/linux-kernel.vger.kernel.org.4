Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37CB6E139A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjDMReJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjDMReF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:34:05 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F109029;
        Thu, 13 Apr 2023 10:34:04 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33DGcDO1016461;
        Thu, 13 Apr 2023 17:33:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MOFDc67Ti2WA2xVO85mEsNHwB8SpuTYqAYmG97NEvko=;
 b=aCw91GRppVoy8UOYG0f9hZGxRSD+xlNP6j5QZdRDeZWVc6rdd3eXEGsrTkvBHjljV3Um
 Hy58BVveqNVD8YXAbInGGIdityYDEXhz3gUBLZ8orDS7id2evVTSpfR+LyxKmqAoJKSP
 E2JmRdSfdjnokbSPLcaRJ3/CSlxscg/8En16K64Kf3k8RxHGmOnt8Z8Mo458Abs8qIP7
 1Vf+T6SkNpGbMVp2lM0P8y8NVdxZOP+r2rXMZFCiZU/9Tt0ZIgI7g6GVELlZXeVmTM4r
 twYHHcbJAvFC+c0HA8dMUVVNC6Ph/zWheRhpZ4NIF4IuEjeaDgik8GARpX+yImCX0nQY rg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3px6cnj0fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 17:33:45 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33DHXi6u013701
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Apr 2023 17:33:44 GMT
Received: from [10.110.32.64] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 13 Apr
 2023 10:33:42 -0700
Message-ID: <f402549e-188b-2fd0-bcf9-a0a7e8ac6cbc@quicinc.com>
Date:   Thu, 13 Apr 2023 10:33:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
Content-Language: en-US
To:     Nicolas Schier <nicolas@fjasle.eu>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        <kernel-team@android.com>, <libabigail@sourceware.org>,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
References: <20230407203456.27141-1-quic_johmoo@quicinc.com>
 <20230407203456.27141-2-quic_johmoo@quicinc.com>
 <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
 <ZDg12nC0XGx6ZdRX@fjasle.eu>
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <ZDg12nC0XGx6ZdRX@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Pz-4OzDu4EnmWLvlYZzRsuF7vXgzvQvJ
X-Proofpoint-GUID: Pz-4OzDu4EnmWLvlYZzRsuF7vXgzvQvJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-13_12,2023-04-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=696
 priorityscore=1501 adultscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 phishscore=0 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304130155
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/13/2023 10:03 AM, Nicolas Schier wrote:
> On Mon, Apr 10, 2023 at 07:03:05PM +0900 Masahiro Yamada wrote:
>> CAVEAT
>> This tool runs 'git checkout' a couple of times internally.
>> If you interrupt it, your worktree might be messed up.
> 
> John, did you consider using git export for obtaining a source tree that
> can be used for headers_install and the following comparison, instead of
> git stash+checkout?  AFACS the script does not depend on any other git
> functionality than providing a specific version of the source tree.  I am
> pretty sure that leaving the original working copy in its original state
> is supporting the script's popularity.
> 
> Kind regards,
> Nicolas
> 

I hadn't considered that. Great suggestion! I'll use this method in the 
next rev. Thanks!
