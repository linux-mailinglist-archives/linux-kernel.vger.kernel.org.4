Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3238371496A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 14:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjE2MXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 08:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjE2MXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 08:23:30 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1BBC7
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:23:28 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f6cbf02747so21068175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 05:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685363007; x=1687955007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/vtPtBKpNoIZXqdLQ0Ssss1GOH1GFkiCTsYHHpw9tHs=;
        b=ttiL0lSWXmQdE1T0lXx3I1Q+ByyO9zkhhYGyb9bfiJGgv6sCGmDbQElXFGoFuTFhdD
         /OErcc+v0zqywDw5glySWRiMVIkP0nxj1Vb2ttlS7aFefEdPIL35NHEL9hMzs1zCMmeE
         bHU1pB4k9etZi14uc8FSKKlN22gE6ENnl9ozrTxgaymhKa3tj5moMCXMD1lga9BYappp
         qnuDZtzBsSIdFB/55n52WIW8hXPGUpk/iB2bH18NpG3bm9GrysZJlbz8yMBUVZqlwBF9
         yS6TBOKiXGYNGBtt5pTaTaE42l7/EuYieS1s5iqSO9JehLG8SVZbK/p0M0bwR+/D0kKH
         NFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685363007; x=1687955007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vtPtBKpNoIZXqdLQ0Ssss1GOH1GFkiCTsYHHpw9tHs=;
        b=Llc44Zf2Qc/SvGAg6g9FuDyWpvHIDIhSrh8VWrJr1WFzSmX2ko8rAfCdGxG1WGsZ3X
         lYT+Wlah9fWEy3Kb31qixXGI4y6Rj7fQlQj+yDCAhjKP+OllZuW7uvxTOVEAeo3t5kCb
         1H2GNfeqy2hK3+7Xh9Zg1cCh4rqJyXkt/OOi1VYlj+3Dzy13Myxrp2I0P48Pgrnh4bNn
         oEHY9N14pS4TSKsHL2+KdcV4LywelRMze6+sboBj+xz8k5V27eo1JnmiDSlpk8ejvZRf
         ofKbZdXl60hHFOqDSNO6FIN8ShVN6SAnxT7XfZ0dMH6L+SH2nbDSLgeLqix/zH3rgacG
         aDoQ==
X-Gm-Message-State: AC+VfDwmScVoGAlN5qvNX1V//N6y2jnFT0wdlAlBvoEBzJTlhgcRvygb
        M1lzu5Hb1wT7osT/mmdkAtHAzVeBEC2azHKeMF72+ZZgwoJgWjEH
X-Google-Smtp-Source: ACHHUZ6tb2ghNK0dSgjCjuwHf9lMSKfL/21Gwq8vk4N52EUCmLHpXs6p/kM87Ta+qRR5Ehwju9qwg6CAZXaNDClvJwo=
X-Received: by 2002:a05:600c:214d:b0:3f6:6c0:7c9b with SMTP id
 v13-20020a05600c214d00b003f606c07c9bmr8051755wml.15.1685363007047; Mon, 29
 May 2023 05:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230517143311.585080-1-sumit.garg@linaro.org>
 <CAN5uoS9h6OmO-SZWmBdRUkT+ih9QK+mTo8Kvmn3ePQ4NrKriBw@mail.gmail.com>
 <CAFA6WYPCOqsyedjP-ffAQiyX3manDV+oE3akFpeuRZukro_dRg@mail.gmail.com>
 <PAXPR10MB468715EB2B1DFE080F380266FD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
 <CAHUa44FDs-cukERVwev88i855Y-ZaAkLUt=bVxah=GdW+JKVLQ@mail.gmail.com>
 <PAXPR10MB46872AD9A798A1B7DAF4721DFD469@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
 <CAFA6WYOFaSHHRhNbeuwjLMtCRhGt4edMyeSD1841E3xzS-ETag@mail.gmail.com>
 <CAHUa44FCEs6dBG_WJApJkDKKUY+rS+EJM1s_ouCDazbb7vURxg@mail.gmail.com> <CAFA6WYMm43GRGFvWv-5dLiRzfeZyFbDMZewoE0ZU93Wsk6EFpQ@mail.gmail.com>
