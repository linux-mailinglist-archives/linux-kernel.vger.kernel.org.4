Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB075B90AD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 01:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiINW77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiINW74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:59:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C6313D6F;
        Wed, 14 Sep 2022 15:59:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8CA1B81D01;
        Wed, 14 Sep 2022 22:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7998BC433C1;
        Wed, 14 Sep 2022 22:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663196392;
        bh=oWqqdyBXsokNJ3n9bzT2vkSRtqN+2pGUWbS5nYnQsTg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WpA7MwY3qrlIOvQJuzLzBuUA0PTGT9Lnje7tnXMz3DteGiR1yFr8oPSS1l4qf9Akr
         UzUsjPljRzimjKGqUdTNGUtywUef0Bz9EZhHQYgOt1YyXB5dQ1+hq9jNM3dSO6/hop
         Uo4/a8KV2ySCM1korX2pji1Eaz8L6hq1yL27ztqg2hLAiue7aOgaSmqL5n91DV+kmP
         56k5gVZDiF7f+jbQ7LfiX71LEVZWfWLEFbQK2Yf4VZXvuI4quEwcFOqipgsrYhAmAJ
         +0auUWHy1k+ksil4SS5MtvBmgB9pOgg67AVs0XXE1O/OW4haDwKsvARseas6eRwAQK
         XMMrPzi1sLjtQ==
Received: by mail-wm1-f43.google.com with SMTP id o5so8593638wms.1;
        Wed, 14 Sep 2022 15:59:52 -0700 (PDT)
X-Gm-Message-State: ACgBeo3B2+Dj+IBhIFO0KOi3kw6N8x2XUDiSe/FihtWzClYU2ppGPW0o
        WLHvzEfJbfi4K9pyguuueC7i3/AgxE0TTF/56eU=
X-Google-Smtp-Source: AA6agR7qaHmVQJjOn3ABWhUEKPyB5dmh5/6FOPhCQ93FD/FBWSx3finiKnKlWC/6fdcKkqMYciv4HAmIrP/+z1PjHoo=
X-Received: by 2002:a05:600c:22d3:b0:3a8:424d:f386 with SMTP id
 19-20020a05600c22d300b003a8424df386mr4636751wmg.57.1663196390712; Wed, 14 Sep
 2022 15:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <43b68b1f48c20b1dfcd7e6663c3dcb38e4e0648c.1663020936.git.objelf@gmail.com>
 <8c734b83-aa2a-83a6-cb12-28e36ace2bbb@collabora.com>
In-Reply-To: <8c734b83-aa2a-83a6-cb12-28e36ace2bbb@collabora.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Wed, 14 Sep 2022 15:59:38 -0700
X-Gmail-Original-Message-ID: <CAGp9Lzq5LrDi0qgOOWFXtGJObYEyxsMz=M_UBObwstBc9p+1=g@mail.gmail.com>
Message-ID: <CAGp9Lzq5LrDi0qgOOWFXtGJObYEyxsMz=M_UBObwstBc9p+1=g@mail.gmail.com>
Subject: Re: [PATCH 1/4] Bluetooth: btusb: mediatek: use readx_poll_timeout
 instead of open coding
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

HI Angelo,

On Tue, Sep 13, 2022 at 1:04 AM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 13/09/22 00:18, sean.wang@mediatek.com ha scritto:
> > From: Sean Wang <sean.wang@mediatek.com>
> >
> > Use readx_poll_timeout instead of open coding to poll the hardware reset
> > status until it is done.
> >
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
>
> Hello Sean, thanks for the patch!
> However, there's something to improve...
>
> > ---
> >   drivers/bluetooth/btusb.c | 32 ++++++++++++++++++--------------
> >   1 file changed, 18 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index c3daba17de7f..4dc9cae3e937 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
>
> ..snip..
>
> > @@ -2910,18 +2918,14 @@ static void btusb_mtk_cmd_timeout(struct hci_dev *hdev)
> >       btusb_mtk_uhw_reg_write(data, MTK_BT_SUBSYS_RST, 0);
> >       btusb_mtk_uhw_reg_read(data, MTK_BT_SUBSYS_RST, &val);
> >
> > -     /* Poll the register until reset is completed */
> > -     do {
> > -             btusb_mtk_uhw_reg_read(data, MTK_BT_MISC, &val);
> > -             if (val & MTK_BT_RST_DONE) {
> > -                     bt_dev_dbg(hdev, "Bluetooth Reset Successfully");
> > -                     break;
> > -             }
> > +     err = readx_poll_timeout(btusb_mtk_reset_done, hdev, val,
> > +                              val & MTK_BT_RST_DONE,
> > +                              100000, 1000000);
>
> I agree with using readx_poll_timeout() instead of open coding the same, but
> there's a catch: this macro uses usleep_range(), which is meant to be used
> for sleeping less than ~20ms.
>
> Even the kerneldoc at include/linux/iopoll.h advertises that:
>
>   * @sleep_us: Maximum time to sleep between reads in us (0
>   *            tight-loops).  Should be less than ~20ms since usleep_range
>   *            is used (see Documentation/timers/timers-howto.rst).
>
> So, if there's any reason for which you can't sleep for less than 100ms
> per iteration, I'm afraid that you can't use readx_poll_timeout()...
> ...otherwise, please change sleep_us to 20000 and keep the timeout at 1 sec.
>

It should be able to be done with polling in 20ms until 1 sec expires
or it is done. It increases some cost in the bus transaction
interacting with the device, but it seemed fine for me because the
code path is cold, it is only working in the device reset which should
rarely happen, and only involves when it is really necessary. That is
a nice catch. I was trying not to break the existing logic
but overlooked the requirements of the API.

    Sean

> Regards,
> Angelo
>
> > +     if (err < 0)
> > +             bt_dev_err(hdev, "Reset timeout");
> >
> > -             bt_dev_dbg(hdev, "Polling Bluetooth Reset CR");
> > -             retry++;
> > -             msleep(MTK_BT_RESET_WAIT_MS);
> > -     } while (retry < MTK_BT_RESET_NUM_TRIES);
> > +     if (val & MTK_BT_RST_DONE)
> > +             bt_dev_dbg(hdev, "Bluetooth Reset Successfully");
> >
> >       btusb_mtk_id_get(data, 0x70010200, &val);
> >       if (!val)
>
