Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB0060E01E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiJZMAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiJZL75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:59:57 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C966013DC6;
        Wed, 26 Oct 2022 04:59:55 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t15so6348214edd.4;
        Wed, 26 Oct 2022 04:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2Dbff/IBDtjjnRXywEoj6LRjme/A3fCnG3Sdfp4DfP4=;
        b=faksOE5hQ3vCGif6dOF5DkpAAnJTHvrwrTfGzKNlmxD9OGF9wWCjPeik8O/jhghQDd
         mpR40Sq1zOrb1d/SFO/YolN26bTUHI5pNApTvLNJu+82Q0jPhQjZ787qkm8g3/6BR2IK
         uqa+GIS5ai6cQYidnvHs8Edb3/qrnT69BOEgTZqFoiztlxrIfYmfGFxKQStAVS0h9wUO
         JaZlRgq13LKM3izzA25phlsneJdoUIo6sPWFQjv5WjWaINzWQ95ORbXM/7hr1+m2Axf1
         G95GQ90bXFKwmcGPwUbCguXn6ZUzENUNVL43fmL+zU5umla+IGgHY9mjiBRxUnlLuLz0
         +QdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Dbff/IBDtjjnRXywEoj6LRjme/A3fCnG3Sdfp4DfP4=;
        b=Uj6Wkx+Nhip86poZwuHe/tkPscRuuHeajlCaN3GFehBGvlLWD8XxBMmzMknB2tKIsh
         h7JtJRYmqfWP/kds1bbCXrkaMlQ9/3SCpHIyBRUoUdsvDrPr+fmTb0vo7+L078fJv/3K
         a4g9G6kFFEUPuFjXewikKD4H4+NdcGt3kQyEoMHWxiE+7zxBklG6pyhXDbcYecAGbGXk
         Fdn33OmASCunC/0frTv2cCpFoLqKgmOHFFUgKRGZxNJbO5iWJhNZ9lV0gWII4Gdl43jm
         hZn0bjFUZgJ37OFfztBVdufZJF54VtuMcTa8MNVewbw9sZYVLaMpngBo13CGPPsuZMK2
         2nzw==
X-Gm-Message-State: ACrzQf04Tbi8jGlDKtJHxRjlL4U43ynFnWv2YPV/3yeg4V8t/5yO09sK
        R6c8IFBeN0NURCNCYX1toWKxUC5OVRzxWv0bhVw=
X-Google-Smtp-Source: AMsMyM5Tp8QwQQhN7fOAlLWSg2jSmcNamZNqvKXoR7rgN58leG2RUPDwRlkuSaVsyxZ7iF3NbdI8nBB/gG7oIOLJZoc=
X-Received: by 2002:a05:6402:40cd:b0:462:7b99:d40d with SMTP id
 z13-20020a05640240cd00b004627b99d40dmr277928edb.319.1666785594409; Wed, 26
 Oct 2022 04:59:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221014183459.181567-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221014183459.181567-6-prabhakar.mahadev-lad.rj@bp.renesas.com> <Y0pSnKREW0pjtPYI@pendragon.ideasonboard.com>
In-Reply-To: <Y0pSnKREW0pjtPYI@pendragon.ideasonboard.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 26 Oct 2022 12:59:28 +0100
Message-ID: <CA+V-a8tzFqvW+9dTpowAzJdhfe4WtwnY9Y+KddqUC6oR5uBxjA@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] media: i2c: ov5645: Call ov5645_entity_init_cfg()
 before registering the subdev
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Jacopo Mondi <jacopo@jmondi.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
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

Hi Laurent,

Thank you for the review.

On Sat, Oct 15, 2022 at 7:26 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Prabhakar,
>
> Thank you for the patch.
>
> On Fri, Oct 14, 2022 at 07:34:59PM +0100, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Make sure we call ov5645_entity_init_cfg() before registering the subdev
> > to make sure default formats are set up.
> >
> > Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> If you have a few spare cycles, it would be even better to convert the
> driver to the subdev active state API :-) You could then drop this call
> entirely.
>
For v3 I did think of it, but it looks like I'll need to spend more
time on the subdev state for this driver (as this driver does cropping
which makes use of TRY/ACTIVE). So for v3 I'll keep this patch as and
will work on the subdev state switch in parallel and post when
complete. (Its just I dont want to miss the v6.2 window for RZ/G2L CRU
driver ;-))

Cheers,
Prabhakar
