Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319906B2DE0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 20:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCITn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 14:43:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCITnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 14:43:23 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70244474D0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 11:43:20 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id cw28so11522425edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 11:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678390998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xNtx6R6rl7SLA2Sw0Xc/NcvtWXxM5jC3ZZ5F1GogymY=;
        b=FuBYHFo+DCqFy711BqRQ3GHdfKl2uqpIFyo1N1qJyHCGJSPcwycdLQoLC6hCrUkrxu
         h1IuQDJYnFf0fHpEk4tRTPIF+9jbhQnp5h3EO4+5gRyt0sbhGc9nF59hFJmocI3wTUNi
         Tief5Yvps/UJsbzXlb8KPkt2U8h+s1YLUF2+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678390998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xNtx6R6rl7SLA2Sw0Xc/NcvtWXxM5jC3ZZ5F1GogymY=;
        b=s93eMcsTpcNCvo4lu6FG9jItVTm71vbrJtfQ8/EPq+xZZLAJZ+WzqKpBLiDTlx0X0F
         kX+VS7vwMSSkC+ynZuN6XG6IY97N3LnAmNiH9qzs+UtmnI9yf786NIZ85oNX2AanZy/d
         ri1+HMzg7cTJu7UFUZZ+VNRA7E1hP9pe6jxVD2Iiy6+KCWZG+kbYAyRI6WHL6kT+3adc
         S7lvH22eO1GcD04P/EdEw0CeL0okwzT89TurGJhwe9Tf64s/D8gGtZCBxkrJJkD7jsVu
         b1gZo2PhK4R8wHH0/dyiTPhDxkRvsR11n7P7b96YI+loqW1TrcRcMO6W2cBh9BQdNU+e
         FmTw==
X-Gm-Message-State: AO0yUKVIaJEersoxwmRksUn/NVEXRwDzttCJOgH2vrzGDoREpuVhOdaF
        54ZeGj+zrjx6srtsLjxGZjINfx3WbcdJtHKJIvk=
X-Google-Smtp-Source: AK7set+mFHa/PsX4+hhho2wvrn9u2mXV/w6VLlQoMfrO2JtV48S0xdWtNKRxpkaEkdonRbnh14qPQA==
X-Received: by 2002:aa7:c585:0:b0:4bf:38dc:d78 with SMTP id g5-20020aa7c585000000b004bf38dc0d78mr22880372edq.21.1678390998460;
        Thu, 09 Mar 2023 11:43:18 -0800 (PST)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id k20-20020a17090627d400b008b17ca37966sm9269302ejc.148.2023.03.09.11.43.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 11:43:17 -0800 (PST)
Received: by mail-wm1-f48.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso4444018wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 11:43:17 -0800 (PST)
X-Received: by 2002:a05:600c:54c8:b0:3eb:2e27:2cf4 with SMTP id
 iw8-20020a05600c54c800b003eb2e272cf4mr33042wmb.0.1678390996697; Thu, 09 Mar
 2023 11:43:16 -0800 (PST)
MIME-Version: 1.0
References: <20230302120648.v3.1.I8e7f9b01d9ac940507d78e15368e200a6a69bedb@changeid>
 <CAFA6WYNuyy2kDpQzEap97dXQxPr+oKE4pvA5PKiow3Dqdx_G7w@mail.gmail.com>
 <CA+ddPcNASYd_mD2ZPB-D=oxpAOZOChrQ+6f7+9yvneLKQm3rCA@mail.gmail.com>
 <CAFA6WYMnpvTOTDFMfR7AnkT7FrWxxhcNf0uhndMjUwi5+WCQfQ@mail.gmail.com>
 <CA+ddPcMvY-VYVy6O0XUdKBEVw6ncqfgzw9C1BCRkqg0_G3DSfQ@mail.gmail.com> <CAFA6WYNXWnSvM4gGu0vWuio+cBqZsaYXbvRNczbH6pKYP9DC2Q@mail.gmail.com>
