Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5E06BCE86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjCPLk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjCPLkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:40:10 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBB27A88
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:39:36 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o11-20020a05600c4fcb00b003eb33ea29a8so888621wmq.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678966773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kc+TKhkWgBxkIa6rZa0UbU5xS8M4xJrUEtCCPts6psA=;
        b=B+5HKVjQ8mqaMShUiMvGvciIUQfBmk2sKuXFiO0jRY7B4pN81pcvxjrp3CGPMA+DWW
         ABYjfzkZkx+Rkzl6tcq+vU8cykbsE+C+SXugvPo+yaMkomHf0k05lr/PG9g0JTmnAf5q
         NtvVb7ZQ4ImBbaCUwogqfDWYshoR/mvjQxWIpV95EFXQlVy+tF4mm47XtGLAT5CH8UKS
         AwY3rD10Jtuj4w+knkTcShcDwzBDypoPy9nz7EDHJ2eK9twKH1pe6vVztC3vjZvchXEp
         aJ0Ymx0RrtjhzuZieo8OVp540TaHoProQLVSDvlVV4xU+oETu5J0ku92y7IE0uUq6Azb
         uLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678966773;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kc+TKhkWgBxkIa6rZa0UbU5xS8M4xJrUEtCCPts6psA=;
        b=g0vDeAb7RAuSckcqNYiEWg+9YZuLT9Tsl28EqxopvOWV8AC4hzZSfQLuB3hsH4fVlD
         zMKFOwlZ2aH1p3/6lsr+XNKSN2/G0W0GCtHBzafmygqZo7yS6sGgdhLew7Yzsjrgoenp
         QAA5ppHlLq6EJDnhAk+LtIDD5jEm5C9i7yOrApJ8NpejmSS4rnhyS20eLJIlW7qifqwO
         cP2tJW9KRcrJSYw4Z+KbbmGuFjFlssce+8ZLHqySbmKSiEXP4auKL/QwpORoa3uZZwV8
         cJdRhD9YzzdpFD2LW62MnUjxSD4yK4aC2a2LqUxKzmT3PZ5kJqlo4F4Oaqzcdr6zdMyp
         kBCA==
X-Gm-Message-State: AO0yUKXoIrzQf6NTRITEuWIsXmeir4uZh6zlfuIrS+1nKfvv//OUKaLv
        0KjQ6krBevYaoMMrpJjOZTU=
X-Google-Smtp-Source: AK7set9t7Ni42RcKhVlDgKuW0vQm8VjNXJNze9Kjqr2Zp/LPYHq/TjiqOUEQAFJlJr4eTogJHxcynQ==
X-Received: by 2002:a05:600c:354d:b0:3ed:340e:afbe with SMTP id i13-20020a05600c354d00b003ed340eafbemr4696790wmq.20.1678966773095;
        Thu, 16 Mar 2023 04:39:33 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003db0bb81b6asm4803346wml.1.2023.03.16.04.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:39:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Date:   Thu, 16 Mar 2023 12:39:31 +0100
Message-ID: <1902746.IobQ9Gjlxr@suse>
In-Reply-To: <ZBLsoTBeKbuYbhCi@khadija-virtual-machine>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine> <279821116.9N5E1g01tA@suse>
 <ZBLsoTBeKbuYbhCi@khadija-virtual-machine>
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

