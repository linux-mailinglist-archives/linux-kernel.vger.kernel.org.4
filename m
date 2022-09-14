Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938A05B8F34
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 21:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiINTOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiINTOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 15:14:15 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9308277D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 12:14:15 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id o7so7977375qkj.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=LfkhmSmZlv7MTBgKYoDZ1uG5kIlxP0nQaqCNbV6G8cQ=;
        b=Dn9mmNxksHUvVHl0pIxrz1ABcy0LaFAY1PRdBPDU0JgfVgdc4cH5CrLx4LVlTMNZ6h
         UE1M83T2Rc6+yQUTkP8iZK1exokKDi1KZPUjt/XfanFohGqKKBnbHKKdWC3ZHdbBinP2
         GE7jo7Nj45MKmXR77bIWqHKkId/ytSRGEX/0yv00VhvqPS0jtrA5tlC+x1O656SZ6fWP
         ZbZZ9qNcLV5/ocvlxCGM2pYZvDcqdOkvcAFY/v+bTQOFBaVWoga0Gtujo0O+PmQI+74Q
         1QY2npKKQ6V2j9pP5v81N7RbdC+ipldC27P+xeQE5WbnpKV1h6h7WakOldQ6yMEdHRMX
         tlZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=LfkhmSmZlv7MTBgKYoDZ1uG5kIlxP0nQaqCNbV6G8cQ=;
        b=UynxTh5igR8DabDdeZHoAUXOf/ZsQIpYhupi1xGSdAkXGKrUKuabHfv1TaATFCheXd
         PIH6KEF/m9SQyBuM4THFzcm71D1TrJZ3X1VSdnRFXQgJLfmgQ+yQzRnvJGNXlfrvgPXU
         COAy4ekRIe5OdWfon7rj8BZfD0J7fJDHUqLSEZmy/4bA5KbgC99u1AAeZClfk59Tn7we
         KnTSUHNM2tFbqmlg5HzWDcGNvbVg6Ng+PJBEaw+p/f0RprJMZmwbaOc/Sq6dV2KX/0TR
         fBbttDS9wm4n2g34Z94ei0z3TccsOa4elF4woq4NT5ixHSGGiTkT/j6GPKNsnmdl2piA
         rwaA==
X-Gm-Message-State: ACgBeo1+m+T4Z/B4e9kcfsfIx0AS5EV3lNdfqeO0wzOtP9sp24PWv00L
        6yD68XoryQwuusU7yHfhMw+v2GSt+P9al04ENgiUvw==
X-Google-Smtp-Source: AA6agR6mTM7/LOyAY3+2AfaAH3ubmnPpGOmGQdppjrjxHWlT5jX+s9P7i51XQmJa6lcLD8OOueeGxHN7ID7C7elvWr4=
X-Received: by 2002:a05:620a:2588:b0:6c9:2daa:9c6d with SMTP id
 x8-20020a05620a258800b006c92daa9c6dmr27798976qko.630.1663182854112; Wed, 14
 Sep 2022 12:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220912214607.929211-1-nhuck@google.com> <YyEOZ+u/T8rP6o9S@dev-arch.thelio-3990X>
In-Reply-To: <YyEOZ+u/T8rP6o9S@dev-arch.thelio-3990X>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Wed, 14 Sep 2022 12:13:00 -0700
Message-ID: <CAJkfWY60NSy382-Px-Xqj_r-57fREMhvyDx8rMJvJ3Q+CsHwrw@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8712: Fix return type of r8712_xmit_entry
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Sathish Kumar <skumark1902@gmail.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like this was already fixed in 307d343620e1fc7a6a2b7a1cdadb705532c9b6a5

Ignore this patch.


On Tue, Sep 13, 2022 at 4:12 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Sep 12, 2022 at 02:46:03PM -0700, Nathan Huckleberry wrote:
> > The ndo_start_xmit field in net_device_ops is expected to be of type
> > netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).
> >
> > The mismatched return type breaks forward edge kCFI since the underlying
> > function definition does not match the function hook definition.
> >
> > The return type of r8712_xmit_entry should be changed from int to
> > netdev_tx_t.
> >
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
>
> The prototype in drivers/staging/rtl8712/xmit_osdep.h should be updated
> as well. With that:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >  drivers/staging/rtl8712/xmit_linux.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8712/xmit_linux.c b/drivers/staging/rtl8712/xmit_linux.c
> > index 4a93839bf947..e84b9fa231cd 100644
> > --- a/drivers/staging/rtl8712/xmit_linux.c
> > +++ b/drivers/staging/rtl8712/xmit_linux.c
> > @@ -140,7 +140,7 @@ void r8712_xmit_complete(struct _adapter *padapter, struct xmit_frame *pxframe)
> >       pxframe->pkt = NULL;
> >  }
> >
> > -int r8712_xmit_entry(_pkt *pkt, struct  net_device *netdev)
> > +netdev_tx_t r8712_xmit_entry(_pkt *pkt, struct  net_device *netdev)
> >  {
> >       struct xmit_frame *xmitframe = NULL;
> >       struct _adapter *adapter = netdev_priv(netdev);
> > @@ -165,11 +165,11 @@ int r8712_xmit_entry(_pkt *pkt, struct  net_device *netdev)
> >       }
> >       xmitpriv->tx_pkts++;
> >       xmitpriv->tx_bytes += xmitframe->attrib.last_txcmdsz;
> > -     return 0;
> > +     return NETDEV_TX_OK;
> >  _xmit_entry_drop:
> >       if (xmitframe)
> >               r8712_free_xmitframe(xmitpriv, xmitframe);
> >       xmitpriv->tx_drop++;
> >       dev_kfree_skb_any(pkt);
> > -     return 0;
> > +     return NETDEV_TX_OK;
> >  }
> > --
> > 2.37.2.789.g6183377224-goog
> >
