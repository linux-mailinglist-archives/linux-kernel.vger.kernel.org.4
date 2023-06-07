Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B25047268CE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjFGSd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjFGSd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:33:26 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A90B1FE2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:33:14 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-565bd368e19so82119167b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20221208.gappssmtp.com; s=20221208; t=1686162793; x=1688754793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e9urOsg3XOcxz6eWa1eYoSND4lj93DSl8iQ3727M7/0=;
        b=4+dPmbw6GeHCDQXyo+hj+MMjmXqSJTRIC0MSsq73FLUKqqVsvwyTwM0OiXbHJzsglH
         JPI37ZXVsUZwojmlPFijwyT1mMKNTI1yQir8BK+J79GxkdnwL5KECtz1jQbQPm/boqUe
         z7nz84uMaivMo2CRCEgTB5kU/+Ppzo3lyprsMz+35NTyXJOp5LsMJl8ZtSS+sfZPNoFR
         5argTwBLSLldtfRudJW51TS5Aye4eKneBoT6PqqUPo/y5FScXU9gbg6VgokDAHXfxfdD
         MzBY3qg00c+utw6MNhIyMW41FyxgVS6OqapLQ9j5NsSUcGv3REu88DQ5P5EwS7KceRy7
         VM9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686162793; x=1688754793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9urOsg3XOcxz6eWa1eYoSND4lj93DSl8iQ3727M7/0=;
        b=QtfeOPs8lU7A4MWCnK/ia7h3V3xTRhJjtheGplBvdpw3PlGD+/FZ+fCgprsXNpY9kO
         X1v5xYziuRWs2ET/sbr9CB4OeG4/FUVKzL9P476PGvBDPiGv77E7TXZJe6GARkGKqznV
         ZqmMT7VxD9CDCG3YuSlFjpnRh/mRKx0J5zT727PyJns6JFjCZMSlg2fVaUXzVMZ3SvDq
         jnx034NH2EtFo6pOIjEsTg8o3dySIVSNqXZ8zxNZ8oQUNCjcA0B5Lq6fuWAtnfh1gm3x
         1zhjxM8zriQoUWJ5ZALlA3HfQ11EEAHV7u9FxZxgIJF5n1hCoTSsxdyxOquv30H385iA
         0yxw==
X-Gm-Message-State: AC+VfDzvXtDr4ZcxewmjLRcyRaflhVDBUHtj7R8lD03nfbrGm9tBzETV
        U6HlpQx1giB8HJ+WzJjDrYpOp0f2KvSE0mT5uBNDew==
X-Google-Smtp-Source: ACHHUZ6479Mks/GDP+tY+qUm+7yp4hId86uacq/V/ONUw9QvsO4o5I1ukz/srPmi/DRNcFbATqlVHRlYO9tWYiBf7s0=
X-Received: by 2002:a81:7d41:0:b0:567:6787:5c26 with SMTP id
 y62-20020a817d41000000b0056767875c26mr7204542ywc.19.1686162793381; Wed, 07
 Jun 2023 11:33:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230607171159.2019417-1-tharvey@gateworks.com>
 <20230607171159.2019417-2-tharvey@gateworks.com> <CAOMZO5ASwTJpH84SJX78k7MtZzwFc0bnbGqXsSFA6JFGq+0Emg@mail.gmail.com>
In-Reply-To: <CAOMZO5ASwTJpH84SJX78k7MtZzwFc0bnbGqXsSFA6JFGq+0Emg@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Wed, 7 Jun 2023 11:33:01 -0700
Message-ID: <CAJ+vNU1zCXxiwpkCuYTUocZR6JWAg7wFGR6eQEYwW=ZSd15CGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: freescale: Add imx8mp-venice-gw73xx-2x
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 10:16=E2=80=AFAM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Tim,
>
> On Wed, Jun 7, 2023 at 2:12=E2=80=AFPM Tim Harvey <tharvey@gateworks.com>=
 wrote:
>
> > +/* bluetooth HCI */
> > +&uart3 {
> > +       pinctrl-names =3D "default";
> > +       pinctrl-0 =3D <&pinctrl_uart3>, <&pinctrl_bten>;
> > +       cts-gpios =3D <&gpio5 8 GPIO_ACTIVE_LOW>;
> > +       rts-gpios =3D <&gpio5 9 GPIO_ACTIVE_LOW>;
> > +       uart-has-rtscts;
>
> 'uart-has-rtscts' means: use native RTS and CTS lines, but you are
> passing 'cts-gpios/rts-gpios',
> which contradicts that.
>
> I suggest you remove 'uart-has-rtscts'.

Fabio,

Yes - will remove for a v2

Thanks,

Tim
