Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B3C6B7F4A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 18:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbjCMRS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 13:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjCMRSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 13:18:07 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CAB17CDB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:17:36 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id c18so13951588qte.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678727819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDajjesrm61WkoOEDDPxOKy7K/qOj7Vveot/w6vi0Zk=;
        b=B5GeUJNFriUd6+NtujI/FxoWmnU72Y0DaOrydbTc4DgB0kygEYaVgRysnRv4qoj/CE
         P/K9l40moax7x6r3KzE+IxkJyL31pExjI/7jcuuF7jJrU0yDfZn3WW3SCglxZaijF2/T
         WDn29GRw9yeC6RJXoT9m5FEa80FWsq0ZcDL6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678727819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDajjesrm61WkoOEDDPxOKy7K/qOj7Vveot/w6vi0Zk=;
        b=boJ7i0y1kHF5F82QqXau6KiW06Q5M3aWJkGthImnaMYlDHg3HWAPc/ttYI4QK/QBg9
         m2xfwtlCNRmmUajPByL7WE7YltQOnXvVz+qHh/qBBUDDTvg/5BRL6Aik0js3n/axL23d
         KG3XdkeJ4wgKBxwZIIHkuWBCw6EEt9a4vEeK5ldZ8gu2qJFV+Z1gxjT8t//4YPb2XoA9
         NWWlAVple9XQsIeIV5ANRAkjRIqgbt/p0HoURgOkI/mCU5z9/U5H16OprsWu8xyr2jEN
         /geqCymAcC/iRhNZknJpnkcbx6dHOOyN353GTXc/sm4x6benkTOpchA17CUiAVF3cQi0
         z/Zw==
X-Gm-Message-State: AO0yUKUCCcpWZj5bHQi2XB5thTunAUXZcX+AlFuyLAfcxqGNRQeiJei1
        rJ3epLqdB4AFgiAaYEput3GEBpTltPdxL2i/OJM=
X-Google-Smtp-Source: AK7set+Uc2weRr5WjlrbxmM3+PQbwblFHJ1ztBVBbQT71YKRP7SOOu6F8vOz/6EjELg05InTwBxzkg==
X-Received: by 2002:a05:622a:104c:b0:3bf:d8e2:ab0e with SMTP id f12-20020a05622a104c00b003bfd8e2ab0emr26479360qte.23.1678727819365;
        Mon, 13 Mar 2023 10:16:59 -0700 (PDT)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id 17-20020ac84e91000000b003bfeb30c24dsm212296qtp.39.2023.03.13.10.16.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 10:16:58 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-54184571389so105480157b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 10:16:58 -0700 (PDT)
X-Received: by 2002:a81:ac67:0:b0:541:753d:32f9 with SMTP id
 z39-20020a81ac67000000b00541753d32f9mr5007478ywj.9.1678727818235; Mon, 13 Mar
 2023 10:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230309114319.v6.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
 <CAFA6WYP9Y0fG-2MeUC8rJcwYJodtLucaqeoDe4--fU0RyA8kFg@mail.gmail.com>
In-Reply-To: <CAFA6WYP9Y0fG-2MeUC8rJcwYJodtLucaqeoDe4--fU0RyA8kFg@mail.gmail.com>
From:   Jeffrey Kardatzke <jkardatzke@chromium.org>
Date:   Mon, 13 Mar 2023 10:16:46 -0700
X-Gmail-Original-Message-ID: <CA+ddPcNgkQZ5afwzNX=7nupBhLd0iK9smfCmGGeMtnCTXUcfqw@mail.gmail.com>
Message-ID: <CA+ddPcNgkQZ5afwzNX=7nupBhLd0iK9smfCmGGeMtnCTXUcfqw@mail.gmail.com>
Subject: Re: [PATCH v6] tee: optee: Add SMC for loading OP-TEE image
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 1:03=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Fri, 10 Mar 2023 at 01:13, Jeffrey Kardatzke <jkardatzke@chromium.org>=
 wrote:
> >
> > Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> > instruct it to load it as the BL32 payload. This works in conjunction
> > with a feature added to Trusted Firmware for ARMv8 and above
> > architectures that supports this.
> >
> > The main purpose of this change is to facilitate updating the OP-TEE
> > component on devices via a rootfs change rather than having to do a
> > firmware update. Further details are linked to in the Kconfig file.
> >
> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > ---
> >
> > Changes in v6:
> > - Expanded Kconfig documentation
> >
> > Changes in v5:
> > - Renamed config option
> > - Added runtime warning when config is used
> >
> > Changes in v4:
> > - Update commit message
> > - Added more documentation
> > - Renamed config option, added ARM64 dependency
> >
> > Changes in v3:
> > - Removed state tracking for driver reload
> > - Check UID of service to verify it needs image load
> >
> > Changes in v2:
> > - Fixed compile issue when feature is disabled
> > - Addressed minor comments
> > - Added state tracking for driver reload
> >
> >  drivers/tee/optee/Kconfig     | 29 +++++++++++
> >  drivers/tee/optee/optee_msg.h | 12 +++++
> >  drivers/tee/optee/optee_smc.h | 24 +++++++++
> >  drivers/tee/optee/smc_abi.c   | 97 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 162 insertions(+)
> >
> > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> > index f121c224e682..8d4836c58486 100644
> > --- a/drivers/tee/optee/Kconfig
> > +++ b/drivers/tee/optee/Kconfig
> > @@ -7,3 +7,32 @@ config OPTEE
> >         help
> >           This implements the OP-TEE Trusted Execution Environment (TEE=
)
> >           driver.
> > +
> > +config OPTEE_INSECURE_LOAD_IMAGE
> > +       bool "Load OP-TEE image as firmware"
> > +       default n
> > +       depends on OPTEE && ARM64
> > +       help
> > +         This loads the BL32 image for OP-TEE as firmware when the dri=
ver is
> > +         probed. This returns -EPROBE_DEFER until the firmware is load=
able from
> > +         the filesystem which is determined by checking the system_sta=
te until
> > +         it is in SYSTEM_RUNNING. This also requires enabling the corr=
esponding
> > +         option in Trusted Firmware for Arm. The documentation there e=
xplains
> > +         the security threat associated with enabling this as well as
> > +         mitigations at the firmware and platform level.
> > +         https://trustedfirmware-a.readthedocs.io/en/latest/threat_mod=
el/threat_model.html
> > +
> > +         When utilizing this option, the following mitigations should =
be
> > +         implemented to prevent attacks at the kernel level.
> > +         1. There must be boot chain security that verifies the kernel=
 and
> > +            rootfs, otherwise an attacker can modify the loaded OP-TEE=
 binary.
> > +         2. It is recommended to build it as an included driver rather=
 than
> > +            a module to prevent exploits that may cause the module to =
not be
> > +            loaded.
> > +         3. If there are alternate methods of booting the device, such=
 as a
> > +            recovery mode, it should be ensured that the same mitigati=
ons are
> > +            applied in that mode.
> > +         4. The OP-TEE driver must be loaded before any potential atta=
ck
> > +            vectors are opened up. This should include mounting of any
> > +            modifiable filesystems, opening of network ports or commun=
icating
> > +            with external devices (such a USB).
>
> This detailed threat model documentation belongs here [1] and it
> should rather be in following format for every bullet point:
>
> Attack vector: <>
> Mitigation: <>
>
> [1] https://docs.kernel.org/staging/tee.html?highlight=3Dtee#op-tee-drive=
r
>

Done in v7 patch set.

> > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_ms=
g.h
> > index 70e9cc2ee96b..e8840a82b983 100644
> > --- a/drivers/tee/optee/optee_msg.h
> > +++ b/drivers/tee/optee/optee_msg.h
> > @@ -241,11 +241,23 @@ struct optee_msg_arg {
> >   * 384fb3e0-e7f8-11e3-af63-0002a5d5c51b.
> >   * Represented in 4 32-bit words in OPTEE_MSG_UID_0, OPTEE_MSG_UID_1,
> >   * OPTEE_MSG_UID_2, OPTEE_MSG_UID_3.
> > + *
> > + * In the case where the OP-TEE image is loaded by the kernel, this wi=
ll
> > + * initially return an alternate UID to reflect that we are communicat=
ing with
> > + * the TF-A image loading service at that time instead of OP-TEE. That=
 UID is:
> > + * a3fbeab1-1246-315d-c7c4-06b9c03cbea4.
> > + * Represented in 4 32-bit words in OPTEE_MSG_IMAGE_LOAD_UID_0,
> > + * OPTEE_MSG_IMAGE_LOAD_UID_1, OPTEE_MSG_IMAGE_LOAD_UID_2,
> > + * OPTEE_MSG_IMAGE_LOAD_UID_3.
> >   */
> >  #define OPTEE_MSG_UID_0                        0x384fb3e0
> >  #define OPTEE_MSG_UID_1                        0xe7f811e3
> >  #define OPTEE_MSG_UID_2                        0xaf630002
> >  #define OPTEE_MSG_UID_3                        0xa5d5c51b
> > +#define OPTEE_MSG_IMAGE_LOAD_UID_0     0xa3fbeab1
> > +#define OPTEE_MSG_IMAGE_LOAD_UID_1     0x1246315d
> > +#define OPTEE_MSG_IMAGE_LOAD_UID_2     0xc7c406b9
> > +#define OPTEE_MSG_IMAGE_LOAD_UID_3     0xc03cbea4
> >  #define OPTEE_MSG_FUNCID_CALLS_UID     0xFF01
> >
> >  /*
> > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_sm=
c.h
> > index 73b5e7760d10..7d9fa426505b 100644
> > --- a/drivers/tee/optee/optee_smc.h
> > +++ b/drivers/tee/optee/optee_smc.h
> > @@ -104,6 +104,30 @@ struct optee_smc_call_get_os_revision_result {
> >         unsigned long reserved1;
> >  };
> >
> > +/*
> > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > + *
> > + * WARNING: Use this cautiously as it could lead to insecure loading o=
f the
> > + * Trusted OS.
> > + * This SMC instructs EL3 to load a binary and execute it as the Trust=
ed OS.
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
> > +#define OPTEE_SMC_FUNCID_LOAD_IMAGE 2
> > +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> > +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
> > +                          ARM_SMCCC_OWNER_TRUSTED_OS_END, \
> > +                          OPTEE_SMC_FUNCID_LOAD_IMAGE)
> > +
> >  /*
> >   * Call with struct optee_msg_arg as argument
> >   *
> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> > index a1c1fa1a9c28..00b6b69b6f79 100644
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
> > @@ -1149,6 +1151,22 @@ static bool optee_msg_api_uid_is_optee_api(optee=
_invoke_fn *invoke_fn)
> >         return false;
> >  }
> >
> > +#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
> > +static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *inv=
oke_fn)
> > +{
> > +       struct arm_smccc_res res;
> > +
> > +       invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res);
> > +
> > +       if (res.a0 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_0 &&
> > +          res.a1 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_1 &&
> > +          res.a2 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_2 &&
> > +          res.a3 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_3)
> > +               return true;
> > +       return false;
> > +}
> > +#endif
> > +
> >  static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
> >  {
> >         union {
> > @@ -1354,6 +1372,81 @@ static void optee_shutdown(struct platform_devic=
e *pdev)
> >                 optee_disable_shm_cache(optee);
> >  }
> >
> > +#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
> > +
> > +#define OPTEE_FW_IMAGE "optee/tee.bin"
> > +
> > +static int optee_load_fw(struct platform_device *pdev,
> > +                        optee_invoke_fn *invoke_fn)
> > +{
> > +       const struct firmware *fw =3D NULL;
> > +       struct arm_smccc_res res;
> > +       phys_addr_t data_pa;
> > +       u8 *data_buf =3D NULL;
> > +       u64 data_size;
> > +       u32 data_pa_high, data_pa_low;
> > +       u32 data_size_high, data_size_low;
> > +       int rc;
> > +
> > +       if (!optee_msg_api_uid_is_optee_image_load(invoke_fn))
> > +               return 0;
> > +
> > +       rc =3D request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
> > +       if (rc) {
> > +               /*
> > +                * The firmware in the rootfs will not be accessible un=
til we
> > +                * are in the SYSTEM_RUNNING state, so return EPROBE_DE=
FER until
> > +                * that point.
> > +                */
> > +               if (system_state < SYSTEM_RUNNING)
> > +                       return -EPROBE_DEFER;
> > +               goto fw_err;
> > +       }
> > +
> > +       data_size =3D fw->size;
> > +       /*
> > +        * This uses the GFP_DMA flag to ensure we are allocated memory=
 in the
> > +        * 32-bit space since TF-A cannot map memory beyond the 32-bit =
boundary.
> > +        */
> > +       data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> > +       if (!data_buf) {
> > +               rc =3D -ENOMEM;
> > +               goto fw_err;
> > +       }
> > +       memcpy(data_buf, fw->data, fw->size);
> > +       data_pa =3D virt_to_phys(data_buf);
> > +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> > +       reg_pair_from_64(&data_size_high, &data_size_low, data_size);
> > +       goto fw_load;
> > +
> > +fw_err:
> > +       pr_warn("image loading failed\n");
> > +       data_pa_high =3D data_pa_low =3D data_size_high =3D data_size_l=
ow =3D 0;
> > +
> > +fw_load:
> > +       /*
> > +        * Always invoke the SMC, even if loading the image fails, to i=
ndicate
> > +        * to EL3 that we have passed the point where it should allow i=
nvoking
> > +        * this SMC.
> > +        */
> > +       pr_warn("OP-TEE image loaded from kernel, this can be insecure"=
);
> > +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_size_=
low,
> > +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
>
> Apart from the security considerations discussed, I see an issue with
> the implementation here. Here you only initialize OP-TEE on *CPUX*
> that is performing OP-TEE probe. IIRC, it is required for that CPUX to
> be primary CPU0. How do we ensure that here?

