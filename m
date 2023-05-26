Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD96712729
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 15:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243461AbjEZNBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 09:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjEZNBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 09:01:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0B2FB;
        Fri, 26 May 2023 06:01:50 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-510f525e06cso1179765a12.2;
        Fri, 26 May 2023 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685106109; x=1687698109;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+UkK3Ol11xLBzUOFBbpZXenRGfaW52LIpYuNVdpGopU=;
        b=YT9VAl+/ZzJNxlLHYnjBgzgNEshcqoBEUpSFRIUDZR5ZcObO2G5ERynF8v/ElWHu9K
         39ze1h7dpTBqIK/FlhNMxfMi7H2ypRQtuqY0qvPT2aCXKiE9BeUXsGQAoQlmaoEqj1EH
         jTurxdL0cnVywnDeluazuZmKAG8CCcFgO9UqDheXhX5MZf6Zr7SkE9gcig8jxzkaJHqQ
         QMpbt50BNsVaUuLyMfRBjZY2tMVAN8B9avpDpzp3D26+fFxh2p2d+j2B6CNStgYz/946
         BDHXjXYrS0xTro2seuyrM7jn1HZWUh4O+EkDxGGtU8aJbN0LAfr5NgjZHaWQtoCzahRq
         B3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685106109; x=1687698109;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UkK3Ol11xLBzUOFBbpZXenRGfaW52LIpYuNVdpGopU=;
        b=RU3QoPKr0wfoqMDRmrH8DbhSOOxLyDVKv8e5/2Sj6M7TqL/nooloGb49ScXiH/hZxD
         uFLGoeJIAdboZIXr1jhEcwE4aQ9RBrE4VaVFXEGc4lRM8dXWPnK4YOPQQAqChxs4pqa8
         RMit8rarKiQrvdAIQkaXIUukTLKewqzfTkS2Y/GUQd8KzH0Z63xxR68+btvCSsxDA8uW
         5N/IfEeW4M2E4uLrPqzkrLm+cigB/F8uqZV0+MPbpNyCeMFjYq1ur6PiIvCzK5TDcRPc
         D6sQCDVDvPI5P6CxZKwi1iWFiMONunNull2XS0AqdCkzuW94FM8GJRyKYErnivuyRkXx
         fBiQ==
X-Gm-Message-State: AC+VfDzntHz/DgjzcW57ZQ6A7vxaehHj1Wwib01KsXcSlFl4fTiKfTsC
        vhSZ554KdzIvBohQTdM6pZA=
X-Google-Smtp-Source: ACHHUZ7Q0qTv8CU3FTLJQtAIegaK0bcCQcBAXF1BfM4+j3yzx+O/MuhHTGIN+FlciNjFbwFlY+93eA==
X-Received: by 2002:aa7:d9cc:0:b0:509:c6e6:c002 with SMTP id v12-20020aa7d9cc000000b00509c6e6c002mr970029eds.39.1685106108296;
        Fri, 26 May 2023 06:01:48 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id c7-20020aa7c987000000b0050bc41352d9sm1551632edt.46.2023.05.26.06.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 06:01:47 -0700 (PDT)
Date:   Fri, 26 May 2023 16:01:45 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        Richard van Schagen <richard@routerhints.com>,
        Richard van Schagen <vschagen@cs.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        erkin.bozoglu@xeront.com, mithat.guner@xeront.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 08/30] net: dsa: mt7530: change p{5,6}_interface
 to p{5,6}_configured
Message-ID: <20230526130145.7wg75yoe6ut4na7g@skbuf>
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-9-arinc.unal@arinc9.com>
 <20230522121532.86610-9-arinc.unal@arinc9.com>
 <20230524175107.hwzygo7p4l4rvawj@skbuf>
 <576f92b0-1900-f6ff-e92d-4b82e3436ea1@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <576f92b0-1900-f6ff-e92d-4b82e3436ea1@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 09:49:58AM +0300, Arınç ÜNAL wrote:
> On 24.05.2023 20:51, Vladimir Oltean wrote:
> > On Mon, May 22, 2023 at 03:15:10PM +0300, arinc9.unal@gmail.com wrote:
> > > diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
> > > index 710c6622d648..d837aa20968c 100644
> > > --- a/drivers/net/dsa/mt7530.c
> > > +++ b/drivers/net/dsa/mt7530.c
> > > @@ -2728,25 +2722,20 @@ mt753x_phylink_mac_config(struct dsa_switch *ds, int port, unsigned int mode,
> > >   			goto unsupported;
> > >   		break;
> > >   	case 5: /* Port 5, can be used as a CPU port. */
> > > -		if (priv->p5_interface == state->interface)
> > > +		if (priv->p5_configured)
> > >   			break;
> > >   		if (mt753x_mac_config(ds, port, mode, state) < 0)
> > >   			goto unsupported;
> > > -
> > > -		if (priv->p5_intf_sel != P5_DISABLED)
> > > -			priv->p5_interface = state->interface;
> > 
> > If you don't replace this bit with anything, who will set priv->p5_configured
> > for mt7530?
> 
> I intend priv->p5_configured and priv->p6_configured to be only used for
> MT7531 as I have stated on the mt7530_priv description.

Ok, but given the premise of this patch set, that phylink is always available,
does it make sense for mt7531_cpu_port_config() and mt7988_cpu_port_config()
to manually call phylink methods?
