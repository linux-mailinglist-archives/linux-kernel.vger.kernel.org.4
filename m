Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841496B5001
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:22:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjCJSV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjCJSVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:21:39 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3C71386A2;
        Fri, 10 Mar 2023 10:20:42 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32ADovRc022695;
        Fri, 10 Mar 2023 18:20:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DgFVAoLAXA+pGzs1RTiR1tB9IOrskv07iltnwai5cWo=;
 b=WQU/imcXQkFIa9aussINsXMJYxmLwIk1g2n+l+bB0lFdprVqz2D5b6EnYW+pYKFsNAO5
 NVW1l3jG+SO7x8S2KOZjYA+HA7rzoLRKemHlziOqFDa82nFrZCoKE67GXxRWw2M7qIbw
 7JF2UyqQLjmMb6H5n77Unkw/3qhomWfyMuzVt1+5APFIPaTR02uD4Myli3UGlGhuaZnE
 W5EumhdOClxEuiAljdjI7cU+BE53UhjserXNj6BpV5MGht7N9oAjVP3YJn8uGL0/1kXY
 0fTOOS5cAoC60G5i0qyI8vNYPSMtTC2wUHT2rqq3NdB2d6xt9dd6bMYG1i+zulS55nrG Mg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7egym7p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 18:20:17 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32AIKGD4013258
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 18:20:16 GMT
Received: from [10.110.35.240] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 10 Mar
 2023 10:20:15 -0800
Message-ID: <c4b39b28-1f18-c436-e3c5-b015600ca3a2@quicinc.com>
Date:   Fri, 10 Mar 2023 10:20:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/2] Validating UAPI backwards compatibility
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>,
        John Moon <quic_johmoo@quicinc.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
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
        "Satya Durga Srinivasu Prabhala" <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <20230301075402.4578-1-quic_johmoo@quicinc.com>
 <ZArlx5wrw+ZQWUg4@infradead.org>
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <ZArlx5wrw+ZQWUg4@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j8nBrDEWwr0u__8SclYtBFl6Esys8tp0
X-Proofpoint-ORIG-GUID: j8nBrDEWwr0u__8SclYtBFl6Esys8tp0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_09,2023-03-10_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 mlxscore=0 clxscore=1011 mlxlogscore=854
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100146
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/2023 12:09 AM, Christoph Hellwig wrote:
> On Tue, Feb 28, 2023 at 11:54:00PM -0800, John Moon wrote:
>> Our goal is to add tooling for vendor driver developers because the
>> upstream model of expert maintainer code review can be difficult to
>> replicate in-house. Tools may help developers catch simple UAPI
>> incompatibilities that could be easily overlooked by in-house review.
> 
> Why would this matter in any way for the kernel?  If you tool is useful
> for in-kernel usage it should be added to the tree and documented as
> such, but ouf of tree crap simply does not matter.

This tool will be helpful for the kernel maintainers and reviewers as 
well if it can detect potential UAPI backward compatibilities. Even for 
the developers while changing UAPI interfaces at kernel.org before 
submission.

John is trying to highlight also that this tool can be useful for 
downstream users who want to keep the UAPI backward compatibility like 
we do at upstream. We can remove the above text, since we would like to 
mainline it at kernel.org.

---Trilok Soni
