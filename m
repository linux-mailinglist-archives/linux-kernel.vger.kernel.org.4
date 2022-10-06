Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF4E5F6149
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 08:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJFG6r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 02:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJFG6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:58:45 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C94F474D6;
        Wed,  5 Oct 2022 23:58:44 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id n186so1110544vsc.9;
        Wed, 05 Oct 2022 23:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=TJqlP80Odus2D0JVNeZG0GyW2KovItTk2V4asNZineM=;
        b=JzukLpQzk/5NkTTS3tT90HIOPDFNdQ481hvyL8cOoL2jLwbZKig/fWrd66WVqNyaDr
         diEKy3Qqh62ArECH6cBfodk4eUGkip68jjat7WmX81O4Ws8vpk+acP7eN8DqBffGMHL3
         Q19Qvgal+nWLwZPTPPg327m38+k7oiY5RudrZ1z7OzvY8n+niPzLulGY4lUMn75Sb21b
         LkRJ/Up8442dp1VamFO/jfMvXyK/RO+slFdb13c7WXjGPmmruBj7KBEL6upbx/YmK2iT
         +LWsNdBlgXNa4SQey9mLr0TY1dBRt5zEt07BX8VCCSMaFe4nR9ETXME1BZFiRvHubnz6
         wWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TJqlP80Odus2D0JVNeZG0GyW2KovItTk2V4asNZineM=;
        b=JWyC969kBVBtqWiTpTnMG2kO+sji8pW9VmAiV+qnsObyKjbAdSZ7vvBbQXFG4Ujs3Y
         jDXJFIbzfZUe9K37XrLX84PFT9Sr7WBn52hz8X5VcARvZA0RTfVoat3tV+Ks1Gdagdv2
         g3XPQ8h32YaApP+h1B03musia7o3sZ/9BxcCvEgDi00ka3pJ0lw4BHiR4NwGjF7Mp2RZ
         vdfsUaGft8kw0K9gSQli2MXgmO+9GYHi1MmQ8eG9uQW9cyFq9ycePeXUSIcv6tBSCyIz
         ET7zHFlEu9au8a9LqHQaWp5kdXXd5mtDl1mIP5KLTIAsJrToCONL8C+BA4IA86Gh4pYT
         IqGw==
X-Gm-Message-State: ACrzQf1bDreWvIkd/4yy/+ec9qLiCU15wuaEY3njdxFafSI3CTs15+7D
        a/GgjJXirg5nKJH2PWlw3Lvp3blwZoevsmLbczI=
X-Google-Smtp-Source: AMsMyM4onYZAMxhs6EoLcrmsenTeXbLk2iEct1qKwKXx/sTDhTwMSrB2/g8Z5gfGSY34TwOlBc6/xKUgHgQACniRNoE=
X-Received: by 2002:a67:c48b:0:b0:3a6:7c10:7422 with SMTP id
 d11-20020a67c48b000000b003a67c107422mr1722542vsk.4.1665039523521; Wed, 05 Oct
 2022 23:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221005085305.42075-1-romain.perier@gmail.com>
 <20221005085305.42075-2-romain.perier@gmail.com> <20221005230214.1A24CC433C1@smtp.kernel.org>
In-Reply-To: <20221005230214.1A24CC433C1@smtp.kernel.org>
From:   Romain Perier <romain.perier@gmail.com>
Date:   Thu, 6 Oct 2022 08:58:32 +0200
Message-ID: <CABgxDo+v1PHbgFwyyTFkT2WtxBUBO+Ygi9ncS0oNQzzxHAO7Ew@mail.gmail.com>
Subject: Re: [PATCH RESEND v6 1/1] clk: mstar: msc313 cpupll clk driver
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Daniel Palmer <daniel@0x0f.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 6 oct. 2022 =C3=A0 01:02, Stephen Boyd <sboyd@kernel.org> a =C3=A9c=
rit :
>
> Quoting Romain Perier (2022-10-05 01:53:05)
> > From: Daniel Palmer <daniel@0x0f.com>
> >
> > Add a driver for the CPU pll/ARM pll/MIPS pll that is present
> > in MStar SoCs.
> >
> > Currently there is no documentation for this block so it's possible
> > this driver isn't entirely correct.
> >
> > Only tested on the version of this IP in the MStar/SigmaStar
> > ARMv7 SoCs.
> >
> > Signed-off-by: Daniel Palmer <daniel@0x0f.com>
> > Co-developed-by: Willy Tarreau <w@1wt.eu>
> > Signed-off-by: Willy Tarreau <w@1wt.eu>
>
> Missing Signed-off-by Romain.

Signed-off-by: Romain Perier <romain.perier@gmail.com>


It is okay, like this ?

Cheers,
Romain
