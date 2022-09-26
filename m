Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1325EB07C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:49:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiIZStu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiIZStp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:49:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94834C62;
        Mon, 26 Sep 2022 11:49:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dv25so16027468ejb.12;
        Mon, 26 Sep 2022 11:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4NYxgBCy61KE2DpMIQzG7XwqLg0XUKMJLHwDukFM71g=;
        b=WRwDVDskPoJtCmLDaGKj7MajqWr/IC+X+ehCo2GdM38soGAE92/3+tUaGUPsUBK16U
         f/mCAYIaG7+He0ZRR7aEvXC9FvENLwQiKPoS7BubKcqG1YN5xES9HRcT6nfKe8HPZUKN
         kJLXb8b2PNo4HWyZbMTM/JPl19rVGd9efFEY69a30Ot09fHCgATGfS+4F97gweIRHWTN
         TbR/74o1TBmdbufRp5w/V0qwcRRrZPX1SVqcdMH3JyKXjM13nMMEvFHZH7HJVJ9khIvN
         BaZhl75eWiwELstKjd3HA4kd8aBzOenCOjtr7lkFLtSAjVfcR0x8t51JwCMKdW+8Wnzh
         R2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4NYxgBCy61KE2DpMIQzG7XwqLg0XUKMJLHwDukFM71g=;
        b=HYhR+dlSiUSJfEFK4JQb+mVo3OeTz7y7ffdOnUzf4N/678XO3j+qvroY4VeQy4b8oV
         bqtHaUNJnGDbX17PvaWramNe6QW4OfqhalO+ZElqh7NGB6nCGHNKkuiNm0Yh9FTfAZRu
         11kFYAw0prsLuVxyOFvQfGiI9TPThmb/z5T824RTrKWmV2iF4fWkdUqB4w2RBHWRNh1n
         aRxG67q34Kbh8lxbM49ZuxOFFaRcMQ262H+2YwVzeLctcPsXOpeBNSBy4VNvbk2VuFSI
         0BwgjMyOkKBik2J/RisMZs/GWMBWvhcQraBz4ldjuMX8ApRtOXEihQurmOH4R+o5z/rD
         TY+A==
X-Gm-Message-State: ACrzQf2tJCkN1vhcDiP7hypoNW/W9OsdI/nmrbAE4GWBEOOFIXMYZHuv
        HhRu3Mmjjsgxxih4wpTpcFzgP1jQhGnQfKVj1Rw=
X-Google-Smtp-Source: AMsMyM6HQ2MlV4QhnFMeH0w5fCQRLjmZlL/DQ91O7L+18zeFe4GsMZudusU9gtKm3YA27hZExgR9L71GygrRHwW06vQ=
X-Received: by 2002:a17:906:8a6b:b0:780:ab37:b63 with SMTP id
 hy11-20020a1709068a6b00b00780ab370b63mr19126110ejc.365.1664218182085; Mon, 26
 Sep 2022 11:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220923063533.239315-1-ye.xingchen@zte.com.cn> <YzGo2o3bVLnOiQJr@maple.lan>
In-Reply-To: <YzGo2o3bVLnOiQJr@maple.lan>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Mon, 26 Sep 2022 11:49:30 -0700
Message-ID: <CAPOBaE7sMPR9YgfLV2Y12E=jxO72PhOzJ=G=tdTkN-Af1CMuRA@mail.gmail.com>
Subject: Re: [PATCH linux-next] backlight: lp8788: use sysfs_emit() to instead
 of scnprintf()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     cgel.zte@gmail.com, lee@kernel.org, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ye xingchen <ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 Daniel Thompson <daniel.thompson@linaro.org> wrote:
>
> On Fri, Sep 23, 2022 at 06:35:33AM +0000, cgel.zte@gmail.com wrote:
> > From: ye xingchen <ye.xingchen@zte.com.cn>
> >
> > Replace the open-code with sysfs_emit() to simplify the code.
> >
> > Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
> > ---
> >  drivers/video/backlight/lp8788_bl.c | 2 +-
>
> This one has the subject right and is a good change. However I'd still
> prefer it as a single patchset that fixes *all* instances of this code
> pattern.

Yes, I agree with Daniel's opinion.

Xingchen,
Please make a "Single" patch for including "ALL" fixes
for this pattern in the 'drivers/video/backlight' directory.
Thank you.

Best regards,
Jingoo Han

>
>
> Daniel.
