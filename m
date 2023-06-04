Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4EA721708
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjFDMrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjFDMrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:47:07 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC66CA;
        Sun,  4 Jun 2023 05:47:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5149e65c244so5135730a12.3;
        Sun, 04 Jun 2023 05:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685882825; x=1688474825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VeW0ngdO2nTxTyDY3vQxZmrgp8rm0aHNbRAt+SY2V/c=;
        b=Lc86kryJmUdS3f9KEDgMu8GmU91p6Dl95GBJ5ExBnvRrOK8VynHk7QPTMc4G06DdRU
         Z8oqnLFXJcpNXkChuykZVpbIarl411xL6RYhp1Ol8KVyFucaW7evW/3xYp7ZtfNj26lO
         GLidJGA0HI0JR0njDkii/YD29HrGeku9RdD72dDchpjyUvwLXikL1Xea9xW6IaviiqlD
         GIpZUXianGvPY72xpuLgy5/ngCzuhu+Qegb9xeokCdmrdceUIhw3QxDWI8WLkERX5uD6
         vomPvSMXjbIAG6guy90SLkUIWZQMgeQtrlZn4Oqi3WaBMTCg9eJTwvYTWW4QBdk66L8o
         SdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685882825; x=1688474825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VeW0ngdO2nTxTyDY3vQxZmrgp8rm0aHNbRAt+SY2V/c=;
        b=QHrfxKn2h48BmPN6fLRyrtqR/Yoni30eH5PIIOXPwBlX3xGQ6mPclqO0pgdnkbFfRl
         YBNjKTzVSczV2Wckc75Jo5WC45kp+hobmpx6oGhGzjylfta2/b5Aj6xPy5NDtMMO0mQ/
         Gxd3LvzMKW9J0GFVWfpnwnLCkJ/7JTP+PZbdNjj7aw8ATHya5dJjRWjYcrR6X8gW7im5
         EDXFFrPDpiGqqmwBEhroRoKg0yYCUFzZjXawywvjK/A53GR6G1pg4uYjK6+BJkZFg0f5
         0X4rL+utIbRsgPfvZNw+h0KocGTcNuxvmCsUnlVluXSdw37o9EA5n4P9LVyCDqQGOCG+
         /lHw==
X-Gm-Message-State: AC+VfDzV7YIhd6gNZ6NX/vqtKHnRVJdRPS44o59oKm67nEcDQForut6V
        N2Omml92tDM0U/Hc5+y88vE=
X-Google-Smtp-Source: ACHHUZ45xevqudBS5Bv4e4mltpxg64iuhAUgQWwQtUKMdW3S5ktWRXJXkJRQ4w5ZtlQdZLCfIHZjmQ==
X-Received: by 2002:aa7:dcd9:0:b0:514:9e3e:4e4e with SMTP id w25-20020aa7dcd9000000b005149e3e4e4emr4992187edu.26.1685882824527;
        Sun, 04 Jun 2023 05:47:04 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id s20-20020a170906bc5400b009745b0cb326sm2985831ejv.109.2023.06.04.05.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 05:47:04 -0700 (PDT)
Date:   Sun, 4 Jun 2023 15:47:01 +0300
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
Subject: Re: [PATCH net-next 27/30] net: dsa: mt7530: introduce BPDU trapping
 for MT7530 switch
Message-ID: <20230604124701.svt2r3aveyybajc3@skbuf>
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-28-arinc.unal@arinc9.com>
 <20230526170223.gjdek6ob2w2kibzr@skbuf>
 <f22d1ddd-b3a4-25da-b681-e0790913f526@arinc9.com>
 <20230604092304.gkcdccgfda5hjitf@skbuf>
 <cc21196b-a18a-ce3c-e3f3-4303abf4b9a3@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc21196b-a18a-ce3c-e3f3-4303abf4b9a3@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 04, 2023 at 12:39:33PM +0300, Arınç ÜNAL wrote:
> On 4.06.2023 12:23, Vladimir Oltean wrote:
> > On Sun, Jun 04, 2023 at 11:51:33AM +0300, Arınç ÜNAL wrote:
> > > > If the switch doesn't currently trap BPDUs, isn't STP broken?
> > > 
> > > No, the BPDU_PORT_FW bits are 0 after reset. The MT7620 programming guide
> > > states that frames with 01:80:C2:00:00:00 MAC DA (which is how the BPDU
> > > distinction is being made) will follow the system default which means the
> > > BPDUs will be treated as normal multicast frames.
> > > 
> > > Only if all 3 bits are set will the BPDUs be dropped.
> > 
> > Right, if you don't trap BPDUs just to the CPU but flood them, I believe
> > the STP protocol won't behave properly with switching loops. Worth testing.
> 
> I've got no interest spending time playing around with STP at the moment so
> I'm going to pass.

You can at the very least move it towards the beginning of the net-next patch
set, so that we can be sure it doesn't depend on the other refactoring work,
in case someone in the future makes a request for the patch to be backported
to stable.
