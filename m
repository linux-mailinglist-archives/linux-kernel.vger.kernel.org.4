Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EAD6BBA1E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjCOQqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232709AbjCOQp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:45:58 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 333452A6F0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:45:15 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id bh21-20020a05600c3d1500b003ed1ff06fb0so1698400wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678898689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04oAu1Epo9SQhPM4NVXULqyDXSz3JDl9X8av4pk+WzQ=;
        b=DglSPjvA+jcxtiMiYO/y0FHAIg4I10LeDXGECLg9vElT1kVFTHvBhtNQJxs0mGzlLB
         /TcrjGiPxOUXeynnARVo7HhDckn/ynBIFzRFVYI/prYtreWruSSxnTEGKkITqPgc7k4q
         gDhZXtXWSuGhadsHat5S8AIxdOkOLYf18APceo5kJMZZ184OYDd6rANjka6onTPzzDlb
         UGAxXNlRSQirMijzGUBC90crz/dpRpIdrG2f26iKKW4Q5ck/TZ+VK4HkyjV0bd4paeTZ
         fTDOB4h9K9e92m9FYq6q4JGXfoEGXVso3h9tUxrhVqxz5T2/aXbBDpPPFH7BAO5tYbUj
         ybgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678898689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04oAu1Epo9SQhPM4NVXULqyDXSz3JDl9X8av4pk+WzQ=;
        b=kAl9Cf0estLJP5+jCRlPvbuH/OQpUhG4ggM3BF6B7azPODGElOhfaYfbLEF/IxhX58
         gYdTN0Pm/z0arC210QK203oNnoVgMzsk+Ntbk9xM8AIWgCfqE7zMwjPBCCOTa60/MafZ
         w1ak7tbdYnZvoqBD3X1Xg6vSlfWAT2FL3uFSYBrwaJBA6P0jU1NtD4nFsdlpxNVNJOnz
         mBXVQZFxzeSjFBcZ5WNIXAhjf++/sPQMk1Vt9p45YA+PA2fQYmX8mj3gIQdyIWzo8lK5
         9+uKjlZBGK0YUkUdv3AQnPU8qISum6boRZjUjECrWBjuJubXw+idQL01Jf2J4zaWF5eP
         jvBQ==
X-Gm-Message-State: AO0yUKV0nQ8I4ebY2HNmHuehwWWa4SeOOtTXKGQlmIrYPerkmIGAQlyi
        1di3lgvnj2EB+MR3nbOY8Dc=
X-Google-Smtp-Source: AK7set/aYkfdm0wcbNd6sEi+oBNKfDmIEBe6EQO935Og7raishZkqyy76N9BebVWQuKE9sqimk+LQg==
X-Received: by 2002:a05:600c:468e:b0:3ea:f73e:9d8c with SMTP id p14-20020a05600c468e00b003eaf73e9d8cmr18568999wmo.16.1678898689062;
        Wed, 15 Mar 2023 09:44:49 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id az40-20020a05600c602800b003e2096da239sm2570663wmb.7.2023.03.15.09.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:44:48 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Date:   Wed, 15 Mar 2023 17:44:47 +0100
Message-ID: <3096768.uvML7RA1vL@suse>
In-Reply-To: <ZBHOi8vA/LpCyLTJ@khadija-virtual-machine>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine> <2168386.Az4OtozEo7@suse>
 <ZBHOi8vA/LpCyLTJ@khadija-virtual-machine>
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

