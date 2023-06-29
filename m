Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D63742F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjF2U7V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 16:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231778AbjF2U7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:59:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46752194;
        Thu, 29 Jun 2023 13:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=71PV5aDwVtaV5fStzwHqmQJIJQPeReGlo36D/hVKmtE=; b=Jy12NeGE/o5x85OdUwJQdskavi
        wtIjLdGJ2u5VC7DaMEQycOW7YpZpqLGbeX4R2MbVAWilTyTj8TOBn0Zkg+cnfFDTmLeyxbiEcwgKO
        kNAwO/9cI0b/BJBg6V7coiRB7uPie/Pmp7/C+AeQ1quBuE3BAmQvmqj63mffkFK7qcejMasYkEyLu
        xjEsRTQYdw+zJOgV6gKwwkHdtJpoRjAI1cVASrkRxevC7mbpGmCsN5TnmNRgV9yN4jvcUHTi3FTDC
        joZPT9V9RRJex3ow7X2g8DKMCwb6LCX/XOnnwVyhvWQEnr+GA1qRSdWY3t6nw7EyGPaViHRKZ/Awx
        mkdWekWA==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qEyjL-002AFE-2A;
        Thu, 29 Jun 2023 20:59:07 +0000
Message-ID: <c9d4e623-5c8c-885f-4343-980798647a0a@infradead.org>
Date:   Thu, 29 Jun 2023 13:59:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v25 06/10] crash: memory and CPU hotplug sysfs attributes
Content-Language: en-US
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
References: <20230629192119.6613-1-eric.devolder@oracle.com>
 <20230629192119.6613-7-eric.devolder@oracle.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230629192119.6613-7-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 6/29/23 12:21, Eric DeVolder wrote:
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  Documentation/ABI/testing/sysfs-devices-memory |  8 ++++++++
>  .../ABI/testing/sysfs-devices-system-cpu       |  8 ++++++++
>  .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
>  Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
>  drivers/base/cpu.c                             | 16 ++++++++++++++--
>  drivers/base/memory.c                          | 13 +++++++++++++
>  include/linux/kexec.h                          |  8 ++++++++
>  7 files changed, 77 insertions(+), 2 deletions(-)
> 

> diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
> index 1b02fe5807cc..eb99d79223a3 100644
> --- a/Documentation/admin-guide/mm/memory-hotplug.rst
> +++ b/Documentation/admin-guide/mm/memory-hotplug.rst
> @@ -291,6 +291,14 @@ The following files are currently defined:
>  		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
>  		       kernel configuration option.
>  ``uevent``	       read-write: generic udev file for device subsystems.
> +``crash_hotplug``      read-only: when changes to the system memory map
> +		       occur due to hot un/plug of memory, this file contains
> +		       '1' if the kernel updates the kdump capture kernel memory
> +		       map itself (via elfcorehdr), or '0' if userspace must update
> +		       the kdump capture kernel memory map.
> +
> +		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
> +		       configuration option.
>  ====================== =========================================================

Did you test build the documentation?
It looks to me like the end-of-table '=' signs line needs 3 more === to be long
enough for the text above it.

>  
>  .. note::
> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
> index e6f5bc39cf5c..54581c501562 100644
> --- a/Documentation/core-api/cpu_hotplug.rst
> +++ b/Documentation/core-api/cpu_hotplug.rst
> @@ -741,6 +741,24 @@ will receive all events. A script like::
>  
>  can process the event further.
>  
> +When changes to the CPUs in the system occur, the sysfs file
> +/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
> +updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
> +or '0' if userspace must update the kdump capture kernel list of CPUs.
> +
> +The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
> +option.
> +
> +To skip userspace processing of CPU hot un/plug events for kdump
> +(ie the unload-then-reload to obtain a current list of CPUs), this sysfs

    i.e.

> +file can be used in a udev rule as follows:
> +
> + SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> +
> +For a cpu hot un/plug event, if the architecture supports kernel updates

         CPU
for consistency

> +of the elfcorehdr (which contains the list of CPUs), then the rule skips
> +the unload-then-reload of the kdump capture kernel.
> +
>  Kernel Inline Documentations Reference
>  ======================================
>  

Thanks.
-- 
~Randy
