Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10D5682C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjAaMSe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:18:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231621AbjAaMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:18:29 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE32F13531
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675167479; x=1706703479;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HZfoUkL79lYgrOdmcntsIiRWStscy316jRpBhaaQrEY=;
  b=K0e++ox/QQrL1XiYHXeL/F0ojHecdwQGbW8FxiWYisgcO8q63PCLYiOP
   y+TqIlZwNCqw+ul5AH6jXPwufxJ9MQdhg8Tk2qu0eV2bSrt4R+AJIJzNq
   HFFyNarsExAbxnje0WdtaL0PZireYQYYmZT4iCbumLMbKdqqLljazzRuU
   S1Sn4+XO0OFEMspAJD9hQDJW8lBm6uVX33IrFKw6iS7cEs3DyZyr3vQyQ
   lE/IU+9Hhs3q2QUgr9HQ0cDpQg8KW9OF0xp/I7Jqv4y17+20aOdRKKDyz
   PpeMQZdfyJiJwtQrDwMzWObmTpFBMlBexiYbhg0mre8DYnEexlWKYrOC3
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="329094788"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="329094788"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:17:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="727925480"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="727925480"
Received: from cli6-desk.ccr.corp.intel.com (HELO [10.239.161.129]) ([10.239.161.129])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 04:17:51 -0800
Message-ID: <b6e8c90b-08ba-ccf9-8704-97c995722ea5@linux.intel.com>
Date:   Tue, 31 Jan 2023 20:17:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [Patch v3 Part2 1/9] x86/microcode: Taint kernel only if
 microcode loading was successful
Content-Language: en-US
To:     Ashok Raj <ashok.raj@intel.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Stefan Talpalaru <stefantalpalaru@yahoo.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Peter Zilstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Martin Pohlack <mpohlack@amazon.de>
References: <20230130213955.6046-1-ashok.raj@intel.com>
 <20230130213955.6046-2-ashok.raj@intel.com>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
In-Reply-To: <20230130213955.6046-2-ashok.raj@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/1/31 5:39, Ashok Raj wrote:
> Currently when late loading is aborted due to check_online_cpu(), kernel
> still ends up tainting the kernel.
> 
> Taint only when microcode loading was successful.
> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: x86 <x86@kernel.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Thomas Gleixner (Intel) <tglx@linutronix.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Stefan Talpalaru <stefantalpalaru@yahoo.com>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Peter Zilstra (Intel) <peterz@infradead.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Andrew Cooper <Andrew.Cooper3@citrix.com>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Martin Pohlack <mpohlack@amazon.de>
> ---
> v1->v2: (Thomas)
> 	- Remove unnecessary assignment of ret that's being overwritten.
> 	- Taint kernel only of loading was successful
> ---
>   arch/x86/kernel/cpu/microcode/core.c | 19 +++++++++++++------
>   1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index 61d57d9b93ee..1c6831b8b244 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -472,7 +472,8 @@ static ssize_t reload_store(struct device *dev,
>   	enum ucode_state tmp_ret = UCODE_OK;
>   	int bsp = boot_cpu_data.cpu_index;
>   	unsigned long val;
> -	ssize_t ret = 0;
> +	int load_ret = -1;
> +	ssize_t ret;
>   
>   	ret = kstrtoul(buf, 0, &val);
>   	if (ret)
> @@ -488,20 +489,26 @@ static ssize_t reload_store(struct device *dev,
>   		goto put;
>   
>   	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev);
> -	if (tmp_ret != UCODE_NEW)
> +	if (tmp_ret != UCODE_NEW) {
> +		ret = size;
>   		goto put;
> +	}
>   
>   	mutex_lock(&microcode_mutex);
> -	ret = microcode_reload_late();
> +	load_ret = microcode_reload_late();
>   	mutex_unlock(&microcode_mutex);
>   
>   put:
>   	cpus_read_unlock();
>   
> -	if (ret == 0)
> +	/*
> +	 * Taint only when loading was successful
> +	 */
> +	if (load_ret == 0) {
>   		ret = size;

What about if loading was not successful(load_ret != 0)?
ret has no chance to be returned as size here and we'll run into the 
endless update?

Thanks,
-Aubrey

> -
> -	add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> +		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
> +		pr_warn("Microcode late loading tainted the kernel\n");
> +	}
>   
>   	return ret;
>   }

