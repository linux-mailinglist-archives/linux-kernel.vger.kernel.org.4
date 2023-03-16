Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C576BD493
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCPQAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbjCPQAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:00:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3529377CBE;
        Thu, 16 Mar 2023 09:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DA94B8227E;
        Thu, 16 Mar 2023 16:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D36C433EF;
        Thu, 16 Mar 2023 16:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678982407;
        bh=GHqd6mmwWSIdksWIe0G7oOtf6sR281Z2AdCgPifu/AQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qId0+JoWJmZvtimfpgsvRRlwTPjX6lG7oCsd16E7p4Ns2lLReS6hNnPC0ihO9xkZW
         RIKZHA8GO54xL/++44/qMdDFrV5txPjrUm1YSMwSLMZ3m34hTjHpUK7mLL3jOW2kpo
         94h9gMKOqeIDLEZdFeBXBy4Q7yCaHVADw3ZYo9SEgAwdKg1ffRhKDWO+T4OYlYzX71
         9La9qQyX/NsNjhJ3gEez2hkyyg1T6jrbqnMMaeJqjQaTZhkbId7w/QclC3w3YVA6Vm
         AXIwr/U2NtT5KuSZke7jOtRJAjtHadCKFPLg6HuoUwpe7gq1zl7S0YbIEe1tGdAYgY
         lkeuFzNZ+dmHA==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1pcq1M-000crq-PH;
        Thu, 16 Mar 2023 16:00:04 +0000
MIME-Version: 1.0
Date:   Thu, 16 Mar 2023 16:00:04 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Shanker Donthineni <sdonthineni@nvidia.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vikram Sethi <vsethi@nvidia.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2] irqchip/gicv3: Workaround for NVIDIA erratum
 T241-FABRIC-4
In-Reply-To: <20230316151014.zaoxo4wmg4mzyoiq@bogus>
References: <20230314135128.2930580-1-sdonthineni@nvidia.com>
 <871qlqif9v.wl-maz@kernel.org>
 <4dda3890-e910-625e-e7ed-6b6c0bbbd9d4@nvidia.com>
 <20230316151014.zaoxo4wmg4mzyoiq@bogus>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <bf9f8763f0116c3f05c008923edfbedb@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sudeep.holla@arm.com, sdonthineni@nvidia.com, catalin.marinas@arm.com, will@kernel.org, corbet@lwn.net, mark.rutland@arm.com, lpieralisi@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, vsethi@nvidia.com, treding@nvidia.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-03-16 15:10, Sudeep Holla wrote:
> On Wed, Mar 15, 2023 at 07:27:14AM -0500, Shanker Donthineni wrote:
>> Hi Marc,
>> 
>> On 3/15/23 03:34, Marc Zyngier wrote:
>> > Please don't duplicate existing code. There is already the required
>> > infrastructure in drivers/firmware/smccc/soc_id.c. All you need to do
>> > is:
>> >
>> > - disassociate the SMCCC probing from the device registration
>> >
>> > - probe the SOC_ID early
>> >
>> > - add accessors for the relevant data
>> >
>> > - select ARM_SMCCC_SOD_ID/ARM_SMCCC_DISCOVERY from the GICv3 Kconfig
>> 
>> 
>> I have not modified soc_id.c as it expects to be loaded as a module 
>> with
>> the use of module_init() and module_exit() functions. The exported 
>> symbols
>> in soc_id driver cannot be accessed from the built-in code.
>> 
>> Agree, the SOD-ID discovery code was duplicated.
>> 
>> Please guide me if the below approach is okay?
>> 
>> 1) Probe the SOC-ID in arm_smccc_version_init() and export two 
>> functions
>> arm_smccc_get_soc_id_version() and arm_smccc_get_soc_id_revision().
>> 
>> --- a/drivers/firmware/smccc/smccc.c
>> +++ b/drivers/firmware/smccc/smccc.c
>> @@ -17,9 +17,13 @@ static enum arm_smccc_conduit smccc_conduit = 
>> SMCCC_CONDUIT_NONE;
>> 
>>  bool __ro_after_init smccc_trng_available = false;
>>  u64 __ro_after_init smccc_has_sve_hint = false;
>> +s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
>> +s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;
>> 
>>  void __init arm_smccc_version_init(u32 version, enum 
>> arm_smccc_conduit conduit)
>>  {
>> +       struct arm_smccc_res res;
>> +
>>         smccc_version = version;
>>         smccc_conduit = conduit;
>> 
>> @@ -27,6 +31,18 @@ void __init arm_smccc_version_init(u32 version, 
>> enum arm_smccc_conduit conduit)
>>         if (IS_ENABLED(CONFIG_ARM64_SVE) &&
>>             smccc_version >= ARM_SMCCC_VERSION_1_3)
>>                 smccc_has_sve_hint = true;
>> +
>> +       if ((smccc_version >= ARM_SMCCC_VERSION_1_2) &&
>> +           (smccc_conduit != SMCCC_CONDUIT_NONE)) {
>> +               arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
>> +                                    ARM_SMCCC_ARCH_SOC_ID, &res);
>> +               if ((s32)res.a0 >= 0) {
>> +                       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, 
>> &res);
>> +                       smccc_soc_id_version = (s32)res.a0;
>> +                       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, 
>> &res);
>> +                       smccc_soc_id_revision = (s32)res.a0;
>> +               }
>> +       }
>>  }
>> 
>> 
>> +s32 arm_smccc_get_soc_id_version(void)
>> +{
>> +       return smccc_soc_id_version;
>> +}
>> +EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_version);
>> +
>> +s32 arm_smccc_get_soc_id_revision(void)
>> +{
>> +       return smccc_soc_id_revision;
>> +}
>> +EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
>> 
>> 
> 
> Overall, it looks OK to me. However I see neither the gic nor the 
> soc_id
> can be build as module atm. So do we really need the export symbols if 
> no
> other modules are using it ?

It really shouldn't be exported. Having accessors should be enough.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
