Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4666F017F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 09:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242755AbjD0HPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 03:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243161AbjD0HOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 03:14:23 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 909554EE4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 00:12:18 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R77AeR028416;
        Thu, 27 Apr 2023 07:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=1moAoHtil6lEu7K2DGne1pxfJDqkbBHuvXsp8jQzFYo=;
 b=ie5EFFisl+gxLHmulGXZ8eDBgcXsZ/xjlrMP11fMB3t1aET1nC/gO4NEwsRIP8P5ixSI
 yKTr+yBKfqhpiKQi8pS7IClKiAg5/2XZjQokWYJOJbr7zb5WCZACITwAeGnqH47sp26y
 UyLgYGR/0ZltB3eZ9JGY2zkBhO8GKTiit7FzyLgRHoRo6LRdejRcEblt0y2NRq0ST1f9
 btinXPrk2QBhHNVXvDQN+AklHHpJNHA3Pzg8C5ec6coLkbL5IpEzbDJmD7ygRMOWIjlE
 8/360wdNfpfldu+YGBckDquQK0CVZNKAf1R4taYlp+ECizkcNofH+g/ysz3zXhS4RUuv Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7m7rr6yp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 07:09:00 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 33R778s4028379;
        Thu, 27 Apr 2023 07:08:59 GMT
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3q7m7rr6tg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 07:08:59 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 33R487OD032104;
        Thu, 27 Apr 2023 07:08:54 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3q477729y9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 07:08:54 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 33R78p6K6488618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 07:08:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B19CC2004B;
        Thu, 27 Apr 2023 07:08:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 612A820043;
        Thu, 27 Apr 2023 07:08:46 +0000 (GMT)
Received: from [9.43.11.206] (unknown [9.43.11.206])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 27 Apr 2023 07:08:46 +0000 (GMT)
Message-ID: <2bc7d559-d827-bae9-33e0-4b7ca172ce5d@linux.ibm.com>
Date:   Thu, 27 Apr 2023 12:38:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v21 0/7] crash: Kernel handling of CPU and memory hot
 un/plug
Content-Language: en-US
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
From:   Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20230404180326.6890-1-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LjrBv1jfrpPeAR5_o7oQjwI0FVfREAjz
X-Proofpoint-GUID: YlfV2DA4ospcZQkqGsyhCpEdHhEnnNId
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_05,2023-04-26_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1011 mlxscore=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270061
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
> Once the kdump service is loaded, if changes to CPUs or memory occur,
> either by hot un/plug or off/onlining, the crash elfcorehdr must also
> be updated.
> 
> The elfcorehdr describes to kdump the CPUs and memory in the system,
> and any inaccuracies can result in a vmcore with missing CPU context
> or memory regions.
> 
> The current solution utilizes udev to initiate an unload-then-reload
> of the kdump image (eg. kernel, initrd, boot_params, purgatory and
> elfcorehdr) by the userspace kexec utility. In the original post I
> outlined the significant performance problems related to offloading
> this activity to userspace.
> 
> This patchset introduces a generic crash handler that registers with
> the CPU and memory notifiers. Upon CPU or memory changes, from either
> hot un/plug or off/onlining, this generic handler is invoked and
> performs important housekeeping, for example obtaining the appropriate
> lock, and then invokes an architecture specific handler to do the
> appropriate elfcorehdr update.
> 
> Note the description in patch 'crash: change crash_prepare_elf64_headers()
> to for_each_possible_cpu()' and 'x86/crash: optimize CPU changes' that
> enables further optimizations related to CPU plug/unplug/online/offline
> performance of elfcorehdr updates.
> 
> In the case of x86_64, the arch specific handler generates a new
> elfcorehdr, and overwrites the old one in memory; thus no involvement
> with userspace needed.
> 
> To realize the benefits/test this patchset, one must make a couple
> of minor changes to userspace:
> 
>   - Prevent udev from updating kdump crash kernel on hot un/plug changes.
>     Add the following as the first lines to the RHEL udev rule file
>     /usr/lib/udev/rules.d/98-kexec.rules:
> 
>     # The kernel updates the crash elfcorehdr for CPU and memory changes
>     SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>     SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> 
>     With this changeset applied, the two rules evaluate to false for
>     CPU and memory change events and thus skip the userspace
>     unload-then-reload of kdump.
> 
>   - Change to the kexec_file_load for loading the kdump kernel:
>     Eg. on RHEL: in /usr/bin/kdumpctl, change to:
>      standard_kexec_args="-p -d -s"
>     which adds the -s to select kexec_file_load() syscall.
> 
> This kernel patchset also supports kexec_load() with a modified kexec
> userspace utility. A working changeset to the kexec userspace utility
> is posted to the kexec-tools mailing list here:
> 
>   http://lists.infradead.org/pipermail/kexec/2022-October/026032.html

With the in-kernel update, the size is anyway getting calculated in
kernel for kexec_file_load case, how about passing the recommended size
for elfcorehdr segment and any other segment that needs an in-kernel 
update as a sysfs attribute instead of kexec-tools having to do the
calculation again in the userspace  (get_elfcorehdrsz()) for kexec_load
case. That makes segment size calculation less error prone.

Thanks
Hari
