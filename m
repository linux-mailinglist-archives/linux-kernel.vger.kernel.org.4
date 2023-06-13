Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EEB272ECE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjFMU3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233199AbjFMU3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:29:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FBB199A
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:29:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31E46634D9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 20:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A052CC433C8;
        Tue, 13 Jun 2023 20:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686688176;
        bh=Mto+CBG6oIkTZvT58Ap2W7GNwLzNDVjVgeAmeD03zOg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nzk1BR4xRN5+OzHBp4o2VQxT0E5D2cSXXYJG4QB5SlhJyEzpvqlKdKP046mmolxaO
         XmTmjkv2N5T1TGGt4QVgmxTV2V1tn9g4B6Y2FMQhvG1V9jjSTtxWZaDqSNgirV891/
         NEGXortM1jHgFodE4xphi1cxfPBLfbUfPA4qb/zjgg749UKElaeaaQdQEeAZxMP6Y/
         vxn1YTUS7MGDu3HxBYtPSs2/sOYGp49sSnyunNSqOoAZ91aYmPBBANTg5BYXnCkdUd
         wC7EshH/jYYAli5d2iE147VWjs6aHYm3ii9pRdxswSWUj2VP6EoaZy+HWFM8FShAg6
         qSL74MTafHKvA==
Date:   Tue, 13 Jun 2023 13:29:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 2/7] net: dsa: mt7530: fix trapping frames with
 multiple CPU ports on MT7530
Message-ID: <20230613132934.1da72c99@kernel.org>
In-Reply-To: <1761c20e-5f94-cb21-6170-0c39520062d6@arinc9.com>
References: <20230611081547.26747-1-arinc.unal@arinc9.com>
        <20230611081547.26747-2-arinc.unal@arinc9.com>
        <20230613150815.67uoz3cvvwgmhdp2@skbuf>
        <a91e88a8-c528-0392-1237-fc8417931170@arinc9.com>
        <20230613171858.ybhtlwxqwp7gyrfs@skbuf>
        <20230613172402.grdpgago6in4jogq@skbuf>
        <ca78b2f9-bf98-af26-0267-60d2638f7f00@arinc9.com>
        <20230613173908.iuofbuvkanwyr7as@skbuf>
        <edcbe326-c456-06ef-373b-313e780209de@arinc9.com>
        <20230613111218.0e1b3e9f@kernel.org>
        <359d0825-e39a-8a12-ebbf-b8d7e941d1ef@arinc9.com>
        <1761c20e-5f94-cb21-6170-0c39520062d6@arinc9.com>
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

On Tue, 13 Jun 2023 22:09:02 +0300 Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> >> It's a new capability that nobody has used, yet, so YMMV :) =20
> >=20
> > Interesting, I've got some questions regarding this.
> >  =20
> >> For example to mark a series as Changes Requested one needs to send=20
> >> the following line anywhere in the email thread:
> >>
> >> pw-bot: changes-requested =20
> >=20
> > I suppose a reply to the cover letter or under the cover letter thread=
=20
> > applies?

Anywhere in the thread, the bot should walk references.

> >> The use of the bot is restricted to authors of the patches (the From:=
=20
> >> header on patch submission and command must match!) =20
> >=20
> > So, for example, if this patch series was new, Vladimir would reply to=
=20
> > the patch they're the author of with 'pw-bot: changes-requested', and=20
> > the patchworks would mark the whole patch series as changes requested? =
=20

Yes.

> Also, replying with 'pw-bot: changes-requested' on an already accepted=20
> patch series as the author won't change the state from accepted to=20
> changes requested, correct?

Yes, authors can only changes status from active to inactive. Accepted
is an inactive state.
