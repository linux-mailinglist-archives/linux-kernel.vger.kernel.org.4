Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43F4689B49
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:15:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjBCOOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:14:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbjBCOOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:14:32 -0500
Received: from vsp01-out.oderland.com (vsp01-out.oderland.com [IPv6:2a02:28f0::24:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5885C7AB2
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:13:41 -0800 (PST)
X-Scanned-Cookie: f500bda16b244583931b552d2d35209f2e653c44
Received: from office.oderland.com (office.oderland.com [91.201.60.5])
        by vsp-out.oderland.com (Halon) with ESMTPSA
        id c5c667fc-a3ca-11ed-988b-13c61387685f;
        Fri, 03 Feb 2023 14:58:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=oderland.se
        ; s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0vnqyLQjLM8vIxF5gJPRlxfMok/MJsZ2QdrgPNLap6A=; b=aAPvWYDchoFfYjna1mfsZ6jyzK
        cI6Dyni4w4oCB0PaIj9A2cpbKDveCoTAg5bDP0iU3yusuhhT2Oi0luM1iVAb30AeJmPC+v4ja5uJ3
        1OBQg6L4q9G6cMsBVX17Ng1wAOvLVRJRz2Ffb9DA5Ez/Jt8uL6+SvmbJ6HXVlm5vFNYcdeNa4kqZu
        X7CuhssKOrDKqUH0v4NVGr42ENlJ7wwgZ1upz3ydYa3/8wld/2Z9a03IX6CTPmsgjuiWE8A8DCq8h
        hWPD5uEUWEeolZ5xzaaR+/eQanWZ+jlMV9quhwKtAK6SROlPEnye7Try6AyyqOboYARa9UJFkUX4g
        l34Ro1XA==;
Received: from 160.193-180-18.r.oderland.com ([193.180.18.160]:42860 helo=[10.137.0.14])
        by office.oderland.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <josef@oderland.se>)
        id 1pNwZq-0040K8-9P;
        Fri, 03 Feb 2023 14:58:01 +0100
Message-ID: <06e6cefb-c773-d959-d569-84dd63e240e1@oderland.se>
Date:   Fri, 3 Feb 2023 14:58:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:108.0) Gecko/20100101
 Thunderbird/108.0
Subject: Re: [PATCH 1/3] acpi/processor: fix evaluating _PDC method when
 running as Xen dom0
To:     Jan Beulich <jbeulich@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-acpi@vger.kernel.org, Roger Pau Monne <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org
References: <20221121102113.41893-1-roger.pau@citrix.com>
 <20221121102113.41893-2-roger.pau@citrix.com>
 <952fdc14-a8e5-a59a-9c7d-af1adf361d77@oderland.se>
 <513e2851-9098-b510-588e-1e68d44d23fc@suse.com>
Content-Language: en-US
From:   Josef Johansson <josef@oderland.se>
In-Reply-To: <513e2851-9098-b510-588e-1e68d44d23fc@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
x-oderland-domain-valid: yes
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/3/23 08:05, Jan Beulich wrote:
> On 30.01.2023 10:21, Josef Johansson wrote:
>> On 11/21/22 11:21, Roger Pau Monne wrote:
>>> --- a/arch/x86/xen/enlighten.c
>>> +++ b/arch/x86/xen/enlighten.c
>>> @@ -346,3 +346,30 @@ void xen_arch_unregister_cpu(int num)
>>>    }
>>>    EXPORT_SYMBOL(xen_arch_unregister_cpu);
>>>    #endif
>>> +
>>> +#ifdef CONFIG_XEN_DOM0
>>> +bool __init xen_processor_present(uint32_t acpi_id)
>>> +{
>>> +	unsigned int i, maxid;
>>> +	struct xen_platform_op op = {
>>> +		.cmd = XENPF_get_cpuinfo,
>>> +		.interface_version = XENPF_INTERFACE_VERSION,
>>> +	};
>>> +	int ret = HYPERVISOR_platform_op(&op);
>>> +
>>> +	if (ret)
>>> +		return false;
>>> +
>>> +	maxid = op.u.pcpu_info.max_present;
>>> +	for (i = 0; i <= maxid; i++) {
>>> +		op.u.pcpu_info.xen_cpuid = i;
>>> +		ret = HYPERVISOR_platform_op(&op);
>>> +		if (ret)
>>> +			continue;
>>> +		if (op.u.pcpu_info.acpi_id == acpi_id)
>>> +			return op.u.pcpu_info.flags & XEN_PCPU_FLAGS_ONLINE;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>> My compiler (Default GCC on Fedora 32, compiling for Qubes) complain
>> loudly that the below was missing.
>>
>> +}
>> +EXPORT_SYMBOL(xen_processor_present);
>>
>> `ERROR: MODPOST xen_processor_present
>> [drivers/xen/xen-acpi-processor.ko] undefined!`
>>
>> Same thing with xen_sanitize_pdc in the next patch.
>>
>> +}
>> +EXPORT_SYMBOL(xen_sanitize_pdc);
>>
>> Everything compiled fine after those changes.
> Except that you may not export __init symbols. The section mismatch checker
> should actually complain about that.
>
> Jan

That makes sense. Patch 3 does change it from an __init though.

diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
index 394dd6675113..a7b41103d3e5 100644
--- a/arch/x86/xen/enlighten.c
+++ b/arch/x86/xen/enlighten.c
@@ -348,7 +348,7 @@ EXPORT_SYMBOL(xen_arch_unregister_cpu);
  #endif

  #ifdef CONFIG_XEN_DOM0
-bool __init xen_processor_present(uint32_t acpi_id)
+bool xen_processor_present(uint32_t acpi_id)
  {


So the change should be in Patch 3 I guess.

Regards
- Josef
