Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C12F697490
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 03:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbjBOCxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 21:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjBOCxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 21:53:38 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E8F2B639
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 18:53:37 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31F1gCOT013853;
        Wed, 15 Feb 2023 02:53:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Exgxn0AYVPDxRYZks80xT9MtkCEQSRrBSvU9sNrFG28=;
 b=rEiTbULsEJYQrx14lrnXV7hD9U6egDiMPFWaEa4d2d1WmWaX5Qb8vmWuh2gx+rxy0xOH
 Zy1xaarMSn1lr5yI5hPfZI+dcHwf1XLmaKGgLhtEGckTCMSRZHD/TRnp9d2ABwqAXTqr
 OtEWvamYggW4mwHYewjovnASdIFekrmOCmZebE6WvzEgYmVfNqdKO+xZWCnbwEfTMV0F
 mJNA7lFH8v+iX+xkmQfxGUxfwTBVhmGRFeEScfHtlkIPxB6MZvzvAlCxM0ZwZGPGg81P
 UtlNsaa0tTP0pSxZAGTDnKwDgYJ/LDzEOuLttydWUq6JN/21BPqywjeNa3svklPM6f6z Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrny0hgt2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 02:53:17 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31F2hLmj027776;
        Wed, 15 Feb 2023 02:53:16 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrny0hgs8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 02:53:16 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31E7UAFA007931;
        Wed, 15 Feb 2023 02:53:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3np2n6bhpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 02:53:13 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31F2rBjp24052426
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Feb 2023 02:53:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E784720049;
        Wed, 15 Feb 2023 02:53:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF00320043;
        Wed, 15 Feb 2023 02:53:06 +0000 (GMT)
Received: from [9.43.21.73] (unknown [9.43.21.73])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 15 Feb 2023 02:53:06 +0000 (GMT)
Message-ID: <4b22740d-6cd4-2485-7a26-c73c8bb6be27@linux.ibm.com>
Date:   Wed, 15 Feb 2023 08:23:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v18 5/7] kexec: exclude hot remove cpu from elfcorehdr
 notes
To:     Eric DeVolder <eric.devolder@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230131224236.122805-1-eric.devolder@oracle.com>
 <20230131224236.122805-6-eric.devolder@oracle.com> <87sffpzkle.ffs@tglx>
 <dd03f47a-0017-6239-04e9-e796dca03c0c@oracle.com> <87h6vw2rwf.ffs@tglx>
 <7580421a-648a-2c4b-3c33-82e7622d9585@oracle.com>
 <d465173e-a31a-c4d6-af51-59d9ff0c2edc@linux.ibm.com>
 <24034f33-739b-e5f5-40c0-8d5abeb1ad89@oracle.com>
 <18c57fd0-2ad0-361a-9a53-ac49c372f021@linux.ibm.com>
 <b3d5c730-60ee-8f1c-978c-e3df41e3a3f1@oracle.com>
 <f7c0269b-05e7-c706-f111-c768d4a13b72@linux.ibm.com> <87ttzpzpzx.ffs@tglx>
Content-Language: en-US
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <87ttzpzpzx.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CLg_oi2szPZcFT6u2gma6lTr1KgQeZlV
X-Proofpoint-GUID: VUkDzequ_XNonaN8X033IYNY-j6xIXOH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_17,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150022
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/02/23 18:22, Thomas Gleixner wrote:
> On Mon, Feb 13 2023 at 10:10, Sourabh Jain wrote:
>> The sysconf document says _SC_NPROCESSORS_CONF is processors configured,
>> isn't that equivalent to possible CPUs?
> glibc tries to evaluate that in the following order:
>
>    1) /sys/devices/system/cpu/cpu*
>
>       That's present CPUs not possible CPUs
>
>    2) /proc/stat
>
>       That's online CPUs
>
>    3) sched_getaffinity()
>
>       That's online CPUs at best. In the worst case it's an affinity mask
>       which is set on a process group

Thanks for the clarification Thomas.

- Sourabh
