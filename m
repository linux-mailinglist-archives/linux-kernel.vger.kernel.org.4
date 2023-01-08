Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0FD6615B1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbjAHODr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 09:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjAHODp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:03:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967ECCEE;
        Sun,  8 Jan 2023 06:03:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E9A860C81;
        Sun,  8 Jan 2023 14:03:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3546DC433D2;
        Sun,  8 Jan 2023 14:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673186622;
        bh=Yj97AqZZxBvGpmEY52L5FJf1TsB1g8VxchoVSk64F3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T+t79dS/MHd5l8YxsEceVethO3ZdEQoNIuMOjm67aWQzigid0kwKENoE9JwT8AnNr
         E0lmknQmfEizax9uP5yQ/M39xhFz6j1iqGCtStGc+vO+EYzV27X6cvjxGTQfHO5VSw
         ImNskWkzbl2H5hiMPQ/kNQxQciV1O3mvyVa+R4hAn1YS+XrekFlHVglrJuVU7VuQ5v
         Ee6oUdAgSf5zvZR+fS03l+U4jU3qPEh6x2oIy+1dDCmPkk8hPekwX8IeYrzvwCH8iy
         1guOGPRCJgMHk6x++5RR1c4z3Knm0de75qElVjerZp8JsP/T2h+yHVfsV/Hj5zxFTH
         OUWERJMjdE25w==
Date:   Sun, 8 Jan 2023 15:01:35 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mliska@suse.cz
Subject: Re: [PATCH] docs: Fix the docs build with Sphinx 6.0
Message-ID: <20230108150135.060b0c7a@coco.lan>
In-Reply-To: <cb916eae-fdf6-504f-8f38-7928e0fa8344@gmail.com>
References: <87wn629ggg.fsf@meer.lwn.net>
        <cb916eae-fdf6-504f-8f38-7928e0fa8344@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
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

Em Sat, 7 Jan 2023 14:17:24 +0900
Akira Yokosawa <akiyks@gmail.com> escreveu:

> On Wed, 04 Jan 2023 13:45:35 -0700, Jonathan Corbet wrote:
> > Sphinx 6.0 removed the execfile_() function, which we use as part of the
> > configuration process.  They *did* warn us...  Just open-code the
> > functionality as is done in Sphinx itself.
> >=20
> > Tested (using SPHINX_CONF, since this code is only executed with an
> > alternative config file) on various Sphinx versions from 2.5 through 6.=
0.
> >=20
> > Reported-by: Martin Li=C5=A1ka <mliska@suse.cz>
> > Signed-off-by: Jonathan Corbet <corbet@lwn.net> =20
>=20
> I have tested full builds of documentation with this change
> with Sphinx versions 1.7.9, 2.4.5, 3.4.3, 4.5.0, 5.3.0, and 6.0.0.
>=20
> Tested-by: Akira Yokosawa <akiyks@gmail.com>
>=20
> That said, Sphinx 6.0.0 needs much more time and memory than earlier
> versions.
>=20
> FYI, I needed to limit parallel slot to 2 (make -j2) on a 16GB machine.
> If you are lucky, -j3 and -j4 might succeed. -j5 or more ended up in
> OOM situations for me:
>=20
> Comparison of elapsed time and maxresident with -j2:
>=20
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   Sphinx version elapsed time maxresident
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   5.3.0          10:16.81      937660
>   6.0.0          17:29.07     5292392
>   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

=46rom the changelogs:
	https://www.sphinx-doc.org/en/master/changes.html

It seems that 6.1 came with some performance optimizations, in particular:

    Cache doctrees in the build environment during the writing phase.

    Make all writing phase tasks support parallel execution.

    Cache doctrees between the reading and writing phases.

It would be nice if you could also test and check elapsed time
there too, as I suspect that 6.0 will have a very short usage, as
6.1 was released just a few days after it.

Regards,
Mauro.



>=20
>         Thanks, Akira
>=20
> > ---
> >  Documentation/sphinx/load_config.py | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/sphinx/load_config.py b/Documentation/sphinx=
/load_config.py
> > index eeb394b39e2c..8b416bfd75ac 100644
> > --- a/Documentation/sphinx/load_config.py
> > +++ b/Documentation/sphinx/load_config.py
> > @@ -3,7 +3,7 @@
> > =20
> >  import os
> >  import sys
> > -from sphinx.util.pycompat import execfile_
> > +from sphinx.util.osutil import fs_encoding
> > =20
> >  # --------------------------------------------------------------------=
----------
> >  def loadConfig(namespace):
> > @@ -48,7 +48,9 @@ def loadConfig(namespace):
> >              sys.stdout.write("load additional sphinx-config: %s\n" % c=
onfig_file)
> >              config =3D namespace.copy()
> >              config['__file__'] =3D config_file
> > -            execfile_(config_file, config)
> > +            with open(config_file, 'rb') as f:
> > +                code =3D compile(f.read(), fs_encoding, 'exec')
> > +                exec(code, config)
> >              del config['__file__']
> >              namespace.update(config)
> >          else:
> > --=20
> > 2.38.1 =20



Thanks,
Mauro
