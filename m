Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB3E6F937C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 20:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjEFSAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjEFSAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 14:00:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D101890C;
        Sat,  6 May 2023 11:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DAE560B75;
        Sat,  6 May 2023 18:00:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E337C433D2;
        Sat,  6 May 2023 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683396043;
        bh=x7C6StQwkhrvjqLJn5ntISyGPSl4P0DVufrOryv/hDE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J4KJQXUQfj9GTtSQshhVWmwIFBMWdLi0QEbfNHfHvDki1UY71iSz8sQ7Mcaq/VI/c
         uQ1xET7RzP8+PB+rGFFyGcTk/xJUiV7nj+kZc6NMVn8oKKWXHrzNRvDKf4KKE6Yt6N
         1gbWcvmfx8TtVwfsUuZvgNAO9ytZPSTKXm6gy2F9Ulv50VoOahEKbxfi3dtEner+Bc
         h4CvuE92JPUq3FqY7zQpCc+NvPChe2aX1w9qPMbmD82uhNpg8LNFWtcNhXt+O35Lg+
         7k6P4M/PkhJQDKH2UyDQDyjPNEdXZr0rZmgAoIwbbip6vLwZXh9xZlDxsn75gLT+De
         g8aG+alyPayqQ==
Date:   Sat, 6 May 2023 19:16:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: addac: ad74413: don't set DIN_SINK for functions
 other than digital input
Message-ID: <20230506191636.3cff4b24@jic23-huawei>
In-Reply-To: <6fcf4997-9d88-7e86-70f7-52f9d296bc6e@rasmusvillemoes.dk>
References: <20230503105042.453755-1-linux@rasmusvillemoes.dk>
        <27fe41e402ea0d6ef42aa0ac80aa3d1488862cd8.camel@gmail.com>
        <6fcf4997-9d88-7e86-70f7-52f9d296bc6e@rasmusvillemoes.dk>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 May 2023 12:08:53 +0200
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 04/05/2023 09.28, Nuno S=C3=A1 wrote:
> > Hi Rasmus,
> >  =20
>=20
> > So, I'm not really that familiar with this part and, at this stage, I'm=
 being
> > lazy to check the datasheet.  =20
>=20
> Well, the data sheet is not particularly helpful here, which is why I
> ended up with this mess.
>=20
> > My concern is about breaking some other users... =20
>=20
> I highly doubt there are users yet (other than my customer); this
> binding+driver implementation only just landed.
>=20
> > So, does it make any sense for having drive-strength-microamp in a non =
digital
> > input at all? =20
>=20
> That's the problem with the data sheet, it doesn't really say that the
> DIN_SINK register has any effect whatsoever when the channel function is
> set to something other than digital input (either flavor). Perhaps it
> does hint that setting it to something non-zero is probably not a good
> idea, because DIN_SINK is automatically set to 0 whenever the channel
> function is set/changed, so one needs a good reason to change DIN_SINK
> afterwards.
>=20
> We just experimentally found out that when we added the DIN_SINK to fix
> the digital input functions, when we got around to testing the
> resistance measurement function that ended up broken due to the non-zero
> DIN_SINK.
>=20
> > Can anyone have a working device by specifying that dt parameter
> > on a non digital channel (or expect something from having that paramete=
r set)?
> > Or the only effect is to actually have some functions misbehaving? =20
>=20
> The data sheet doesn't say that the DIN_SINK should have any effect for
> other functions, so I'm pretty sure it's only the latter: some functions
> misbehave.
>=20
> > On the driver side, if it's never right to have
> > these settings together, then the patch is valid since if someone has t=
his, his
> > configuration is broken anyways (maybe that's also a valid point for the
> > bindings)... =20
>=20
> Yes, I do believe that it's a broken description (whether or not the
> bindings specify that), and drivers don't need to go out of their way to
> validate or fixup such brokenness. But in this particular case, there's
> really no extra burden on the driver to not put garbage in DIN_SINK when
> a not-digital-input function has been chosen (the patch is a two-liner
> with 'git show -w').

If we can tighten the DT binding to rule out something that should not be
set than that would be good.  Tightening bindings is fine - we don't mind
validation of bindings failing on peoples DTs as long as we didn't 'break'
them actually working.

Jonathan

>=20
> Rasmus
>=20