On gioved=EC 16 marzo 2023 11:17:05 CET Khadija Kamran wrote:
> On Wed, Mar 15, 2023 at 05:24:23PM +0100, Fabio M. De Francesco wrote:
> > On mercoled=EC 15 marzo 2023 16:06:56 CET Nathan Chancellor wrote:
> > > Hi Khadija,
> > >=20
> > > On Wed, Mar 15, 2023 at 07:22:39PM +0500, Khadija Kamran wrote:
> > > > On Wed, Mar 15, 2023 at 02:34:31PM +0100, Fabio M. De Francesco wro=
te:
> > > > > Aside from what I said and asked for with the other message of th=
is
> > > > > same
> > > > > thread, please take note that you can build a specific module if =
you
> > > > > prefer
> > > > > not to re-build the whole kernel and other modules at the same ti=
me.
> > > > >=20
> > > > > I'm pretty sure that the instructions to do so are in the
> > > > > OutreachyFirstPatch
> > > > > tutorial.
> > > > >=20
> > > > > If they are not there, please let us know.
> > > > >=20
> > > > > Fabio
> > > >=20
> > > > Hey Fabio!
> > > >=20
> > > > In the Outreachy FirstPatchTutorial under the 'Compiling only part =
of
> > > > the kernel' section there are ways to compile only some part of the
> > > > kernel.
> > > >=20
> > > > I have tried using "make W=3D1 drivers/staging/axis-fifo/" and it s=
ays
> > > > 'nothing to be done for'.
> > >=20
> > > Is CONFIG_XIL_AXIS_FIFO enabled in your configuration?
> >=20
> > @Khadija:
> >=20
> > Maybe that you won't find CONFIG_XIL_AXIS_FIFO among the staging drivers
> > entries while using "make menuconfig" (or the other similar commands for
> > working with the configuration).
> >=20
> > In that case, first enable the CONFIG_OF option if disabled.
> > CONFIG_XIL_AXIS_FIFO depends on the former.
> >=20
> > For "CONFIG_XIL_AXIS_FIFO depends on CONFIG_OF" we mean that you can the
> > former if and only if the latter is already enabled.
> >=20
> > Actually, CONFIG_XIL_AXIS_FIFO depends also on two other options. Howev=
er
> > you
> > shouldn't worry about those others because they are commonly enabled in=
=20
more
> > than 99% of PC distributions.
>=20
> Hey Fabio!
>=20
> I have checked in my .config file and both options are enabled. The file
> says,
> CONFIG_OF=3Dy
> CONFIG_HAS_IOMEM=3Dy
>=20
> The "make menuconfig" shows 'Xilinx AXI-Stream FIFO IP core driver' with
> built-in selection [*].
> The problem I am having here is that in the OutreachyFirstPatch
> tutorial, it asks you to change [*] -> [m], but I cannot change it.
>=20
> Kindly help me with this!

Hi Khadija,

Sorry for being here so late.

I just saw also your other messages with further help requests.
Please do other work while waiting for help on a specific issue.=20

If I understand you correctly, you are saying that you can only build axis-
fifo in-kernel because you cannot change the '*' to 'm'. Correct?

If so, you have probably touched other configuration options in a way that=
=20
forces that driver to work only if compiled in-kernel). Therefore, I'd rest=
art=20
from scratch.

Please delete your current .config and make a copy of the one from your=20
running kernel. Then check the three options Alison and I were talking abou=
t.=20

Remember that you cannot see the axis-fifo module entry (CONFIG_XIL_AXIS_FI=
=46O)=20
in "Device Drivers" -> "Staging Drivers" section if you have not yet enable=
d =20
(either with 'm' or 'y') CONFIG_OF and CONFIG_HAS_IOMEM.=20

Now you should end up with a visible CONFIG_XIL_AXIS_FIFO that can be enabl=
ed=20
as a module with 'm'.=20

Let me know if this procedure works.

=46abio

> Thank you!
> Regards,
> Khadija
>=20
> > > > Should I start with the steps to reproduce? :'(
> > >=20
> > > I did see a report of this same warning occurring with GCC but the
> > > report I commented on cane from clang/LLVM; using that toolchain may
> > > make it easier for you to reproduce this issue. The robot's reproduct=
ion
> > > instructions are fine but I think doing it manually is actually simpl=
er.
> > >=20
> > > Ubuntu 22.04 should have a pretty modern version of clang/LLVM, which
> > > you can install via 'sudo apt install clang lld llvm'.
> > > https://apt.llvm.org is another resource.
> >=20
> > @Nathan: Congratulations, you now have another clang/LLVM adept!
> > (Obviously, I'm just kidding :-))
> >=20
> > Fabio




