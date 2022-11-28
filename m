Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5413A63AA1F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiK1Nxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiK1Nxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:53:37 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A657FB1B;
        Mon, 28 Nov 2022 05:53:36 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x2so15540282edd.2;
        Mon, 28 Nov 2022 05:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0nL99pZ4RJUpEgtFxI8B3xt54A7EJNAJ95lZjHVoXWY=;
        b=IlllHOn1t+t9xZag64u0/1YYZn03G5hHGRpVDnEm1W1mmFCuy6Wuze9IQLww1vBDaW
         EKIqfhWuQLIRMbRDFsylpDVxC2YjuAliZin1UO1p7/YBn1+ewkq7OksjK5eRXhGA37Kz
         4kkzONCWruYEICysU69EOTdEeQxpa/ExoAoqtnw+upL/LGcXH0nAV738oH01aaGRvqOy
         q3nW20LVbRhLcLDZHShp8+fVwOevcTF3sHTEV2Wg768stiKWQAL0WTEQ3KQbzqJ5uJkv
         lf3ZTg1xSWGPaGZQEQNGbrw45ImJWS187drEtSfcYFe43qSZ6YYSnEOJJLJkBsrtYG2g
         Aw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0nL99pZ4RJUpEgtFxI8B3xt54A7EJNAJ95lZjHVoXWY=;
        b=fBFA6xJ7r0RoQIOSuBP0DA8kIQbE6zlVCzokdx+z5IE/cvLTId4D3DZ8aZH+cP75Ho
         Kd7PIi9MB9ELbllN3cQIkfajDeMUo2LjaoLkfsYuufP4cjJMjGnJ/DmkNmmMGofd+v7/
         f5oKWV7h/kzKZA03tCdD6PrlJzQw/PQ9R73+mHzZ5wiWFvrs5QzghKDtcjtqHq0C8Rzg
         O+rdHNnUrJNq5peQQF48cOD0hScJ42chqfCETDzNDPzD2B59rx4GA4+LOtETSrCAMkYK
         r87scm/XZSdJXKrGSLH7CoIZYs+vxNGCcuJk6JWRy+zahJ/PcCTarWbSpn4iSdFvux5F
         66dw==
X-Gm-Message-State: ANoB5pmttUcqxs6OHtZjWO5s+rsqwu3ysBX5je9gJE05OBBUoLBQcIob
        6jayPMb+teYO7oncfBVrjD7AM3i/vA5G7YPq9nM=
X-Google-Smtp-Source: AA0mqf6MsS6kpVG7psn8SeuxEJiQ96AvHYPpr1XaJsJLgR8FGLibjVbju+H0gGWJSdpRxacxXeEN9ES49KS+b44uNRM=
X-Received: by 2002:a05:6402:1f87:b0:468:7df:c38c with SMTP id
 c7-20020a0564021f8700b0046807dfc38cmr46515406edc.150.1669643615154; Mon, 28
 Nov 2022 05:53:35 -0800 (PST)
MIME-Version: 1.0
References: <20221031232202.131945-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221031232202.131945-7-prabhakar.mahadev-lad.rj@bp.renesas.com> <738a2461-7a6a-286b-89e8-d46a26ec6506@xs4all.nl>
In-Reply-To: <738a2461-7a6a-286b-89e8-d46a26ec6506@xs4all.nl>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 28 Nov 2022 13:53:08 +0000
Message-ID: <CA+V-a8smCQ0+Gz7Fo-P0H6j_4OmEqS5dLOVhWWQz8hPKHbazpA@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] media: i2c: ov5645: Use runtime PM
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Hi Hans,

On Mon, Nov 28, 2022 at 1:49 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
<snip>
> > +exit:
> > +     ov5645_set_power_off(dev);
> >       return ret;
>
> smatch gives this warning:
>
> drivers/media/i2c/ov5645.c:687 ov5645_set_power_on() warn: 'ov5645->xclk' from clk_prepare_enable() not released on lines: 687.
>
> Can you take a look?
>
Sure I'll have a look at it.

Cheers,
Prabhakar
