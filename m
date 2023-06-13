Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE8572DBF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbjFMIEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233941AbjFMID4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:03:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9D419BC;
        Tue, 13 Jun 2023 01:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B35C61446;
        Tue, 13 Jun 2023 08:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561C1C433D2;
        Tue, 13 Jun 2023 08:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686643433;
        bh=IbqKvRQt5VBDRTYPdOQS+ty2cQ4CTJhQibclditk/S4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vDh0uSUnLpyrWDbMMeUrvD9Zd8MJfQhw3KEV+S69h2EgvKzcPDYAV3hc5nhjKH1c7
         k05EfIr0CtBiPudnzfw98Q2JOb36RI8DDk0N2ulQk7RGZETZaccHuqtdYWD+ptX5Su
         K+s8HB5VkOFmXzGCMkF9DsaPyuO2fn7/uHW239tc=
Date:   Tue, 13 Jun 2023 10:03:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Eric DeVolder <eric.devolder@oracle.com>
Cc:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org, hpa@zytor.com,
        rafael@kernel.org, vgoyal@redhat.com, dyoung@redhat.com,
        lf32.dev@gmail.com, akpm@linux-foundation.org,
        naveen.n.rao@linux.vnet.ibm.com, zohar@linux.ibm.com,
        bhelgaas@google.com, vbabka@suse.cz, tiwai@suse.de,
        seanjc@google.com, linux@weissschuh.net, vschneid@redhat.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com
Subject: Re: [PATCH v23 4/8] crash: memory and CPU hotplug sysfs attributes
Message-ID: <2023061320-vindicate-usual-6643@gregkh>
References: <20230612210712.683175-1-eric.devolder@oracle.com>
 <20230612210712.683175-5-eric.devolder@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612210712.683175-5-eric.devolder@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 05:07:08PM -0400, Eric DeVolder wrote:
