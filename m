Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DE96ABF98
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCFMe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjCFMev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:34:51 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCE22596B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:34:49 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id v48so6300779uad.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 04:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678106088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ns1gy7fo3P7FsWXDSeDIgeuTGnGTqEoXNUlxd/X7EAw=;
        b=e+VgJwXh5yHL5wzg1Bt6cprw/F8rX8qCqt55X7vfuuDGYfdDby1/n1q4tag500CSdJ
         JGIHxeNCGH8s7SMuKCT0KBKWDfNEenLeh6tAFYQs03p9TaRYzO/vQ+o2A0Caw+trgm2i
         XD1PlzhqSUpxz8Rfz12J/xIq9cY7M5tY7FkCxjZnG91eO6KqnPZB178qyJs1osJOO/0A
         7fJTCWrujCWYKvofotbXEI7Z6kp43yhYWo7I3WWJpPsLwNy+GPzQMx/P3Ug2SxjKyMOJ
         uiolV0gotm+k/wfKNEf7sJxZZld1z8iWJiDnh6+BH2DoMle73X7eywOnRiHnXmp37+am
         vl+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678106088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ns1gy7fo3P7FsWXDSeDIgeuTGnGTqEoXNUlxd/X7EAw=;
        b=OC8PQv0NUW5qNRAUxoN+iBup+eOldq+0xLXoiLJNtl4/kbB3Htdd3YNlgd6jB3yZb3
         fRvRNXqhC15dJPIV2o54OhmQiHJnMhP72c9GeoWtp21Q92j6/HZ2Ny/QJyvQGJLyyL4O
         Bhf8E+qWx9vAaTidxcQ1Hmw7Q5BWmuJ27j4ffqhQGQ+VtmxQadSVgHqSEdBE8sHMZyrV
         HkfiRFdg97p+i/6yIutse4LBiEan1TgwsZ9x0qI55QReILCkJQbzqgaOiOH6lp8u2peS
         KaQkfS/kHjCTA9b1FBIKSJkYdkkUQZfCp3UhJOLyDdbNHR1RSOdvmFad0uyOjlinBtpR
         lMig==
X-Gm-Message-State: AO0yUKWBUeRP26OIJlwFPPtnimWTy07T9CH5LzK5Po9jUakkoW9FrGyo
        7/VIfyQuDeupXBtK9XqPz2+Wl+KrN1m3cZveJWWmyA==
X-Google-Smtp-Source: AK7set8bkKE44A6LpLbaFkx/id0WBO0Pz9iRc0FaC7g6t8pqzEilwWHLxIampiwKDGvT3R9I/3xB6OeRc4W/DwVVeMQ=
X-Received: by 2002:ab0:4714:0:b0:68b:90f4:1d8c with SMTP id
 h20-20020ab04714000000b0068b90f41d8cmr897588uac.1.1678106088377; Mon, 06 Mar
 2023 04:34:48 -0800 (PST)
MIME-Version: 1.0
References: <20230302120648.v3.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
In-Reply-To: <20230302120648.v3.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 6 Mar 2023 18:04:37 +0530
Message-ID: <CAFA6WYNuyy2kDpQzEap97dXQxPr+oKE4pvA5PKiow3Dqdx_G7w@mail.gmail.com>
Subject: Re: [PATCH v3] tee: optee: Add SMC for loading OP-TEE image
To:     Jeffrey Kardatzke <jkardatzke@chromium.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Jeffrey Kardatzke <jkardatzke@google.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Mar 2023 at 01:37, Jeffrey Kardatzke <jkardatzke@chromium.org> wrote:
>
> Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> instruct it to load it as the BL32 payload. This works in conjunction
> with a feature added to Trusted Firmware for ARM that supports this.

s/Trusted Firmware for ARM/Trusted Firmware for Armv8 and above architectures/

This commit description tells me what you have implemented but not
why? The motivation for this change should be included here along with
security implications.

>
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> ---
>
> Changes in v3:
> - Removed state tracking for driver reload
> - Check UID of service to verify it needs image load
>
> Changes in v2:
> - Fixed compile issue when feature is disabled
> - Addressed minor comments
> - Added state tracking for driver reload
>
>  drivers/tee/optee/Kconfig     | 10 ++++
>  drivers/tee/optee/optee_msg.h | 12 +++++
>  drivers/tee/optee/optee_smc.h | 24 +++++++++
>  drivers/tee/optee/smc_abi.c   | 96 +++++++++++++++++++++++++++++++++++
>  4 files changed, 142 insertions(+)
>
> diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> index f121c224e682..f0f12b146add 100644
> --- a/drivers/tee/optee/Kconfig
> +++ b/drivers/tee/optee/Kconfig
> @@ -7,3 +7,13 @@ config OPTEE
>         help
>           This implements the OP-TEE Trusted Execution Environment (TEE)
>           driver.
> +
> +config OPTEE_LOAD_IMAGE

