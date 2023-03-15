Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1D06BB99C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjCOQYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCOQY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:24:28 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF720166C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:24:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h17so3830930wrt.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678897465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZ7bO5zo+7ogRY2D2YZLjwycpYGtkrGLFqABwsp8vCg=;
        b=me9JRyyglUG2k3QNr79dMI+MM7rB1ZP4K1urYWj2nIAz9kG7dP64zEKVvl7wNw34gL
         ryxluYkgmpUmhadfhScWuBvnbxaXiTlOzVA8bQhwwfM933EK0lM9Ia50NDyX+S+6APCH
         RJZYyjL6ztNrreDmn7WjwJuRGys7FHcSwTX/3dIrphQB7jQ4CQspkw9w3gr+ZfS9CJ29
         I7iZpjolzcXANf3MVay3m0++dNjWChCDUfdi/0tQ6F6fZVgsantUs2KiBDIx3lICzuVu
         wqGJ3SfLdG6FZ8Pi1T4t6Qihpkf/bykeYvc5MfWTbJh5KrdiGg0fqML6/MZWCbAX+o8y
         nLrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678897465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZ7bO5zo+7ogRY2D2YZLjwycpYGtkrGLFqABwsp8vCg=;
        b=OHB25fkCAhHW55ARXu/lmt+hHGM1pJnuELevxf96riGHgDsG4wzwKEKUnU/GzhAjm7
         7liX90/Vm5vYxltMV362V6IzCnHA/sYqIp9jT7AWVw7zc2F8WIF/Wpd5qyKOfeaZ8JcA
         tmbG1PjaJNKRsBpTQBh149Rfd/N8hgXdH4OKrw57GNGM3dfq/G5BIiYI9Aauz4Qq8k/C
         +v54LV9HXpQLbgvCT+onhoyJQO1Wr2Cwcoqc2nyas77+R77eD0Qe6qfTPn1LSRG8IJuc
         X5UKSdYQhMnKwQB6lQpKboX8+kGd2fpjUh81gkD66jNyy/IIyoTDZewErccom9Eh7rVz
         33qA==
X-Gm-Message-State: AO0yUKX3yecNqG7d9WAmSIjfZ0TAqZjqUbZjHAX77bIbKI0TCTZU5Qek
        Qe8/MfQMmuOiQr5TOs7buL4=
X-Google-Smtp-Source: AK7set8wiiOSxf5/NZ2MwOosX7e8X0tNsyjGVPxkgEbtFIp5Ot2D8aVKdhdiCEDnfjnvgN2e8wcPyw==
X-Received: by 2002:a5d:4dd1:0:b0:2c5:594b:10d6 with SMTP id f17-20020a5d4dd1000000b002c5594b10d6mr2336997wru.29.1678897465061;
        Wed, 15 Mar 2023 09:24:25 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id y2-20020adffa42000000b002c7163660a9sm4923812wrr.105.2023.03.15.09.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 09:24:24 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: initialize timeouts in probe only
Date:   Wed, 15 Mar 2023 17:24:23 +0100
Message-ID: <279821116.9N5E1g01tA@suse>
In-Reply-To: <20230315150656.GA2938956@dev-arch.thelio-3990X>
References: <ZA9mThZ7NyRrQAMX@khadija-virtual-machine>
 <ZBHUr7bANuhnOnIV@khadija-virtual-machine>
 <20230315150656.GA2938956@dev-arch.thelio-3990X>
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

On mercoled=EC 15 marzo 2023 16:06:56 CET Nathan Chancellor wrote:
> Hi Khadija,
>=20
> On Wed, Mar 15, 2023 at 07:22:39PM +0500, Khadija Kamran wrote:
> > On Wed, Mar 15, 2023 at 02:34:31PM +0100, Fabio M. De Francesco wrote:
> > > Aside from what I said and asked for with the other message of this s=
ame
> > > thread, please take note that you can build a specific module if you
> > > prefer
> > > not to re-build the whole kernel and other modules at the same time.
> > >=20
> > > I'm pretty sure that the instructions to do so are in the
> > > OutreachyFirstPatch
> > > tutorial.
> > >=20
> > > If they are not there, please let us know.
> > >=20
> > > Fabio
> >=20
> > Hey Fabio!
> >=20
> > In the Outreachy FirstPatchTutorial under the 'Compiling only part of
> > the kernel' section there are ways to compile only some part of the
> > kernel.
> >=20
> > I have tried using "make W=3D1 drivers/staging/axis-fifo/" and it says
> > 'nothing to be done for'.
>=20
> Is CONFIG_XIL_AXIS_FIFO enabled in your configuration?

@Khadija:

Maybe that you won't find CONFIG_XIL_AXIS_FIFO among the staging drivers=20
entries while using "make menuconfig" (or the other similar commands for=20
working with the configuration).=20

In that case, first enable the CONFIG_OF option if disabled.=20
CONFIG_XIL_AXIS_FIFO depends on the former.=20

=46or "CONFIG_XIL_AXIS_FIFO depends on CONFIG_OF" we mean that you can the=
=20
former if and only if the latter is already enabled.=20

Actually, CONFIG_XIL_AXIS_FIFO depends also on two other options. However y=
ou=20
shouldn't worry about those others because they are commonly enabled in mor=
e=20
than 99% of PC distributions.

> > Should I start with the steps to reproduce? :'(
>=20
> I did see a report of this same warning occurring with GCC but the
> report I commented on cane from clang/LLVM; using that toolchain may
> make it easier for you to reproduce this issue. The robot's reproduction
> instructions are fine but I think doing it manually is actually simpler.
>=20
> Ubuntu 22.04 should have a pretty modern version of clang/LLVM, which
> you can install via 'sudo apt install clang lld llvm'.
> https://apt.llvm.org is another resource.

@Nathan: Congratulations, you now have another clang/LLVM adept!
(Obviously, I'm just kidding :-))

=46abio



