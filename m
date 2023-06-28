Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E842A740C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235555AbjF1I6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233749AbjF1Icd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:32:33 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EEF469C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:24:58 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-54f75f85a17so3009397a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 01:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687940698; x=1690532698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z1rezx4FlsyiQzr31Fbv1Ua224W3A27Dsl53mJwBX+Q=;
        b=HNrPckaSsayG+1s6jwbaMdcUi1nHme8boVBGWPvSSaPE7Sz9Jib4gNiLLEkoZnf6qo
         LLrZ8mgX7X8ltSqvr65j0h+pe0O6rCJ9PAN6/VQU9M3UeJAGz8QUqSE6udqk32mUcKPt
         GFtHg2ak7mjiknlOe7Kv0ngDFEFNnPWso/8TE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687940698; x=1690532698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1rezx4FlsyiQzr31Fbv1Ua224W3A27Dsl53mJwBX+Q=;
        b=FBxudQY4njZOxw3yC0r0qgtqdEMlgWn1+SRJh/rNQPvZjM8km0d1/mrzx05XBYVJqf
         XTmT4LxSiLCM79eeyufKqqDAcaWHMHfBbOUGo/BX1u8oqE9QNt/VfdQJFEAL01uUjGl+
         jgiLpILdFQTqGKIbF+EURPt0Ja5ne4KeYPKre6CEva0uPe8LPBg8mzuLjRMaxUfwnlW+
         ybHMJ9JaUyZHbi90mpIlexXDjtMLS+bb9pDDQzFQyGlNG0BMqZCNLeLL62cLIRSgmgTW
         68p2Hb6imjqgaYne4pfpYdOJ+bYzrPxn9/Bse3Ux3ofbkYFqDRT34x0eqhfNwPvKLAmm
         85Zg==
X-Gm-Message-State: AC+VfDxEYHKlLQfkp4Umr8VlzVR/HIQo9QQ9wVM7iEgItOx/Wyyoi4Il
        Dz1x8RrpMqpY8yp2Vz57wtxznZTofCyxtyES5KI=
X-Google-Smtp-Source: ACHHUZ7KT4Fg1lTSocDCNNw/9wkPQe7TfmtvFw0+Rk4N8M5KR/3eIdl3R/uQabndibwMqJlKiV/VcA==
X-Received: by 2002:a6b:7218:0:b0:763:92eb:f81e with SMTP id n24-20020a6b7218000000b0076392ebf81emr35269464ioc.8.1687926313653;
        Tue, 27 Jun 2023 21:25:13 -0700 (PDT)
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com. [209.85.166.48])
        by smtp.gmail.com with ESMTPSA id i1-20020a02b681000000b0040bd3646d0dsm2576684jam.157.2023.06.27.21.25.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 21:25:12 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7836e80b303so84638239f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 21:25:12 -0700 (PDT)
X-Received: by 2002:a05:6602:22cd:b0:783:63f9:55b9 with SMTP id
 e13-20020a05660222cd00b0078363f955b9mr6463588ioe.16.1687926311837; Tue, 27
 Jun 2023 21:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230627063946.14935-1-shawn.sung@mediatek.com>
 <20230627063946.14935-14-shawn.sung@mediatek.com> <30fc2593-1d8e-286a-cc54-03ee250a37e7@baylibre.com>
In-Reply-To: <30fc2593-1d8e-286a-cc54-03ee250a37e7@baylibre.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Wed, 28 Jun 2023 12:24:35 +0800
X-Gmail-Original-Message-ID: <CAC=S1niScbOZrq6srx2DHGGtKfTV+L7rEf6o+77Y=XCz6GezwQ@mail.gmail.com>
Message-ID: <CAC=S1niScbOZrq6srx2DHGGtKfTV+L7rEf6o+77Y=XCz6GezwQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/14] drm/mediatek: Improve compatibility of display driver
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Hsiao Chien Sung <shawn.sung@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Jason-JH Lin <jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 9:48=E2=80=AFPM Alexandre Mergnat <amergnat@baylibr=
e.com> wrote:
>
snip
>
> The lines is > 80 columns.
>
> https://www.kernel.org/doc/html/latest/process/coding-style.html#breaking=
-long-lines-and-strings

The 80-column convention is preferred but I think this provides better
readability.
Also checkpatch.pl allows up to 100 columns today and the lines fit in.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Dbdc48fa11e46f

Regards,
Fei
