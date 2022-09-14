Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C83D5B8F35
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiINTPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 15:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiINTPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 15:15:10 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF7F5B079
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 12:15:08 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id h21so11959747qta.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 12:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=imU6N/sbMDNwpxG/ml2ujPHotZONSIOXltM3qdyiYEg=;
        b=U/9GmOj+GfMD2TH7b2IpkKELRpqmUZkeeowz2SRbmL0+H33N8eIBdCjO6GVRzC4RWs
         RM5ovijGZKdH676/OXn4ERY5DkZ5B11052NL2Yg5tSB72ujaPk2nG/GiuvuuV9lze7DW
         1yQd3M7zdbC2InodbaDWm4SojuJ+6EegEtV5JrB2nvWqBtIh+s5RBl8ikaydAiyV5ylK
         H8nWybPSTACWUlkQCsz3ylFyi6I+Zp2NrYd4hfzKeIYgUcRwEa2NOLnaLmPotcUoI4iO
         //ram+OjsBORt9GKCVbhvW2nXwaiqsQU/uxqQdArJKgnpDJc+bdrT2MoPfMVXKZEUiWE
         8PzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=imU6N/sbMDNwpxG/ml2ujPHotZONSIOXltM3qdyiYEg=;
        b=PdgZYNS2akg7wYRVwBhDXEQWNUbcYyLKMHyEy0/NrSMkfpDrtZ7vdOe2/k6fNvJzsE
         0tCCPHlEb2aq62xyYSJ0YEZYjgWjpNgLAIdrUki3AmsvAvmN3TFgyGx9e14djWNufALx
         KmWCP9TVUgQDHhIfdSRbqFuiX6sEO/Jec65TFG2qrKc2S9Q7bJjc0jHaYNDa99VEK2bH
         aMI2agXYmfJRJH0ysp+lY/hy98Zo6WgYYywxTSI4VRJmogMfFe/AVAhDq/ii29gtDK4a
         KXbFlSAErpSthGinDnMNbK5roUNBOi58SkNP5oORFQxORIp35fbHKPpHeO0wNXKrrFDd
         15gg==
X-Gm-Message-State: ACgBeo2P/Gy24mbYsem7xcaLAjr2l98YrJiAtxyoRU0+GlVGSBzPCz7l
        l/S3kejLBmLnJxyiQsJxhJjiUPmfLPWd2DyVrXFm/w==
X-Google-Smtp-Source: AA6agR7vZKjaZzM24rYovfFQyKuHAPFpHIzjRs5BIEUSYEB8YPicvGP6DCoHcRyQaHhwg57ssIZpTiuY6MFOUK+AAYs=
X-Received: by 2002:ac8:7dca:0:b0:344:5679:2dbb with SMTP id
 c10-20020ac87dca000000b0034456792dbbmr34760646qte.245.1663182907940; Wed, 14
 Sep 2022 12:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220912214617.929240-1-nhuck@google.com> <YyEO01+suq0Wl/2F@dev-arch.thelio-3990X>
In-Reply-To: <YyEO01+suq0Wl/2F@dev-arch.thelio-3990X>
From:   Nathan Huckleberry <nhuck@google.com>
Date:   Wed, 14 Sep 2022 12:14:00 -0700
Message-ID: <CAJkfWY7SAOMgKH68ffVeQxd94BxnqnkYp3Q1oW7XLV3Zc=9K4Q@mail.gmail.com>
Subject: Re: [PATCH] staging: rtl8723bs: Fix rtw_xmit_entry return type
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Dan Carpenter <error27@gmail.com>, llvm@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
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

Looks like this was already fixed in a90044ef5605bc0961356548526c44964bc819a7

Ignore this patch.


On Tue, Sep 13, 2022 at 4:14 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Mon, Sep 12, 2022 at 02:46:14PM -0700, Nathan Huckleberry wrote:
> > The ndo_start_xmit field in net_device_ops is expected to be of type
> > netdev_tx_t (*ndo_start_xmit)(struct sk_buff *skb, struct net_device *dev).
> >
> > The mismatched return type breaks forward edge kCFI since the underlying
> > function definition does not match the function hook definition.
> >
> > The return type of rtw_xmit_entry should be changed from int to
> > netdev_tx_t.
> >
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1703
> > Cc: llvm@lists.linux.dev
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
>
> The prototype in drivers/staging/rtl8723bs/include/xmit_osdep.h should
> be updated as well. With that:
>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
>
> > ---
> >  drivers/staging/rtl8723bs/os_dep/xmit_linux.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> > index 530e7a6c67c5..472d3ac0179b 100644
> > --- a/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> > +++ b/drivers/staging/rtl8723bs/os_dep/xmit_linux.c
> > @@ -181,7 +181,7 @@ static int rtw_mlcst2unicst(struct adapter *padapter, struct sk_buff *skb)
> >       return true;
> >  }
> >
> > -int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
> > +netdev_tx_t _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
> >  {
> >       struct adapter *padapter = rtw_netdev_priv(pnetdev);
> >       struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
> > @@ -217,15 +217,12 @@ int _rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
> >       dev_kfree_skb_any(pkt);
> >
> >  exit:
> > -     return 0;
> > +     return NETDEV_TX_OK;
> >  }
> >
> > -int rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
> > +netdev_tx_t rtw_xmit_entry(struct sk_buff *pkt, struct net_device *pnetdev)
> >  {
> > -     int ret = 0;
> > -
> >       if (pkt)
> > -             ret = _rtw_xmit_entry(pkt, pnetdev);
> > -
> > -     return ret;
> > +             return _rtw_xmit_entry(pkt, pnetdev);
> > +     return NETDEV_TX_OK;
> >  }
> > --
> > 2.37.2.789.g6183377224-goog
> >
