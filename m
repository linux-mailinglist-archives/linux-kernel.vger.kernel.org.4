Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401AA5B908D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 00:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiINWpd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 18:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiINWpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 18:45:31 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED58925C59;
        Wed, 14 Sep 2022 15:45:27 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f9so26773307lfr.3;
        Wed, 14 Sep 2022 15:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zFF2lCYlEtGBcqj2aYJNGrAsisA/ypCs1g/YrKPkZYA=;
        b=L7Da3Ihe9ysWH419HKN8UZD8WdHltmVwGyORUc/Xf8VEyR8J4EXkaKfbz2ivXiXnwG
         102SNzJS1UljweZ6+J5Qof8DmYtntbvIh2+wlbDYZLtF9CuNxnqFjdkhE6A6ksiEotcH
         83ml9SovYJF+xHAIjLOwTax8fRAtcgUmzPMD95Z6Awfbi8g2bIW4NGtUNEgPK370UhCr
         tVE92vKagUCv0OBs88rf6t8WkpsPi2Bvd57oHLOny4W4Svz8FARLLEGxoeqoRTLUfn7N
         0xXFRfZqDtj+cxKR3FCGe62YMoO3d/Y4DxBjt5zVeC/gsCQsS03zliwt5zYZP5pqnRy4
         CyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zFF2lCYlEtGBcqj2aYJNGrAsisA/ypCs1g/YrKPkZYA=;
        b=xD6qWkW0/DhLg/GBpPW9HhSF2qVhkkJuyCpt9uXiggrsQSiRl6YP2fm5FT8/gM5fMH
         F10X6n/gEyVv9IMpe/Ne8b+vf+nlf1/OyJkmiAH1lUi6Hon/7aLE2qt/AZ4iS2VA62XZ
         p6ngS/j1nWXl0WyotUNo1eRGY+cHmAhZJyl3BrofeRhTUQpa45stERbGmdsutGbXD0Nr
         6cuiG5gz7wzm7okrd763XALurNTt5nHE4bhVSLGo+Bxt6foSgjb/yGhMogBSEWFI7Tve
         LoGKZgeR8fGEk2QcvnmZkAhTxgWxo4HsFMuYmuPr1MqKtGZuXOj2YF0ZnFVL22w81bcj
         OX3w==
X-Gm-Message-State: ACrzQf32uksbsWwehy7erEZwuswCiZ56k6Bzx8RUXXH3U9Knu27ecUF0
        UQJs7VbPTb7+lJAmsZRB2qYoO9mxKlf95O41dg8=
X-Google-Smtp-Source: AMsMyM6SCeXeYYoK1cu55dFuBxWNFB6ruywGaz6zlJkrpy1QCR8r2NmbIuQhd4neJWcbDuAgQ8Zh+vkDiNTz5D/FfOs=
X-Received: by 2002:a19:6555:0:b0:49e:7d52:a4ca with SMTP id
 c21-20020a196555000000b0049e7d52a4camr643616lfj.198.1663195526049; Wed, 14
 Sep 2022 15:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <43b68b1f48c20b1dfcd7e6663c3dcb38e4e0648c.1663020936.git.objelf@gmail.com>
 <a432abf4cf95e93783864b27bafa53d45bdd5212.1663020936.git.objelf@gmail.com>
In-Reply-To: <a432abf4cf95e93783864b27bafa53d45bdd5212.1663020936.git.objelf@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Sep 2022 15:45:14 -0700
Message-ID: <CABBYNZ+Z+BApMOPEgVBxf6j0sTYFE0tH6Eab-hQW8FKVFqfvqA@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: btusb: mediatek: reset the device as WMT failed
To:     sean.wang@mediatek.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On Mon, Sep 12, 2022 at 3:18 PM <sean.wang@mediatek.com> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> Reset the BT device whenever the driver detected any WMT failure happened
> to recover such kind of system-level error as soon as possible.
>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/bluetooth/btusb.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 653f57a98233..dc86726c8271 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2576,6 +2576,10 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
>         data->evt_skb = NULL;
>  err_free_wc:
>         kfree(wc);
> +
> +       if (err < 0)
> +               btmtk_reset_sync(hdev);

Doesn't reset itself can fail?

>         return err;

It would probably be better to reset on error at the caller IMO, also
in case it fails during firmware upload does reset even work? Also it
would probably have been better to have its own file for vendor
specific commands like this and use btmtk_ prefix as well.

>  }
>
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
