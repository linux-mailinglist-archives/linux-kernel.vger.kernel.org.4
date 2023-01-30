Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80C86809D6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 10:43:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235759AbjA3JnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 04:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbjA3JnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 04:43:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D486646A5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 01:43:15 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30U8Cn6S027799;
        Mon, 30 Jan 2023 09:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YD5SaBBJIl2JTApqS/3OmKQbvVL4iVvdHb/6vCkTGpE=;
 b=UN2CnTQlxXaP+Z7C4karaizW9Q2TdWoD2vEtyX1wd0UCAVX/+yOM6Jl9aVa2cwNuXufU
 TLI7l1VxB3QBmhbGyv2PKN3KrTdUHG0MYoWA0gut3DOgCR929X1o9HBjJo88Re3Hx3zt
 ajnIpdIBCKRtGs5L3nwUTuKyG7BVF50Ep9XQqAYjlc/pDPASJDdPqcrASecJaEjdtCKc
 17xVFFLayacx6Yw2V/f1W9bkWSk3fanV70GraE/P309I/7QBLbNNAqZwpnp8d5xkh5s5
 tiQ1DO2j818AyioazD9p+jIZP9tl2rcTcCRsNF5sJpcNWuJ28/s+dBu1C6tczv7mBHWI FA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nea669quq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 09:29:27 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30U92HYS004659;
        Mon, 30 Jan 2023 09:29:27 GMT
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nea669quc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 09:29:27 +0000
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30U9FNv2025829;
        Mon, 30 Jan 2023 09:29:26 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma03dal.us.ibm.com (PPS) with ESMTPS id 3ncvtrcfna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 09:29:26 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30U9TOfc61145520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 30 Jan 2023 09:29:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DFB9358052;
        Mon, 30 Jan 2023 09:29:24 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1173958045;
        Mon, 30 Jan 2023 09:29:22 +0000 (GMT)
Received: from [9.171.57.35] (unknown [9.171.57.35])
        by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTPS;
        Mon, 30 Jan 2023 09:29:21 +0000 (GMT)
Message-ID: <1844e345-eb71-3b0b-aa1d-7b71575e534d@linux.ibm.com>
Date:   Mon, 30 Jan 2023 10:29:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] lib/zlib: remove redundation assignement of avail_in
 dfltcc_gdht()
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, akpm@linux-foundation.org,
        iii@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org
References: <20230128165048.1245792-1-trix@redhat.com>
From:   Zaslonko Mikhail <zaslonko@linux.ibm.com>
In-Reply-To: <20230128165048.1245792-1-trix@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: idOeDkqhtDYZDJVAYwQnFRR3fq3ZW1pG
X-Proofpoint-GUID: 0vcbq0PiCz2vweO8tpEe9d8XNZ41VRuI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_07,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 bulkscore=0 clxscore=1015 phishscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300086
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28.01.2023 17:50, Tom Rix wrote:
> cppcheck reports
> lib/zlib_dfltcc/dfltcc_deflate.c:65:21: warning: Redundant assignment of 'avail_in' to itself. [selfAssignment]
>     size_t avail_in = avail_in = strm->avail_in;
> 
> Only setting avail_in once is needed.
> 
> Fixes: aa5b395b69b6 ("lib/zlib: add s390 hardware support for kernel zlib_deflate")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  lib/zlib_dfltcc/dfltcc_deflate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/zlib_dfltcc/dfltcc_deflate.c b/lib/zlib_dfltcc/dfltcc_deflate.c
> index 80924f067c24..b732b6d9e35d 100644
> --- a/lib/zlib_dfltcc/dfltcc_deflate.c
> +++ b/lib/zlib_dfltcc/dfltcc_deflate.c
> @@ -62,7 +62,7 @@ static void dfltcc_gdht(
>  {
>      deflate_state *state = (deflate_state *)strm->state;
>      struct dfltcc_param_v0 *param = &GET_DFLTCC_STATE(state)->param;
> -    size_t avail_in = avail_in = strm->avail_in;
> +    size_t avail_in = strm->avail_in;
>  
>      dfltcc(DFLTCC_GDHT,
>             param, NULL, NULL,

Acked-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