I'm not aware of any restrictions that require OP-TEE to be loaded on
CPU0, do you have a point to something that indicates such a
requirement? (it's always worked fine for me no matter what core it
inits on)
>
> Also, I observe from the TF-A patch that you are doing lazy OP-TEE
> initialization for other secondary CPUs. IOW, if there is an OP-TEE
> SMC call invoked for a particular CPU then only you invoke
> opteed_cpu_on_finish_handler(0) once. This can be a bit unsafe as
> OP-TEE hasn't setup its context for those CPU which may involve some
> CPU specific security bits too such as:
> - GIC CPU interface initialization, secure vs non-secure interrupts.
> - Any platform and CPU specific TrustZone configuration.

When opteed_cpu_on_finish_handler(0) is invoked...that invokes
opteed_init_optee_ep_state(...) which then sets up the CPU context for
that CPU. It then invokes opteed_synchronous_sp_entry for the
cpu_on_entry handler which should then do any other type of platform
specific initialization in the OP-TEE code itself. What setup in
OP-TEE are you referring to that isn't going to be invoked when doing
it the lazy way?

>
> I would have rather expected you to utilize cpuhp_setup_state() and
> friends to initialize OP-TEE for secondary CPUs during boot instead
> which is safe as per your platform threat model.
>
That could be another way to do it (I'm not familiar with that kernel
code currently)..but I'd rather stick with what I have unless there is
something technically wrong with it since it's already been approved
in TF-A.

> -Sumit
>
> > +       if (!rc)
> > +               rc =3D res.a0;
> > +       if (fw)
> > +               release_firmware(fw);
> > +       kfree(data_buf);
> > +
> > +       return rc;
> > +}
> > +#else
> > +static inline int optee_load_fw(struct platform_device *__unused1,
> > +               optee_invoke_fn *__unused2) {
> > +       return 0;
> > +}
> > +#endif
> > +
> >  static int optee_probe(struct platform_device *pdev)
> >  {
> >         optee_invoke_fn *invoke_fn;
> > @@ -1372,6 +1465,10 @@ static int optee_probe(struct platform_device *p=
dev)
> >         if (IS_ERR(invoke_fn))
> >                 return PTR_ERR(invoke_fn);
> >
> > +       rc =3D optee_load_fw(pdev, invoke_fn);
> > +       if (rc)
> > +               return rc;
> > +
> >         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
> >                 pr_warn("api uid mismatch\n");
> >                 return -EINVAL;
> > --
> > 2.40.0.rc1.284.g88254d51c5-goog
> >