On mercoled=EC 15 marzo 2023 14:56:27 CET Khadija Kamran wrote:
> On Wed, Mar 15, 2023 at 02:13:51PM +0100, Fabio M. De Francesco wrote:
> > On mercoled=EC 15 marzo 2023 13:32:55 CET Khadija Kamran wrote:
> > > On Tue, Mar 14, 2023 at 04:57:47PM -0700, Alison Schofield wrote:
> > > > My guess is that this patch gets ignored because it has a lower=20
version
> > > > number than a previous patch.
> > > >=20
> > > > Take the feedback given here, and rev to
> > > > [PATCH v5] staging: axis-fifo: initialize timeouts in probe only
> > > >=20
> > > > Be sure the Changelog, below the --- explains the journey.
> > > >=20
> > > > Changes in v5:
> > > >=20
> > > > Changes in v4:
> > > >=20
> > > > Changes in v3:
> > >=20
> > > > Changes in v2:
> > > Hey Alison!
> >=20
> > Hi Khadija,
> >=20
> > Please put one or two blank lines between the last message you are=20
replying
> > and the new you are writing (exactly as I'm doing here between "Hey=20
Alison!"
> > and "Hi Khadija").
>=20
> Hey Fabio!
>=20
> Sorry about that. This was pointed by Alison before and I have been
> adding spaces since then. Hopefully I am doing it right this time.
>=20
You are doing right this time :-)
>
> > > Based on Nathan's feedback I am trying to recompile and send a patch
> > > without any warnings.
> >=20
> > Great!
> >=20
> > > As suggested by Fabio, I am running "make w=3D1 -jX" command to see i=
f I
> > > get any warnings.
> >=20
> > I suppose that "w=3D1" is a typo. The option is enabled with "W=3D1" (c=
apital
> > case, Linux and all UNIX-like are case-sensitive).
>=20
> Okay. I should re-run it with "W=3D1".
>=20
> > > But it is taking a lot of time, is there any way of
> > > speeding it up?
> >=20
> > What is you choice for 'X' in "-jX"?
>=20
> I used "-j4".
>=20
> > Did you try with the exact number of logical cores?
> > Are you building into a VM with enough logical cores?
> > If you are building into a VM, did you reserve enough RAM?
>=20
> I am using Ubuntu 22.04.01 with the help of VM on VMware.
> My machine has 13GB RAM and 2 processors(4 cores each).

Therefore, you are using a Linux guest on a Linux host. This is a wise choi=
ce.=20
However, you didn't say where you are running your builds...

I mean, the better things to do are the following steps:

1) Your workspace with the staging tree should stay in the host.
2) Shut down your guest in order to have all RAM and all logical processors=
=20
available for the build.
3) Run "make -j8" in the host. Since you shutdown your guest VM you can use=
=20
all 8 logical cores and the maximum available RAM (without the VM draining=
=20
resources while building)
4) When the build is done, switch on your VM on VMware with at least 4 logi=
cal=20
cores and 6GB of reserved RAM.
5) Mount your cloned base directory as a shared folder between host and gue=
st.
6) In the guest, 'cd' to the shared folder and then run "make modules_insta=
ll=20
install" (in the guest, attention). This will install and configure the=20
kernel, the modules, GRUB2 and everything else in your guest VM.
7) Reboot the VM and test your patches.

This procedure will speed up your next builds.
The fundamental point is that you don't need to partition precious resource=
s=20
while building, Do everything without running the VM and switch it on only =
for=20
install and tests. Since you only build in the host but never install and b=
oot=20
in it, you don't risk any system's damage.

This is what I do for Kernel development purposes.

I hope it helps to answer your question about how to run fast recompilation.

=46abio =20


>=20
> > Please read carefully my questions above and try to understand your
> > environment and reply, so that I can help you more effectively.
> >=20
> > > If this doesn't work then I have to follow the steps to reproduce in =
lkp
> > > mail as you said before.
> >=20
> > The steps to reproduce will take your precious time and use more=20
resources.
> > Again, try to respond my questions.
> >=20
> > > After dealing with these warnings I will send a [PATCH v5], following
> > > your instructions above.
> >=20
> > Sorry for inadvertently overlooking to warn you about to send a message=
 to
> > Greg and ask him to drop your first 3 + 1 patches. Now you are doing go=
od=20
by
> > following what Alison suggested: send v5 and write the log of revisions
> > under
> > the three dashes (exactly how Alison explained).
> >=20
> > > Kindly, let me know if I am on the wrong track.
> > > Thank you!
> >=20
> > I think you are in the right track.
> > Let's try to speed up your builds because you'll need to build again yo=
ur
> > kernel many, many times for future works.
>=20
> Okay great! Thank you.
>=20
> Regards,
> Khadija
>=20
> > Thanks,
> >=20
> > Fabio




