Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806BF72EAC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 20:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbjFMSV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 14:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjFMSVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 14:21:22 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BEBA19A;
        Tue, 13 Jun 2023 11:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=juq72744bbt+1tC+EywAD76Jb+ygPBpQeICaFLDnKjA=; b=fnu/ramaMmpZB3NQux+azFlCUV
        7ga0av+e/3rtiILUmleFCt1GPwNUtWULBocPwYbvySIeeC5cuk8s3TrgtjdM3fpqhwGI35UE6T/lk
        08Td2WsZB6+GtFnTWXetz3DRETQYP3CgXn8lrowJz45q5s4GdcKWotueTfEbNEkf9BkOvvWRbwWA6
        +mUhv5eaC3H+yHXFrXU2wwFnQZwA/aR9DAJpfWGdJFCMwLWHjh74GB/DdBMeKEfPnNEtZSdUN3vjM
        vDivOSHV4VgtUxs91Snk0T3LT91xWSf/CHh22iqxEJJHfLOW8VztLUoFRqGR7K2DI2DrlRnUBUN4p
        UPcUkAlw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56914)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q98da-0000YQ-LR; Tue, 13 Jun 2023 19:21:02 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q98dU-0006Ff-6l; Tue, 13 Jun 2023 19:20:56 +0100
Date:   Tue, 13 Jun 2023 19:20:56 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 2/7] net: dsa: mt7530: fix trapping frames with
 multiple CPU ports on MT7530
Message-ID: <ZIiziJ6Os+QScfMj@shell.armlinux.org.uk>
References: <20230611081547.26747-1-arinc.unal@arinc9.com>
 <20230611081547.26747-2-arinc.unal@arinc9.com>
 <20230613150815.67uoz3cvvwgmhdp2@skbuf>
 <a91e88a8-c528-0392-1237-fc8417931170@arinc9.com>
 <20230613171858.ybhtlwxqwp7gyrfs@skbuf>
 <20230613172402.grdpgago6in4jogq@skbuf>
 <ca78b2f9-bf98-af26-0267-60d2638f7f00@arinc9.com>
 <20230613173908.iuofbuvkanwyr7as@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613173908.iuofbuvkanwyr7as@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 08:39:08PM +0300, Vladimir Oltean wrote:
> Ok. I see Russell has commented on v4, though I don't see that he particularly
> pointed out that this fixes a problem which isn't yet a problem. I got lost in
> all the versions. v2 and v3 are out of my inbox now :)

I didn't really get to that level of detail (which is why I haven't
given any r-b's) - I was more focused on trying to understand what
each commit was doing, and trying to get easier to parse commit
messages.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