> Introduce the crash_hotplug attribute for memory and CPUs for
> use by userspace.  These attributes directly facilitate the udev
> rule for managing userspace re-loading of the crash kernel upon
> hot un/plug changes.
> 
> For memory, expose the crash_hotplug attribute to the
> /sys/devices/system/memory directory. For example:
> 
>  # udevadm info --attribute-walk /sys/devices/system/memory/memory81
>   looking at device '/devices/system/memory/memory81':
>     KERNEL=="memory81"
>     SUBSYSTEM=="memory"
>     DRIVER==""
>     ATTR{online}=="1"
>     ATTR{phys_device}=="0"
>     ATTR{phys_index}=="00000051"
>     ATTR{removable}=="1"
>     ATTR{state}=="online"
>     ATTR{valid_zones}=="Movable"
> 
>   looking at parent device '/devices/system/memory':
>     KERNELS=="memory"
>     SUBSYSTEMS==""
>     DRIVERS==""
>     ATTRS{auto_online_blocks}=="offline"
>     ATTRS{block_size_bytes}=="8000000"
>     ATTRS{crash_hotplug}=="1"
> 
> For CPUs, expose the crash_hotplug attribute to the
> /sys/devices/system/cpu directory. For example:
> 
>  # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
>   looking at device '/devices/system/cpu/cpu0':
>     KERNEL=="cpu0"
>     SUBSYSTEM=="cpu"
>     DRIVER=="processor"
>     ATTR{crash_notes}=="277c38600"
>     ATTR{crash_notes_size}=="368"
>     ATTR{online}=="1"
> 
>   looking at parent device '/devices/system/cpu':
>     KERNELS=="cpu"
>     SUBSYSTEMS==""
>     DRIVERS==""
>     ATTRS{crash_hotplug}=="1"
>     ATTRS{isolated}==""
>     ATTRS{kernel_max}=="8191"
>     ATTRS{nohz_full}=="  (null)"
>     ATTRS{offline}=="4-7"
>     ATTRS{online}=="0-3"
>     ATTRS{possible}=="0-7"
>     ATTRS{present}=="0-3"
> 
> With these sysfs attributes in place, it is possible to efficiently
> instruct the udev rule to skip crash kernel reloading for kernels
> configured with crash hotplug support.
> 
> For example, the following is the proposed udev rule change for RHEL
> system 98-kexec.rules (as the first lines of the rule file):
> 
>  # The kernel updates the crash elfcorehdr for CPU and memory changes
>  SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
>  SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> 
> When examined in the context of 98-kexec.rules, the above rules
> test if crash_hotplug is set, and if so, the userspace initiated
> unload-then-reload of the crash kernel is skipped.
> 
> CPU and memory checks are separated in accordance with
> CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
> If an architecture supports, for example, memory hotplug but not
> CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
> attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
> attribute file will NOT be present. Thus the udev rule skips
> userspace processing of memory hot un/plug events, but the udev
> rule will evaluate false for CPU events, thus allowing userspace to
> process CPU hot un/plug events (ie the unload-then-reload of the kdump
> capture kernel).
> 
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
> Acked-by: Baoquan He <bhe@redhat.com>
> ---
>  .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
>  Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
>  drivers/base/cpu.c                             | 14 ++++++++++++++
>  drivers/base/memory.c                          | 13 +++++++++++++
>  include/linux/kexec.h                          |  8 ++++++++
>  5 files changed, 61 insertions(+)
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
>  
>  .. note::
> diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
> index f75778d37488..0c8dc3fe5f94 100644
> --- a/Documentation/core-api/cpu_hotplug.rst
> +++ b/Documentation/core-api/cpu_hotplug.rst
> @@ -750,6 +750,24 @@ will receive all events. A script like::
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
> +file can be used in a udev rule as follows:
> +
> + SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
> +
> +For a cpu hot un/plug event, if the architecture supports kernel updates
> +of the elfcorehdr (which contains the list of CPUs), then the rule skips
> +the unload-then-reload of the kdump capture kernel.
> +
>  Kernel Inline Documentations Reference
>  ======================================
>  
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index c1815b9dae68..06a0c22b37b8 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -282,6 +282,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
>  static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
>  #endif
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +#include <linux/kexec.h>
> +static ssize_t crash_hotplug_show(struct device *dev,
> +				     struct device_attribute *attr,
> +				     char *buf)
> +{
> +	return sprintf(buf, "%d\n", crash_hotplug_cpu_support());
> +}
> +static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
> +#endif
> +
>  static void cpu_device_release(struct device *dev)
>  {
>  	/*
> @@ -469,6 +480,9 @@ static struct attribute *cpu_root_attrs[] = {
>  #ifdef CONFIG_NO_HZ_FULL
>  	&dev_attr_nohz_full.attr,
>  #endif
> +#ifdef CONFIG_HOTPLUG_CPU
> +	&dev_attr_crash_hotplug.attr,
> +#endif
>  #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
>  	&dev_attr_modalias.attr,
>  #endif
> diff --git a/drivers/base/memory.c b/drivers/base/memory.c
> index b456ac213610..24b8ef4c830c 100644
> --- a/drivers/base/memory.c
> +++ b/drivers/base/memory.c
> @@ -490,6 +490,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
>  
>  static DEVICE_ATTR_RW(auto_online_blocks);
>  
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +#include <linux/kexec.h>
> +static ssize_t crash_hotplug_show(struct device *dev,
> +				       struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%d\n", crash_hotplug_memory_support());
> +}

This sysfs file has to be documented in Documentation/ABI/ right?

And did you use checkpatch?  It should have told you to use sysfs_emit()
instead...

> +static DEVICE_ATTR_RO(crash_hotplug);
> +#endif

All of these #ifdefs should all be removed and instead use the
is_visible() callback to determine if the attribute is shown or not,
using the IS_ENABLED() test in the function.

thanks,

greg k-h
