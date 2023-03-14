Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 541E56B9421
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCNMlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230470AbjCNMl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:41:29 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC16CA17CB
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:41:03 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id v48so10449218uad.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678797662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaVjr1/kveIDxz5H/pexyiUgqEKlzPjSxpZuZKvtsOM=;
        b=BvK7mdXhEaM1CPH0yK3XzmbeySAfWkJfMPBv+VJqwEcflQwOiO7lQaOqaq1TyRBVXO
         OiEVZnjQsnqRlTdFaaxpLvkZHpgqfJexw2305kktJs/nyrZ5utRV2LwZITPPLMkIzxA5
         yv1UGmKc9siGtbmWWZnoKpJHOGjgoPQ8NpMdLp/V57PYPkR7D4uph8rirP4KR8Y4iwAa
         xWFEHcRiFkGjILFJ8oAWz79SYJsC9prSNa9ZtTUOJDWF07f/gmRsjaEJIgj0d0xygUa5
         6AHc7Fc7jytMwDwcrE7N/wg5DwN0+33bz8ormEiHus4dv6Zxr0cNqmYdAhcIYKreMo00
         jhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678797662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaVjr1/kveIDxz5H/pexyiUgqEKlzPjSxpZuZKvtsOM=;
        b=vVSNTqrXcnOLG/w7O9ODEeRHVY/rz6aSjnkZkDH/C0OCnWT6gmdyjEhHoSJwpYn3Kz
         /tWgJgSX5H77zmxRnY/subs/CyYdS07viiso64CGQlBgvLDhMLl+2Xb1TpOtDCc9mBSv
         Y58NIw+tREtF0FDBt5t/h/JJMLHUewaC2Oyb8VaQ+sIiaPtv7ZtHo05rfLYeZsTAn9ox
         /D7jAnJEAMpUxbmlwQ74L4AV6WXvQ2U7SzeJQlQFa3KL+K15IcwZH+jsQDpIbJlnQtVK
         VtedUBvPjPV45wJubCwM+VNV8CU16U6HzueQGyvrn90cy7bROYw/cQyLb4pchduRHD/J
         kMvQ==
X-Gm-Message-State: AO0yUKVG03kVsXrKKJDFa8BKReRbl9K7swifkVV/roxsGduJgVCyM8nR
        2il6Z8odWEW8GuZZQ07Yy6hrIXpYGcbXRi0BZTvRTS7ILyzjq4QqpcY=
X-Google-Smtp-Source: AK7set+usGshTWvYcUxPDfBgfQ77MuL6AjJ35zRUdN9U3A7FASNOX8aMzEKOKFewYW68sU3cQX73JuxTEzuG8fESc9s=
X-Received: by 2002:a9f:310b:0:b0:663:e17a:e5f6 with SMTP id
 m11-20020a9f310b000000b00663e17ae5f6mr26536376uab.2.1678797662489; Tue, 14
 Mar 2023 05:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230309114319.v6.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
 <CAFA6WYP9Y0fG-2MeUC8rJcwYJodtLucaqeoDe4--fU0RyA8kFg@mail.gmail.com> <CA+ddPcNgkQZ5afwzNX=7nupBhLd0iK9smfCmGGeMtnCTXUcfqw@mail.gmail.com>