In-Reply-To: <CAFA6WYNXWnSvM4gGu0vWuio+cBqZsaYXbvRNczbH6pKYP9DC2Q@mail.gmail.com>
From:   Jeffrey Kardatzke <jkardatzke@chromium.org>
Date:   Thu, 9 Mar 2023 11:43:04 -0800
X-Gmail-Original-Message-ID: <CA+ddPcPyMu5RX841tEQTNx1yJgeL88T_0AiWThjWmf=vv6_3fQ@mail.gmail.com>
Message-ID: <CA+ddPcPyMu5RX841tEQTNx1yJgeL88T_0AiWThjWmf=vv6_3fQ@mail.gmail.com>
Subject: Re: [PATCH v3] tee: optee: Add SMC for loading OP-TEE image
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

On Wed, Mar 8, 2023 at 11:54=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org> =
wrote:
>
> On Wed, 8 Mar 2023 at 01:09, Jeffrey Kardatzke <jkardatzke@chromium.org> =
wrote:
> >
> > On Tue, Mar 7, 2023 at 6:04=E2=80=AFAM Sumit Garg <sumit.garg@linaro.or=
g> wrote:
> > >
> > > On Tue, 7 Mar 2023 at 00:26, Jeffrey Kardatzke <jkardatzke@chromium.o=
rg> wrote:
> > > >
> > > >
> > > >
> > > > On Mon, Mar 6, 2023 at 4:34=E2=80=AFAM Sumit Garg <sumit.garg@linar=
o.org> wrote:
> > > >>
> > > >> On Fri, 3 Mar 2023 at 01:37, Jeffrey Kardatzke <jkardatzke@chromiu=
m.org> wrote:
> > > >> >
> > > >> > Adds an SMC call that will pass an OP-TEE binary image to EL3 an=
d
> > > >> > instruct it to load it as the BL32 payload. This works in conjun=
ction
> > > >> > with a feature added to Trusted Firmware for ARM that supports t=
his.
> > > >>
> > > >> s/Trusted Firmware for ARM/Trusted Firmware for Armv8 and above ar=
chitectures/
> > > >>
> > > > Fixed in next patch.
> > > >>
> > > >> This commit description tells me what you have implemented but not
> > > >> why? The motivation for this change should be included here along =
with
> > > >> security implications.
> > > >>
> > > > Fixed in next patch. I added another sentence on this and then link=
ed to the TF-A documentation that explains the threat model and security im=
plications. Enabling the kernel feature itself won't create any security co=
ncerns; it's only if TF-A has the feature enabled is there a risk introduce=
d.
> > >
> > > Do you have a scenario where this feature would be at all useful in
> > > the kernel without it being enabled in TF-A?
> >
> > No
> > >
> > >
> > > So once you enable this feature in TF-A, isn't the kernel included in
> > > the trust boundary for the secure world to do the right thing? IOW,
> > > mitigations for potential attack vectors have to be implemented in th=
e
> > > kernel such as (from top of my head):
> > >
> > > - The OP-TEE kernel module has to be signature checked.
> > > - The OP-TEE firmware has to be loaded from a RO filesystem which has
> > > been signature checked.
> > > - How can we prevent other system entities like DMA capable devices
> > > from mangling RAM where OP-TEE firmware is loaded during SMC call?
> > > - How can we ensure that the OP-TEE firmware is loaded at the earlies=
t
> > > point before exposing it to the user-space attack vectors?
> >
> > This is covered in the TF-A documentation linked to by this statement
> > in the mitigations section: "When enabling the option
> > OPTEE_ALLOW_SMC_LOAD, the non-secure OS must be considered a closed
> > platform up until the point the SMC can be invoked to load OP-TEE."
> > It's also expanded on in the linked section here:
> > https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/c=
omponents/spd/optee-dispatcher.rst
> >
>
> "A closed platform" is a very abstract and opaque term. The TF-A
> threat model doesn't cover any Linux kernel attack vectors as I
> mentioned above.
>
Ack
> > For ChromeOS, the entire kernel/rootfs is signature checked. Other DMA
> > devices could modify the memory where OP-TEE is loaded from...so the
> > platform needs to ensure all firmware/drivers are signed (which we
> > achieve by signing the entire rootfs). As for loading it early, it can
> > be included rather than being a module to achieve that (or it can be a
> > module and should be probed as early as possible after the kernel
> > loads).
>
> These are the bits I am looking to be documented which mentions the
> kernel attack vectors and corresponding mitigations for ChromeOS. It
> would be helpful for other platform owners if the threat model sounds
> fine to them and choose to enable this feature. Also, it would give
> clarity regarding how this feature is being enabled for a real
> platform use-case.
>
> > This is definitely not intended to be "here's a checklist, if
> > you cover it then you're safe to use this option."
>
> The threat model for a particular platform component is essentially a
> checklist which must be considered during system integration.
>
Ack
> > Anybody using this
> > needs to evaluate their overall platform security and be sure this
> > fits with their model.
>
> That's true. In case there is platform security documentation
> available for ChromeOS platform publicly which covers attack vectors
> for every component, that would work for me.
There isn't anything on this currently available publicly. I've
updated the documentation in the Kconfig file now based on your above
comments. Please review.
>
> -Sumit
>
> > >
> > >
> > > >>
> > > >> >
> > > >> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@chromium.org>
> > > >> > Signed-off-by: Jeffrey Kardatzke <jkardatzke@google.com>
> > > >> > ---
> > > >> >
> > > >> > Changes in v3:
> > > >> > - Removed state tracking for driver reload
> > > >> > - Check UID of service to verify it needs image load
> > > >> >
> > > >> > Changes in v2:
> > > >> > - Fixed compile issue when feature is disabled
> > > >> > - Addressed minor comments
> > > >> > - Added state tracking for driver reload
> > > >> >
> > > >> >  drivers/tee/optee/Kconfig     | 10 ++++
> > > >> >  drivers/tee/optee/optee_msg.h | 12 +++++
> > > >> >  drivers/tee/optee/optee_smc.h | 24 +++++++++
> > > >> >  drivers/tee/optee/smc_abi.c   | 96 ++++++++++++++++++++++++++++=
+++++++
> > > >> >  4 files changed, 142 insertions(+)
> > > >> >
> > > >> > diff --git a/drivers/tee/optee/Kconfig b/drivers/tee/optee/Kconf=
ig
> > > >> > index f121c224e682..f0f12b146add 100644
> > > >> > --- a/drivers/tee/optee/Kconfig
> > > >> > +++ b/drivers/tee/optee/Kconfig
> > > >> > @@ -7,3 +7,13 @@ config OPTEE
> > > >> >         help
> > > >> >           This implements the OP-TEE Trusted Execution Environme=
nt (TEE)
> > > >> >           driver.
> > > >> > +
> > > >> > +config OPTEE_LOAD_IMAGE
> > > >>
> > > >> Given the warning text attached to this config option, this should=
 be
