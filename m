Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D26061F204
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiKGLkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiKGLkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:40:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1752319C2E;
        Mon,  7 Nov 2022 03:40:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93E1DB81049;
        Mon,  7 Nov 2022 11:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63E3FC433C1;
        Mon,  7 Nov 2022 11:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667821202;
        bh=HSpNsHoUJe22nf8stIi1qB8KEHXotaEprWjAhSqymdk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4sdf83lzAuGpytAmO1jhshmo0LqEB1WCoS4CwlR5JHAqTR8f26ghCbCLQtmsU5JA
         qaBtGMf2vbYlq4t70l2zLVB1OmPehPpDEDoj5r7xSotF8bbCiNWQ+/fMoyAKXbxTXu
         jt9o5ba5fIAADxOaEG1RVqcIfuRNdypDQNjQV7ntbJBHKhKaG42DMOBKhgU85I5PCo
         ke2xGU5s5yOtR8BCbldPsPGJYBB5QjTYJPcIkCr2Zd3GHSU7DY2XhgVJuwUGf8gpH+
         gdiHz/E+RQ8fh8FgpGBBOrL4D/gbVc0W8SO4ysDu0UXfUe08ucmrxWw1WJXKsyJXHM
         gcxhBOYKghVCA==
Date:   Mon, 7 Nov 2022 13:39:57 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net, gwendal@chromium.org,
        apronin@chromium.org, Pavel Machek <pavel@ucw.cz>,
        Kees Cook <keescook@chromium.org>,
        Matthew Garrett <mgarrett@aurora.tech>,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, dlunev@google.com,
        Eric Biggers <ebiggers@kernel.org>,
        Ben Boeckel <me@benboeckel.net>,
        Matthew Garrett <matthewgarrett@google.com>,
        Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH v4 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
Message-ID: <Y2jujfZ01h5JriYc@kernel.org>
References: <20221103180120.752659-1-evgreen@chromium.org>
 <20221103105558.v4.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103105558.v4.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 11:01:11AM -0700, Evan Green wrote:
> From: Matthew Garrett <matthewgarrett@google.com>
> 
> Introduce a new Kconfig, TCG_TPM_RESTRICT_PCR, which if enabled
> restricts usermode's ability to extend or reset PCR 23.
> 
> Under certain circumstances it might be desirable to enable the creation
> of TPM-backed secrets that are only accessible to the kernel. In an
> ideal world this could be achieved by using TPM localities, but these
> don't appear to be available on consumer systems. An alternative is to
> simply block userland from modifying one of the resettable PCRs, leaving
> it available to the kernel. If the kernel ensures that no userland can
> access the TPM while it is carrying out work, it can reset PCR 23,
> extend it to an arbitrary value, create or load a secret, and then reset
> the PCR again. Even if userland somehow obtains the sealed material, it
> will be unable to unseal it since PCR 23 will never be in the
> appropriate state.
> 
> This Kconfig is only properly supported for systems with TPM2 devices.
> For systems with TPM1 devices, having this Kconfig enabled completely
> restricts usermode's access to the TPM. TPM1 contains support for
> tunnelled transports, which usermode could use to smuggle commands
> through that this Kconfig is attempting to restrict.
> 
> Link: https://lore.kernel.org/lkml/20210220013255.1083202-3-matthewgarrett@google.com/
> Signed-off-by: Matthew Garrett <mjg59@google.com>
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---
> 
> Changes in v4:
>  - Augment the commit message (Jarkko)
> 
> Changes in v3:
>  - Fix up commit message (Jarkko)
>  - tpm2_find_and_validate_cc() was split (Jarkko)
>  - Simply fully restrict TPM1 since v2 failed to account for tunnelled
>    transport sessions (Stefan and Jarkko).
> 
> Changes in v2:
>  - Fixed sparse warnings
> 
>  drivers/char/tpm/Kconfig          | 12 ++++++++++++
>  drivers/char/tpm/tpm-dev-common.c |  8 ++++++++
>  drivers/char/tpm/tpm.h            | 19 +++++++++++++++++++
>  drivers/char/tpm/tpm1-cmd.c       | 13 +++++++++++++
>  drivers/char/tpm/tpm2-cmd.c       | 22 ++++++++++++++++++++++
>  5 files changed, 74 insertions(+)
> 
> diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
> index 927088b2c3d3f2..c8ed54c66e399a 100644
> --- a/drivers/char/tpm/Kconfig
> +++ b/drivers/char/tpm/Kconfig
> @@ -211,4 +211,16 @@ config TCG_FTPM_TEE
>  	  This driver proxies for firmware TPM running in TEE.
>  
>  source "drivers/char/tpm/st33zp24/Kconfig"
> +
> +config TCG_TPM_RESTRICT_PCR
> +	bool "Restrict userland access to PCR 23"
> +	depends on TCG_TPM
> +	help
> +	  If set, block userland from extending or resetting PCR 23. This allows it
> +	  to be restricted to in-kernel use, preventing userland from being able to
> +	  make use of data sealed to the TPM by the kernel. This is required for
> +	  secure hibernation support, but should be left disabled if any userland
> +	  may require access to PCR23. This is a TPM2-only feature, and if enabled
> +	  on a TPM1 machine will cause all usermode TPM commands to return EPERM due
> +	  to the complications introduced by tunnelled sessions in TPM1.2.
>  endif # TCG_TPM
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index dc4c0a0a512903..7a4e618c7d1942 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -198,6 +198,14 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  	priv->response_read = false;
>  	*off = 0;
>  
> +	if (priv->chip->flags & TPM_CHIP_FLAG_TPM2)
> +		ret = tpm2_cmd_restricted(priv->chip, priv->data_buffer, size);
> +	else
> +		ret = tpm1_cmd_restricted(priv->chip, priv->data_buffer, size);
> +
> +	if (ret)
> +		goto out;
> +
>  	/*
>  	 * If in nonblocking mode schedule an async job to send
>  	 * the command return the size.
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index f1e0f490176f01..c0845e3f9eda17 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -245,4 +245,23 @@ void tpm_bios_log_setup(struct tpm_chip *chip);
>  void tpm_bios_log_teardown(struct tpm_chip *chip);
>  int tpm_dev_common_init(void);
>  void tpm_dev_common_exit(void);
> +
> +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> +#define TPM_RESTRICTED_PCR 23
> +
> +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size);
> +#else
> +static inline int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> +				      size_t size)
> +{
> +	return 0;
> +}
> +
> +static inline int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer,
> +				      size_t size)
> +{
> +	return 0;
> +}
> +#endif
>  #endif
> diff --git a/drivers/char/tpm/tpm1-cmd.c b/drivers/char/tpm/tpm1-cmd.c
> index cf64c738510529..1869e89215fcb9 100644
> --- a/drivers/char/tpm/tpm1-cmd.c
> +++ b/drivers/char/tpm/tpm1-cmd.c
> @@ -811,3 +811,16 @@ int tpm1_get_pcr_allocation(struct tpm_chip *chip)
>  
>  	return 0;
>  }
> +
> +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> +int tpm1_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> +{
> +	/*
> +	 * Restrict all usermode commands on TPM1.2. Ideally we'd just restrict
> +	 * TPM_ORD_PCR_EXTEND and TPM_ORD_PCR_RESET, but TPM1.2 also supports
> +	 * tunnelled transport sessions where the kernel would be unable to filter
> +	 * commands.
> +	 */
> +	return -EPERM;
> +}
> +#endif
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 303ce2ea02a4b0..e0503cfd7bcfee 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -778,3 +778,25 @@ int tpm2_find_cc(struct tpm_chip *chip, u32 cc)
>  
>  	return -1;
>  }
> +
> +#ifdef CONFIG_TCG_TPM_RESTRICT_PCR
> +int tpm2_cmd_restricted(struct tpm_chip *chip, u8 *buffer, size_t size)
> +{
> +	int cc = tpm2_find_and_validate_cc(chip, NULL, buffer, size);
> +	__be32 *handle;
> +
> +	switch (cc) {
> +	case TPM2_CC_PCR_EXTEND:
> +	case TPM2_CC_PCR_RESET:
> +		if (size < (TPM_HEADER_SIZE + sizeof(u32)))
> +			return -EINVAL;
> +
> +		handle = (__be32 *)&buffer[TPM_HEADER_SIZE];
> +		if (be32_to_cpu(*handle) == TPM_RESTRICTED_PCR)
> +			return -EPERM;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +#endif
> -- 
> 2.38.1.431.g37b22c650d-goog
> 

This looks otherwise good but I have still one remark: what is the reason
for restricting PCR23 for TPM 1.x?

BR, Jarkko