In-Reply-To: <CA+ddPcNgkQZ5afwzNX=7nupBhLd0iK9smfCmGGeMtnCTXUcfqw@mail.gmail.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 14 Mar 2023 18:10:51 +0530
Message-ID: <CAFA6WYPLzZcBKmFDfpnYydHxSZ0hL9fu6qfAxSYdFeLdjjMTjA@mail.gmail.com>
Subject: Re: [PATCH v6] tee: optee: Add SMC for loading OP-TEE image
To:     Jeffrey Kardatzke <jkardatzke@chromium.org>
Cc:     op-tee@lists.trustedfirmware.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 at 22:47, Jeffrey Kardatzke <jkardatzke@chromium.org> w=
rote:
>
> On Mon, Mar 13, 2023 at 1:03=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > On Fri, 10 Mar 2023 at 01:13, Jeffrey Kardatzke <jkardatzke@chromium.or=
g> wrote:
> > >
> > > Adds an SMC call that will pass an OP-TEE binary image to EL3 and
> > > instruct it to load it as the BL32 payload. This works in conjunction
> > > with a feature added to Trusted Firmware for ARMv8 and above
> > > architectures that supports this.
> > >
> > > The main purpose of this change is to facilitate updating the OP-TEE
> > > component on devices via a rootfs change rather than having to do a
> > > firmware update. Further details are linked to in the Kconfig file.
> > >
> > > Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> > > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > > ---
> > >
> > > Changes in v6:
> > > - Expanded Kconfig documentation
> > >
> > > Changes in v5:
> > > - Renamed config option
> > > - Added runtime warning when config is used
> > >
> > > Changes in v4:
> > > - Update commit message
> > > - Added more documentation
> > > - Renamed config option, added ARM64 dependency
> > >
> > > Changes in v3:
> > > - Removed state tracking for driver reload
> > > - Check UID of service to verify it needs image load
> > >
> > > Changes in v2:
> > > - Fixed compile issue when feature is disabled
> > > - Addressed minor comments
> > > - Added state tracking for driver reload
> > >
> > >  drivers/tee/optee/Kconfig     | 29 +++++++++++
> > >  drivers/tee/optee/optee_msg.h | 12 +++++
> > >  drivers/tee/optee/optee_smc.h | 24 +++++++++
> > >  drivers/tee/optee/smc_abi.c   | 97 +++++++++++++++++++++++++++++++++=
++
> > >  4 files changed, 162 insertions(+)
> > >
> > > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconfig
> > > index f121c224e682..8d4836c58486 100644
> > > --- a/drivers/tee/optee/Kconfig
> > > +++ b/drivers/tee/optee/Kconfig
> > > @@ -7,3 +7,32 @@ config OPTEE
> > >         help
> > >           This implements the OP-TEE Trusted Execution Environment (T=
EE)
> > >           driver.
> > > +
> > > +config OPTEE_INSECURE_LOAD_IMAGE
> > > +       bool "Load OP-TEE image as firmware"
> > > +       default n
> > > +       depends on OPTEE && ARM64
> > > +       help
> > > +         This loads the BL32 image for OP-TEE as firmware when the d=
river is
> > > +         probed. This returns -EPROBE_DEFER until the firmware is lo=
adable from
> > > +         the filesystem which is determined by checking the system_s=
tate until
> > > +         it is in SYSTEM_RUNNING. This also requires enabling the co=
rresponding
> > > +         option in Trusted Firmware for Arm. The documentation there=
 explains
