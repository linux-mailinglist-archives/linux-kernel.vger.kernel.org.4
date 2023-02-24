Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB026A17E6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjBXIZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXIZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:25:45 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395A815179
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 00:25:44 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l2-20020a05600c1d0200b003e1f6dff952so1556138wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 00:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9oGkW/fZKGVuSTvUenh5oA9mLLShh37PyBxosFr//AQ=;
        b=vj+zag8NjLJIUTEfApkgstqpNCeBrgTdJdquH7f0QNO3JUnVAuIvjY0mwn67+f7WYB
         YR5l93pEfSONJLr0wB3qM8/q9/ID3P8Teo7prhqRZxwbtSnC+lVTeWpOZpK4bryY2eZK
         zD5PlS+5fHw3FLGxrWoh3GZdkTNuNRcXwkxjH7N9ygcHWOXIf77G5BnpiiXfGsCXERSk
         XEIFkzfCE+Ek3J7wx0diMlFD46AjAPGNIZmqd8Y1jd94YzXFGqJx3GDO53nECPgmXJea
         vPEla1eDudGvtBbT4+lFF2JejJopx6rfjh8UOtY9kFl9BqTPo1lwMQBZ6iwwAXRP1sw3
         NK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9oGkW/fZKGVuSTvUenh5oA9mLLShh37PyBxosFr//AQ=;
        b=JPMQfbD6G6wncreFuFHwVmffzT20UoswakYe/iWC3ys64OKmQcMiA0cF+1MbMpUk8k
         mFv6HC2CM2qpp5jxXs2Xh/4hQC4+JaChExaE2om6dymegYvBEm7MZIzAUcAdHgPWlNoT
         o1WCGjvu9lfGHAXXpMq7tVtfj8LQcetXpNDwcxU23hoZvks6g2WPXV/GW6eatevaaN7N
         TscXxjXMNpDz1rmCN/jBakQIzAii+a6SiN/bVdOoxHFwfFqZ/pxl+FhMAgXhnCIMdoPg
         jwcXIIkeVU0ftHXPKC8waYCiidxHvXlPfYVul0yt+PUUZTLqmdtIqD4KPUhRzIrPi0sz
         Y9CQ==
X-Gm-Message-State: AO0yUKW1zXRtGLl2rsowAE+P04NlmikvZc2f/l8JJeuYgVomKEUW0Bep
        Z7bjL/hf7A9h4SEBJxe+9mMteGArCeyTaqVo1/vdFg==
X-Google-Smtp-Source: AK7set+B2TPrIl8s+OGbii8Nen5m+wqOpDSn9xIgOh2Eyq+xNbFdCujwj2mSTVxNSkDHl5gUSED9/+z+uEPBgnRbFQM=
X-Received: by 2002:a05:600c:1f06:b0:3e2:cc:d8f2 with SMTP id
 bd6-20020a05600c1f0600b003e200ccd8f2mr987057wmb.1.1677227142588; Fri, 24 Feb
 2023 00:25:42 -0800 (PST)
MIME-Version: 1.0
References: <20230222092409.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
 <CAHUa44GUEtN4J_PKaeM4YEfL8dGBpCcSWw1C_pobwh9VFpWKTw@mail.gmail.com> <CA+ddPcNnCwBVnpyT2cWYeRtUfqZFk-KodtMHfNMnQs=T9o3nyA@mail.gmail.com>
In-Reply-To: <CA+ddPcNnCwBVnpyT2cWYeRtUfqZFk-KodtMHfNMnQs=T9o3nyA@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 24 Feb 2023 09:25:31 +0100
Message-ID: <CAHUa44FVrLDBNQqfFfwFAPHTjDNRpQJShCz2+H7X4nUbfe3QUQ@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: Add SMC for loading OP-TEE image
To:     Jeffrey Kardatzke <jkardatzke@chromium.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
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

