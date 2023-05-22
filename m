Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26DF70CAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 22:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234397AbjEVUR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 16:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbjEVUQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 16:16:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC1C184
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:25 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f5dbd8f677so1455e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 13:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684786584; x=1687378584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgIuipWDW2M3E5mzxpsdUwXJEbfSRwP8TZNDUu0qiYg=;
        b=IH3g/6o9+scn7S83kkFJQ8yep4C+vmuV6+fjgPWMhxosVlhn1PbcSI8CMX8hB70r6e
         r/mr/dorGNRzM5dhLeDd3YbZYKdpMXkGBVWRY2je15izsopn9asKiztX8WdJKqaq17yD
         YTHAL7pUyU/rVlKqHjlaCPBMXJCeRCZpZ3zRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684786584; x=1687378584;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgIuipWDW2M3E5mzxpsdUwXJEbfSRwP8TZNDUu0qiYg=;
        b=ZBYXqa8PR/nVoX6kC9geMTi+B65Y9l2W6EFpOHEBUDnp8S03wWjMLrLWC0UvPd3QVa
         Tn/HK7AnXV1oj8dshx/FnlCVF3K2ZWVTalgbUuGEFKtlua9DtvO4Seck2bddUnXtRp8A
         L7Qtgq//nPgQrF+Acxrb2bLN1F/rQU2XycHVe2a9tr9zBpNr2OGYVKsMOmyGUIiT+FA5
         PgzWAH9932LCLaVVLZabzNQ8AFBSBz7nX/KW600PD5+IzVwUOcHNMeUm3lwImz+Cm2o/
         aphJ4gjVwVCXxsLUuU86yBxfFyC+7JqGZRyCcg1FbgKpZWmFSFkqtKGJvDggl3M9OokA
         C5Dg==
X-Gm-Message-State: AC+VfDye+1gmaIULaTIwO5MyKfLc93/uCSF7KyB0vjxGyU8BWe+yGNZY
        0TuTXXTc+9vVdknonwZ6gbKAbri2yd3Y+ZdvtRCGEw==
X-Google-Smtp-Source: ACHHUZ5iGjpuC9AkaKlFs80nVJ4jJR4XYAbA6DOvdT3vqQU4/vsED7Tl61v0MgCb7ZChy9ZvLgST86vy7qhmkA5Pbro=
X-Received: by 2002:a05:600c:3b16:b0:3f4:fb7:48d4 with SMTP id
 m22-20020a05600c3b1600b003f40fb748d4mr36406wms.3.1684786584163; Mon, 22 May
 2023 13:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230518072657.1.If9539da710217ed92e764cc0ba0f3d2d246a1aee@changeid>
 <CALs4sv2+Uu=Bry=B3FYzWdNrHjGWDvPCDhTFcNERVpWTjpmEyA@mail.gmail.com>
In-Reply-To: <CALs4sv2+Uu=Bry=B3FYzWdNrHjGWDvPCDhTFcNERVpWTjpmEyA@mail.gmail.com>
From:   Grant Grundler <grundler@chromium.org>
Date:   Mon, 22 May 2023 13:16:12 -0700
Message-ID: <CANEJEGuzoBa_yYHRCa0KygUe=AOhUkSg4u6gWx+QNCuGtKod2Q@mail.gmail.com>
Subject: Re: [PATCH] igb: Fix igb_down hung on surprise removal
To:     Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc:     Ying Hsu <yinghsu@chromium.org>, netdev@vger.kernel.org,
        grundler@chromium.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 3:36=E2=80=AFAM Pavan Chebbi <pavan.chebbi@broadcom=
.com> wrote:
>
> On Thu, May 18, 2023 at 12:58=E2=80=AFPM Ying Hsu <yinghsu@chromium.org> =
wrote:
> >
> > diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/et=
hernet/intel/igb/igb_main.c
> > index 58872a4c2540..a8b217368ca1 100644
> > --- a/drivers/net/ethernet/intel/igb/igb_main.c
> > +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> > @@ -9581,6 +9581,11 @@ static pci_ers_result_t igb_io_error_detected(st=
ruct pci_dev *pdev,
> >         struct net_device *netdev =3D pci_get_drvdata(pdev);
> >         struct igb_adapter *adapter =3D netdev_priv(netdev);
> >
> > +       if (state =3D=3D pci_channel_io_normal) {
> > +               dev_warn(&pdev->dev, "Non-correctable non-fatal error r=
eported.\n");
> > +               return PCI_ERS_RESULT_CAN_RECOVER;
> > +       }
> > +
>
> This code may be good to have. But not sure if this should be the fix
> for igb_down() synchronization.

I have the same opinion. This appears to solve the problem - but I
don't know if there is a better way to solve this problem.

> Intel guys may comment.

Ping? Can we please get feedback from IGB/IGC maintainers this week?

(I hope igc maintainers can confirm this isn't an issue for igc.)

cheers,
grant

>
> >         netif_device_detach(netdev);
> >
> >         if (state =3D=3D pci_channel_io_perm_failure)
> > --
> > 2.40.1.606.ga4b1b128d6-goog
> >
> >
