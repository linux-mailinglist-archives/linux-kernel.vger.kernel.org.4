Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BAC6ECCFC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 15:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjDXNSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 09:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbjDXNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 09:18:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132184EE0;
        Mon, 24 Apr 2023 06:17:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBF0621DF;
        Mon, 24 Apr 2023 13:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64DBCC433D2;
        Mon, 24 Apr 2023 13:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682342251;
        bh=M+h7EY4AiZbkEA3gNML0gkXreAnwG9/Xm2WXRg8j3u8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rAU28QjZnUffm4ki2BBz7jZLTSz36r8timeIiQ7+vfIqD5BcpihnbC5WJbxFiQ4a0
         HbVJPG/TRWjr4JJLx63/Ata41VxRWg6LgMOGNDzekM8ESvBEXVkFv9WsBRsbSFWX18
         jJtGUUI3n0ldkEab6UTJ5p6tsV6NWC8dAgHXpuQnDR29qX+FHaPkXnneUqCewXpVTd
         Zjsnb6H9D72q0ADMrKUrbfSrjpirW/Jmo5mWDdnbytEUPDitIpVpxB0tXZ6zXXH7XY
         CHq+nKNC+9zGgJmiqw03CtYs71ZRWGDtqgOdMHhagMh/Aaz3UeGpJfjz7ws42cIF6s
         av/UqpQiKu98g==
Date:   Mon, 24 Apr 2023 14:17:27 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Peter Enderborg <peter.enderborg@sony.com>,
        Yingsha Xu <ysxu@hust.edu.cn>,
        Serge Semin <fancer.lancer@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: remove return value check of debugfs_create_dir()
Message-ID: <dc807773-2028-4647-aa85-26f08a2810fa@sirena.org.uk>
References: <20230423061155.2540-1-ysxu@hust.edu.cn>
 <eb3c6aa6-6820-4e94-8eb0-5abd3b627fcc@sirena.org.uk>
 <368e31ae-31b5-839f-72e3-20a27239cb0b@sony.com>
 <a4706089-399b-4663-9ac8-216f12ebe7ca@sirena.org.uk>
 <2023042421-landowner-magnitude-a38c@gregkh>
 <55ab40bb-8b3e-496d-bf45-6c4ebd01e43f@sirena.org.uk>
 <2023042423-ice-rice-e3d3@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Njd17Gd35FNMdLYh"
Content-Disposition: inline
In-Reply-To: <2023042423-ice-rice-e3d3@gregkh>
X-Cookie: A rolling disk gathers no MOS.
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Njd17Gd35FNMdLYh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 24, 2023 at 03:08:03PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 24, 2023 at 02:00:14PM +0100, Mark Brown wrote:

> > The ones I've seen have been name collisions caused by for example the
> > debugfs structure created being flatter than the device model structure,
> > though obviously something unanticipated could come up.

> Sure name collisions will happen, when people aren't precise about how
> they create their debugfs files (I just had to insist on this type of
> fixups for a USB patch last week.)  But, debugfs failures should never
> stop a driver from working properly, only the debugging functionalities.
> So there's no need to error out from debugfs errors as the only one
> affected is the kernel developer involved, not users.

Developers can be users, and multiple people can work with a single bit
of code.  If these things are being done as a result of looking at the
code and reasonably deciding that actually the error handling wasn't
needed that'd be fine but when it's just silencing a static checker with
no obvious consideration and it's super obviously the right call just
=66rom the diff that's a different thing.

--Njd17Gd35FNMdLYh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmRGgWYACgkQJNaLcl1U
h9Dwfgf+IK/jtSQuLElDzicMl5BR8rklPouX/5Ri3NRqHpgYbSI5LCgCHlnVYGLU
W3CYV5PvUiXDBQllK3g+3ZG++2IhA+Gws/6eBHT2pTRJhL23Hv533a3/AShCTBTW
XPF8EhuLLuJ1H9xmKlDX4si8pkc1qzGqE3bLar0c0ODvnC8E0hz7XvNCwX5kkQsl
2GqvmQSbC9cI1zXyRrUavKqtnoF35ucBAQF+wJBhHxYsKGLyopO+O9A8kvFaVQ+z
itn8fmPLqlKq6wCu0dLeAGLgh/Ik7e0pwc5VzDFS7i/C4VT9s6RAzXkwR0A6LoGD
vZLRYFia7xjfbj8fF/a7UYHFe9JW2w==
=CegU
-----END PGP SIGNATURE-----

--Njd17Gd35FNMdLYh--
