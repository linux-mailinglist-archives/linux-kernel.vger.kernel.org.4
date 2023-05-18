Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E48707D35
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 11:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjERJr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 05:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229920AbjERJry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 05:47:54 -0400
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 537CA10DC
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:47:53 -0700 (PDT)
Received: by mail-vs1-xe36.google.com with SMTP id ada2fe7eead31-435fff402d0so1137420137.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 02:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684403272; x=1686995272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wg6shwNIwwRwkhfOkTgCr9OKJegA1DzRyg52qKzAeE=;
        b=S2WWolW1jn+wgLVUhlxoiii/6QVTjUizpIsXpMURcKDqGpWBHB5V40WX32jxC4o+Vz
         xdIyCaA+GXrMOZHI5+BRfjptlc5DzEucEh9wkYBO6sA+QwTn8hWa5yFIBKc4XzbY26Bc
         Yzn/lqaxlJKCSbQrbINpJsd9B9POYPLTyUWzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684403272; x=1686995272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wg6shwNIwwRwkhfOkTgCr9OKJegA1DzRyg52qKzAeE=;
        b=IViuf1pNCU2JyOgz3hqNMIDhzFoJegjufPzHLVUB4VP72fuWnisxrtxIGD3wnkUZEk
         2Wi4VPVkWkMRD2wTP6GgTnpPh9ZoIkQChpSR30N+ZUlZWMh1v1/2cnbRRs2HFPi4L36o
         rqaDuftcZz7v/4/NSeXva0KyRd04op1ztruLzWC9VIyU29NNEsb4mPCKi9xE23+OCJe4
         ow4r52HfmkbMkm5aKrcuhFtwtkGULtuDfuE3QXiIgfJb1EwJwWO+VkKyds3h7QrG2Aqo
         TABxvjsEC866W8rVCStC6qc22B7b5ND8BmpkaPpIpsPex7GymRY8kukhWRej8vriAPFm
         3YbA==
X-Gm-Message-State: AC+VfDxsij9mR8rqBE7gxg4mLYjVVrh2OlLmVsBA2YByFBg5xEmfqsu2
        WFfzu7t1NMT+3sRaPOuUWS07AjlCqKIVTCP3zCUjfQ==
X-Google-Smtp-Source: ACHHUZ60eoWoZUBqR1HIJE8nKIEe2ryuS5bJ8rKbXaBjLvR6HbKInnu2RTlWZrWSvYRwdHCvElTH6deS1M9M1Yz/l0M=
X-Received: by 2002:a67:fe43:0:b0:437:d900:6603 with SMTP id
 m3-20020a67fe43000000b00437d9006603mr281259vsr.24.1684403272445; Thu, 18 May
 2023 02:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230518040646.8730-1-sen.chu@mediatek.com> <b9531c67-ab85-5ba4-6d86-9fc83974df4b@collabora.com>
In-Reply-To: <b9531c67-ab85-5ba4-6d86-9fc83974df4b@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 18 May 2023 17:47:41 +0800
Message-ID: <CAGXv+5H+peO6fhuE9jj2t6DS5EPRyg8m=zc3ACDGdvm8Bes+RA@mail.gmail.com>
Subject: Re: [PATCH v2] regulator: mt6359: add read check for PMIC MT6359
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Sen Chu <sen.chu@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 5:32=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 18/05/23 06:06, Sen Chu ha scritto:
> > Add hardware version read check for PMIC MT6359
> >
> > Signed-off-by: Sen Chu <sen.chu@mediatek.com>
>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>

No fixes tag?
