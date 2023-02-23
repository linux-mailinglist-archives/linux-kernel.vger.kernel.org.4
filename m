Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9F96A101F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjBWTJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjBWTJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:09:26 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E963E081
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:09:21 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id r5so2183126qtp.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=L5B11ZVXywPAysPevv2KOjdZRGhQxbb3X6SimYDX2dI=;
        b=X3tCnwLjfLqMRtEmXJ+eaG0pASe7c7yu3JjJMaijHvtmdzsfC4KLBZE6kxzSRy+VUH
         swrL08KU7g3TyE4UDqi/HwqUdPd4BVannLSrzuXo5tv/PeA9o1OPjMyWJXzh6l5619/U
         56L4/dFK6JfZ0tX6P6w+0B8wTQ5IOzRuUjqf4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L5B11ZVXywPAysPevv2KOjdZRGhQxbb3X6SimYDX2dI=;
        b=RWpu4JCPmA/6r0Dvc/D0V5Mqn5pxFum6XXusJ5WmHTfP7K+1ezL5mJPti6qm6OArJY
         hP6XNn7h/zIVjBW86haTbpN286ARHJ+Kv26RPOJ+eCYQcKqBy+qxcXsrIoCV54VAkh5L
         FK/8xcV7HnQoqu7PZFPb34xj3j6OWH7jRUKWwK1sSDoJxunOT8xWxMMNH1p94zCbAUP9
         bsQbtZzxayaTsIAOIW7DlQrRVMnNpT/EFFXR6eGmX7LGZ+heJpiShGrgzLurUvMFLU+w
         9FHIAPh+iJa9VerGMTUDVQwdzOrxWdI50g2xI4UimTkOCsWS6mEZrh99hERlr0oa9txH
         TeHg==
X-Gm-Message-State: AO0yUKUkAjjJawY0QwAIskMeQtzSnzADuztpX1GM+bdxIxJxDmRroY9N
        XQNS3/z7YrzpJb3tf3OKkgYiRIIqrsFxqZlVZ+I=
X-Google-Smtp-Source: AK7set8saWAgHdnzUsNFpO4SoU49bWmku7vNgmOjJqtYRBTU6X8pYzSgpkB77H7gcYjYg538KpY9aw==
X-Received: by 2002:ac8:7f89:0:b0:3a8:20fd:7111 with SMTP id z9-20020ac87f89000000b003a820fd7111mr5752766qtj.39.1677179359747;
        Thu, 23 Feb 2023 11:09:19 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id d20-20020ac85454000000b003a530a32f67sm7051328qtq.65.2023.02.23.11.09.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 11:09:19 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-536be69eadfso212705387b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 11:09:18 -0800 (PST)
X-Received: by 2002:a5b:50b:0:b0:a36:3875:564a with SMTP id
 o11-20020a5b050b000000b00a363875564amr1016041ybp.2.1677179357626; Thu, 23 Feb
 2023 11:09:17 -0800 (PST)
MIME-Version: 1.0
References: <20230222092409.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
 <CAHUa44GUEtN4J_PKaeM4YEfL8dGBpCcSWw1C_pobwh9VFpWKTw@mail.gmail.com>
