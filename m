Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7219D6D51A5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 21:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjDCTyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 15:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjDCTym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 15:54:42 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7732D7D;
        Mon,  3 Apr 2023 12:54:41 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 333IwZW3028930;
        Mon, 3 Apr 2023 19:54:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sI/KI1M9WQUoAVI3hQPJq/s8QurLUTf4o+gm5JkNNQA=;
 b=N2ewvnT3s8M9V2Lwdkm7rNVGamgSVPdSxvG5A1epj0zqanQawo8xCnkvphzMR9tz7d1P
 Nm0SZP2gHoxl6U34HAoVB8aPyZHMacqW8t43mTmeWf1nNfdTyLCv2NT5FjH4sB/cH32Q
 u22hmPrfhwyawnhq7CWu9eYtur8JDaHEO6HlJfvhB2yg2R0D2yob1CNylD4f2Qcq+x8+
 cQkfnHW5NC7b6rHMPDJ+jfGXPh7WWFfwmtCjGytjICHaBR5LecZ8+6WbTQkrM+1VKFuo
 HHQ3GjI2VJfOdFplEgnGVkdWaUSa+4zwVZk1rD3aikbz8Rt5MJzPqKWfTWowTJ0Xgj+L 3Q== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pqwdrsabq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Apr 2023 19:54:13 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 333Jrvnn032472
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Apr 2023 19:53:57 GMT
Received: from [10.110.44.117] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 3 Apr 2023
 12:53:55 -0700
Message-ID: <6d55e7af-4d68-2872-f407-268c3a4e95c8@quicinc.com>
Date:   Mon, 3 Apr 2023 12:53:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 1/2] check-uapi: Introduce check-uapi.sh
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>
CC:     <linux-kbuild@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
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
References: <20230327174140.8169-1-quic_johmoo@quicinc.com>
 <20230327174140.8169-2-quic_johmoo@quicinc.com>
From:   John Moon <quic_johmoo@quicinc.com>
In-Reply-To: <20230327174140.8169-2-quic_johmoo@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Dc6jDXDEQnbtZ_OZatM18cZwm3cJBrCH
X-Proofpoint-ORIG-GUID: Dc6jDXDEQnbtZ_OZatM18cZwm3cJBrCH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-03_15,2023-04-03_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=694 suspectscore=0 clxscore=1011
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2303200000 definitions=main-2304030154
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/2023 10:41 AM, John Moon wrote:
> While the kernel community has been good at maintaining backwards
> compatibility with kernel UAPIs, it would be helpful to have a tool
> to check if a commit introduces changes that break backwards
> compatibility.
> 
> To that end, introduce check-uapi.sh: a simple shell script that
> checks for changes to UAPI headers using libabigail.
> 
> libabigail is "a framework which aims at helping developers and
> software distributors to spot some ABI-related issues like interface
> incompatibility in ELF shared libraries by performing a static
> analysis of the ELF binaries at hand."
> 
> The script uses one of libabigail's tools, "abidiff", to compile the
> changed header before and after the commit to detect any changes.
> 
> abidiff "compares the ABI of two shared libraries in ELF format. It
> emits a meaningful report describing the differences between the two
> ABIs."
> 
> The script also includes the ability to check the compatibility of
> all UAPI headers across commits. This allows developers to inspect
> the stability of the UAPIs over time.
> 
> Signed-off-by: John Moon <quic_johmoo@quicinc.com>
> ---
>      - Refactored to exclusively check headers installed by make
>        headers_install. This simplified the code dramatically and removed
>        the need to perform complex git diffs.
>      - Removed the "-m" flag. Since we're checking all installed headers
>        every time, a flag to check only modified files didn't make sense.
>      - Added info message when usr/include/Makefile is not present that
>        it's likely because that file was only introduced in v5.3.
>      - Changed default behavior of log file. Now, the script will not
>        create a log file unless you pass "-l <file>".
>      - Simplified exit handler.
>      - Added -j $MAX_THREADS to make headers_install to improve speed.
>      - Cleaned up variable references.


Hi Masahiro, just a friendly reminder about this patch. I believe we've 
addressed all of your comments from previous reviews and we're looking 
forward to your feedback on this version.

Thanks so much!

- John
