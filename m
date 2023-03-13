Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE796B81F2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 20:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjCMT56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 15:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCMT54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 15:57:56 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E4985349
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:57:55 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e194so13211523ybf.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 12:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678737474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNmrFmdOwqWoZOf3NQ0Teya8OC/92es+1ha5kGZPvcs=;
        b=SPaD5icQTOki2lvuo1t+8avj4BVjLIgFuat6KCCg7JI/eQpSu0LnwlrX8X1uZaHFne
         yvuh+bm0/uBG0GlNKBpB8bi31DjTwkj2mjlzFO3GDXmLD00Rj2uMfEiNYLLUPkTx2j6k
         ma65PZZfWYD9k/JAxcJDsIjBUuHq/B66yOLZAXX9a0fiP89bk0+w4IJ7MJ74zCbIfudp
         7Q7phMuEI0s7UOXmkAR7qMNg/urT7aIkeVJH9kfMEfHREGO63cuhOCOJDhJAa4lOCNGQ
         LvbdnKaAcSPuaQULUKAnzrqC5sanIC1wYco56YSoI/bPvgmtjk5J4FWyzIt7/0+4Zpi+
         RY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678737474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNmrFmdOwqWoZOf3NQ0Teya8OC/92es+1ha5kGZPvcs=;
        b=5VA0tz10MU+XidTMeMvt5iKG9MZ+VByGEkB0eyeBQUZVjbBlgi4l2V8D1Nrc3g2hIs
         HlHutjLRYUNtqQtAmhxIhnyrzirX2YR0Wgn1EbpGmp7V+jOLETqHgv4UPqzmYpuUscwQ
         n0N3KolsZSrjXc2OSoCTC0Kkkm2HTgtTt3U5ZSzLbNOJ+hY+54kiCyoK1+BVhmouInK+
         r9nLvMNHnwAd1nAKrZdkBCzm3bWfym/tFA1G4i0vT4VzsrV0D9dJ7KmMogEc488K7hY+
         M8jpdNTZREHOHsz8KzS5inZ8GxHQU7srs8c4rnLyI4KxNIkxoZIumkYF/qCJ1EzoEPDD
         0cXQ==
X-Gm-Message-State: AO0yUKWI1o+aVU3StPW7Pl6dPSOtS0PLJiOlrG3X2ArlGLILLB0LHW2D
        CEb7apVw4oPRtGS2wLLF8ReAzjUlW/HtOcT92wF/
X-Google-Smtp-Source: AK7set+0TktabyCs4HMqig2S8zrjlmgzFzpORLNAB0cTxNDi06XIhxhfWP7pgN3ICHz+FDAq6xKoHCfJqM1lmj1MFwQ=
X-Received: by 2002:a25:7802:0:b0:b3c:637f:ad00 with SMTP id
 t2-20020a257802000000b00b3c637fad00mr3124843ybc.5.1678737474157; Mon, 13 Mar
 2023 12:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230312145305.1908607-1-zyytlz.wz@163.com>
In-Reply-To: <20230312145305.1908607-1-zyytlz.wz@163.com>
From:   John Stultz <jstultz@google.com>
Date:   Mon, 13 Mar 2023 12:57:44 -0700
Message-ID: <CANDhNCr=hdhKS4c+U=+W1ONHDWv6BrwL5TovGjs0G2G+Reqc9g@mail.gmail.com>
Subject: Re: [PATCH] misc: hisi_hikey_usb: Fix use after free bug in
 hisi_hikey_usb_remove due to race condition
To:     Zheng Wang <zyytlz.wz@163.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 7:53=E2=80=AFAM Zheng Wang <zyytlz.wz@163.com> wrot=
e:
>
> In hisi_hikey_usb_probe, it called hisi_hikey_usb_of_role_switch
> and bound &hisi_hikey_usb->work with relay_set_role_switch.
> When it calls hub_usb_role_switch_set, it will finally call
> schedule_work to start the work.
>
> When we call hisi_hikey_usb_remove to remove the driver, there
> may be a sequence as follows:
>
> Fix it by finishing the work before cleanup in hisi_hikey_usb_remove.
>
> CPU0                  CPU1
>
>                     |relay_set_role_switch
> hisi_hikey_usb_remove|
>   usb_role_switch_put|
>     usb_role_switch_release  |
>      kfree(sw)     |
>                     | usb_role_switch_set_role
>                     |   //use
>
> Fixes: 7a6ff4c4cbc3 ("misc: hisi_hikey_usb: Driver to support onboard USB=
 gpio hub on Hikey960")
> Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> ---
>  drivers/misc/hisi_hikey_usb.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.=
c
> index 2165ec35a343..26fc895c4418 100644
> --- a/drivers/misc/hisi_hikey_usb.c
> +++ b/drivers/misc/hisi_hikey_usb.c
> @@ -242,6 +242,7 @@ static int hisi_hikey_usb_probe(struct platform_devic=
e *pdev)
>  static int  hisi_hikey_usb_remove(struct platform_device *pdev)
>  {
>         struct hisi_hikey_usb *hisi_hikey_usb =3D platform_get_drvdata(pd=
ev);
> +       cancel_work_sync(&hisi_hikey_usb->work);
>
>         if (hisi_hikey_usb->hub_role_sw) {
>                 usb_role_switch_unregister(hisi_hikey_usb->hub_role_sw);

Looks sane to me.
Pulling in Sumit and YongQin as they have hardware and can test with it.

thanks
-john
