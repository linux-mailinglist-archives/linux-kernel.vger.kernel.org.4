Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276935B9083
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiINWe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiINWeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:34:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648AE785A8;
        Wed, 14 Sep 2022 15:34:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F372361F58;
        Wed, 14 Sep 2022 22:34:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B612C43470;
        Wed, 14 Sep 2022 22:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663194863;
        bh=5JNKrPYbxMNe6Hm6rld4fqMiyupR+bHOxvW1ZOcAvpc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZpMMMiJhnoxLtZk9rLxTeIYajMlKz7VBGEy3QpDuF7nVa6PlEKsuJxKPQuiVFSNIe
         2TL608GGg6RlAB+RVg9htWN6DLNLY0C8kYNgVWficw8w9va44x9+nixDlNGGE6VEUj
         CgTeUOeyHZEvCBdK4fWbqW5wShEJm8m6V3IceuUiBhl/DRm3NdZS4HtftobWb7Cdq6
         pDs/LY04D4o9OTkU1CbqBpP0GF9IEXDTSBnKUrKvliZeHx29e0aKM7eFA4m6FHE4jG
         LfwYzLZWN2Czly7GEs1V2+PbLXtaOGjku1O812e0H1xoneOV2emKaKIX5b5zMSMyub
         C4i3WX0QThW4w==
Received: by mail-wm1-f50.google.com with SMTP id r66-20020a1c4445000000b003b494ffc00bso3980105wma.0;
        Wed, 14 Sep 2022 15:34:23 -0700 (PDT)
X-Gm-Message-State: ACgBeo1NIiQjCz2NweMa/N1MqYuhZG+GEOuJNtnVcYm8Urpsy3QS0BlO
        aMtBpcLfV5U0hSCLwdzpGTNZlhkd/t+L0AsAVas=
X-Google-Smtp-Source: AA6agR7ru2g7GnIe25Ah1O05C3vLxOEHyNPJD5VFnOAgGP94sW4ihHDOIPwLKc/bBXA4Vqh3EO+xnXJtdy7eYprJF0Y=
X-Received: by 2002:a7b:c84c:0:b0:3b3:3faa:10c3 with SMTP id
 c12-20020a7bc84c000000b003b33faa10c3mr4601516wml.94.1663194861556; Wed, 14
 Sep 2022 15:34:21 -0700 (PDT)
MIME-Version: 1.0
References: <43b68b1f48c20b1dfcd7e6663c3dcb38e4e0648c.1663020936.git.objelf@gmail.com>
 <a432abf4cf95e93783864b27bafa53d45bdd5212.1663020936.git.objelf@gmail.com> <07016e51-a5b5-a350-cad2-b9fcebfe3706@collabora.com>
In-Reply-To: <07016e51-a5b5-a350-cad2-b9fcebfe3706@collabora.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Wed, 14 Sep 2022 15:34:09 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzr7hruZ3LXD_bAVb_xy8v5YXptVpye9tEpO=aF18r_4Cw@mail.gmail.com>
Message-ID: <CAGp9Lzr7hruZ3LXD_bAVb_xy8v5YXptVpye9tEpO=aF18r_4Cw@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: btusb: mediatek: reset the device as WMT failed
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sean.wang@mediatek.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        abhishekpandit@google.com, michaelfsun@google.com,
        abhishekpandit@chromium.org, mcchou@chromium.org,
        shawnku@google.com, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Angelo

On Tue, Sep 13, 2022 at 1:23 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 13/09/22 00:18, sean.wang@mediatek.com ha scritto:
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > Reset the BT device whenever the driver detected any WMT failure happened
> > to recover such kind of system-level error as soon as possible.
> >
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>
> This looks like a fix, so you probably want a Fixes tag for backport.

I didn't add the fix tag because there is not a previous patch that
had issues the patch needs to fix.

It would be looking more like an enhancement patch for me to fix up
the potential issue happening in the firmware where the existing
driver cannot detect and recover in time with .cmd_timeout callback
but actually, the kind of potential issue in firmware I was worried
about in the firmware didn't happen or being reported so far.

   Sean

>
> Regards,
> Angelo
>
> > ---
> >   drivers/bluetooth/btusb.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 653f57a98233..dc86726c8271 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -2576,6 +2576,10 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
> >       data->evt_skb = NULL;
> >   err_free_wc:
> >       kfree(wc);
> > +
> > +     if (err < 0)
> > +             btmtk_reset_sync(hdev);
> > +
> >       return err;
> >   }
> >
>
