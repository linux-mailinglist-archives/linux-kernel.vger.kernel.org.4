Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE657325A4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 05:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241673AbjFPDIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 23:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjFPDIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 23:08:40 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEF62D40
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:08:39 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-78676ca8435so1060631241.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 20:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686884918; x=1689476918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJrTLod3qq+bnrpFVtyiXrm6GhPtv1R+1GYPqh4OiIk=;
        b=Vz3fYT8uYGp/hNgMCPra7gF03IJMxHTvjK2anSwVV5xo7W56I77Zz0RIkn1NddfV0G
         3mv8TTYuJCVZa55q2jN57gg5h5jziec4LrwiQTqLh0AHUVo2JpvjP1etY/DZ7jMz/dea
         cONJI7sVwyS7OjiSVJhQvEbQlxpUZYdx8z7qA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686884918; x=1689476918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJrTLod3qq+bnrpFVtyiXrm6GhPtv1R+1GYPqh4OiIk=;
        b=ge9oO8hWEa0wLdMg2ca1xmPR1KD43f00DBgJoXrnnxjTr7lE3LlA09Dk0TSpEWO779
         xiauGJIS5KBBiRCKEJQUPLjewxYxOkBC7m+gbrMVyN/A2G0GtzDqC/aqKuMe6TrgVP9m
         BZ/lvow68AktzHMNJblBlLIny9tliDTfLrIKRs6JWYM1nIKpucK3YHWq2b5WdcPQs07m
         QnvRsWd/h02lEiWOwnERnoSOLxOS834Ur6nwS0YKZS/P5Dys/FkkJDT3LDRPaTmLXR5z
         lheXDetDlbFJzyh4FSG4dc7UN3h4wmcdfXJMuxxHcvP4uSjvaSw9pcdIsMOflZaR8YrS
         fHxg==
X-Gm-Message-State: AC+VfDxKk+Vkg1Lw8KNK/Rx6kpnIQ/eswlxf1traOz8nbrZhWdArRoUs
        XC8hrkwXs4cEpelKvnldCm2ZNAFg26XRXAx4VOcGRg==
X-Google-Smtp-Source: ACHHUZ4TgeTe/0Pyvf4eaD0+Nxq/kvS8KgwFWXt1dBOkYhgFCqsCJoOwRLozdRCin/hWZ94S95bTZacH0ku+oOFt+iI=
X-Received: by 2002:a1f:c110:0:b0:464:7d75:fa58 with SMTP id
 r16-20020a1fc110000000b004647d75fa58mr302529vkf.0.1686884918653; Thu, 15 Jun
 2023 20:08:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230615122051.546985-1-angelogioacchino.delregno@collabora.com> <20230615122051.546985-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230615122051.546985-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 16 Jun 2023 11:08:27 +0800
Message-ID: <CAGXv+5Hh8=LGNfOUakfYwxw=pv4MxRBXgz=mJjPXte+WtvnGGA@mail.gmail.com>
Subject: Re: [PATCH 2/3] clk: mediatek: clk-mt8173-apmixedsys: Fix return
 value for of_iomap() error
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, matthias.bgg@gmail.com,
        u.kleine-koenig@pengutronix.de, msp@baylibre.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
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

On Thu, Jun 15, 2023 at 8:21=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The of_iomap() function returns NULL in case of error so usage of
> PTR_ERR() is wrong!
> Change that to return -ENOMEM in case of failure.
>
> Fixes: 41138fbf876c ("clk: mediatek: mt8173: Migrate to platform driver a=
nd common probe")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
