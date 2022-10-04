Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD945F3CD1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 08:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJDGjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 02:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiJDGjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 02:39:00 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165592A96D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 23:38:58 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2946PVB4010931;
        Tue, 4 Oct 2022 06:38:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=4eQdKxYv6CFPpwGd2E6nDue75ks9Qq+xsAsqlVfZibM=;
 b=ZAKoQILNOOUEFAV75yyb2fxl1vqEQimqUzFnHL+7dB3+6mI7iKVB3a7qXfAQrfvgBGFJ
 meAjFKy+pr4tUgHeLfUKKLH1uWxAjN2cRcSSzQZC/vj3NZCecjA5wp2CpnuG7zEKJBuK
 aLSiJoa7nmWcuh7amXn27bdVnduBvLubx6mHvtCTUbSLtRNrgskH21GguIUEVQBAARBz
 5Zgi7AiVM+SqFHnxfl2gsoplU1YGy4dHcUmY36+vo/S2WNM11KmASbwGMF5WbVYHHmzc
 fe0ZzP9/UB5jMyXRf+sKXdQ4mLK/HJOu9HPGMJjian0sbandvp3rFqMNRuVptTMTUDd/ ow== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0fj5rb38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 06:38:22 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2946PUgi010923;
        Tue, 4 Oct 2022 06:38:21 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3k0fj5rb2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 06:38:21 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2946a86w029260;
        Tue, 4 Oct 2022 06:38:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3jxd693pxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 04 Oct 2022 06:38:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2946ckiR50659762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 4 Oct 2022 06:38:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5AD75A4054;
        Tue,  4 Oct 2022 06:38:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DE6C9A405B;
        Tue,  4 Oct 2022 06:38:12 +0000 (GMT)
Received: from [9.43.62.42] (unknown [9.43.62.42])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  4 Oct 2022 06:38:12 +0000 (GMT)
Message-ID: <1a07c461-67e8-8f0d-756d-ef96fa4a9b91@linux.ibm.com>
Date:   Tue, 4 Oct 2022 12:08:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v12 3/7] crash: add generic infrastructure for crash
 hotplug support
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20220909210509.6286-1-eric.devolder@oracle.com>
 <20220909210509.6286-4-eric.devolder@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20220909210509.6286-4-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wipsn-qfOuJvUfOSXojz_Qlfaq5bzFti
X-Proofpoint-GUID: q5K-hzptsQMrEM76xtVuh2S2JGYW5TFo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_02,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210040041
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/09/22 02:35, Eric DeVolder wrote:
> CPU and memory change notifications are received in order to
> regenerate the elfcorehdr.
>
> To support cpu hotplug, a callback is registered to capture the
> CPUHP_AP_ONLINE_DYN online and offline events via
> cpuhp_setup_state_nocalls().
>
> To support memory hotplug, a notifier is registered to capture the
> MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().
>
> The cpu callback and memory notifiers call handle_hotplug_event()
> which performs needed tasks and then dispatches the event to the
> architecture specific arch_crash_handle_hotplug_event(). During the
> process, the kexec_mutex is held.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>   include/linux/crash_core.h |   8 +++
>   include/linux/kexec.h      |  26 +++++++
>   kernel/crash_core.c        | 134 +++++++++++++++++++++++++++++++++++++
>   3 files changed, 168 insertions(+)
>
> diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
> index de62a722431e..a270f8660538 100644
> --- a/include/linux/crash_core.h
> +++ b/include/linux/crash_core.h
> @@ -84,4 +84,12 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
>   int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
>   		unsigned long long *crash_size, unsigned long long *crash_base);
>   
> +#define KEXEC_CRASH_HP_REMOVE_CPU		0
> +#define KEXEC_CRASH_HP_ADD_CPU			1
> +#define KEXEC_CRASH_HP_REMOVE_MEMORY		2
> +#define KEXEC_CRASH_HP_ADD_MEMORY		3
> +#define KEXEC_CRASH_HP_INVALID_CPU		-1U
> +
> +struct kimage;
> +
>   #endif /* LINUX_CRASH_CORE_H */
> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
> index 4eefa631e0ae..9597b41136ec 100644
> --- a/include/linux/kexec.h
> +++ b/include/linux/kexec.h
> @@ -374,6 +374,13 @@ struct kimage {
>   	struct purgatory_info purgatory_info;
>   #endif
>   
> +#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
> +	bool hotplug_event;
> +	unsigned int offlinecpu;
> +	bool elfcorehdr_index_valid;
> +	int elfcorehdr_index;

Do we really need elfcorehdr_index_valid to decide elfcorehdr_index 
holds a valid index?

How about initializing elfcorehdr_index to a negative number while 
loading kdump kernel (or kexec kernel if needed)
for both kexec_load and kexec_file_load case and consider that as 
invalid index to find the correct one.

Some thing like this:

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 5bc5159d9cb1..0cccdb2f7f26 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -656,7 +656,7 @@ static void handle_hotplug_event(unsigned int 
hp_action, unsigned int cpu)
                  * segment containing the elfcorehdr, if not already found.
                  * This works for both the kexec_load and 
kexec_file_load paths.
                  */
-               if (!image->elfcorehdr_index_valid) {
+               if (image->elfcorehdr_index < 0) {
                         unsigned char *ptr;
                         unsigned long mem, memsz;
                         unsigned int n;
diff --git a/kernel/kexec.c b/kernel/kexec.c
index b5e40f069768..ed1c6a88879b 100644
--- a/kernel/kexec.c
+++ b/kernel/kexec.c
@@ -156,6 +156,10 @@ static int do_kexec_load(unsigned long entry, 
unsigned long nr_segments,
         if (ret)
                 goto out;

+       /* Below check is not necessary */
+       if (flags & KEXEC_FILE_ON_CRASH)
+               image->elfcorehdr_index = -1;
+
         /* Install the new kernel and uninstall the old */
         image = xchg(dest_image, image);

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index d0c2661b3509..535dbc26930a 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -400,6 +400,10 @@ SYSCALL_DEFINE5(kexec_file_load, int, kernel_fd, 
int, initrd_fd,
         if (ret)
                 goto out;

+       /* Below check is not necessary */
+       if (flags & KEXEC_FILE_ON_CRASH)
+               image->elfcorehdr_index = -1;
+
         /*
          * Free up any temporary buffers allocated which are not needed
          * after image has been loaded

Thanks,
Sourabh Jain

