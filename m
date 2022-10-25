Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24B0660D090
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiJYP2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233234AbiJYP20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:28:26 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996EA43328;
        Tue, 25 Oct 2022 08:28:25 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id g12so8917530wrs.10;
        Tue, 25 Oct 2022 08:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7r/lxb9syFi5fszVxey13EVYUFPTHODfMEEaPAN/V+Y=;
        b=V381NSJCc2t+KGfhMm8mz4zvLvUd1ECWt2Vg5y1ifx5E4L3IBAiDSRqQGj3Af6/log
         dvzcHCrt8eR0BcP3QJLig4KAwW+Qx9duhgXdGEClye3/s8l6nOkhL95NQo3hNzmlo1CF
         ggdhZTBfabsD4bUcZdOCI2yIp3nVwMdndztOLdI4fAxy0yO2c3Ww4zMT/QDpPLd7Q33R
         5HG3fP2syiJpc1A/ikzob+C3y9qDmtsngf4hSh3k/BB9kwBXCRX4GarXRgAGpGXHkRAY
         7Yhd6Haq2Mcr8Eshwk+u8bTf+FqR3mfsSokRK4pbZuZtGluGnEtq0ACluHE7de+QB13k
         Tk6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7r/lxb9syFi5fszVxey13EVYUFPTHODfMEEaPAN/V+Y=;
        b=Z5dJOwWZyGTogTb+CjemGdoPwv6tQXpJshtpLtLt/XAzOCZljhWTTf4lAax5q5MJ85
         qShQdWuU8Fc1Xnf3eIyL6jNMDrpO79me5wzbI7OH8R7goGJB1IcDY0uCDvg2a05h0QKk
         NqUNEkhlKAvxfpAN93Q4X89n3SCqQNsZCu9qn4O1Ls2npQSDG0F+MVvx16/aahhqWH+H
         c6rZaYgh1d9PbSa17Fn9p/d2SSrqQbfSyODSLmDQd5KbNtDXjjbr9KSvmkgONQq1YBye
         vSQtg6pq4CYstmE6s4abwHjNydSg+2SZfpMOVdr4WfbqwhlqkrndAcb5fbDqmvbHSQfE
         lKNA==
X-Gm-Message-State: ACrzQf1zTm+fCUnjvzxBf66EmcDnAIZtYObpnsrX00R0iRl2qHQoarl4
        8+TDrM7/OAC5vbtjI43C+A4=
X-Google-Smtp-Source: AMsMyM5K0ZKfrU9AcZgM/WGkAuYCPoBp+s8EysvSeUPepfjiMjsmTSvUp3+EbonMe8RJZrf0AZOixg==
X-Received: by 2002:a5d:52d0:0:b0:21e:4923:fa09 with SMTP id r16-20020a5d52d0000000b0021e4923fa09mr26317288wrv.244.1666711704051;
        Tue, 25 Oct 2022 08:28:24 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id a2-20020a056000050200b0023662245d3csm2848766wrf.95.2022.10.25.08.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 08:28:23 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, mripard@kernel.org,
        mchehab@kernel.org, gregkh@linuxfoundation.org, wens@csie.org,
        samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/11] media: cedrus: Add helper for checking capabilities
Date:   Tue, 25 Oct 2022 17:28:22 +0200
Message-ID: <8131177.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <Y1f/U8NxyJo/pMAH@aptenodytes>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com> <13124586.uLZWGnKmhe@jernej-laptop> <Y1f/U8NxyJo/pMAH@aptenodytes>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne torek, 25. oktober 2022 ob 17:22:59 CEST je Paul Kocialkowski napisal(a=
):
> Hi Jernej,
>=20
> On Tue 25 Oct 22, 17:17, Jernej =C5=A0krabec wrote:
> > Dne torek, 25. oktober 2022 ob 08:30:28 CEST je Dan Carpenter napisal(a=
):
> > > On Mon, Oct 24, 2022 at 10:15:08PM +0200, Jernej Skrabec wrote:
> > > > There is several different Cedrus cores with varying capabilities, =
so
> > > > some operations like listing formats depends on checks if feature is
> > > > supported or not.
> > > >=20
> > > > Currently check for capabilities is only in format enumeration help=
er,
> > > > but it will be used also elsewhere later. Let's convert this check =
to
> > > > helper and while at it, also simplify it. There is no need to check=
 if
> > > > capability mask is zero, condition will still work properly.
> > >=20
> > > Sure.  That's true.  Out of curiousity, can
> > > cedrus_formats[i].capabilities
> > > be zero?  Because it feels like that's what should be checked.
> >=20
> > Yes, it can be. It's the case for V4L2_PIX_FMT_NV12_32L32. All variants
> > supports it, so there is no special capability needed in order to be
> > listed. What would you check in such case? Condition still works for th=
is
> > case.
> I think the problem is that (bits & 0) =3D=3D 0 is always true.
> So if the input caps are 0, we need to make sure to return false.

No. If format (or any other) capabilities are 0, means they are supported b=
y=20
all variants and it's expected from cedrus_is_capable() to return true.

Regards,
Jernej