Given the warning text attached to this config option, this should be
renamed as OPTEE_INSECURE_LOAD_IMAGE. Also, the help text should be
updated to reflect the security implication of this.

I would also like to see documentation updates regarding how your
platform is mitigating potential threats in order to enable this
option. It would enable others to make a concious decision if their
threat model allows this option.

> +       bool "Load OP-TEE image as firmware"
> +       default n
> +       depends on OPTEE

IIRC, from earlier review threads you mentioned that this option is
enabled when OP-TEE driver is built-in rather than loadable. Shouldn't
we make that dependency explicit?

Also, this option only makes sense for ARM64 as in case of ARM the
secure monitor is bundled into OP-TEE image and hence can't be loaded
dynamically. We should make that dependency explicit too.

> +       help
> +         This loads the BL32 image for OP-TEE as firmware when the driver is probed.
> +         This returns -EPROBE_DEFER until the firmware is loadable from the
> +         filesystem which is determined by checking the system_state until it is in
> +         SYSTEM_RUNNING.
> diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> index 70e9cc2ee96b..237d6fa9a6e8 100644
> --- a/drivers/tee/optee/optee_msg.h
> +++ b/drivers/tee/optee/optee_msg.h
> @@ -241,11 +241,23 @@ struct optee_msg_arg {
>   * 384fb3e0-e7f8-11e3-af63-0002a5d5c51b.
>   * Represented in 4 32-bit words in OPTEE_MSG_UID_0, OPTEE_MSG_UID_1,
>   * OPTEE_MSG_UID_2, OPTEE_MSG_UID_3.
> + *
> + * In the case where the OP-TEE image is loaded by the kernel, this will
> + * initially return an alternate UID to reflect that we are communicating with
> + * the TF-A image loading service at that time instead of OP-TEE. That UID is:
> + * a3fbeab1-1246-315d-c7c4-06b9c03cbea4.
> + * Represetned in 4 32-bit words in OPTEE_MSG_IMAGE_LOAD_UID_0,

s/Represetned/Represented/

> + * OPTEE_MSG_IMAGE_LOAD_UID_1, OPTEE_MSG_IMAGE_LOAD_UID_2,
> + * OPTEE_MSG_IMAGE_LOAD_UID_3.
>   */
>  #define OPTEE_MSG_UID_0                        0x384fb3e0
>  #define OPTEE_MSG_UID_1                        0xe7f811e3
>  #define OPTEE_MSG_UID_2                        0xaf630002
>  #define OPTEE_MSG_UID_3                        0xa5d5c51b
> +#define OPTEE_MSG_IMAGE_LOAD_UID_0     0xa3fbeab1
> +#define OPTEE_MSG_IMAGE_LOAD_UID_1     0x1246315d
> +#define OPTEE_MSG_IMAGE_LOAD_UID_2     0xc7c406b9
> +#define OPTEE_MSG_IMAGE_LOAD_UID_3     0xc03cbea4
>  #define OPTEE_MSG_FUNCID_CALLS_UID     0xFF01
>
>  /*
> diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> index 73b5e7760d10..7d9fa426505b 100644
> --- a/drivers/tee/optee/optee_smc.h
> +++ b/drivers/tee/optee/optee_smc.h
> @@ -104,6 +104,30 @@ struct optee_smc_call_get_os_revision_result {
>         unsigned long reserved1;
>  };
>
> +/*
> + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> + *
> + * WARNING: Use this cautiously as it could lead to insecure loading of the
> + * Trusted OS.
> + * This SMC instructs EL3 to load a binary and execute it as the Trusted OS.
> + *
> + * Call register usage:
> + * a0 SMC Function ID, OPTEE_SMC_CALL_LOAD_IMAGE
> + * a1 Upper 32bit of a 64bit size for the payload
> + * a2 Lower 32bit of a 64bit size for the payload
> + * a3 Upper 32bit of the physical address for the payload
> + * a4 Lower 32bit of the physical address for the payload
> + *
> + * The payload is in the OP-TEE image format.
> + *
> + * Returns result in a0, 0 on success and an error code otherwise.
> + */
> +#define OPTEE_SMC_FUNCID_LOAD_IMAGE 2
> +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
> +                          ARM_SMCCC_OWNER_TRUSTED_OS_END, \
> +                          OPTEE_SMC_FUNCID_LOAD_IMAGE)
> +
>  /*
>   * Call with struct optee_msg_arg as argument
>   *
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index a1c1fa1a9c28..14612edef8f2 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -8,9 +8,11 @@
>
>  #include <linux/arm-smccc.h>
>  #include <linux/errno.h>
> +#include <linux/firmware.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/irqdomain.h>
> +#include <linux/kernel.h>
>  #include <linux/mm.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -1149,6 +1151,22 @@ static bool optee_msg_api_uid_is_optee_api(optee_invoke_fn *invoke_fn)
>         return false;
>  }
>
> +#ifdef CONFIG_OPTEE_LOAD_IMAGE
> +static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *invoke_fn)
> +{
> +       struct arm_smccc_res res;
> +
> +       invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res);
> +
> +       if (res.a0 == OPTEE_MSG_IMAGE_LOAD_UID_0 &&
> +          res.a1 == OPTEE_MSG_IMAGE_LOAD_UID_1 &&
> +          res.a2 == OPTEE_MSG_IMAGE_LOAD_UID_2 &&
> +          res.a3 == OPTEE_MSG_IMAGE_LOAD_UID_3)
> +               return true;
> +       return false;
> +}
> +#endif
> +
>  static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
>  {
>         union {
> @@ -1354,6 +1372,80 @@ static void optee_shutdown(struct platform_device *pdev)
>                 optee_disable_shm_cache(optee);
>  }
>
> +#ifdef CONFIG_OPTEE_LOAD_IMAGE
> +
> +#define OPTEE_FW_IMAGE "optee/tee.bin"
> +
> +static int optee_load_fw(struct platform_device *pdev,
> +                        optee_invoke_fn *invoke_fn)
> +{
> +       const struct firmware *fw = NULL;
> +       struct arm_smccc_res res;
> +       phys_addr_t data_pa;
> +       u8 *data_buf = NULL;
> +       u64 data_size;
> +       u32 data_pa_high, data_pa_low;
> +       u32 data_size_high, data_size_low;
> +       int rc;
> +
> +       if (!optee_msg_api_uid_is_optee_image_load(invoke_fn))
> +               return 0;
> +
> +       rc = request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
> +       if (rc) {
> +               /*
> +                * The firmware in the rootfs will not be accessible until we
> +                * are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
> +                * that point.
> +                */
> +               if (system_state < SYSTEM_RUNNING)
> +                       return -EPROBE_DEFER;
> +               goto fw_err;
> +       }
> +
> +       data_size = fw->size;
> +       /*
> +        * This uses the GFP_DMA flag to ensure we are allocated memory in the
> +        * 32-bit space since TF-A cannot map memory beyond the 32-bit boundary.
> +        */
> +       data_buf = kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> +       if (!data_buf) {
> +               rc = -ENOMEM;
> +               goto fw_err;
> +       }
> +       memcpy(data_buf, fw->data, fw->size);
> +       data_pa = virt_to_phys(data_buf);
> +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> +       reg_pair_from_64(&data_size_high, &data_size_low, data_size);
> +       goto fw_load;
> +
> +fw_err:
> +       pr_warn("image loading failed\n");
> +       data_pa_high = data_pa_low = data_size_high = data_size_low = 0;
> +
> +fw_load:
> +       /*
> +        * Always invoke the SMC, even if loading the image fails, to indicate
> +        * to EL3 that we have passed the point where it should allow invoking
> +        * this SMC.
> +        */
> +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_low,
> +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
> +       if (!rc)
> +               rc = res.a0;
> +       if (fw)
> +               release_firmware(fw);
> +       kfree(data_buf);
> +
> +       return rc;
> +}
> +#else
> +static inline int optee_load_fw(struct platform_device *__unused1,
> +               optee_invoke_fn *__unused2) {
> +       return 0;
> +}
> +#endif
> +
>  static int optee_probe(struct platform_device *pdev)
>  {
>         optee_invoke_fn *invoke_fn;
> @@ -1372,6 +1464,10 @@ static int optee_probe(struct platform_device *pdev)
>         if (IS_ERR(invoke_fn))
>                 return PTR_ERR(invoke_fn);
>
> +       rc = optee_load_fw(pdev, invoke_fn);
> +       if (rc)
> +               return rc;
> +
>         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
>                 pr_warn("api uid mismatch\n");
>                 return -EINVAL;
> --
> 2.40.0.rc0.216.gc4246ad0f0-goog
>
