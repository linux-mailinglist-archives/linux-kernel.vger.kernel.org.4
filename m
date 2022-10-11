Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339E25FB476
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiJKOWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiJKOWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293E91D67E;
        Tue, 11 Oct 2022 07:22:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A59FC6119E;
        Tue, 11 Oct 2022 14:22:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE813C433D6;
        Tue, 11 Oct 2022 14:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665498127;
        bh=UnTADQlb1c9sMBi6JfkWaS5g/Z+SghRtz6zwEjj/c/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MGtgzeVxQqEOw4QNbLspA4olIz6C7JwyqfbtZxRJG0BUivMG16gJ62068dBmONy06
         xjPvGfwZzKd7CZSQiTMwGdaxoVjWfnViwMCrzKYDxqIOJ6SdcQtb7dlT2TLcDvKBuw
         sdk7vi8CEpz6qoQUHjH94ASMTO2htEn4G9bNy84g=
Date:   Tue, 11 Oct 2022 16:22:50 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, linux-api@vger.kernel.org,
        f.fainelli@gmail.com
Subject: Re: [PATCH v6] MIPS: Expose prid and globalnumber to sysfs
Message-ID: <Y0V8OlvdqADjCS9I@kroah.com>
References: <20221011110951.93404-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011110951.93404-1-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 12:09:51PM +0100, Jiaxun Yang wrote:
> Some application would like to know precise model and rev of processor
> to do errata workaround or optimization.
> 
> Expose them in sysfs as:
> /sys/devices/system/cpu/cpuX/regs/identification/prid
> /sys/devices/system/cpu/cpuX/regs/identification/globalnumber
> 
> Reusing AArch64 CPU registers directory.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Drop static qualifier for kobj (gregkh)
> v3: Use kzalloc to allocate struct cpuregs.
>     note: When Greg mentioned about static I was thinking about
>     static qualifier of percpu variable. After reading documents
>     again it turns out kobjs should be allocated at runtime. Arm64's
>     cpuinfo kobj is also on a percpu variable... I guess that was a
>     intentional use?
> v4: Properly handle err of kobj creation. (gregkh)
> v5: Drop invalid kfree
> v6: Correct offline routine, use kobject_put
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      |  9 ++
>  arch/mips/kernel/topology.c                   | 97 +++++++++++++++++++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 5bf61881f012..9dea45ad5a22 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -512,6 +512,15 @@ Description:	information about CPUs heterogeneity.
>  
>  		cpu_capacity: capacity of cpuX.
>  
> +What:		/sys/devices/system/cpu/cpuX/regs/identification/prid
> +		/sys/devices/system/cpu/cpuX/regs/identification/globalnumber
> +Date:		October 2022
> +Contact:	Linux MIPS Kernel Mailing list <linux-mips@vger.kernel.org>
> +Description:	MIPS CPU registers
> +
> +		'identification' directory exposes the Processor ID and Global Number
> +		registers for identifying model and revision of the CPU.
> +
>  What:		/sys/devices/system/cpu/vulnerabilities
>  		/sys/devices/system/cpu/vulnerabilities/meltdown
>  		/sys/devices/system/cpu/vulnerabilities/spectre_v1
> diff --git a/arch/mips/kernel/topology.c b/arch/mips/kernel/topology.c
> index 9429d85a4703..85588ffd6bac 100644
> --- a/arch/mips/kernel/topology.c
> +++ b/arch/mips/kernel/topology.c
> @@ -5,6 +5,8 @@
>  #include <linux/node.h>
>  #include <linux/nodemask.h>
>  #include <linux/percpu.h>
> +#include <linux/seq_file.h>
> +#include <linux/smp.h>
>  
>  static DEFINE_PER_CPU(struct cpu, cpu_devices);
>  
> @@ -26,3 +28,98 @@ static int __init topology_init(void)
>  }
>  
>  subsys_initcall(topology_init);
> +
> +static struct kobj_type cpuregs_kobj_type = {
> +	.sysfs_ops = &kobj_sysfs_ops,
> +};
> +
> +struct cpureg {
> +	struct kobject kobj;
> +	struct cpuinfo_mips *info;
> +};
> +static DEFINE_PER_CPU(struct cpureg *, cpuregs);
> +
> +#define kobj_to_cpureg(kobj)	container_of(kobj, struct cpureg, kobj)
> +#define CPUREGS_ATTR_RO(_name, _field)						\
> +	static ssize_t _name##_show(struct kobject *kobj,			\
> +			struct kobj_attribute *attr, char *buf)			\
> +	{									\
> +		struct cpuinfo_mips *info = kobj_to_cpureg(kobj)->info;		\
> +										\
> +		return sysfs_emit(buf, "0x%08x\n", info->_field);	\
> +	}									\
> +	static struct kobj_attribute cpuregs_attr_##_name = __ATTR_RO(_name)
> +
> +CPUREGS_ATTR_RO(prid, processor_id);
> +CPUREGS_ATTR_RO(globalnumber, globalnumber);
> +
> +static struct attribute *cpuregs_id_attrs[] = {
> +	&cpuregs_attr_prid.attr,
> +	&cpuregs_attr_globalnumber.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group cpuregs_attr_group = {
> +	.attrs = cpuregs_id_attrs,
> +	.name = "identification"
> +};
> +
> +static int cpuregs_cpu_online(unsigned int cpu)
> +{
> +	int rc;
> +	struct device *dev;
> +	struct cpureg *reg;
> +
> +	dev = get_cpu_device(cpu);
> +	if (!dev) {
> +		rc = -ENODEV;
> +		goto out;
> +	}
> +	reg = kzalloc(sizeof(struct cpureg), GFP_KERNEL);
> +	if (!reg) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +	reg->info = &cpu_data[cpu];
> +
> +	rc = kobject_init_and_add(&reg->kobj, &cpuregs_kobj_type,
> +					&dev->kobj, "regs");
> +	if (rc)
> +		goto out_kobj;
> +	rc = sysfs_create_group(&reg->kobj, &cpuregs_attr_group);
> +	if (rc)
> +		goto out_kobj;
> +
> +	return 0;
> +out_kobj:
> +	kobject_put(&reg->kobj);
> +out:
> +	return rc;
> +}
> +
> +static int cpuregs_cpu_offline(unsigned int cpu)
> +{
> +	struct cpureg *reg = per_cpu(cpuregs, cpu);
> +
> +	if (!reg)
> +		return -ENODEV;
> +	sysfs_remove_group(&reg->kobj, &cpuregs_attr_group);
> +	kobject_put(&reg->kobj);

You did not test this code :(

Please do so, and also exercise the cpu-remove path and fix up all the
errors that happen there.

thanks,

greg k-h