In-Reply-To: <CAHUa44GUEtN4J_PKaeM4YEfL8dGBpCcSWw1C_pobwh9VFpWKTw@mail.gmail.com>
From:   Jeffrey Kardatzke <jkardatzke@chromium.org>
Date:   Thu, 23 Feb 2023 11:09:05 -0800
X-Gmail-Original-Message-ID: <CA+ddPcNnCwBVnpyT2cWYeRtUfqZFk-KodtMHfNMnQs=T9o3nyA@mail.gmail.com>
Message-ID: <CA+ddPcNnCwBVnpyT2cWYeRtUfqZFk-KodtMHfNMnQs=T9o3nyA@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Add SMC for loading OP-TEE image
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 1:28 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> On Wed, Feb 22, 2023 at 6:24 PM Jeffrey Kardatzke
> <jkardatzke@chromium.org> wrote:
> >
> > Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> > instruct it to load it as the BL32 payload. This works in conjunction
> > with a feature added to Trusted Firmware for ARM that supports this.
> >
> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > ---
> >
> >  drivers/tee/optee/Kconfig     | 10 +++++
> >  drivers/tee/optee/optee_msg.h | 14 +++++++
> >  drivers/tee/optee/optee_smc.h | 22 ++++++++++
> >  drivers/tee/optee/smc_abi.c   | 77 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 123 insertions(+)
> >
> > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> > index f121c224e682..5ffbeb3eaac0 100644
> > --- a/drivers/tee/optee/Kconfig
> > +++ b/drivers/tee/optee/Kconfig
> > @@ -7,3 +7,13 @@ config OPTEE
> >         help
> >           This implements the OP-TEE Trusted Execution Environment (TEE)
> >           driver.
> > +
> > +config OPTEE_LOAD_IMAGE
> > +       bool "Load Op-Tee image as firmware"
>
> OP-TEE
Done, fixed in next patch set.
>
> > +       default n
> > +       depends on OPTEE
> > +       help
> > +         This loads the BL32 image for OP-TEE as firmware when the driver is probed.
> > +         This returns -EPROBE_DEFER until the firmware is loadable from the
> > +         filesystem which is determined by checking the system_state until it is in
> > +         SYSTEM_RUNNING.
> > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> > index 70e9cc2ee96b..84c1b15032a9 100644
> > --- a/drivers/tee/optee/optee_msg.h
> > +++ b/drivers/tee/optee/optee_msg.h
> > @@ -284,6 +284,20 @@ struct optee_msg_arg {
> >   */
> >  #define OPTEE_MSG_FUNCID_GET_OS_REVISION       0x0001
> >
> > +/*
> > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > + *
> > + * WARNING: Use this cautiously as it could lead to insecure loading of the
> > + * Trusted OS.
> > + * This SMC instructs EL3 to load a binary and excute it as the Trusted OS.
> > + * The first two params are the high and low 32 bits of the size of the payload
> > + * and the third and fourth params are the high and low 32 bits of the physical
> > + * address of the payload. The payload is in the OP-TEE image format.
> > + *
> > + * Returns 0 on success and an error code otherwise.
> > + */
> > +#define OPTEE_MSG_FUNCID_LOAD_IMAGE   0x0002
>
> There's no need to add anything to this file, you can define
> OPTEE_SMC_FUNCID_LOAD_IMAGE to 2 directly in optee_smc.h below.
>
Done, fixed in next patch set.
> > +
> >  /*
> >   * Do a secure call with struct optee_msg_arg as argument
> >   * The OPTEE_MSG_CMD_* below defines what goes in struct optee_msg_arg::cmd
> > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> > index 73b5e7760d10..908b1005e9db 100644
> > --- a/drivers/tee/optee/optee_smc.h
> > +++ b/drivers/tee/optee/optee_smc.h
> > @@ -104,6 +104,28 @@ struct optee_smc_call_get_os_revision_result {
> >         unsigned long reserved1;
> >  };
> >
> > +/*
> > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > + *
> > + * WARNING: Use this cautiously as it could lead to insecure loading of the
> > + * Trusted OS.
> > + * This SMC instructs EL3 to load a binary and excute it as the Trusted OS.
>
> execute
>
Done, fixed in next patch set.
> > + *
> > + * Call register usage:
> > + * a0 SMC Function ID, OPTEE_SMC_CALL_LOAD_IMAGE
> > + * a1 Upper 32bit of a 64bit size for the payload
> > + * a2 Lower 32bit of a 64bit size for the payload
> > + * a3 Upper 32bit of the physical address for the payload
> > + * a4 Lower 32bit of the physical address for the payload
> > + *
> > + * The payload is in the OP-TEE image format.
> > + *
> > + * Returns result in a0, 0 on success and an error code otherwise.
> > + */
> > +#define OPTEE_SMC_FUNCID_LOAD_IMAGE OPTEE_MSG_FUNCID_LOAD_IMAGE
> > +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> > +       OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_LOAD_IMAGE)
> > +
> >  /*
> >   * Call with struct optee_msg_arg as argument
> >   *
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index a1c1fa1a9c28..c1abbee86b39 100644
> > --- a/drivers/tee/optee/smc_abi.c
> > +++ b/drivers/tee/optee/smc_abi.c
> > @@ -8,9 +8,11 @@
> >
> >  #include <linux/arm-smccc.h>
> >  #include <linux/errno.h>
> > +#include <linux/firmware.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> >  #include <linux/irqdomain.h>
> > +#include <linux/kernel.h>
> >  #include <linux/mm.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -1354,6 +1356,77 @@ static void optee_shutdown(struct platform_device *pdev)
> >                 optee_disable_shm_cache(optee);
> >  }
> >
> > +#ifdef CONFIG_OPTEE_LOAD_IMAGE
> > +
> > +#define OPTEE_FW_IMAGE "optee/tee.bin"
> > +
> > +static int optee_load_fw(struct platform_device *pdev,
> > +                        optee_invoke_fn *invoke_fn)
> > +{
> > +       const struct firmware *fw = NULL;
> > +       struct arm_smccc_res res;
> > +       phys_addr_t data_pa;
> > +       u8 *data_buf = NULL;
> > +       u64 data_size;
> > +       u32 data_pa_high, data_pa_low;
> > +       u32 data_size_high, data_size_low;
> > +       int rc;
> > +
> > +       rc = request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
> > +       if (rc) {
> > +               /*
> > +                * The firmware in the rootfs will not be accessible until we
> > +                * are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
> > +                * that point.
> > +                */
> > +               if (system_state < SYSTEM_RUNNING)
> > +                       return -EPROBE_DEFER;
> > +               goto fw_err;
> > +       }
> > +
> > +       data_size = fw->size;
> > +       /*
> > +        * This uses the GFP_DMA flag to ensure we are allocated memory in the
> > +        * 32-bit space since TF-A cannot map memory beyond the 32-bit boundary.
> > +        */
> > +       data_buf = kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> > +       if (!data_buf) {
> > +               rc = -ENOMEM;
> > +               goto fw_err;
> > +       }
> > +       memcpy(data_buf, fw->data, fw->size);
> > +       data_pa = virt_to_phys(data_buf);
> > +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> > +       reg_pair_from_64(&data_size_high, &data_size_low, data_size);
> > +       goto fw_load;
> > +
> > +fw_err:
> > +       pr_warn("image loading failed\n");
> > +       data_pa_high = data_pa_low = data_size_high = data_size_low = 0;
> > +
> > +fw_load:
> > +       /*
> > +        * Always invoke the SMC, even if loading the image fails, to indicate
> > +        * to EL3 that we have passed the point where it should allow invoking
> > +        * this SMC.
> > +        */
> > +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_low,
> > +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
>
> Prior to this, you've done nothing to check that the firmware might do
> what you're expecting. optee_msg_api_uid_is_optee_api() does this
> under normal circumstances as that SMC function is defined in the SMC
> Calling Convention. I'm not sure what is the best approach here
> though.
>
The way I think about it is that we have to issue this SMC call once
we are in the SYSTEM_RUNNING state no matter what. We need to close
the security hole this would leave open otherwise. Any other checks we
would do that would prevent us from making that call could be other
attack vectors.
> > +       if (!rc)
> > +               rc = res.a0;
> > +       if (fw)
> > +               release_firmware(fw);
> > +       kfree(data_buf);
> > +
> > +       return rc;
> > +}
> > +#else
> > +static inline int optee_load_fw(struct platform_device *__unused,
> > +               optee_invoke_fn *__unused) {
> > +       return 0;
> > +}
> > +#endif
> > +
> >  static int optee_probe(struct platform_device *pdev)
> >  {
> >         optee_invoke_fn *invoke_fn;
> > @@ -1372,6 +1445,10 @@ static int optee_probe(struct platform_device *pdev)
> >         if (IS_ERR(invoke_fn))
> >                 return PTR_ERR(invoke_fn);
> >
> > +       rc = optee_load_fw(pdev, invoke_fn);
> > +       if (rc)
> > +               return rc;
>
> What if OP-TEE already was loaded?
> This also causes trouble if unloading and loading the driver again.
> I think we need a way of telling if OP-TEE must be loaded first or not.
>
OK, I added some state tracking in the driver code to return the prior
loading result if it was already loaded.
> Thanks,
> Jens
>
> > +
> >         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
> >                 pr_warn("api uid mismatch\n");
> >                 return -EINVAL;
> > --
> > 2.39.2.637.g21b0678d19-goog
> >
