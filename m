Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A7A6AC2BA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCFONJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCFOMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:12:43 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC096305D2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:10:24 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326DXf2w007100;
        Mon, 6 Mar 2023 14:09:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=c3indpg/sGES9cvcKerk+c5DowGaoIvM3MaLoRJwyJc=;
 b=FFh/7G+gAIMVnQiOp3kG7MrD5HufFYH+uyOh163glbq2y7yucdESvresmSZ80Zgb2xDv
 0cGB9eO7FyJ0CnkYqgits5HbozbmJlNFdc/AWnXCbdb0JSsHx82NWuyonPG4IgOmeHK2
 lJhjyJ7nZLy+nioL9uoV5Y7dixh6ZV0f4oUA+whnvBCxEusTbTJaFNt51EABdeJnavjl
 Go3NimpEfhcnW+C1ely9f5jw/v/wsv+kSDu/a3Ys2ACBdgWKJGBV2pG6JLRaJxCCS0rz
 reYOcs7ai9otJqCqVvqb+2FGgGD8WNWNsgQnSHKMwXyDIwh2Z3+lq3r6RdtrBoXGUGeP Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4ysdnw81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 14:09:10 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 326E37a5030003;
        Mon, 6 Mar 2023 14:09:10 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4ysdnw79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 14:09:10 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3265c9tR011404;
        Mon, 6 Mar 2023 14:09:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3p418v2836-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Mar 2023 14:09:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 326E95Vd57672076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Mar 2023 14:09:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B3C92004F;
        Mon,  6 Mar 2023 14:09:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDCDC2004D;
        Mon,  6 Mar 2023 14:09:04 +0000 (GMT)
Received: from [9.101.4.33] (unknown [9.101.4.33])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  6 Mar 2023 14:09:04 +0000 (GMT)
Message-ID: <d720d943-ea5d-451b-b8fa-ec9ad56f6dbf@linux.ibm.com>
Date:   Mon, 6 Mar 2023 15:09:04 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] powerpc/mm: fix mmap_lock bad unlock
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Sachin Sant <sachinp@linux.ibm.com>,
        Suren Baghdasaryan <surenb@google.com>
References: <20230306135520.4222-1-ldufour@linux.ibm.com>
 <7161f75e-9f40-f881-84b8-1eaaec0b0e3f@redhat.com>
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <7161f75e-9f40-f881-84b8-1eaaec0b0e3f@redhat.com>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZCAAo8REJb2cV2Ico_GTnCpjlwwTWbBY
X-Proofpoint-GUID: OQ96FBNbuO1igKID2f6Mnsb6fP9PMYyn
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_07,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 malwarescore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303060120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 15:07:26, David Hildenbrand wrote:
> On 06.03.23 14:55, Laurent Dufour wrote:
>> When page fault is tried holding the per VMA lock, bad_access_pkey() and
>> bad_access() should not be called because it is assuming the mmap_lock is
>> held.
>> In the case a bad access is detected, fall back to the default path,
>> grabbing the mmap_lock to handle the fault and report the error.
>>
>> Fixes: 169db3bb4609 ("powerc/mm: try VMA lock-based page fault handling
>> first")
>> Reported-by: Sachin Sant <sachinp@linux.ibm.com>
>> Link:
>> https://lore.kernel.org/linux-mm/842502FB-F99C-417C-9648-A37D0ECDC9CE@linux.ibm.com
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>> ---
>>   arch/powerpc/mm/fault.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index c7ae86b04b8a..e191b3ebd8d6 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -479,17 +479,13 @@ static int ___do_page_fault(struct pt_regs *regs,
>> unsigned long address,
>>         if (unlikely(access_pkey_error(is_write, is_exec,
>>                          (error_code & DSISR_KEYFAULT), vma))) {
>> -        int rc = bad_access_pkey(regs, address, vma);
>> -
>>           vma_end_read(vma);
>> -        return rc;
>> +        goto lock_mmap;
>>       }
>>         if (unlikely(access_error(is_write, is_exec, vma))) {
>> -        int rc = bad_access(regs, address);
>> -
>>           vma_end_read(vma);
>> -        return rc;
>> +        goto lock_mmap;
>>       }
>>         fault = handle_mm_fault(vma, address, flags |
>> FAULT_FLAG_VMA_LOCK, regs);
> 
> IIUC, that commit is neither upstream not in mm-stable -- it's unstable.
> Maybe raise that as a review comment in reply to the original patch, so we
> can easily connect the dots and squash it into the original, problematic
> patch that is still under review.
> 
Oh yes, I missed that. I'll reply to the Suren's thread.

Thanks,
Laurent.