In-Reply-To: <CAFA6WYMm43GRGFvWv-5dLiRzfeZyFbDMZewoE0ZU93Wsk6EFpQ@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 29 May 2023 14:23:16 +0200
Message-ID: <CAHUa44HBQatvnJ5Nkm=uWmnXX7xx_svjDt5d+fV6sosKAxppSg@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] tee: optee: support tracking system threads
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Etienne CARRIERE <etienne.carriere@st.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        Etienne CARRIERE - foss <etienne.carriere@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 12:17=E2=80=AFPM Sumit Garg <sumit.garg@linaro.org>=
 wrote:
>
> On Mon, 29 May 2023 at 15:10, Jens Wiklander <jens.wiklander@linaro.org> =
wrote:
> >
> > On Mon, May 29, 2023 at 9:11=E2=80=AFAM Sumit Garg <sumit.garg@linaro.o=
rg> wrote:
> > >
> > > On Fri, 26 May 2023 at 01:05, Etienne CARRIERE <etienne.carriere@st.c=
om> wrote:
> > > >
> > > >
> > > > > De: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > Envoy=C3=A9 : jeudi 25 mai 2023 17:20
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Thu, May 25, 2023 at 1:48=E2=80=AFPM Etienne CARRIERE
> > > > > <etienne.carriere@st.com> wrote:>
> > > > > >
> > > > > > >
> > > > > > > De : Sumit Garg <sumit.garg@linaro.org>
> > > > > > > Envoy=C3=A9 : mercredi 24 mai 2023 09:31
> > > > > > > > On Tue, 23 May 2023 at 12:41, Etienne Carriere
> > > > > > > <etienne.carriere@linaro.org> wrote:
> > > > > > > > Hello Sumit,
> > > > > > > >
> > > > > > > >
> > > > > > > > On Wed, 17 May 2023 at 16:33, Sumit Garg <sumit.garg@linaro=
.org> wrote:
> > > > > > > > >
> > > > > > > > > From: Etienne Carriere <etienne.carriere@linaro.org>
> > > > > > > > >
> > > > > > > > > Adds support in the OP-TEE driver to keep track of reserv=
ed system
> > > > > > > > > threads. The optee_cq_*() functions are updated to handle=
 this if
> > > > > > > > > enabled. The SMC ABI part of the driver enables this trac=
king, but the
> > > > > > > > > FF-A ABI part does not.
> > > > > > > > >
> > > > > > > > > The logic allows atleast 1 OP-TEE thread can be reserved =
to TEE system
> > > > > > > > > sessions. For sake of simplicity, initialization of call =
queue
> > > > > > > > > management is factorized into new helper function optee_c=
q_init().
> > > > > > > > >
> > > > > > > > > Co-developed-by: Jens Wiklander <jens.wiklander@linaro.or=
g>
> > > > > > > > > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > > > > > > > > Signed-off-by: Etienne Carriere <etienne.carriere@linaro.=
org>
> > > > > > > > > Co-developed-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Disclaimer: Compile tested only
> > > > > > > > >
> > > > > > > > > Hi Etienne,
> > > > > > > > >
> > > > > > > > > Overall the idea we agreed upon was okay but the implemen=
tation looked
> > > > > > > > > complex to me. So I thought it would be harder to explain=
 that via
> > > > > > > > > review and I decided myself to give a try at simplificati=
on. I would
> > > > > > > > > like you to test it if this still addresses the SCMI dead=
lock problem or
> > > > > > > > > not. Also, feel free to include this in your patchset if =
all goes fine
> > > > > > > > > wrt testing.
> > > > > > > >
> > > > > > > > With these changes, there is no more a specific waiting lis=
t for TEE
> > > > > > > > system threads hence when a waiting queue can complete, we'=
ll pick any
> > > > > > > > TEE thread, not a TEE system thread first..
> > > > > > >
> > > > > > > I had thought about this but I can't see any value in having =
a
> > > > > > > separate wait queue for system threads. Here we only need to =
provide
> > > > > > > an extra privileged thread for system sessions (kernel client=
s) such
> > > > > > > that user-space doesn't contend for that thread. This prevent=
s kernel
> > > > > > > client's starvation or deadlock like in the SCMI case.
> > > > > > >
> > > > > > > > Also, as stated in a below answer, these change uncondition=
ally
> > > > > > > > reserve a TEE thread for TEE system calls even if no TEE cl=
ient
> > > > > > > > reserved such.
> > > > > > >
> > > > > > > I don't think we should make thread reservations based on the=
 presence