> > > >> renamed as OPTEE_INSECURE_LOAD_IMAGE. Also, the help text should b=
e
> > > >> updated to reflect the security implication of this.
> > > >
> > > > OK, I renamed this to OPTEE_NONSECURE_LOAD_IMAGE (to reflect that i=
t's loading the secure image from the non-secure world).
> > >
> > > No this has to be an insecure OP-TEE module configuration which
> > > currently only works for your platform threat model. I would also be
> > > in favour of a runtime warning if this option is enabled.
> >
> > OK, renamed it to OPTEE_INSECURE_LOAD_IMAGE and added a runtime warning=
.
> > >
> > >
> > > > I also added more comments on the security implications and that fu=
ll documentation is in TF-A.
> > > >>
> > > >>
> > > >> I would also like to see documentation updates regarding how your
> > > >> platform is mitigating potential threats in order to enable this
> > > >> option. It would enable others to make a concious decision if thei=
r
> > > >> threat model allows this option.
> > > >
> > > > This is already covered in the TF-A documentation. Let me know if y=
ou want me to link to that from here or not.
> > >
> > > I am looking for documentation regarding risk mitigations in the
> > > kernel (see above), basically how one should configure their kernel.
> > > Maybe I have overlooked it but I can't find that in the TF-A
> > > documentation.
> >
> > It's not so much the kernel config...but the platform config overall.
> > This section linked to from the TF-A thread model describes that even
> > further:
> > https://github.com/ARM-software/arm-trusted-firmware/blob/master/docs/c=
omponents/spd/optee-dispatcher.rst
> > >
> > >
> > > -Sumit
> > >
> > > >>
> > > >>
> > > >> > +       bool "Load OP-TEE image as firmware"
> > > >> > +       default n
> > > >> > +       depends on OPTEE
> > > >>
> > > >> IIRC, from earlier review threads you mentioned that this option i=
s
> > > >> enabled when OP-TEE driver is built-in rather than loadable. Shoul=
dn't
> > > >> we make that dependency explicit?
> > > >
> > > > That was an issue with a prior patch set, but has since been fixed.=
 This can work as a built in driver or loadable module now.
> > > >>
> > > >>
> > > >> Also, this option only makes sense for ARM64 as in case of ARM the
> > > >> secure monitor is bundled into OP-TEE image and hence can't be loa=
ded
> > > >> dynamically. We should make that dependency explicit too.
> > > >
> > > > Fixed.
> > > >>
> > > >>
> > > >> > +       help
> > > >> > +         This loads the BL32 image for OP-TEE as firmware when =
the driver is probed.
> > > >> > +         This returns -EPROBE_DEFER until the firmware is loada=
ble from the
> > > >> > +         filesystem which is determined by checking the system_=
state until it is in
> > > >> > +         SYSTEM_RUNNING.
> > > >> > diff --git a/drivers/tee/optee/optee_msg.h b/drivers/tee/optee/o=
ptee_msg.h
> > > >> > index 70e9cc2ee96b..237d6fa9a6e8 100644
> > > >> > --- a/drivers/tee/optee/optee_msg.h
> > > >> > +++ b/drivers/tee/optee/optee_msg.h
> > > >> > @@ -241,11 +241,23 @@ struct optee_msg_arg {
> > > >> >   * 384fb3e0-e7f8-11e3-af63-0002a5d5c51b.
> > > >> >   * Represented in 4 32-bit words in OPTEE_MSG_UID_0, OPTEE_MSG_=
UID_1,
> > > >> >   * OPTEE_MSG_UID_2, OPTEE_MSG_UID_3.
> > > >> > + *
> > > >> > + * In the case where the OP-TEE image is loaded by the kernel, =
this will
> > > >> > + * initially return an alternate UID to reflect that we are com=
municating with
> > > >> > + * the TF-A image loading service at that time instead of OP-TE=
E. That UID is:
> > > >> > + * a3fbeab1-1246-315d-c7c4-06b9c03cbea4.
> > > >> > + * Represetned in 4 32-bit words in OPTEE_MSG_IMAGE_LOAD_UID_0,
> > > >>
> > > >> s/Represetned/Represented/
> > > >>
> > > > Fixed.
> > > >>
> > > >> > + * OPTEE_MSG_IMAGE_LOAD_UID_1, OPTEE_MSG_IMAGE_LOAD_UID_2,
> > > >> > + * OPTEE_MSG_IMAGE_LOAD_UID_3.
> > > >> >   */
> > > >> >  #define OPTEE_MSG_UID_0                        0x384fb3e0
> > > >> >  #define OPTEE_MSG_UID_1                        0xe7f811e3
> > > >> >  #define OPTEE_MSG_UID_2                        0xaf630002
> > > >> >  #define OPTEE_MSG_UID_3                        0xa5d5c51b
> > > >> > +#define OPTEE_MSG_IMAGE_LOAD_UID_0     0xa3fbeab1
> > > >> > +#define OPTEE_MSG_IMAGE_LOAD_UID_1     0x1246315d
> > > >> > +#define OPTEE_MSG_IMAGE_LOAD_UID_2     0xc7c406b9
> > > >> > +#define OPTEE_MSG_IMAGE_LOAD_UID_3     0xc03cbea4
> > > >> >  #define OPTEE_MSG_FUNCID_CALLS_UID     0xFF01
> > > >> >
> > > >> >  /*
> > > >> > diff --git a/drivers/tee/optee/optee_smc.h b/drivers/tee/optee/o=
ptee_smc.h
> > > >> > index 73b5e7760d10..7d9fa426505b 100644
> > > >> > --- a/drivers/tee/optee/optee_smc.h
> > > >> > +++ b/drivers/tee/optee/optee_smc.h
> > > >> > @@ -104,6 +104,30 @@ struct optee_smc_call_get_os_revision_resul=
t {
> > > >> >         unsigned long reserved1;
> > > >> >  };
> > > >> >
> > > >> > +/*
> > > >> > + * Load Trusted OS from optee/tee.bin in the Linux firmware.
> > > >> > + *
> > > >> > + * WARNING: Use this cautiously as it could lead to insecure lo=
ading of the
> > > >> > + * Trusted OS.
> > > >> > + * This SMC instructs EL3 to load a binary and execute it as th=
e Trusted OS.
> > > >> > + *
> > > >> > + * Call register usage:
> > > >> > + * a0 SMC Function ID, OPTEE_SMC_CALL_LOAD_IMAGE
> > > >> > + * a1 Upper 32bit of a 64bit size for the payload
> > > >> > + * a2 Lower 32bit of a 64bit size for the payload
> > > >> > + * a3 Upper 32bit of the physical address for the payload
> > > >> > + * a4 Lower 32bit of the physical address for the payload
> > > >> > + *
> > > >> > + * The payload is in the OP-TEE image format.
> > > >> > + *
> > > >> > + * Returns result in a0, 0 on success and an error code otherwi=
se.
> > > >> > + */
> > > >> > +#define OPTEE_SMC_FUNCID_LOAD_IMAGE 2
> > > >> > +#define OPTEE_SMC_CALL_LOAD_IMAGE \
> > > >> > +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32=
, \
> > > >> > +                          ARM_SMCCC_OWNER_TRUSTED_OS_END, \
> > > >> > +                          OPTEE_SMC_FUNCID_LOAD_IMAGE)
> > > >> > +
> > > >> >  /*
> > > >> >   * Call with struct optee_msg_arg as argument
> > > >> >   *
> > > >> > diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc=
_abi.c
> > > >> > index a1c1fa1a9c28..14612edef8f2 100644
> > > >> > --- a/drivers/tee/optee/smc_abi.c
> > > >> > +++ b/drivers/tee/optee/smc_abi.c
> > > >> > @@ -8,9 +8,11 @@
> > > >> >
> > > >> >  #include <linux/arm-smccc.h>
> > > >> >  #include <linux/errno.h>
> > > >> > +#include <linux/firmware.h>
> > > >> >  #include <linux/interrupt.h>
> > > >> >  #include <linux/io.h>
> > > >> >  #include <linux/irqdomain.h>
> > > >> > +#include <linux/kernel.h>
> > > >> >  #include <linux/mm.h>
> > > >> >  #include <linux/module.h>
> > > >> >  #include <linux/of.h>
> > > >> > @@ -1149,6 +1151,22 @@ static bool optee_msg_api_uid_is_optee_ap=
i(optee_invoke_fn *invoke_fn)
> > > >> >         return false;
> > > >> >  }
> > > >> >
> > > >> > +#ifdef CONFIG_OPTEE_LOAD_IMAGE
> > > >> > +static bool optee_msg_api_uid_is_optee_image_load(optee_invoke_=
fn *invoke_fn)
> > > >> > +{
> > > >> > +       struct arm_smccc_res res;
> > > >> > +
> > > >> > +       invoke_fn(OPTEE_SMC_CALLS_UID, 0, 0, 0, 0, 0, 0, 0, &res=
);
> > > >> > +
> > > >> > +       if (res.a0 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_0 &&
> > > >> > +          res.a1 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_1 &&
> > > >> > +          res.a2 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_2 &&
> > > >> > +          res.a3 =3D=3D OPTEE_MSG_IMAGE_LOAD_UID_3)
> > > >> > +               return true;
> > > >> > +       return false;
> > > >> > +}
> > > >> > +#endif
> > > >> > +
> > > >> >  static void optee_msg_get_os_revision(optee_invoke_fn *invoke_f=
n)
> > > >> >  {
> > > >> >         union {
> > > >> > @@ -1354,6 +1372,80 @@ static void optee_shutdown(struct platfor=
m_device *pdev)
> > > >> >                 optee_disable_shm_cache(optee);
> > > >> >  }
> > > >> >
> > > >> > +#ifdef CONFIG_OPTEE_LOAD_IMAGE
> > > >> > +
> > > >> > +#define OPTEE_FW_IMAGE "optee/tee.bin"
> > > >> > +
> > > >> > +static int optee_load_fw(struct platform_device *pdev,
> > > >> > +                        optee_invoke_fn *invoke_fn)
> > > >> > +{
> > > >> > +       const struct firmware *fw =3D NULL;
> > > >> > +       struct arm_smccc_res res;
> > > >> > +       phys_addr_t data_pa;
> > > >> > +       u8 *data_buf =3D NULL;
> > > >> > +       u64 data_size;
> > > >> > +       u32 data_pa_high, data_pa_low;
> > > >> > +       u32 data_size_high, data_size_low;
> > > >> > +       int rc;
> > > >> > +
> > > >> > +       if (!optee_msg_api_uid_is_optee_image_load(invoke_fn))
> > > >> > +               return 0;
> > > >> > +
> > > >> > +       rc =3D request_firmware(&fw, OPTEE_FW_IMAGE, &pdev->dev)=
;
> > > >> > +       if (rc) {
> > > >> > +               /*
> > > >> > +                * The firmware in the rootfs will not be access=
ible until we
> > > >> > +                * are in the SYSTEM_RUNNING state, so return EP=
ROBE_DEFER until
> > > >> > +                * that point.
> > > >> > +                */
> > > >> > +               if (system_state < SYSTEM_RUNNING)
> > > >> > +                       return -EPROBE_DEFER;
> > > >> > +               goto fw_err;
> > > >> > +       }
> > > >> > +
> > > >> > +       data_size =3D fw->size;
> > > >> > +       /*
> > > >> > +        * This uses the GFP_DMA flag to ensure we are allocated=
 memory in the
> > > >> > +        * 32-bit space since TF-A cannot map memory beyond the =
32-bit boundary.
> > > >> > +        */
> > > >> > +       data_buf =3D kmalloc(fw->size, GFP_KERNEL | GFP_DMA);
> > > >> > +       if (!data_buf) {
> > > >> > +               rc =3D -ENOMEM;
> > > >> > +               goto fw_err;
> > > >> > +       }
> > > >> > +       memcpy(data_buf, fw->data, fw->size);
> > > >> > +       data_pa =3D virt_to_phys(data_buf);
> > > >> > +       reg_pair_from_64(&data_pa_high, &data_pa_low, data_pa);
> > > >> > +       reg_pair_from_64(&data_size_high, &data_size_low, data_s=
ize);
> > > >> > +       goto fw_load;
> > > >> > +
> > > >> > +fw_err:
> > > >> > +       pr_warn("image loading failed\n");
> > > >> > +       data_pa_high =3D data_pa_low =3D data_size_high =3D data=
_size_low =3D 0;
> > > >> > +
> > > >> > +fw_load:
> > > >> > +       /*
> > > >> > +        * Always invoke the SMC, even if loading the image fail=
s, to indicate
> > > >> > +        * to EL3 that we have passed the point where it should =
allow invoking
> > > >> > +        * this SMC.
> > > >> > +        */
> > > >> > +       invoke_fn(OPTEE_SMC_CALL_LOAD_IMAGE, data_size_high, dat=
a_size_low,
> > > >> > +                 data_pa_high, data_pa_low, 0, 0, 0, &res);
> > > >> > +       if (!rc)
> > > >> > +               rc =3D res.a0;
> > > >> > +       if (fw)
> > > >> > +               release_firmware(fw);
> > > >> > +       kfree(data_buf);
> > > >> > +
> > > >> > +       return rc;
> > > >> > +}
> > > >> > +#else
> > > >> > +static inline int optee_load_fw(struct platform_device *__unuse=
d1,
> > > >> > +               optee_invoke_fn *__unused2) {
> > > >> > +       return 0;
> > > >> > +}
> > > >> > +#endif
> > > >> > +
> > > >> >  static int optee_probe(struct platform_device *pdev)
> > > >> >  {
> > > >> >         optee_invoke_fn *invoke_fn;
> > > >> > @@ -1372,6 +1464,10 @@ static int optee_probe(struct platform_de=
vice *pdev)
> > > >> >         if (IS_ERR(invoke_fn))
> > > >> >                 return PTR_ERR(invoke_fn);
> > > >> >
> > > >> > +       rc =3D optee_load_fw(pdev, invoke_fn);
> > > >> > +       if (rc)
> > > >> > +               return rc;
> > > >> > +
> > > >> >         if (!optee_msg_api_uid_is_optee_api(invoke_fn)) {
> > > >> >                 pr_warn("api uid mismatch\n");
> > > >> >                 return -EINVAL;
> > > >> > --
> > > >> > 2.40.0.rc0.216.gc4246ad0f0-goog
> > > >> >
