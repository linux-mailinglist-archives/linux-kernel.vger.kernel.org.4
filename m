Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72596B9F58
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 20:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjCNTHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 15:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjCNTHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 15:07:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2909CC27
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:07:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso13904337wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 12:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678820832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmMsS72DrhmKHSRbr2NFMNW5CLIkt+u/jgJhqvsUU+k=;
        b=ZKESy222bvgLEzuBCchTHrEsX6V83Zf1v22/U6gUrCbWClgbyvNGjwjldnKLh8W81m
         M9MQYp77Xjr6Qh7Sdxu5TbWbLmHuIgiW+NZby4h4TnR4wbfG1O+W7qCLGOnDUAL0c7TZ
         a4fl2WUDFSbqBl3Xr7V+AQF4E7qUde1WY9NvZ5bNQLd9Z4rgt9zVFGfp8AqH90JpygtG
         Rcle2yv2NU/sWKVvMxFuaEqtCApXWuGfOyEuczVBOI4yuHLdUslasDo1LuBXrNO+emG/
         t+BJSOJwitbbIHx6Di63cJAYMX/aBqVpmSYVTRkDEV5EoOPKtUE+fF57SxFIQUQ9dP27
         N7Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678820832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmMsS72DrhmKHSRbr2NFMNW5CLIkt+u/jgJhqvsUU+k=;
        b=GEDmxYDgDs8wqQzgXlwkaF1Ex6QEvW+ie/QtvpfspVt1l9onl5uO5vE0AcsDS7Qzi8
         nHChp0fZkjVhMNMULAKSb5vSWI732DHaqogRtmZ4f6cUu0Z9VG+nO/79kh0dLj6UTo2X
         MxaPlOWzGtsr81l0gQbtopWZgws4uZnNh2fGHnmmme6W2eLO2V1vgB5oNvRIcyeRtnr6
         Llyp0Zz3dhMYQ7oboKHDn6XF7zr3cnLWv1XkrkYzL5QwBrDzKAA3mempossSBwAAgBX2
         hwpW1X0uaypZO62fk5VOl4QU10dKDo7Y7cCJGhNBrcSBGT4MYxGcAS8T7crFTXRfzex4
         wXAg==
X-Gm-Message-State: AO0yUKVBKLy43jYlv2hU+QlZhHBnqmv2yYgxbNvGZRoCMNIEcq8oiwuI
        KXtCkH3olaghP8P9JkeHZZbawJiuIVMJkg==
X-Google-Smtp-Source: AK7set8v+ja22gvJX3YpINvF+53LIkLKWQPeXL/mCNvDScclBCyrySvPPEjBZ7ejUE6QeaVYS6lxGA==
X-Received: by 2002:a05:600c:5028:b0:3eb:a4e:a2b2 with SMTP id n40-20020a05600c502800b003eb0a4ea2b2mr15172610wmr.4.1678820832262;
        Tue, 14 Mar 2023 12:07:12 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id v18-20020a1cf712000000b003e91b9a92c9sm3522646wmh.24.2023.03.14.12.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 12:07:11 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        outreachy@lists.linux.dev, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Date:   Tue, 14 Mar 2023 20:07:07 +0100
Message-ID: <2510576.EEEGcR9oU2@suse>
In-Reply-To: <ZBCPMVFvjodeUbGF@aschofie-mobl2>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <20230314144207.GA4106922@dev-arch.thelio-3990X>
 <ZBCPMVFvjodeUbGF@aschofie-mobl2>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On marted=EC 14 marzo 2023 16:13:53 CET Alison Schofield wrote:
> On Tue, Mar 14, 2023 at 07:42:07AM -0700, Nathan Chancellor wrote:
> > Hi Khadija,
> >=20
> > On Tue, Mar 14, 2023 at 07:08:31PM +0500, Khadija Kamran wrote:
> > > On Tue, Mar 14, 2023 at 11:45:51AM +0800, kernel test robot wrote:
> > > >
> > > > [...]
> > >=20
> > > Hi everyone!
> > > Kindly let me know if I should look into these warnings.
> > > Thank you!
> >=20
> > You should always avoid introducing new warnings whenever possible. In
> > this case, it appears that read_timeout and write_timeout should be
> > changed from 'int' to 'long' to account for the fact that
> > MAX_SCHEDULE_TIMEOUT is being assigned to it directly now, versus being
> > passed as a parameter to wait_event_interruptible_timeout(), which
> > assigned it to 'long' anyways.
> >=20
> > If you have any other questions or need further help, let me know :)
> >=20
> > Cheers,
> > Nathan
>=20
> Hi Khadija,
>=20
> Echoing Nathan's feedback - yes, you need to correct these.
>=20
> Do you see these warnings when you compiled?  If yes, then your path to
> fixing them is easier. Make sure it recompiles with no warnings.
>=20
> If you don't see these warnings, then you need to follow the steps to
> reproduce in the lkp email. You have to be able to 'see the warning'
> make a change and 'see it go away'.
>=20
> Alison
>=20

Hi Khadija,

I would suggest trying to recompile using "make W=3D1 -j...". Not sure if y=
ou'll=20
see the warnings (depends on your compiler, version and target architecture=
).=20
However, it's worth a try as it may save you the time it takes to go throug=
h=20
the steps for reproduction.

Anyway, as Nathan said, that warning is triggered by assigning 'long' to 'i=
nt'=20
(i.e., "MAX_SCHEDULE_TIMEOUT" is cast to 'long', while the types of=20
"read_timeout" and "write_timeout " are both 'int'). Obviously, these kinds=
 of =20
assignments overflow wherever the representation of type 'long' uses more b=
its=20
than the type 'int'.

That implies that you should try to understand where the module's parameter=
s=20
are defined and how to work with the related macros.

I hope it helps.

=46abio

P.S.: If you don't know yet what to do, take a look at the following docume=
nt:
https://sysprog21.github.io/lkmpg/ (The Linux Kernel Module Programming=20
Guide).
  =20



