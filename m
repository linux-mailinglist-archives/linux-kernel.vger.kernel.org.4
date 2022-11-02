Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C30A616B11
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiKBRky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiKBRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:40:38 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924CDE0B8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 10:40:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id o4so25622885wrq.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 10:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3AmOaNKj9n4rah80wv2WlbMnKprd9ZeBs5crd0e6tQc=;
        b=W94sUZoG7KhzjFn386rOmrDaRK7nI1ygMHwpBtMGc4KPQzubcQl8TjzyPv9puWoZk7
         D+jeb3N3GTTIkMPPYqLOeJUkkaa+lX6jrVAC0DhMV1R5IOmemT2O/73f8T3qzO6TBse1
         AYvXBbbQDgG16j3/5CnsutUNFnkHSKpxvvCgxZs0RmyirGI7lSqg7AH0RGF+051dOylr
         Xjl5pfG8AHjhE/vkVjJgvJT3cLiASyFnqyMP4IE0JqkL7Me6u0Vk2jQ2MhwJPMassHOk
         6OxVvTig4hdIVmadcgUcNqmzLQcb5COFlrByDzDHuDVjNVLfR1AcsvpMV1n93RtFgFHW
         Rzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3AmOaNKj9n4rah80wv2WlbMnKprd9ZeBs5crd0e6tQc=;
        b=gGEbbumRn8JldEbI/gTtSLA0YKLGX1hfdr8VQmXzmHqLRkn6l8ZYVtQdYNsfDPK0lh
         8nDiAvMNQAqCTGUEFrn2vx79xm9Py1zwX1APZv7l1Hbd9c1px47C7yiIcAmbmI/aOGNP
         Lzq1dggvcFre5zo3GWp9m+aX5tFI6kaHaPAYSkl71gb+QN3piyTODg8gX8D+Qq4NoTss
         QiNax7IK1bT64i7ws52t6WbZW4kzJZe9srufMykwjU8SHz3M8tAHo9VeB2HgEn/bICiv
         YUgVajCbux/mLDTJxlcmLhIG11BX57YnYC24BFsnQ5iXSsoSjH+vwI2XdYD/t/HfGUYn
         J72A==
X-Gm-Message-State: ACrzQf2FdzQVGm3bHw3TFraFdjSXfppLNAWY4tQa0H2taJxj8oVrQbMI
        i/Tuc1uV3p5OEjY8LZa8iZRRpQIA+DX0IVxjtIN96A==
X-Google-Smtp-Source: AMsMyM6g1HDpFNiQWEW4SG59uf5BYHt/jrEe19S9vIuvW6m1cOpkYBN+wFZaJSmqSvb/uCn4JesL+kPgDErPCt/rFqk=
X-Received: by 2002:adf:e241:0:b0:238:3c64:decc with SMTP id
 bl1-20020adfe241000000b002383c64deccmr364071wrb.698.1667410834538; Wed, 02
 Nov 2022 10:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20221102111410.38737-1-peng.fan@oss.nxp.com>
In-Reply-To: <20221102111410.38737-1-peng.fan@oss.nxp.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 2 Nov 2022 11:40:23 -0600
Message-ID: <CANLsYky+FPNi82kDwgJBzdoxS5=SBXBqiRRFNCvt4ihUpJS+9w@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: imx_rproc: correct i.MX93 DRAM mapping
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     andersson@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2022 at 05:12, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> According to updated reference mannual, the M33 DRAM view of
> 0x[C,D]0000000 maps to A55 0xC0000000, so correct it.
>
> Fixes: 9222fabf0e39 ("remoteproc: imx_rproc: Support i.MX93")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
> index 2c471e46f4ca..9fc978e0393c 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -134,8 +134,8 @@ static const struct imx_rproc_att imx_rproc_att_imx93[] = {
>         { 0x80000000, 0x80000000, 0x10000000, 0 },
>         { 0x90000000, 0x80000000, 0x10000000, 0 },
>
> -       { 0xC0000000, 0xa0000000, 0x10000000, 0 },
> -       { 0xD0000000, 0xa0000000, 0x10000000, 0 },
> +       { 0xC0000000, 0xC0000000, 0x10000000, 0 },
> +       { 0xD0000000, 0xC0000000, 0x10000000, 0 },

But how did this work before?  Were some SoC released with the old mapping?

>  };
>
>  static const struct imx_rproc_att imx_rproc_att_imx8qm[] = {
> --
> 2.37.1
>
