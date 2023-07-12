Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC07505CC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjGLLRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbjGLLQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:16:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D6A1BE3;
        Wed, 12 Jul 2023 04:16:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A173F61779;
        Wed, 12 Jul 2023 11:16:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13848C433CA;
        Wed, 12 Jul 2023 11:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689160594;
        bh=z8wYXBpvPqezW8+Aq12OFGkmP7PrH5hpc2JqCK5G+Jw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=p4rcN99w7Je7qXSskRXrngQQtbuPRJ8HBrbc3/nEma0tiACwf2Qfgf1zeDn7c2eBw
         QOfzb+we6L80q1bWA7symXmUz8lqO2a8HkOVo8po7xdC1cnrRmL+CIk6MFndtXklv/
         pIJ/LQ0pzwM81pQ3wOKtK/c64fkMM4P5u1mJ4CNWdCD/pJDbW2WfAOmdNCMCznvE7I
         5pULZlOqgiLSPwIz9gczv0ztU05BvHpQeVnrXwtKHnVB4LHMRXaIqiYEDrxOmREEW1
         ZduUu2KS0YJI328fXM/YU6xXsoEFHKpP7RYNW01yODzcj1p7Gjgqi/Jr7hTByLHYzb
         wyt17TGArCQQQ==
Date:   Wed, 12 Jul 2023 13:16:29 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     =?UTF-8?B?R3LDqWdvcnk=?= Clement <gregory.clement@bootlin.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] firmware: turris-mox-rwtm: Fix an error handling
 path in mox_get_board_info()
Message-ID: <20230712131629.3161d6c9@thinkpad>
In-Reply-To: <95bd5686-1ed9-63ef-e91f-30aa54c09cd6@wanadoo.fr>
References: <fb3a73fd378582bf02e6c5eeabb61d3a3662cbdc.1676453328.git.christophe.jaillet@wanadoo.fr>
        <20230217122108.4a93667f@dellmb>
        <95bd5686-1ed9-63ef-e91f-30aa54c09cd6@wanadoo.fr>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory, could you take this patch via mvebu?

On Tue, 11 Jul 2023 18:44:36 +0200
Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Le 17/02/2023 =C3=A0 12:21, Marek Beh=C3=BAn a =C3=A9crit=C2=A0:
> > On Wed, 15 Feb 2023 10:30:02 +0100
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:
> >  =20
> >> wait_for_completion_timeout() returns 0 if timed out, and positive (at
> >> least 1, or number of jiffies left till timeout) if completed.
> >>
> >> In case of timeout, return -ETIMEDOUT.
> >>
> >> Fixes: 389711b37493 ("firmware: Add Turris Mox rWTM firmware driver")
> >> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >> ---
> >> Compile tested only.
> >>
> >> v2:
> >>     - Fix some other wait_for_completion_timeout() calls
> >>
> >> ---
> >>   drivers/firmware/turris-mox-rwtm.c | 12 ++++++------
> >>   1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/firmware/turris-mox-rwtm.c b/drivers/firmware/tur=
ris-mox-rwtm.c
> >> index 6ea5789a89e2..d6fc37ba897d 100644
> >> --- a/drivers/firmware/turris-mox-rwtm.c
> >> +++ b/drivers/firmware/turris-mox-rwtm.c
> >> @@ -200,8 +200,8 @@ static int mox_get_board_info(struct mox_rwtm *rwt=
m)
> >>   		return ret;
> >>  =20
> >>   	ret =3D wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
> >> -	if (ret < 0)
> >> -		return ret;
> >> +	if (ret =3D=3D 0)
> >> +		return -ETIMEDOUT;
> >>  =20
> >>   	ret =3D mox_get_status(MBOX_CMD_BOARD_INFO, reply->retval);
> >>   	if (ret =3D=3D -ENODATA) {
> >> @@ -236,8 +236,8 @@ static int mox_get_board_info(struct mox_rwtm *rwt=
m)
> >>   		return ret;
> >>  =20
> >>   	ret =3D wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
> >> -	if (ret < 0)
> >> -		return ret;
> >> +	if (ret =3D=3D 0)
> >> +		return -ETIMEDOUT;
> >>  =20
> >>   	ret =3D mox_get_status(MBOX_CMD_ECDSA_PUB_KEY, reply->retval);
> >>   	if (ret =3D=3D -ENODATA) {
> >> @@ -275,8 +275,8 @@ static int check_get_random_support(struct mox_rwt=
m *rwtm)
> >>   		return ret;
> >>  =20
> >>   	ret =3D wait_for_completion_timeout(&rwtm->cmd_done, HZ / 2);
> >> -	if (ret < 0)
> >> -		return ret;
> >> +	if (ret =3D=3D 0)
> >> +		return -ETIMEDOUT;
> >>  =20
> >>   	return mox_get_status(MBOX_CMD_GET_RANDOM, rwtm->reply.retval);
> >>   } =20
> >=20
> > Reviewed-by: Marek Beh=C3=BAn <kabel@kernel.org>
> >  =20
>=20
> Hi,
> polite reminder.
>=20
> CJ

