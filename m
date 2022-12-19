Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE31B6510B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 17:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiLSQsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 11:48:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiLSQsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 11:48:41 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEC9A1BD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 08:48:40 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJGi3c5024934;
        Mon, 19 Dec 2022 16:48:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Avcqq16wcT/rgWLBTYvJjWGMCSJ5kcrYa+wkoaZ9R/0=;
 b=g0+r7mrzf0szb/CHf0ih7yQoYaNV4ULwhnpYUbUtFR183F4T1gEdlIgsbIsnRhdSaVih
 B3M+pCQmtrIyr0m6H53JPeDlHIDTO3fmeWKts4rOYuLQvu7OjGT1zco3T013O8wsgJPU
 VBPhlKRRss+o7Nd9fMnRsaKiAcN5rTNIjFJX7LqRsDu+FMa7OQ2XrRbveiblKk4mXdf8
 yVjqyon09Qc1oQSNZbCv+lT7cDvguqluvHyND1t71vdQUhizCKf5jRfUuc/sVBAZDtLI
 6wnqmIEiD6wLtm4GolAOlYgybbCr7gp+hYPkNHVTH+0a9KV3t6nI1BFwjK6aZYWD5m0V FQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mjur3r4pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 16:48:35 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BJGi9io025553;
        Mon, 19 Dec 2022 16:48:35 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3mjur3r4nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 16:48:35 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 2BJE1K14013948;
        Mon, 19 Dec 2022 16:48:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3mh6yw2vd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Dec 2022 16:48:33 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2BJGmUYE16712142
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Dec 2022 16:48:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9D6C42005A;
        Mon, 19 Dec 2022 16:48:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7ED8F2004F;
        Mon, 19 Dec 2022 16:48:30 +0000 (GMT)
Received: from [9.171.202.193] (unknown [9.171.202.193])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Dec 2022 16:48:30 +0000 (GMT)
Message-ID: <1da3f764-4445-2135-3292-2912c2e8e778@linux.ibm.com>
Date:   Mon, 19 Dec 2022 17:48:14 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] gcov: Add support for checksum field
Content-Language: en-US
To:     Rickard Andersson <rickaran@axis.com>, linux-kernel@vger.kernel.org
Cc:     rickard314.andersson@gmail.com, mliska@suse.cz
References: <20221219150621.3310033-1-rickaran@axis.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <20221219150621.3310033-1-rickaran@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Af2f7sjyRAR5ny7q2MU6zjnCSPy3Zq73
X-Proofpoint-GUID: bww0ZYjgVw71OGYN4tYSdn-4uIqcsI8b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-19_01,2022-12-15_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212190147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.12.2022 16:06, Rickard Andersson wrote:
> From: Rickard x Andersson <rickaran@axis.com>
> 
> In GCC version 12.1 a checksum field was added.

Thanks for the patch!

In another e-mail you mentioned that this patch fixes a kernel crash
during boot when using gcov-kernel with GCC 12. Please add this
information to the commit message and if possible the platform on which
this occurs.

Also this patch fixes a missing piece from a previous patch, so please add:

Fixes: 977ef30a7d88 ("gcov: support GCC 12.1 and newer compilers")
Cc: <stable@vger.kernel.org>

Finally I reviewed and tested the patch and it looks good to me, so
please add:

Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Tested-by: Peter Oberparleiter <oberpar@linux.ibm.com>

Please resend with these commit message changes. Thanks!

For the record: I wondered why my testing of the previous patch with GCC
12 didn't catch this. It turns out that this crash does not occur on
architectures with 8-byte pointer alignment such as s390x where I
performed my tests. Consider this pahole output on s390x without the patch:

struct gcov_info {
[...]
        unsigned int       stamp;                /*    16     4 */
        /* XXX 4 bytes hole, try to pack */
        const char  *      filename;             /*    24     8 */
[...]
}

And with the patch:

struct gcov_info {
[...]
       unsigned int       stamp;                /*    16     4 */
       unsigned int       checksum;             /*    20     4 */
       const char  *      filename;             /*    24     8 */
[...]
}

As can be seen, the offset of the filename and subsequent fields does
not change because the new field fills an alignment hole. It would
change (resulting in a crash during boot) if the alignment-requirement
of the const char *filename field would be different.

> 
> Signed-off-by: Rickard x Andersson <rickaran@axis.com>
> ---
>  kernel/gcov/gcc_4_7.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/gcov/gcc_4_7.c b/kernel/gcov/gcc_4_7.c
> index c699feda21ac..04880d8fba25 100644
> --- a/kernel/gcov/gcc_4_7.c
> +++ b/kernel/gcov/gcc_4_7.c
> @@ -85,6 +85,7 @@ struct gcov_fn_info {
>   * @version: gcov version magic indicating the gcc version used for compilation
>   * @next: list head for a singly-linked list
>   * @stamp: uniquifying time stamp
> + * @checksum: unique object checksum
>   * @filename: name of the associated gcov data file
>   * @merge: merge functions (null for unused counter type)
>   * @n_functions: number of instrumented functions
> @@ -97,6 +98,10 @@ struct gcov_info {
>  	unsigned int version;
>  	struct gcov_info *next;
>  	unsigned int stamp;
> + /* Since GCC 12.1 a checksum field is added. */
> +#if (__GNUC__ >= 12)
> +	unsigned int checksum;
> +#endif
>  	const char *filename;
>  	void (*merge[GCOV_COUNTERS])(gcov_type *, unsigned int);
>  	unsigned int n_functions;

-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D