On Thu, Feb 23, 2023 at 8:09 PM Jeffrey Kardatzke
<jkardatzke@chromium.org> wrote:
>
> On Thu, Feb 23, 2023 at 1:28 AM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > Hi,
> >
> > On Wed, Feb 22, 2023 at 6:24 PM Jeffrey Kardatzke
> > <jkardatzke@chromium.org> wrote:
> > >
> > > Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> > > instruct it to load it as the BL32 payload. This works in conjunction
> > > with a feature added to Trusted Firmware for ARM that supports this.
> > >
> > > Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> > > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > > ---
> > >
> > >  drivers/tee/optee/Kconfig     | 10 +++++
> > >  drivers/tee/optee/optee_msg.h | 14 +++++++
> > >  drivers/tee/optee/optee_smc.h | 22 ++++++++++
> > >  drivers/tee/optee/smc_abi.c   | 77 +++++++++++++++++++++++++++++++++++
> > >  4 files changed, 123 insertions(+)
> > >
> > > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> > > index f121c224e682..5ffbeb3eaac0 100644
> > > --- a/drivers/tee/optee/Kconfig
> > > +++ b/drivers/tee/optee/Kconfig
> > > @@ -7,3 +7,13 @@ config OPTEE
> > >         help
> > >           This implements the OP-TEE Trusted Execution Environment (TEE)
> > >           driver.
> > > +
> > > +config OPTEE_LOAD_IMAGE
> > > +       bool "Load Op-Tee image as firmware"
> >
> > OP-TEE
> Done, fixed in next patch set.
> >
> > > +       default n
> > > +       depends on OPTEE
> > > +       help
> > > +         This loads the BL32 image for OP-TEE as firmware when the driver is probed.
> > > +         This returns -EPROBE_DEFER until the firmware is loadable from the
> > > +         filesystem which is determined by checking the system_state until it is in
> > > +         SYSTEM_RUNNING.
> > > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_msg.h
> > > index 70e9cc2ee96b..84c1b15032a9 100644
> > > --- a/drivers/tee/optee/optee_msg.h
> > > +++ b/drivers/tee/optee/optee_msg.h
> > > @@ -284,6 +284,20 @@ struct optee_msg_arg {
> > >   */
> > >  #define OPTEE_MSG_FUNCID_GET_OS_REVISION       0x0001
> > >
> > > +/*
> > > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > > + *
> > > + * WARNING: Use this cautiously as it could lead to insecure loading of the
> > > + * Trusted OS.
> > > + * This SMC instructs EL3 to load a binary and excute it as the Trusted OS.
> > > + * The first two params are the high and low 32 bits of the size of the payload
> > > + * and the third and fourth params are the high and low 32 bits of the physical
> > > + * address of the payload. The payload is in the OP-TEE image format.
> > > + *
> > > + * Returns 0 on success and an error code otherwise.
> > > + */
> > > +#define OPTEE_MSG_FUNCID_LOAD_IMAGE   0x0002
> >
> > There's no need to add anything to this file, you can define
> > OPTEE_SMC_FUNCID_LOAD_IMAGE to 2 directly in optee_smc.h below.
> >
> Done, fixed in next patch set.
> > > +
> > >  /*
> > >   * Do a secure call with struct optee_msg_arg as argument
> > >   * The OPTEE_MSG_CMD_* below defines what goes in struct optee_msg_arg::cmd
> > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_smc.h
> > > index 73b5e7760d10..908b1005e9db 100644
> > > --- a/drivers/tee/optee/optee_smc.h
> > > +++ b/drivers/tee/optee/optee_smc.h
> > > @@ -104,6 +104,28 @@ struct optee_smc_call_get_os_revision_result {
> > >         unsigned long reserved1;
> > >  };
> > >
> > > +/*
> > > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > > + *
> > > + * WARNING: Use this cautiously as it could lead to insecure loading of the
> > > + * Trusted OS.
> > > + * This SMC instructs EL3 to load a binary and excute it as the Trusted OS.
> >
> > execute
> >
> Done, fixed in next patch set.
> > > + *
> > > + * Call register usage:
> > > + * a0 SMC Function ID, OPTEE_SMC_CALL_LOAD_IMAGE
> > > + * a1 Upper 32bit of a 64bit size for the payload
> > > + * a2 Lower 32bit of a 64bit size for the payload
> > > + * a3 Upper 32bit of the physical address for the payload
> > > + * a4 Lower 32bit of the physical address for the payload
> > > + *
> > > + * The payload is in the OP-TEE image format.
> > > + *
> > > + * Returns result in a0, 0 on success and an error code otherwise.
> > > + */
> > > +#define OPTEE_SMC_FUNCID_LOAD_IMAGE OPTEE_MSG_FUNCID_LOAD_IMAGE
> > > +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> > > +       OPTEE_SMC_FAST_CALL_VAL(OPTEE_SMC_FUNCID_LOAD_IMAGE)
> > > +
> > >  /*
> > >   * Call with struct optee_msg_arg as argument
> > >   *
> > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > > index a1c1fa1a9c28..c1abbee86b39 100644
> > > --- a/drivers/tee/optee/smc_abi.c
> > > +++ b/drivers/tee/optee/smc_abi.c
> > > @@ -8,9 +8,11 @@
> > >
> > >  #include <linux/arm-smccc.h>
> > >  #include <linux/errno.h>
> > > +#include <linux/firmware.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/io.h>
> > >  #include <linux/irqdomain.h>
> > > +#include <linux/kernel.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > > @@ -1354,6 +1356,77 @@ static void optee_shutdown(struct platform_device *pdev)
> > >                 optee_disable_shm_cache(optee);
> > >  }
> > >
> > > +#ifdef CONFIG_OPTEE_LOAD_IMAGE
> > > +
> > > +#define OPTEE_FW_IMAGE "optee/tee.bin"
> > > +
> > > +static int optee_load_fw(struct platform_device *pdev,
> > > +                        optee_invoke_fn *invoke_fn)
> > > +{
> > > +       const struct firmware *fw = NULL;
> > > +       struct arm_smccc_res res;
> > > +       phys_addr_t data_pa;
> > > +       u8 *data_buf = NULL;
> > > +       u64 data_size;
> > > +       u32 data_pa_high, data_pa_low;
> > > +       u32 data_size_high, data_size_low;
> > > +       int rc;
> > > +
> > > +       rc = request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
> > > +       if (rc) {
> > > +               /*
> > > +                * The firmware in the rootfs will not be accessible until we
> > > +                * are in the SYSTEM_RUNNING state, so return EPROBE_DEFER until
> > > +                * that point.
> > > +                */
> > > +               if (system_state < SYSTEM_RUNNING)
> > > +                       return -EPROBE_DEFER;
> > > +               goto fw_err;
> > > +       }
> > > +
> > > +       data_size = fw->size;
> > > +       /*
> > > +        * This uses the GFP_DMA flag to ensure we are allocated memory in the
> > > +        * 32-bit space since TF-A cannot map memory beyond the 32-bit boundary.
> > > +        */
> > > +       data_buf = kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> > > +       if (!data_buf) {
> > > +               rc = -ENOMEM;
> > > +               goto fw_err;
> > > +       }
> > > +       memcpy(data_buf, fw->data, fw->size);
> > > +       data_pa = virt_to_phys(data_buf);
> > > +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> > > +       reg_pair_from_64(&data_size_high, &data_size_low, data_size);
> > > +       goto fw_load;
> > > +
> > > +fw_err:
> > > +       pr_warn("image loading failed\n");
> > > +       data_pa_high = data_pa_low = data_size_high = data_size_low = 0;
> > > +
> > > +fw_load:
> > > +       /*
> > > +        * Always invoke the SMC, even if loading the image fails, to indicate
> > > +        * to EL3 that we have passed the point where it should allow invoking
> > > +        * this SMC.
> > > +        */
> > > +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_low,
> > > +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
> >
> > Prior to this, you've done nothing to check that the firmware might do
> > what you're expecting. optee_msg_api_uid_is_optee_api() does this
> > under normal circumstances as that SMC function is defined in the SMC
> > Calling Convention. I'm not sure what is the best approach here
> > though.
> >
> The way I think about it is that we have to issue this SMC call once
> we are in the SYSTEM_RUNNING state no matter what. We need to close
> the security hole this would leave open otherwise. Any other checks we
> would do that would prevent us from making that call could be other
> attack vectors.

