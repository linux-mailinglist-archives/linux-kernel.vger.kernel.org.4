Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A27721011
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 14:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbjFCM1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 08:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjFCM1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 08:27:37 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A721A4;
        Sat,  3 Jun 2023 05:27:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-969f90d71d4so445734066b.3;
        Sat, 03 Jun 2023 05:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685795255; x=1688387255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZcxFciO+FgadEz/OB9cY/SNSRDrKptPDDCbhwYKKivw=;
        b=WFctNZ81xWIx29VG0DK7rYmLHHpVtkUKtme5W4sXiOd+y5tiNx8DVwPlILjCR9MqGD
         1ZQXt+KjLQZjCdKWfIOC8SG18OvMxTMp4waGGA57Pk1Aq6aW0rL6usKrkKlpRQfg6hE/
         YAC3MpkGe83ek2+JtCNqJoTCcFaiUOtfDDn99vsG9ObgB41Gilfyqz0xlp0ol+c3UC9P
         ETn3m8nFzi61310h93OYSg9LmaisnjuaCT6S1NUK9hEVt58WyHtTD+9NjuWVAbw10NU9
         hw2TjpMFqPMhxBsHjcjxbD/CF64+Q2wNjnCNcd+GqzNOG3L0ruCTlK5+fHjP/k8MHoCm
         4Vsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685795255; x=1688387255;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZcxFciO+FgadEz/OB9cY/SNSRDrKptPDDCbhwYKKivw=;
        b=GXHebttBvqIfodInCodjXa9dafY3HpnSPXi5Pjj3Pu4esHRifjQA9R1fl7LE4gT88X
         NFZGw85gLUUe7+1h+ELLraiUKR/9MEAHFSRuXyOK+s3nUhjKAmd6DvxlDhNuEv2QvUeh
         roJeBnvQR0f6Gjc2ckR7K0AcSXFi/I/beaYWnLnO5/1MbF7QaEjiDR8uVOHybq7r6MTh
         h9dXC/4qRN+XMxMHAWplK2HyZdIb0uwMm2/730Knz80IIsFrZruTui9GuVkI+t1nWVNZ
         UwNVrM73TY4PdUpz/f+A6rfVQMTY6aSlk5U2eBUiT0Cwz5+v1MB73nqt/PE6OaLejYwT
         jpGQ==
X-Gm-Message-State: AC+VfDxh7VyaRqFfaJRDL8we8QsCcs6TnuVOur+iD/9jua9raYsPPr5g
        WMZt6eUki/7Nvt4Cn0/eFS4=
X-Google-Smtp-Source: ACHHUZ6WkA2BZcESwcxlAeOsw3PJj/CPtyUZi607dceyCN4ixJQWx8ZldbdWd1nJQZzDpfz6MQ+R9w==
X-Received: by 2002:a17:907:94d4:b0:975:bb0:5628 with SMTP id dn20-20020a17090794d400b009750bb05628mr1224998ejc.15.1685795254500;
        Sat, 03 Jun 2023 05:27:34 -0700 (PDT)
Received: from skbuf ([188.27.184.189])
        by smtp.gmail.com with ESMTPSA id lh20-20020a170906f8d400b0094f698073e0sm1872588ejb.123.2023.06.03.05.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jun 2023 05:27:34 -0700 (PDT)
Date:   Sat, 3 Jun 2023 15:27:31 +0300
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
Message-ID: <20230603122731.bmo2r4jlwtwpcv3k@skbuf>
References: <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-1-arinc.unal@arinc9.com>
 <20230522121532.86610-9-arinc.unal@arinc9.com>
 <20230522121532.86610-9-arinc.unal@arinc9.com>
 <20230524175107.hwzygo7p4l4rvawj@skbuf>
 <576f92b0-1900-f6ff-e92d-4b82e3436ea1@arinc9.com>
 <20230526130145.7wg75yoe6ut4na7g@skbuf>
 <7117531f-a9f2-63eb-f69d-23267e5745d0@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7117531f-a9f2-63eb-f69d-23267e5745d0@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 03, 2023 at 03:15:52PM +0300, Arınç ÜNAL wrote:
> On 26.05.2023 16:01, Vladimir Oltean wrote:
> > Ok, but given the premise of this patch set, that phylink is always available,
> > does it make sense for mt7531_cpu_port_config() and mt7988_cpu_port_config()
> > to manually call phylink methods?
> 
> All I know is that that's how the implementation of phylink's PCS support in
> this driver works. It expects the MAC to be set up before calling
> mt753x_phylink_pcs_link_up() and mt753x_phylink_mac_link_up().

No, but I mean, won't phylink call mt7531_mac_config(), mt753x_phylink_pcs_link_up()
and mt753x_phylink_mac_link_up() automatically and in the expected order already,
and if not, what prevents that from happening? I just don't understand why the
cpu_port_config() methods of MT7531 and MT7988 call phylink methods manually
from the driver.
