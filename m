Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A44746104
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 18:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjGCQzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 12:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjGCQzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 12:55:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5366E6B;
        Mon,  3 Jul 2023 09:55:12 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fbac8b01b3so38700155e9.1;
        Mon, 03 Jul 2023 09:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688403311; x=1690995311;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zL0YZw0wZXE91TR93PhKhNRpWNjTwpDaxV7QYySv1hc=;
        b=qolvdv4frtbW2slovXtEWKJ5ac1TY0rsQK+uaaZcq+AW4rZlaEY6zeK52rPmN0wj7w
         4jdGL6kO/P0ie8CLQWznY3QiJbSio/ihTl98Ps4VRgaGqIJ2737Op0Z3UiXPXPZ5EgvF
         skCFUvIkP/hyHSuRmqYCglloPkxdpaB68mXD3E+KGuMCUjQ7LdYvyrYJRD8g8LWHaJj5
         eJ/DdWaobowx7R7u6HXZ8zpLmSGjxzIHVW6aVGEdYJQFczQ8EKSkZ/hNOs1ZPA2/9uge
         sHbb1c3CJE9xcM9Hz7s3zJfKFEklOPIRuRRAP6ZKLuApD1zB0yt8vr3aihy2w5AAHGqM
         tSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688403311; x=1690995311;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zL0YZw0wZXE91TR93PhKhNRpWNjTwpDaxV7QYySv1hc=;
        b=IgFChkt8qTOg4dlOrWOPgfaAttGiO6OKUpsj6uzURvVNxuzJUhw8dh+0fA3DciXxsX
         VF+zehynYesowYRyNaKeYyGDlKSBI8TohzCmFMJZJUkRlTSa5icWK/o8kE3JcYCLt6J4
         gH9V5DguczgOx3BnZMQGhEhUcHhowic590Yb2mT4/Cw/RN4tYzQ3Bw25oNj4blIAumTn
         56+/sH+9hEAAtpV6bHFcPmkfoCA89I1z6813/6GH9TSYp4q6lU03gZqU2Np359BDc85o
         xBIeqhTSesJTIfcFbjwKOqd/I1A/1AYVsFcLwtnTr6LsyCPCbdWSLmAf911+rx0/AQZ9
         3nyw==
X-Gm-Message-State: AC+VfDy+cFTQvXBKoKwyC43fWUBw3foTdfdfLN4pdv9A5yUOIzsOTTFq
        eE/hspqu2N6K8pcUr4aqCZ8=
X-Google-Smtp-Source: ACHHUZ4P5/s4YSdgkJjHIAQiIvPfe9LjkoY4u3f23reQEzleXMzdCk10cx0XLLnoN1NZt56wZ4g39w==
X-Received: by 2002:a05:600c:210a:b0:3fa:aeac:e978 with SMTP id u10-20020a05600c210a00b003faaeace978mr9730976wml.0.1688403310952;
        Mon, 03 Jul 2023 09:55:10 -0700 (PDT)
Received: from skbuf ([188.25.159.134])
        by smtp.gmail.com with ESMTPSA id u16-20020a7bcb10000000b003fbb5142c4bsm13983188wmj.18.2023.07.03.09.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 09:55:10 -0700 (PDT)
Date:   Mon, 3 Jul 2023 19:55:08 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/7] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20230703165508.po7tl5q2z2twf6on@skbuf>
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
 <20230625115343.1603330-6-paweldembicki@gmail.com>
 <20230625150552.sljrgm6rqodmefq5@skbuf>
 <CAJN1KkycUbLLWSTACr=xpuxLG7Arn3L0O0+z2VtyovnFx9s5QA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJN1KkycUbLLWSTACr=xpuxLG7Arn3L0O0+z2VtyovnFx9s5QA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 10:18:08PM +0200, Paweł Dembicki wrote:
> niedz., 25 cze 2023 o 17:05 Vladimir Oltean <olteanv@gmail.com> napisał(a):
> > Why do you need ports to be double VLAN aware when vlan_filtering=0?
> > Isn't VLAN_TCI_IGNORE_ENA sufficient to ignore the 802.1Q header from
> > incoming packets, and set up the PVIDs of user ports as egress-tagged on
> > the CPU port?
> 
> Because I want to forward tagged and untagged frames when
> vlan_filtering is off.  If I set VSC73XX_DOUBLE_VLAN_AWARE, I can put
> all (tagged and untagged) traffic into the outer vlan, called by the
> datasheet as "MAN space". In QinQ mode, it is possible to ignore what
> goes from a particular port but it is possible to separate traffic
> from different ports.

I think we may have some problem in finding common terminology.

Opening the manual and seeing the table "Customer Port Sample Configuration",
I think it's indeed what you need. But I wouldn't call it "double VLAN aware".
The port is actually configured to be VLAN *unaware* from the perspective of
classification, and always encapsulate all packets in one more VLAN (the
port PVID).

This switch's analyzer is always aware only of the outer VLAN header, and
that's not "double VLAN aware" (it can perform no action based on the
inner VLAN, if that exists), but it's fine for what is needed of it.

You might be mixing these with MAC_CFG::VLAN_AWR and MAC_CFG::VLAN_DBLAWR,
which essentially are only there to allow single- and double-VLAN-tagged
frames to be longer by 4 and 8 bytes, respectively, than the max frame
size. I don't think that these 2 fields have any reason to depend upon
the bridge VLAN awareness state of the port. They can be unconditionally
enabled. After all, Linux only cares about MTU, and that is the size of
the L2 payload, excluding any VLAN headers, if present.

I would suggest that if you exclude the MAC_CFG registers from
vsc73xx_port_set_vlan_conf(), you end up with not as many VLAN awareness
modes as you think. 2, to be precise: on or off. So you don't need the
enum.

Also, AFAIU, I don't see a reason to modify CAT_VLAN_MISC::VLAN_KEEP_TAG_ENA
from the value of 1 at all. You could always keep frames in the queue
system with the VID attached, and strip that VID on egress, if necessary,
via TXUPDCFG.

Not sure if you're noticed this, but drivers/net/ethernet/mscc/ and
drivers/net/dsa/ocelot/ contain a driver for a newer generation of
hardware than the VSC73xx, but many of the concepts apply. Maybe you
can take a look at how some things were done there.

> > > +
> > > +     for (i = 0; i <= 3072; i++) {
> > > +             ret = vsc73xx_port_update_vlan_table(ds, port, i, 0);
> > > +             if (ret)
> > > +                     return ret;
> > > +     }
> >
> > What is the purpose of this?
> 
> I want to be sure that the table is cleared when vlan awareness is changed.

Yes, but why? That should specifically not be done, since there is no
code in the kernel to replay the port_vlan_add() and tag_8021q_vlan_add()
calls for you when the VLAN awareness state changes. If you delete the
VLANs, they're gone, even though in software they're still there.
