Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0E16FFB4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 22:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbjEKU3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 16:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238918AbjEKU3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 16:29:36 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA3B49DB;
        Thu, 11 May 2023 13:29:35 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1a69e101070so17786595ad.1;
        Thu, 11 May 2023 13:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683836975; x=1686428975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cIq+csdZEem8CM7fcgH+5/GZeWFKK87200SdyT17Gx0=;
        b=a1rVpvl/Pn1WWSGMfSMkv2Hxawdf9hhhC1VBT4W0Wmfssa+RjlcSH40UzxVVWmsrT1
         lBn6e6k4dacM/AxVcp4zm19aar1NjFJdGo7i4u6YmlUswm9opOVShy8A83p+VkxOuI82
         vqhbTgm83HDxusvCAP4BztOBQfU7+MX0SeoqshAFXkiIiFlqPl3XjFe7QFNhqR6ihnr8
         Z3NGiRtvIajZHyikPyWgB95PTJLWoGhiwPDCL5K1ncbP8bfu1/ry29cvK6suibd5MvN3
         RqeK/TAHJkzTdBZX5p3YBhktKyX3NA7ArHzAg2EQBKMZIPyniISKryUjeC42k11Ryz3I
         4yFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683836975; x=1686428975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cIq+csdZEem8CM7fcgH+5/GZeWFKK87200SdyT17Gx0=;
        b=Q+uLN7kel4MNJBd6PZYQAayE3JaavQIHXMIu7C6CBk5EbkiUe37WNu3tw7lE4YVgto
         Cl8qkvgpf+x/6xup1ifIx4qpP+B02+va8Q1IbXE3VD5Gt1FJP84sbYN9bZAdNijJuk7Q
         XXp6pGCFZL46wuXT3VUPrekKWeiNV7q+bTZq6utF/Z47gnY0ulPWvTvVFKiH5e5UCqCD
         Y1l8W/XfiPx0ZgJgYhD7UsLtsNLbz6BraiL4GXaBe+siGMjY9BEoot4O4Sck9V0E8gOM
         hMdMDLVkWspRowTo3miJLYNMpX8s30BXvb/Xr4FpBeMY2+aM+k1gsIggpYjL1rLrqdeb
         DZdA==
X-Gm-Message-State: AC+VfDxilFUnwTe2f35oIw2ZeL3BZQbqEFMMit+VNScUWQ24SnXKRNEn
        Pvm7uZV5rpqHHRhGWBzMgZRBf8LonbJtG8vdRh0=
X-Google-Smtp-Source: ACHHUZ7A30kuohXj6o1p5sDSupKTAGuECnl44YgqupI0Fs/UFelDMXdh5M6ZyFb4PBhk1DaShccX5HaGpS1QlDlSLvA=
X-Received: by 2002:a17:902:d4c4:b0:1ac:40f7:8b5a with SMTP id
 o4-20020a170902d4c400b001ac40f78b5amr26750525plg.3.1683836975198; Thu, 11 May
 2023 13:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230511135632.78344-1-bstruempfel@ultratronik.de>
In-Reply-To: <20230511135632.78344-1-bstruempfel@ultratronik.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 11 May 2023 17:29:23 -0300
Message-ID: <CAOMZO5B_a-oauJFsO8aXwSxu-3_=YiYbsHi-B=2MykkJ08fNtA@mail.gmail.com>
Subject: Re: [PATCH] spi: Add option to keep the MOSI line low, when it is idle.
To:     Boerge Struempfel <boerge.struempfel@gmail.com>
Cc:     bstruempfel@ultratronik.de, Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boerge,

On Thu, May 11, 2023 at 10:58=E2=80=AFAM Boerge Struempfel
<boerge.struempfel@gmail.com> wrote:
>
> By default, the imx spi controller uses a high mosi line, whenever it is
> idle. This may not be desired in all use cases. For example neopixel
> leds can get confused and flicker due to misinterpreting the idle state.
> Therefore, we introduce a new spi-mode bit, with which the idle behaviour
> can be overwritten on a per device basis.
...
> +       if (of_property_read_bool(nc, "spi-mosi-idle-low"))
> +               spi->mode |=3D SPI_MOSI_IDLE_LOW;

Yes, this is useful.

As this is a new property,  please send a patch that adds it to:
Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml

Thanks
