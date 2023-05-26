Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276B5712C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbjEZRr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbjEZRr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:47:27 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5330C9;
        Fri, 26 May 2023 10:47:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9700219be87so179901966b.1;
        Fri, 26 May 2023 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685123244; x=1687715244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQ/mZiE1DDLOAtWwEqQIo9NTpf4yc0wp34Ig/HGhPX4=;
        b=Rx3Q483hiduzAtSQ9xT826hU64MZ3nsv/l1S2d+95mbKEBV4iS1itIFuG1ACAlZ93M
         WTxpNhgOf69JBFqtsBCawVdjXBi0R+joU1vOEz2c9pGRYvmdi/febe0zlTdHeAsntSui
         Pi5x8A37be4zWIdYTRf5/436iKCxGyS9gVJcSPqmaXCIs+56dpyuXT5A7Uyi06NPy6B0
         Hs3ZrbiykGC5m58K4lLlGb519Gkp1eNcB+poVYQK9FGrtVYzPIx65p9Q6bRMJlJdgQSB
         /EIKPBTYbG9JunwvsE4gyapFKG9lP09YCKEbI67AbWYBQ6ul6O6l060hYJo/+RXHaGYN
         sbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685123244; x=1687715244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQ/mZiE1DDLOAtWwEqQIo9NTpf4yc0wp34Ig/HGhPX4=;
        b=fvPwnxEAJJVQlbeVdVhwp4Ud/ybd9hajWKQv9UYZ92HY0qi3VHS575NUoRPBZQItcY
         r0w1ewJNIFgYBYPjnXHtSTjTx4TU7URnXRSPa+Al95UY6YchePblm7p8D6Sb70rfd+Iq
         +PHf8LNvWVV3bg20KfBRJUciz8bRaCGfR0grbRXumLIdT6qBJ0Yh1DMs9mGiyd5sQZwB
         qKcn6BsbF51eI+h0oykKI8WBRnHiDDgW7dROUKYMhpvZMgtnR6GvLX+1uH6LhIU9eaDx
         QH/Q3deYYJPdqEJFiaa3c1H2mr971J51+BCg2TXC7LrJLyVCdttzkRdgGsl1yQ7qNdRa
         Y/Sw==
X-Gm-Message-State: AC+VfDxwaWGw4+pYsyMqoSKLxbA1ekTTIafZNWOsv8A0iehCLXLueZRX
        tBqyMyKiPBRU5LFo5A2ctec=
X-Google-Smtp-Source: ACHHUZ4e3H4E47OpEJ4FjqZDL4K7u5OZImeOvXQZzOYZaPpmbevgWFJ++QbgFeYcEP/sZ/qITxh2IA==
X-Received: by 2002:a17:907:16a3:b0:96a:928c:d391 with SMTP id hc35-20020a17090716a300b0096a928cd391mr3246692ejc.4.1685123243954;
        Fri, 26 May 2023 10:47:23 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id i13-20020a17090685cd00b0096f83b16ab1sm2394439ejy.136.2023.05.26.10.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:47:23 -0700 (PDT)
Date:   Fri, 26 May 2023 20:47:20 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     arinc9.unal@gmail.com
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
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 00/30] net: dsa: mt7530: improve, trap BPDU &
 LLDP, and prefer CPU port
Message-ID: <20230526174720.q7wsbbauyttu4grw@skbuf>
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522121532.86610-1-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 03:15:02PM +0300, arinc9.unal@gmail.com wrote:
> Hello!
> 
> This patch series simplifies the code, improves the logic of the switch
> hardware support, traps LLDP frames and BPDUs for MT7530, MT7531, and
> MT7988 SoC switches, and introduces the preferring local CPU port
> operation.
> 
> There's also a patch for fixing the port capabilities of the switch on the
> MT7988 SoC.
> 
> I have done a bidirectional speed test using iperf3 on all ports of the
> MT7530 and MT7531 switches with this patch series applied. I have tested
> every possible configuration on the MCM and standalone MT7530 and MT7531
> switch. I'll let the name of the dtb files speak for themselves.

As general feedback for the series, please sort the fixes to be first,
to have as few dependencies as possible, and submit then to the 'net' tree,
leaving cleanup at the end.