This is clearly a weakness in the design. If the kernel config doesn't
match exactly, we either have an open security hole in the secure
world or fail to initialize the driver. The former can only happen in
systems designed like yours where the kernel up to this point has the
same level of security as the secure world. There's no need for me to
repeat my concerns over that, but this is now going to have an impact
on platforms that don't use your security model too. So far we've
managed to avoid configuration options in the OP-TEE driver that
breaks everything for a class of devices.

Given how important this call is for your platform and at the same
time harmful for all others perhaps this call should be done in a
separate driver.

Thanks,
Jens

> > > +       if (!rc)
> > > +               rc = res.a0;
> > > +       if (fw)
> > > +               release_firmware(fw);
> > > +       kfree(data_buf);
> > > +
> > > +       return rc;
> > > +}
> > > +#else
> > > +static inline int optee_load_fw(struct platform_device *__unused,
> > > +               optee_invoke_fn *__unused) {
> > > +       return 0;
> > > +}
> > > +#endif
> > > +
> > >  static int optee_probe(struct platform_device *pdev)
> > >  {
> > >         optee_invoke_fn *invoke_fn;
> > > @@ -1372,6 +1445,10 @@ static int optee_probe(struct platform_device *pdev)
> > >         if (IS_ERR(invoke_fn))
> > >                 return PTR_ERR(invoke_fn);
> > >
> > > +       rc = optee_load_fw(pdev, invoke_fn);
> > > +       if (rc)
> > > +               return rc;
> >
> > What if OP-TEE already was loaded?
> > This also causes trouble if unloading and loading the driver again.
> > I think we need a way of telling if OP-TEE must be loaded first or not.
> >
> OK, I added some state tracking in the driver code to return the prior
> loading result if it was already loaded.
> > Thanks,
> > Jens
> >
> > > +
> > >         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
> > >                 pr_warn("api uid mismatch\n");
> > >                 return -EINVAL;
> > > --
> > > 2.39.2.637.g21b0678d19-goog
> > >
