Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BD06A5621
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjB1Jui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjB1Jue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:50:34 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580A61B326
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:50:33 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S8E7fc016598;
        Tue, 28 Feb 2023 09:50:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=LcGgfoav5k5Rm47XSDD3mjaHEbaM16gUYoV09qZnmWk=;
 b=DH0WAwNQKnVYOzfyRfY69NDQjUtrw/hikH2TWLf4nIhb1+8bHdk92nOtXMdkMArJb+Zg
 /lGqaEiLm+7w3c56RTkRNdS1qlQreZjyVIYCidY/05FnZNx/sARyBwx9l4VXYYBCosqK
 Pj6nX/VTW6zqH85XaiO/jCdV5oQ3ju5UG/Bt9AFkjwO7Lo70eRmyQwZMMXNyqhepB5Va
 e2sjSdlFnmw17uucQiTwgDVm0HewpmyEyZS9eOMlSX45rWyUYXU3i5rOn0O6PddP/oJN
 C4iIGEtPOB34nMBekrkTvgKrx02Y8tcPNayOSBcXgCVfFSA08S9gktXIR5HvOPLMfS6J zQ== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3p1dwwjckv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 09:50:32 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31S9Fs7B017424;
        Tue, 28 Feb 2023 09:50:31 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3nybchc9fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 09:50:31 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31S9oTaO35324356
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 09:50:29 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BFADA5805A;
        Tue, 28 Feb 2023 09:50:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CDAF58052;
        Tue, 28 Feb 2023 09:50:29 +0000 (GMT)
Received: from [9.155.200.176] (unknown [9.155.200.176])
        by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 28 Feb 2023 09:50:28 +0000 (GMT)
Message-ID: <95f018c8-aad9-3c5a-7193-7187dd1a85e5@linux.ibm.com>
Date:   Tue, 28 Feb 2023 10:50:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/1] lib/zlib: DFLTCC deflate does not write all available
 bits for Z_NO_FLUSH
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230221131617.3369978-1-zaslonko@linux.ibm.com>
 <20230221131617.3369978-2-zaslonko@linux.ibm.com>
 <20230223125402.2d9fa0465ed62410dd5b4ed9@linux-foundation.org>
From:   Zaslonko Mikhail <zaslonko@linux.ibm.com>
In-Reply-To: <20230223125402.2d9fa0465ed62410dd5b4ed9@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PS5lvhFdEBGInzViNEEKCTt2lVrIqYJZ
X-Proofpoint-ORIG-GUID: PS5lvhFdEBGInzViNEEKCTt2lVrIqYJZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-28_06,2023-02-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 adultscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302280076
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrew,

On 23.02.2023 21:54, Andrew Morton wrote:
> On Tue, 21 Feb 2023 14:16:17 +0100 Mikhail Zaslonko <zaslonko@linux.ibm.com> wrote:
> 
>> DFLTCC deflate with Z_NO_FLUSH might generate a corrupted stream when
>> the output buffer is not large enough to fit all the deflate output at
>> once. The problem takes place on closing the deflate block since
>> flush_pending() might leave some output bits not written.
>> Similar problem for software deflate with Z_BLOCK flush option (not
>> supported by kernel zlib deflate) has been fixed a while ago in userspace
>> zlib but the fix never got to the kernel.
>> Now flush_pending() flushes the bit buffer before copying out the byte buffer,
>> in order to really flush as much as possible.
>> Currently there are no users of DFLTCC deflate with Z_NO_FLUSH option in the
>> kernel so the problem remained hidden for a while.
>>
>> This commit is based on the old zlib commit:
>> https://github.com/madler/zlib/commit/0b828b4
>>
> 
> Thanks.  Does this fix make sense when your series "lib/zlib: Set of
> s390 DFLTCC related patches for kernel zlib" is not applied?  If so
> then should we backport it in to earlier kernels?

This fix is separate and does not require a previous zlib patch series.
Although there are no users of s390 hardware deflate with Z_NO_FLUSH at the moment, 
we might still backport this fix to avoid potential issues in the future.
For all my zlib patches the following tag can be used:
  Fixes: aa5b395b69b6 ("lib/zlib: add s390 hardware support for kernel zlib_deflate")

> 
> If "no" then are you able to identify a suitable Fixes: tag?  So that
> anyone who backports the "lib/zlib: Set of s390 DFLTCC related patches
> for kernel zlib" series into an earlier kernel has a better way of
> knowing that a fixup is needed.
> 

Thanks,
Mikhail
