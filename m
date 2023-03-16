Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973BF6BD807
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 19:17:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjCPSR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 14:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjCPSRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 14:17:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E050E1C93
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:17:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso1787078wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678990633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGJcQHKYE1j8gzhOWA6q/l3a+xn5TndJ24CTCuu25Ow=;
        b=Hp6JbDCv15hXk7NcQzowcV7+OPYO6Amak0dNUBfkJi5VVMD06Aj8EclWwINhqzVmlJ
         A9IbAK/cY1mOVMM1Gg2enf7JuXSGoe2ZYTIzo5O85KP3caDwr8DSGYpQzTuFON7C8su/
         4LUWCIiCPwFtQiPvY17f0ca65irDQKF6wrOhGC9hLnDr3ucjf6f33v90wHDk/KrEbvtx
         SzWFZK1SrWnOvh8FQq2E3dK5/0Sct764NtudLs7j3BLtrJeM3edHZoNm9AP97jaXL9h2
         nrWPSbc5J1yxn00FK72M5a726xYBWpKe87IPOmq/vvNM5fDlBEFSFC4X7IgdormGQBEi
         1BxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678990633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sGJcQHKYE1j8gzhOWA6q/l3a+xn5TndJ24CTCuu25Ow=;
        b=LqphtHjmKvurq81yy8Oo46PGW3CT9mKpwXm4xIGy582PbixrFfbG/auz+KaDH9Heep
         OW6WEM8S0GCN8LBHSiuHO6NudP5/PDSwcjcheA8lFmjnbT1mrRvmN+y+niBgAidcP7K2
         jqVRNEFxefevijsKCX5vOdSQsKPnCW/JKOf1WfFSTa6ageJOuedc7CPmJlFuuLEExmUl
         BV13a12VosU742MK79ZfliD9HPMX7tLRKfI6tvOOT1ILbriqG+VPnEPJptt/TxZ/GPn3
         R+9yDVUvx913jAtW7AZq2oC8K3weeQISgokHtYAEKrPJAYk21WR3mX9E2Xbtk8iSCEv1
         kOUg==
X-Gm-Message-State: AO0yUKVlyryFnIlWY4fSQIAmIPhJJT6xL3OXLBqH23s0CIaXezDKHJj/
        5YloCk/4yN1GDP1UMjHQ3QhHw27gJ8s=
X-Google-Smtp-Source: AK7set9wfFKQ7s6YFRygCFRwMJaW1CQUJcoUokqzzr1FKyUQQoUVwHMayqOGXv+atFxAwiWdsFGCTA==
X-Received: by 2002:a05:600c:45d2:b0:3ed:2a8f:e6dd with SMTP id s18-20020a05600c45d200b003ed2a8fe6ddmr11363859wmo.6.1678990632910;
        Thu, 16 Mar 2023 11:17:12 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id y6-20020a7bcd86000000b003e20cf0408esm5633001wmj.40.2023.03.16.11.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 11:17:12 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
Date:   Thu, 16 Mar 2023 19:17:11 +0100
Message-ID: <1821635.atdPhlSkOF@suse>
In-Reply-To: <2162728.C4sosBPzcN@suse>
References: <ZBMR4s8xyHGqMm72@khadija-virtual-machine>
 <ZBMxFLtW2ekCvm/s@khadija-virtual-machine> <2162728.C4sosBPzcN@suse>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On gioved=EC 16 marzo 2023 17:17:47 CET Fabio M. De Francesco wrote:
> On gioved=EC 16 marzo 2023 16:09:08 CET Khadija Kamran wrote:
> > On Thu, Mar 16, 2023 at 03:38:03PM +0100, Fabio M. De Francesco wrote:
> > > Khadija,
> > >=20
> > > Just saw your v5 patch and Greg's two replies.
> > >=20
> > > For v6 you will need to change the subject to "[PATCH v6] staging:
> > > axis-fifo:
> > > initialize timeouts in init only" to indicate that you are doing
>=20
> assignments
>=20
> > > in axis_fifo_init().
> > >=20
> > > Don't forget to extend the version log with "Changes in v6:" and clar=
ify
> > > that
> > > v5 had a different "Object" (you should probably also add a link to t=
he=20
v5
> > > patch in lore: https://lore.kernel.org/lkml
> > > /ZBMR4s8xyHGqMm72@khadija-virtual- machine/). When the "Subject"=20
changes,
> > > readers may not find the previous versions easily.
> > >=20
> > > On gioved=EC 16 marzo 2023 13:56:02 CET Khadija Kamran wrote:
> > > > Module parameter, read_timeout, can only be set at the loading time=
=2E=20
As
> > > > it can only be modified once, initialize read_timeout once in the=20
probe
> > >=20
> > > Substitute "probe" with "init".
> > >=20
> > > > function.
> > > >=20
> > > > As a result, only use read_timeout as the last argument in
> > > > wait_event_interruptible_timeout() call.
> > >=20
> > > This two sentences are not much clear. I'd merge and rework:
> > >=20
> > > "Initialize the module parameters read_timeout and write_timeout once=
 in
