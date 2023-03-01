Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E110D6A77B5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 00:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCAXgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 18:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjCAXgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 18:36:20 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1602351FB0;
        Wed,  1 Mar 2023 15:36:20 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 321LNKQ1004544;
        Wed, 1 Mar 2023 23:35:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TrDGloP3Fe3baydtB3P+PQzjWfPeOK/PaswwGn4HH48=;
 b=VJxOhT5z5xhn7rYrVLzJ7fUtHsV9ewHxFoYqXIJeNFziOPNyQAJqfKFIut/kelDLwlAh
 5zrO7+ruKGU4cryr3P3o1/rukgY0BODiIFlk4JOuiBhOUIpDSuvKo8PylZSik5pIhyZr
 4NVUa78nzvNOHsOzKXa2g2QB44Ncp9fZ3PXD822Ap2TgY/RIcC3gTvGrn1akOyeekP+w
 ECx6Pr2w+IaqMuQCm1S20v6pfQPpCIxxLXtdzqxZY7erqRyPU+MYooVTS2o9I2DWfN0E
 09fIesOBow6s/ALLnkKexl5TyiUGso2aN/FF+qoevQAQPnoEjQGO5LALUdqTmykGzjyn QQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2cx88gc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 23:35:56 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 321NZtPB011908
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 23:35:55 GMT
Received: from [10.110.20.47] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 1 Mar 2023
 15:35:54 -0800
Message-ID: <8cedfaea-b8b5-30a4-969c-205af5193ce6@quicinc.com>
Date:   Wed, 1 Mar 2023 15:35:53 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 0/2] Validating UAPI backwards compatibility
To:     Nick Desaulniers <ndesaulniers@google.com>,
        John Moon <quic_johmoo@quicinc.com>
CC:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
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
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>
References: <20230301075402.4578-1-quic_johmoo@quicinc.com>
 <CAKwvOdmqShYae=DrwP1JZBYXAYZyDB0SaOkVCvCzQC60MaJcpw@mail.gmail.com>
 <41d287fa-3a0a-cac6-4595-ad47ef873d79@quicinc.com>
 <0c92e7b8-e415-8ad5-14e7-d94f18c3fa25@quicinc.com>
 <b2055eab-4762-5fbf-8ea6-0956a0a2eb58@quicinc.com>
 <CAKwvOdmUm8oEiiYt64oe0MY+H3U0TxpzVhWbhfvptTDkKHUFcA@mail.gmail.com>
Content-Language: en-US
From:   Trilok Soni <quic_tsoni@quicinc.com>
In-Reply-To: <CAKwvOdmUm8oEiiYt64oe0MY+H3U0TxpzVhWbhfvptTDkKHUFcA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vjyQCU8iGbuU0109tHKb9e6q6KpJrIh2
X-Proofpoint-ORIG-GUID: vjyQCU8iGbuU0109tHKb9e6q6KpJrIh2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_15,2023-03-01_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=933
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303010189
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/2023 3:33 PM, Nick Desaulniers wrote:
> On Wed, Mar 1, 2023 at 2:33 PM John Moon <quic_johmoo@quicinc.com> wrote:
>>
>> With some additional help from Nick offline, we determined that the
>> issue isn't with clang, but with libdw (from elfutils). You need at
>> least libdw version 0.171 for the abidiff tool to work correctly with
>> clang (in this particular case). Ubuntu 18.04 ships with version 0.170.
>>
>> If there's any interest, it'd be fairly easy to add a check for this
>> condition under the check_deps() function in the script.
> 
> Good job John; mind sending a v3 with that addition, and the commit
> message updated?

I would prefer to wait to get more reviews on v2 from Greg/Masahiro and 
then combine above checks in the v3. If there are no comments by next 
Monday then we can send v3, sounds good?

---Trilok Soni
