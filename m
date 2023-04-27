Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3DF6F0237
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbjD0IBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242868AbjD0IBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:01:14 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4089B2683
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 01:01:13 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R79nvh026940;
        Thu, 27 Apr 2023 07:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5BRldYvrmsuQSj/Fu/SNvXBBIZ/xH4BOurNrfYX1+ZY=;
 b=dhJMglXyHSYAhxEu8JRPAapWwP0EKuIpdgQu5R3iEAm4W3XbYI9TLFFFlBsUGqQxjMHU
 KjVQviBbyOynG2tRJGXfi34DJOdk0TOzEu+XVOV5kcUEg44KpH5JDbpnlT7qbhG8GyRw
 FA0ecdHkzdfes3rmzsMA5cq+Cxm6mOL70Dd+GlrLKqI3kUG3hofVrZS/LBm77DHZFC0b
 KJ33t8a0K2L92uGMkLmFkM90e32KCcSu+NQkm5kKKgv83azYMtf6f+OqUxJA++tE7DyZ
 6hOiTqKlhc7RzTkac5J2vegC+E0FC+8jRc78ICzj0v47KGaqTXgoD8do+ke4rZCSXMBk 5w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7junapsx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 07:21:21 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R7AIj6029628;
        Thu, 27 Apr 2023 07:21:21 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7junaps2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 07:21:21 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33R2sFW7019058;
        Thu, 27 Apr 2023 07:09:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3q47772sea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 07:09:12 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33R79AkQ26607936
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 07:09:10 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5912A20043;
        Thu, 27 Apr 2023 07:09:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98C6420040;
        Thu, 27 Apr 2023 07:09:04 +0000 (GMT)
Received: from [9.43.11.206] (unknown [9.43.11.206])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 27 Apr 2023 07:09:04 +0000 (GMT)
Message-ID: <da95e01d-24bd-676b-3a48-bafda1b36cda@linux.ibm.com>
Date:   Thu, 27 Apr 2023 12:39:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v21 5/7] x86/crash: add x86 crash hotplug support
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230404180326.6890-1-eric.devolder@oracle.com>
 <20230404180326.6890-6-eric.devolder@oracle.com>
Content-Language: en-US
From:   Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20230404180326.6890-6-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ebNw7G5EhX-7w9QhN3IkPzfUN3fFOYpe
X-Proofpoint-ORIG-GUID: 42rGyw8kGrqEoMDRFpI6EpqPzroqZIRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_05,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304270061
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On 04/04/23 11:33 pm, Eric DeVolder wrote:
> When CPU or memory is hot un/plugged, or off/onlined, the crash
> elfcorehdr, which describes the CPUs and memory in the system,
> must also be updated.
> 
> The segment containing the elfcorehdr is identified at run-time
> in crash_core:crash_handle_hotplug_event(), which works for both
> the kexec_load() and kexec_file_load() syscalls. A new elfcorehdr
> is generated from the available CPUs and memory into a buffer,
> and then installed over the top of the existing elfcorehdr.
> 
> In the patch 'kexec: exclude elfcorehdr from the segment digest'
> the need to update purgatory due to the change in elfcorehdr was
> eliminated.  As a result, no changes to purgatory or boot_params
> (as the elfcorehdr= kernel command line parameter pointer
> remains unchanged and correct) are needed, just elfcorehdr.
> 
> To accommodate a growing number of resources via hotplug, the
> elfcorehdr segment must be sufficiently large enough to accommodate
> changes, see the CRASH_MAX_MEMORY_RANGES description. This is used
> only on the kexec_file_load() syscall; for kexec_load() userspace
> will need to size the segment similarly.
> 
> To accommodate kexec_load() syscall in the absence of

Firstly, thanks! This series is a nice improvement to kdump support
in hotplug environment.

One concern though is that this change assumes corresponding support
in kexec-tools. Without that support kexec_load would fail to boot
with digest verification failure, iiuc.

I would suggest a flag to advertise to the kernel that kexec-tools/
userspace wants in-kernel update. Something like KEXEC_IN_KERNEL_UPDATE
on top of existing flags like KEXEC_ON_CRASH & KEXEC_PRESERVE_CONTEXT.
This flag can be used to decide whether in-kernel update needs to be
enforced or not. That should make transition to this change smoother
without having to break userspace.

Thanks
Hari
