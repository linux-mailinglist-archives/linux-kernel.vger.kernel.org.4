Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2B8B72F842
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 10:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243756AbjFNItV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 04:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243799AbjFNItE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 04:49:04 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC852111
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 01:48:49 -0700 (PDT)
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 4725F838;
        Wed, 14 Jun 2023 10:48:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1686732497;
        bh=dpE1nweZGv3FQpOlkvuV+NTwLtNfvVa+FGvfaPzSn0g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=T2PKyp40X5CEMLbbIoGmUPe8Zb64PD2mmGTAhq68mvGR75kftUo8N5dHXUlbB0Rgm
         /mWfMvl2aEu5MC2TlJ/5WWBr7l3y3FlGfcdBRiz6CzU51/vqrcpX2JB6oglqzwO/OD
         J1lsEMsSZB+2xtCF7+4an18S09wXs/s57UmJ7SfA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230613211159.b1faefb1a1bd.Ie873f66db5555c014c4afc15678e4fd5cfeca226@changeid>
References: <20230613211159.b1faefb1a1bd.Ie873f66db5555c014c4afc15678e4fd5cfeca226@changeid>
Subject: Re: [PATCH] gdb: linux: make SB_* constants gdb-parsed
From:   Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Date:   Wed, 14 Jun 2023 09:48:45 +0100
Message-ID: <168673252566.2889415.6583119718907787971@Monstersaurus>
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

Quoting Johannes Berg (2023-06-13 20:11:59)
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> These now contain "UL" suffixes due to the use of BIT(),
> so they need to be parsed by gdb since python doesn't
> understand that.
>=20
Thank you for the patch, however there is an existing patch [0] submitted
and on it's way upstream [1] to resolve this.

[0] https://lore.kernel.org/all/20230607221337.2781730-1-florian.fainelli@b=
roadcom.com/
[1] https://lore.kernel.org/all/20230609004453.2AAEEC433EF@smtp.kernel.org/

> Also fix a comment typo while at it.
>=20

This typo wasn't fixed though. Perhaps that's worth a separate patch if
you wish ...

--
Regards

Kieran

> ticket=3Dnone
>=20
> Fixes: f15afbd34d8f ("fs: fix undefined behavior in bit shift for SB_NOUS=
ER")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  scripts/gdb/linux/constants.py.in | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/scripts/gdb/linux/constants.py.in b/scripts/gdb/linux/consta=
nts.py.in
> index 471300ba176c..646fffddd862 100644
> --- a/scripts/gdb/linux/constants.py.in
> +++ b/scripts/gdb/linux/constants.py.in
> @@ -48,14 +48,14 @@ if IS_BUILTIN(CONFIG_COMMON_CLK):
>      LX_GDBPARSED(CLK_GET_RATE_NOCACHE)
> =20
>  /* linux/fs.h */
> -LX_VALUE(SB_RDONLY)
> -LX_VALUE(SB_SYNCHRONOUS)
> -LX_VALUE(SB_MANDLOCK)
> -LX_VALUE(SB_DIRSYNC)
> -LX_VALUE(SB_NOATIME)
> -LX_VALUE(SB_NODIRATIME)
> +LX_GDBPARSED(SB_RDONLY)
> +LX_GDBPARSED(SB_SYNCHRONOUS)
> +LX_GDBPARSED(SB_MANDLOCK)
> +LX_GDBPARSED(SB_DIRSYNC)
> +LX_GDBPARSED(SB_NOATIME)
> +LX_GDBPARSED(SB_NODIRATIME)
> =20
> -/* linux/htimer.h */
> +/* linux/hrtimer.h */
>  LX_GDBPARSED(hrtimer_resolution)
> =20
>  /* linux/irq.h */
> --=20
> 2.40.1
>