> > > init().
> > >=20
> > > Module parameters can only be set once and cannot be modified later, =
so=20
we
> > > don't need to evaluate them again when passing the parameters to
> > > wait_event_interruptible_timeout()."
> > >=20
> > > > Convert datatpe
> > >=20
> > > s/datatpe/type/
> > >=20
> > > > of read_timeout
> > >=20
> > > of {read,write}_timeout
> > >=20
> > > > from 'int' to 'long int' because
> > > > implicit conversion of 'long int' to 'int' in statement 'read_timeo=
ut=20
=3D
> > > > MAX_SCHEDULE_TIMEOUT' results in an overflow warning.
> > >=20
> > > We don't care too much about the warning themselves: I mean, it=20
overflows
> > > and
> > > you must avoid it to happen (as you are doing with the changes of=20
types),
> > > not
> > > merely be interested in avoiding the warning. "[] results in an=20
overflow."
> > > is
> > > all we care about.
> >=20
> > Hey Fabio!
> > Thank you for your feedback. I have understood it and will make sure to
> > send them in the next PATCH v6.
>=20
> Great to hear it!
>=20
> > > Add also the previous paragraph in the last part of the commit messag=
e.
> > >=20
> > > > Perform same steps formodule parameter, write_timeout.
> > >=20
> > > And instead delete the this last phrase.
> >=20
> > Can you please explain the above feedback. I am confused. What should I
> > use instead of this last phrase?
>=20
> Sorry, I made a typo in the sentence above and that may confuse you :-(
>=20
> I just intended to suggest to delete "Perform same steps formodule=20
parameter,
> write_timeout.".
>=20
> In the previous lines I suggested you to merge and rework your entire com=
mit
> message. If you like it you are left with the following text (that I put =
for
> you between two '"'):
>=20
> "Initialize the module parameters read_timeout and write_timeout once in
> init().
>=20
> Module parameters can only be set once and cannot be modified later, so we
> don't need to evaluate them again when passing the parameters to
> wait_event_interruptible_timeout().
>=20
> Convert the type of {read,write}_timeout from 'int' to 'long int' because
> implicit conversion of 'long int' to 'int' in statement 'read_timeout =3D
> MAX_SCHEDULE_TIMEOUT' results in an overflow.".
>=20
> Just three small sentences are all you need (and don't forget to change t=
he
> Subject - "probe()" -> "init()".
>=20
> I hope I have been clearer this time.
> If not, please ask for further clarification.
>=20
> Thanks,
>=20
> Fabio

I put my signature here, but it was a mistake.
Did you see the rest of the message below?

> > > > Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > > ---
> > > >=20
> > > > Changes in v5:
> > > >  - Convert timeout's datatype from int to long.
> > > >=20
> > > > Changes in v4:
> > > >  - Initialize timeouts once as suggested by Greg; this automatically
> > > > =20
> > > >    fixes the indentation problems.
> > > > =20
> > > >  - Change the subject and description.
> > > >=20
> > > > Changes in v3:
> > > >  - Fix grammatical mistakes
> > > >  - Do not change the second argument's indentation in split lines
> > > >=20
> > > > Changes in v2:
> > > >  - Instead of matching alignment to open parenthesis, align second =
and
> > > > =20
> > > >    the last argument instead.
> > > > =20
> > > >  - Change the subject to 'remove tabs to align arguments'.
> > > >  - Use imperative language in subject and description
> > > > =20
> > > >  drivers/staging/axis-fifo/axis-fifo.c | 26 ++++++++++++++++-------=
=2D--
> > > >  1 file changed, 16 insertions(+), 10 deletions(-)
>=20
> [snip]
>=20
> > > >  				 >=3D words_to_write,
> > >=20
> > > What is this? You haven't yet compiled your patch.

This unnecessary objection was due to that split I was talking about in the=
 v6=20
of your patch. At first glance it looked to me like a remnant of some mista=
ke=20
with copy-pasting. Sorry, I should have looked at it more carefully.=20

> > > Any further problems with enabling axis-fifo as a module?
> > Sorry, my bad.  Instead of fixing the menuconfig I used this command to
> > remove the warnings:
> > make -j"$(nproc)" ARCH=3Darm64 LLVM=3D1 drivers/staging/axis-fifo/
> > I thought it is compiling my module correctly.
> > But I am working on your feedback. And before sending my next patch I
> > will make sure to compile it properly.
>=20
> When you are done with build, install, and final reboot to test if your=20
module
> can "modprobe" or "insmod" (i.e. link with the running custom kernel you
> built, installed and boot), try to compare the output of the following
> commands:
>=20
> # uname -a
> Linux suse 6.2.2-1-default #1 SMP PREEMPT_DYNAMIC Thu Mar  9 06:06:13 UTC=
=20
2023
> (44ca817) x86_64 x86_64 x86_64 GNU/Linux
>=20
> AND
>=20
> # modinfo <name of the module you are testing here>
>=20
> I'm running "modinfo kvm" (but showing only two of many lines):
>=20
> # modinfo kvm
> filename:       /lib/modules/6.2.2-1-default/kernel/arch/x86/kvm/kvm.ko.z=
st
> vermagic:       6.2.2-1-default SMP preempt mod_unload modversions
>=20
> Can you see that the kernel in "uname -a" and the filename and vermagic h=
ave
> the same "6.2.2-1-default"? Well, so I'm sure I'm running the right Kerne=
l=20
and
> inserted the appropriate "kvm" module.
>=20
> Furthermore, before rebooting your custom kernel, you may also look at the
> directory in the Kernel where you compiled your module and search for "*.=
o"
> "*mod*" and "*.ko" files. If you have them, you built your module properl=
y.
>=20
> Thanks,
>=20
> Fabio

=46abio



