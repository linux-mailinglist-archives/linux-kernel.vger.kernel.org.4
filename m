Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4D472EA98
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232450AbjFMSMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjFMSMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:12:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E9CF1B2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 11:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 336A860F64
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 18:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82C3C433D9;
        Tue, 13 Jun 2023 18:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686679940;
        bh=ki+xIq/Dtd9uylVNt8VBujumNOAojzQwiYYysPBIzcs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hBhEDrl4b8DDCLZU8lDdDOYrB0LSlfpGhPq1VZj+bHO12jCDh3U+pK/tzcaq1z8lV
         JtCGVSdsyZDbMN4gHGtaow3ty0MNeGKIwp1KxZnb2XcDVs8mDxWSDW/ah48vkJOBzP
         TCITMHrsqHCnZxeTdojdkzXP8siv3Bzcb8HWrUI59/C6xhTb3ghvXvOMyCuFWszrds
         mb9yb2LtSZam88vyxKBwb+zYPpk6KMHWBFS5G4xcIbZvPqEOlBbUat0ePSe/uMdyJ8
         cTqtnF0ag1mr9lVl+z2xwunbrQzwAyETLw5kqSrdtWDlBoGcVn32WaNZ/DoQG61KLp
         ZcP74nuDe0zuA==
Date:   Tue, 13 Jun 2023 11:12:18 -0700
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
Message-ID: <20230613111218.0e1b3e9f@kernel.org>
In-Reply-To: <edcbe326-c456-06ef-373b-313e780209de@arinc9.com>
References: <20230611081547.26747-1-arinc.unal@arinc9.com>
        <20230611081547.26747-2-arinc.unal@arinc9.com>
        <20230613150815.67uoz3cvvwgmhdp2@skbuf>
        <a91e88a8-c528-0392-1237-fc8417931170@arinc9.com>
        <20230613171858.ybhtlwxqwp7gyrfs@skbuf>
        <20230613172402.grdpgago6in4jogq@skbuf>
        <ca78b2f9-bf98-af26-0267-60d2638f7f00@arinc9.com>
        <20230613173908.iuofbuvkanwyr7as@skbuf>
        <edcbe326-c456-06ef-373b-313e780209de@arinc9.com>
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

On Tue, 13 Jun 2023 20:58:33 +0300 Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> > Ok. I see Russell has commented on v4, though I don't see that he parti=
cularly
> > pointed out that this fixes a problem which isn't yet a problem. I got =
lost in
> > all the versions. v2 and v3 are out of my inbox now :) =20
>=20
> All good, I had to quickly roll v3 as v2 had wrong author information=20
> and I couldn't risk getting v2 applied.

FWIW you can reply with pw-bot: changes-requested to your own patches
and the bot should discard them from patchwork.

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#updatin=
g-patch-status

It's a new capability that nobody has used, yet, so YMMV :)
