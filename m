Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D05174D396
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjGJKeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjGJKd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:33:59 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9085ED1;
        Mon, 10 Jul 2023 03:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1688985230;
        bh=Qd7Jq6PV9bUrlUetZdlFipTTG5XNVHRahk+7pTupUnY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hnWfx1femhGVzcnMKSnDNf5xgExdFaoCKOuaJ7ctT8uwiVSpSlPmmIAI906gmEQ+4
         0owCsZvwTSPxqkE5OG0BhsTeRBEFCnEw61/oroH4BdFCoDwDucZwRFDJsYpLsNac3a
         nZkP5TXtpTvOEY4bvFfgSRt+BdyWIKfa6EDfvFUg=
Received: from [192.168.124.11] (unknown [113.140.11.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 7226465AB5;
        Mon, 10 Jul 2023 06:33:47 -0400 (EDT)
Message-ID: <2856be90ec133a2bafd5f11e537f8d589d0f8cb9.camel@xry111.site>
Subject: Re: [RFC PATCH] wifi: iwlwifi: remove 'use_tfh' config to fix crash
From:   Xi Ruoyao <xry111@xry111.site>
To:     Jeff Chua <jeff.chua.linux@gmail.com>,
        "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Networking <netdev@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Mon, 10 Jul 2023 18:33:45 +0800
In-Reply-To: <CAAJw_Zuo1L3yTP-PVgdW74uYg=R7YxXF0hA5s0Gfm1bCqC90RQ@mail.gmail.com>
References: <20230709181323.12085-2-johannes@sipsolutions.net>
         <19f7bc7f43922c257238127d5fe84ea01cf2be79.camel@intel.com>
         <CAAJw_Zuo1L3yTP-PVgdW74uYg=R7YxXF0hA5s0Gfm1bCqC90RQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-07-10 at 18:16 +0800, Jeff Chua wrote:
> On Mon, Jul 10, 2023 at 9:53=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> =
wrote:
> >=20
> > On Sun, 2023-07-09 at 20:13 +0200, Johannes Berg wrote:
> > > From: Johannes Berg <johannes.berg@intel.com>
> > >=20
> > > This is equivalent to 'gen2', and it's confusing to have two
> > > of the same configs. The split config patch actually had been
> > > originally developed after this, and didn't add the use_tfh
> > > in the new configs because they were copied to the new files
> > > after ...
> > >=20
> > > There's clearly still an unwind error in iwl_txq_gen2_init()
> > > since it crashes if something fails there, but the reason it
> > > fails in the first place is due to the gen2/use_tfh confusion.
> > >=20
> > > Reported-by: Jeff Chua <jeff.chua.linux@gmail.com>
> > > Reported-by: "Zhang, Rui" <rui.zhang@intel.com>
> > > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217622
> > > Link:
> > > https://lore.kernel.org/all/9274d9bd3d080a457649ff5addcc1726f08ef5b2.=
camel@xry111.site/
> > > Link:
> > > https://lore.kernel.org/all/CAAJw_Zug6VCS5ZqTWaFSr9sd85k%3DtyPm9DEE%2=
BmV%3DAKoECZM%2BsQ@mail.gmail.com/
> > > Fixes: 19898ce9cf8a ("wifi: iwlwifi: split 22000.c into multiple
> > > files")
> > > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> >=20
> > Hi, Johannes,
> >=20
> > Thanks for the patch. It fixes the problem on my side.
> >=20
> > Tested-by: Zhang Rui <rui.zhang@intel.com>
> >=20
> > thanks,
> > rui
>=20
>=20
> Johannes,
>=20
> Fixed as well! Thank you!

Works for me too, thanks!

Tested-by: Xi Ruoyao <xry111@xry111.site>

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University