> > > +         the security threat associated with enabling this as well a=
s
> > > +         mitigations at the firmware and platform level.
> > > +         https://trustedfirmware-a.readthedocs.io/en/latest/threat_m=
odel/threat_model.html
> > > +
> > > +         When utilizing this option, the following mitigations shoul=
d be
> > > +         implemented to prevent attacks at the kernel level.
> > > +         1. There must be boot chain security that verifies the kern=
el and
> > > +            rootfs, otherwise an attacker can modify the loaded OP-T=
EE binary.
> > > +         2. It is recommended to build it as an included driver rath=
er than
> > > +            a module to prevent exploits that may cause the module t=
o not be
> > > +            loaded.
> > > +         3. If there are alternate methods of booting the device, su=
ch as a
> > > +            recovery mode, it should be ensured that the same mitiga=
tions are
> > > +            applied in that mode.
> > > +         4. The OP-TEE driver must be loaded before any potential at=
tack
> > > +            vectors are opened up. This should include mounting of a=
ny
> > > +            modifiable filesystems, opening of network ports or comm=
unicating
> > > +            with external devices (such a USB).
> >
> > This detailed threat model documentation belongs here [1] and it
> > should rather be in following format for every bullet point:
> >
> > Attack vector: <>
> > Mitigation: <>
> >
> > [1] https://docs.kernel.org/staging/tee.html?highlight=3Dtee#op-tee-dri=
ver
> >
>
> Done in v7 patch set.
>
> > > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/optee_=
msg.h
> > > index 70e9cc2ee96b..e8840a82b983 100644
> > > --- a/drivers/tee/optee/optee_msg.h
> > > +++ b/drivers/tee/optee/optee_msg.h
> > > @@ -241,11 +241,23 @@ struct optee_msg_arg {
> > >   * 384fb3e0-e7f8-11e3-af63-0002a5d5c51b.
> > >   * Represented in 4 32-bit words in OPTEE_MSG_UID_0, OPTEE_MSG_UID_1=
,
> > >   * OPTEE_MSG_UID_2, OPTEE_MSG_UID_3.
> > > + *
> > > + * In the case where the OP-TEE image is loaded by the kernel, this =
will
> > > + * initially return an alternate UID to reflect that we are communic=
ating with
> > > + * the TF-A image loading service at that time instead of OP-TEE. Th=
at UID is:
> > > + * a3fbeab1-1246-315d-c7c4-06b9c03cbea4.
> > > + * Represented in 4 32-bit words in OPTEE_MSG_IMAGE_LOAD_UID_0,
> > > + * OPTEE_MSG_IMAGE_LOAD_UID_1, OPTEE_MSG_IMAGE_LOAD_UID_2,
> > > + * OPTEE_MSG_IMAGE_LOAD_UID_3.
> > >   */
> > >  #define OPTEE_MSG_UID_0                        0x384fb3e0
> > >  #define OPTEE_MSG_UID_1                        0xe7f811e3
> > >  #define OPTEE_MSG_UID_2                        0xaf630002
> > >  #define OPTEE_MSG_UID_3                        0xa5d5c51b
> > > +#define OPTEE_MSG_IMAGE_LOAD_UID_0     0xa3fbeab1
> > > +#define OPTEE_MSG_IMAGE_LOAD_UID_1     0x1246315d
> > > +#define OPTEE_MSG_IMAGE_LOAD_UID_2     0xc7c406b9
> > > +#define OPTEE_MSG_IMAGE_LOAD_UID_3     0xc03cbea4
> > >  #define OPTEE_MSG_FUNCID_CALLS_UID     0xFF01
> > >
> > >  /*
> > > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/optee_=
smc.h
> > > index 73b5e7760d10..7d9fa426505b 100644
> > > --- a/drivers/tee/optee/optee_smc.h
> > > +++ b/drivers/tee/optee/optee_smc.h
> > > @@ -104,6 +104,30 @@ struct optee_smc_call_get_os_revision_result {
> > >         unsigned long reserved1;
> > >  };
> > >
> > > +/*
> > > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > > + *
> > > + * WARNING: Use this cautiously as it could lead to insecure loading=
 of the
> > > + * Trusted OS.
> > > + * This SMC instructs EL3 to load a binary and execute it as the Tru=
sted OS.
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
> > > +#define OPTEE_SMC_FUNCID_LOAD_IMAGE 2
> > > +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> > > +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, \
> > > +                          ARM_SMCCC_OWNER_TRUSTED_OS_END, \
> > > +                          OPTEE_SMC_FUNCID_LOAD_IMAGE)
> > > +
> > >  /*
> > >   * Call with struct optee_msg_arg as argument
> > >   *
> > > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.=
c
> > > index a1c1fa1a9c28..00b6b69b6f79 100644
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
> > > @@ -1149,6 +1151,22 @@ static bool optee_msg_api_uid_is_optee_api(opt=
ee_invoke_fn *invoke_fn)
> > >         return false;
> > >  }
> > >
> > > +#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
> > > +static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_fn *i=
nvoke_fn)
> > > +{
> > > +       struct arm_smccc_res res;
> > > +
> > > +       invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res);
> > > +
> > > +       if (res.a0 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_0 &&
> > > +          res.a1 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_1 &&
> > > +          res.a2 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_2 &&
> > > +          res.a3 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_3)
> > > +               return true;
> > > +       return false;
> > > +}
> > > +#endif
> > > +
> > >  static void optee_msg_get_os_revision(optee_invoke_fn *invoke_fn)
> > >  {
> > >         union {
> > > @@ -1354,6 +1372,81 @@ static void optee_shutdown(struct platform_dev=
ice *pdev)
> > >                 optee_disable_shm_cache(optee);
> > >  }
> > >
> > > +#ifdef CONFIG_OPTEE_INSECURE_LOAD_IMAGE
> > > +
> > > +#define OPTEE_FW_IMAGE "optee/tee.bin"
> > > +
> > > +static int optee_load_fw(struct platform_device *pdev,
> > > +                        optee_invoke_fn *invoke_fn)
> > > +{
> > > +       const struct firmware *fw =3D NULL;
> > > +       struct arm_smccc_res res;
> > > +       phys_addr_t data_pa;
> > > +       u8 *data_buf =3D NULL;
> > > +       u64 data_size;
> > > +       u32 data_pa_high, data_pa_low;
> > > +       u32 data_size_high, data_size_low;
> > > +       int rc;
> > > +
> > > +       if (!optee_msg_api_uid_is_optee_image_load(invoke_fn))
> > > +               return 0;
> > > +
> > > +       rc =3D request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev);
> > > +       if (rc) {
> > > +               /*
> > > +                * The firmware in the rootfs will not be accessible =
until we
> > > +                * are in the SYSTEM_RUNNING state, so return EPROBE_=
DEFER until
> > > +                * that point.
> > > +                */
> > > +               if (system_state < SYSTEM_RUNNING)
> > > +                       return -EPROBE_DEFER;
> > > +               goto fw_err;
> > > +       }
> > > +
> > > +       data_size =3D fw->size;
> > > +       /*
> > > +        * This uses the GFP_DMA flag to ensure we are allocated memo=
ry in the
> > > +        * 32-bit space since TF-A cannot map memory beyond the 32-bi=
t boundary.
> > > +        */
> > > +       data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> > > +       if (!data_buf) {
> > > +               rc =3D -ENOMEM;
> > > +               goto fw_err;
> > > +       }
> > > +       memcpy(data_buf, fw->data, fw->size);
> > > +       data_pa =3D virt_to_phys(data_buf);
> > > +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> > > +       reg_pair_from_64(&data_size_high, &data_size_low, data_size);
> > > +       goto fw_load;
> > > +
> > > +fw_err:
> > > +       pr_warn("image loading failed\n");
> > > +       data_pa_high =3D data_pa_low =3D data_size_high =3D data_size=
_low =3D 0;
> > > +
> > > +fw_load:
> > > +       /*
> > > +        * Always invoke the SMC, even if loading the image fails, to=
 indicate
> > > +        * to EL3 that we have passed the point where it should allow=
 invoking
> > > +        * this SMC.
> > > +        */
> > > +       pr_warn("OP-TEE image loaded from kernel, this can be insecur=
e");
> > > +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, data_siz=
e_low,
> > > +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
> >
> > Apart from the security considerations discussed, I see an issue with
> > the implementation here. Here you only initialize OP-TEE on *CPUX*
> > that is performing OP-TEE probe. IIRC, it is required for that CPUX to
> > be primary CPU0. How do we ensure that here?
>
> I'm not aware of any restrictions that require OP-TEE to be loaded on
> CPU0, do you have a point to something that indicates such a
> requirement? (it's always worked fine for me no matter what core it
> inits on)

You can grep in OP-TEE OS code base for keywords like "primary" and
"secondary". This will give you an idea how initialization differs
among primary and secondary CPUs. I would be interested to see the
OP-TEE init log (LOG_LEVEL =3D 4) when the primary CPU is *not* CPU0.
You can try to force that environment using taskset [1] while
installing the OP-TEE module as an out-of-tree build.

The one thing that essentially pops out to me is that, with the
default SPI interrupt routing model (routed to CPU0), OP-TEE won't be
able to handle the secure interrupts until it has been initialized on
CPU0.

[1] https://man7.org/linux/man-pages/man1/taskset.1.html

> >
> > Also, I observe from the TF-A patch that you are doing lazy OP-TEE
> > initialization for other secondary CPUs. IOW, if there is an OP-TEE
> > SMC call invoked for a particular CPU then only you invoke
> > opteed_cpu_on_finish_handler(0) once. This can be a bit unsafe as
> > OP-TEE hasn't setup its context for those CPU which may involve some
> > CPU specific security bits too such as:
> > - GIC CPU interface initialization, secure vs non-secure interrupts.
> > - Any platform and CPU specific TrustZone configuration.
>
> When opteed_cpu_on_finish_handler(0) is invoked...that invokes
> opteed_init_optee_ep_state(...) which then sets up the CPU context for
> that CPU. It then invokes opteed_synchronous_sp_entry for the
> cpu_on_entry handler which should then do any other type of platform
> specific initialization in the OP-TEE code itself. What setup in
> OP-TEE are you referring to that isn't going to be invoked when doing
> it the lazy way?

No, I am not worried about any missing setup but rather deferred
OP-TEE initialization for secondary CPUs after you open up the Linux
attack surface.

>
> >
> > I would have rather expected you to utilize cpuhp_setup_state() and
> > friends to initialize OP-TEE for secondary CPUs during boot instead
> > which is safe as per your platform threat model.
> >
> That could be another way to do it (I'm not familiar with that kernel
> code currently)..

AFAIK, there are many Linux kernel experts within Google who can guide
you through.

> but I'd rather stick with what I have unless there is
> something technically wrong with it since it's already been approved
> in TF-A.

We can very well amend the TF-A implementation with a followup patch.
Given above comments, the approach to initialize OP-TEE on all CPUs at
once during boot should be the correct approach.

-Sumit

>
> > -Sumit
> >
> > > +       if (!rc)
> > > +               rc =3D res.a0;
> > > +       if (fw)
> > > +               release_firmware(fw);
> > > +       kfree(data_buf);
> > > +
> > > +       return rc;
> > > +}
> > > +#else
> > > +static inline int optee_load_fw(struct platform_device *__unused1,
> > > +               optee_invoke_fn *__unused2) {
> > > +       return 0;
> > > +}
> > > +#endif
> > > +
> > >  static int optee_probe(struct platform_device *pdev)
> > >  {
> > >         optee_invoke_fn *invoke_fn;
> > > @@ -1372,6 +1465,10 @@ static int optee_probe(struct platform_device =
*pdev)
> > >         if (IS_ERR(invoke_fn))
> > >                 return PTR_ERR(invoke_fn);
> > >
> > > +       rc =3D optee_load_fw(pdev, invoke_fn);
> > > +       if (rc)
> > > +               return rc;
> > > +
> > >         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
> > >                 pr_warn("api uid mismatch\n");
> > >                 return -EINVAL;
> > > --
> > > 2.40.0.rc1.284.g88254d51c5-goog
> > >
