Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4505F4F8A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiJEFkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiJEFks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB1D33A16;
        Tue,  4 Oct 2022 22:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7689C61572;
        Wed,  5 Oct 2022 05:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B36EC433C1;
        Wed,  5 Oct 2022 05:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664948445;
        bh=2ZCyjTnuExLT4on5tcT7ZdHMYIQElFLXS7V55E7herc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ad2PqJjihXkLB3NxPIZkSCv9lucAzi1VGAj/nnsCMfmI7jheGpgrCgC6DbmIQ8Slr
         YGKnVNzi2JRar9zNMT4G6cZZSy7SpqqKweRWr3dryV70FezYA0CARQOqLu3IJOU9B+
         4zwkQ/NbH35NfZmkQo7G0211iWjxRypaAO8SipO5LCTXiyAqZx32TCg4eh5lyN9EcY
         ICCbHhC1uJpPqx6OyTImmW7PURtZe3D1+3bX96yfYt/9pp1X8rGIA9RqimWTTxRa4N
         xMFJh/W3WnKVAGHPRS3ghrny3GbjHS7zb/bnjxsG7qD7+qXIzOi1g73827tFeoZVHS
         VuoMLPib4QI+w==
Date:   Wed, 5 Oct 2022 06:40:39 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH RFC 0/5] docs: Improvements to our HTML output
Message-ID: <20221005064039.2ed74fa9@sal.lan>
In-Reply-To: <20221004201222.281845-1-corbet@lwn.net>
References: <20221004201222.281845-1-corbet@lwn.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Em Tue,  4 Oct 2022 14:12:17 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> For a long time we have rejoiced that our HTML output from Sphinx is far
> better than what we got from the old DocBook toolchain.  But it still
> leaves a lot to be desired; the following is an attempt to improve the
> situation somewhat.
>=20
> Sphinx has a theming mechanism for HTML rendering.  Since the kernel's
> adoption of Sphinx, we have been using the "Read The Docs" theme =E2=80=
=94 a choice
> made in a bit of a hurry to have *something* while figuring out the rest.
> RTD is OK, but it is not hugely attractive, requires the installation of =
an
> extra package, and does not observe all of the Sphinx configuration
> parameters.  Among other things, that makes it hard to put reasonable
> contents into the left column in the HTML output.
>=20
> The Alabaster theme is the default for Sphinx installations, and is bundl=
ed
> with Sphinx itself.  It has (IMO) nicer output and gives us the control
> that we need.

Nice to see it defaulting to one of the bundled themes! Not needing to
install a theme by default is a nice addition.

> So: switch to Alabaster.  Additional patches adjust the documentation and
> remove the RTD references from scripts/sphinx-pre-install.
>=20
> The final patch changes the way that kerneldoc declarations are rendered =
to
> (IMO) improve readability.  That requires some changes to kernel-doc to
> output a new container block and some CSS tweaks to improve things overal=
l.
>=20
> It should be noted that I have a long history of inflicting ugly web
> designs on the net; this work is a start, but I think we could do far
> better yet.  It would be great if somebody who actually enjoys working wi=
th
> CSS and such would help to improve what we have.
>=20
> As before, I've put a copy of the rendered docs at:
>=20
>   https://static.lwn.net/kerneldoc/
>=20
> To compare the kerneldoc changes specifically, pick a page that includes a
> lot of definitions; for example:
>=20
>   https://static.lwn.net/kerneldoc/driver-api/media/drivers/frontends.html
>   vs.
>   https://www.kernel.org/doc/html/latest/driver-api/media/drivers/fronten=
ds.html

There's one change there that I didn't like much: at the original page,
the index shows the full index, allowing to see exactly on what part of the
index the page is sitting, e. g:

...
 The Linux driver implementer's API guide
   Media subsystem kernel internal API
     1. Media Subsystem Profile
     2. Video4Linux devices
     3. Digital TV (DVB) devices
     4. Remote Controller devices
     5. Media Controller devices
     6. CEC Kernel Support
     7. Pixel data transmitter and receiver drivers
     8. Writing camera sensor drivers
            9. Media driver-specific documentation
                9.1. Video4Linux (V4L) drivers
                9.2. Digital TV drivers


While, after the change, it shows only:

  Table of Contents
    9.2.2. Frontend drivers
        9.2.2.1. Frontend attach headers

IMO, the RTD's index output is a lot more useful, as someone reading this
would very likely need/want to navigate to other chapters of the same
part of the documentation, allowing to quickly navigate outside the=20
item 9.2.2.

On the other hand, hiding the books outside the kAPI guide makes sense.

I would play with the sidebar options used by Alabaster in order to
try to make the TOC more useful.

-

On a side note, one thing I miss on all default themes is a way to dynamica=
lly
use dark mode. That's btw why I ended adding non-default support for=20
'sphinx_rtd_dark_mode' (which also requires an external package). At the ti=
me
I added CSS/themes customization support to the build system, this was the =
only=20
theme that allowed to switch to either dark/light mode. It would be really =
cool=20
if Alabaster (or some other default themes) could honor the user's preferen=
ce
between light/dark modes.

Regards,
Mauro
