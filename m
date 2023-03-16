Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF266BD2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 16:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbjCPPLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 11:11:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjCPPKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 11:10:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F7F234038;
        Thu, 16 Mar 2023 08:10:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E0D602F4;
        Thu, 16 Mar 2023 08:11:33 -0700 (PDT)
Received: from bogus (unknown [10.57.52.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE0D13F67D;
        Thu, 16 Mar 2023 08:10:47 -0700 (PDT)
Date:   Thu, 16 Mar 2023 15:10:14 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Shanker Donthineni <sdonthineni@nvidia.com>
Cc:     Marc Zyngier <maz@kernel.org>,
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
Message-ID: <20230316151014.zaoxo4wmg4mzyoiq@bogus>
References: <20230314135128.2930580-1-sdonthineni@nvidia.com>
 <871qlqif9v.wl-maz@kernel.org>
 <4dda3890-e910-625e-e7ed-6b6c0bbbd9d4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dda3890-e910-625e-e7ed-6b6c0bbbd9d4@nvidia.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 07:27:14AM -0500, Shanker Donthineni wrote:
> Hi Marc,
> 
> On 3/15/23 03:34, Marc Zyngier wrote:
> > Please don't duplicate existing code. There is already the required
> > infrastructure in drivers/firmware/smccc/soc_id.c. All you need to do
> > is:
> > 
> > - disassociate the SMCCC probing from the device registration
> > 
> > - probe the SOC_ID early
> > 
> > - add accessors for the relevant data
> > 
> > - select ARM_SMCCC_SOD_ID/ARM_SMCCC_DISCOVERY from the GICv3 Kconfig
> 
> 
> I have not modified soc_id.c as it expects to be loaded as a module with
> the use of module_init() and module_exit() functions. The exported symbols
> in soc_id driver cannot be accessed from the built-in code.
> 
> Agree, the SOD-ID discovery code was duplicated.
> 
> Please guide me if the below approach is okay?
> 
> 1) Probe the SOC-ID in arm_smccc_version_init() and export two functions
> arm_smccc_get_soc_id_version() and arm_smccc_get_soc_id_revision().
> 
> --- a/drivers/firmware/smccc/smccc.c
> +++ b/drivers/firmware/smccc/smccc.c
> @@ -17,9 +17,13 @@ static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
> 
>  bool __ro_after_init smccc_trng_available = false;
>  u64 __ro_after_init smccc_has_sve_hint = false;
> +s32 __ro_after_init smccc_soc_id_version = SMCCC_RET_NOT_SUPPORTED;
> +s32 __ro_after_init smccc_soc_id_revision = SMCCC_RET_NOT_SUPPORTED;
> 
>  void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
>  {
> +       struct arm_smccc_res res;
> +
>         smccc_version = version;
>         smccc_conduit = conduit;
> 
> @@ -27,6 +31,18 @@ void __init arm_smccc_version_init(u32 version, enum arm_smccc_conduit conduit)
>         if (IS_ENABLED(CONFIG_ARM64_SVE) &&
>             smccc_version >= ARM_SMCCC_VERSION_1_3)
>                 smccc_has_sve_hint = true;
> +
> +       if ((smccc_version >= ARM_SMCCC_VERSION_1_2) &&
> +           (smccc_conduit != SMCCC_CONDUIT_NONE)) {
> +               arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
> +                                    ARM_SMCCC_ARCH_SOC_ID, &res);
> +               if ((s32)res.a0 >= 0) {
> +                       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
> +                       smccc_soc_id_version = (s32)res.a0;
> +                       arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
> +                       smccc_soc_id_revision = (s32)res.a0;
> +               }
> +       }
>  }
> 
> 
> +s32 arm_smccc_get_soc_id_version(void)
> +{
> +       return smccc_soc_id_version;
> +}
> +EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_version);
> +
> +s32 arm_smccc_get_soc_id_revision(void)
> +{
> +       return smccc_soc_id_revision;
> +}
> +EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
> 
>

Overall, it looks OK to me. However I see neither the gic nor the soc_id
can be build as module atm. So do we really need the export symbols if no
other modules are using it ?

-- 
Regards,
Sudeep