> > > > > > > of TEE clients. You never know how much user-space or kernel =
TEE
> > > > > > > clients you are dealing with. And reserving a single privileg=
ed thread
> > > > > > > unconditionally for system sessions shouldn't be much of a bu=
rden for
> > > > > > > memory constrained devices too.
> > > > > > >
> > > > > > > Also, this way we would enable every kernel TEE client to lev=
erage
> > > > > > > system sessions as it's very likely they wouldn't like to com=
pete with
> > > > > > > user-space for thread availability. Two other kernel TEE clie=
nts that
> > > > > > > are on top of my head are HWRNG and Trusted Keys which can be=
nefit
> > > > > > > from this feature.
> > > > > >
> > > > > > Trusted Keys is an interesting use case. When OP-TEE accesses T=
rusted Keys,
> > > > > > it may need to access the eMMC/RPMB using the Linux OS tee-supp=
licant
> > > > > >  whichj may repuire an eMMC clock or voltage regulator to be en=
abled.
> > > > > > If that clock or regulator is under an SCMI control, then we ne=
ed 2
> > > > > > reserved TEE thread: one for invoking the Trusted Key TA and
> > > > > > another for the SCMI request to reach the TEE will the Trusted =
Key
> > > > > > TA invocation still consumes a thread.
> > >
> > > Trusked keys TA doesn't need access to secure storage (eMMC/RPMB). It
> > > only requires a RNG and access to a key derived from HUK.
> >
> > Because it's always compiled as an early TA so no rollback protection i=
s used?
> >
>
> Yeah it has to be compiled as an early TA to support Trusted Keys
> use-cases. BTW, we don't have enumeration support for REE-FS TAs at
> the moment.
>
> > >
> > > > > >
> > > > > Why would the Trusted Keys session need a system thread? To me, i=
t
> > > > > seems that the session could use the normal client priority.
> > >
> > > The system thread priority as per my patch is nothing but an extra
> > > thread available in the thread pool for kernel clients as compared to
> > > user-space clients.
> > >
> > > Trusted keys use-case was really motivated by: "every kernel TEE
> > > client would like to avoid competing with user-space for thread
> > > availability". However, HWRNG has a real case that user-space
> > > shouldn't starve kernel RNG thread for OP-TEE thread availability.
> > >
> > > System thread can be useful for trusted keys in case the disk
> > > encryption key is backed by a trusted key.
> >
> > With well-behaving TAs every TEE client will get its thread in due time=
.
>
> We should try to keep distinction among user-space clients vs kernel
> clients rather than keeping them in the same bucket. The kernel
> clients are more privileged than user-space ones. This is similar
> hardening as we have done with respect to session login method (REE
> kernel login).
>
> >
> > The system thread feature was originally intended as a way of avoiding
> > a deadlock.
>
> That's true but doing so can also benefit other (mutual independent)
> kernel clients as well.
>
> > So far we have otherwise assigned threads on a first-come
> > first-served basis. If we now also need a way of giving priority to
> > kernel clients for less critical reasons we may need to take a step
> > back and redesign because reserving a thread for each kernel client
> > doesn't scale.
>
> No, please have a relook at this patch. We have *only* reserved a
> single thread for all the allowed (sess->use_sys_thread =3D true) kernel
> clients to compete for. And user-space has access to all the other
> threads on a first-come first-served basis except the one thread
> reserved for kernel clients.

Thanks, got it now. User space clients may or may not be able to
starve kernel clients enough to matter. However, if all kernel clients
only will be guaranteed one thread then we're still stuck with the
deadlock problem for SCMI. We can't guarantee that none of the kernel
clients will indirectly access eMMC/RPMB.

Cheers,
Jens

>
> -Sumit
>
> >
> > Thanks,
> > Jens
