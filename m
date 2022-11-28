Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DEC63A9FF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbiK1NtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiK1NtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:49:18 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5B61E5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:49:16 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e189so7584524iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5WWumrqiTDYq5uOZBAPJFRzs6vcelTvSCtUZimwYyKk=;
        b=JaLWK4hY8LgNiPiKh9CCSm+56V2c4Rm7Q59ef1OdxUY5vA0ZNzGYJh8zBSh2Cg6W64
         eEKR+qLTv/MU1cSh80KUT8bP9gfduZ5u5xWY/RRkgkx433VnWoMLQFoAUQzLsnHsYWJW
         YGsPYd+Hr+yIoAkDDGPvqs9pyqr1YJYebXF1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WWumrqiTDYq5uOZBAPJFRzs6vcelTvSCtUZimwYyKk=;
        b=68mGE/r0APWvpTMFrhdNa8NK19+z2W3A+xMsEPcTC6g7ydwI3KKpcfiXAO2vlgGZHo
         wIHxPRYxOiDs7W1VuKC4ipzmx3MntYl1zVqpLQpNorM1e5NeNoGZfJN/HRW2aUa+RtkX
         g1EzuKYCVMLByRkUDdItMYX6y3x8oo7uXC7OE8ZviJrqJHJdYTf3epknyDXIHupgwH/l
         Qh+ky+NX3qp9tpyqU+lNvMnRi7HajPzNFSy9fMRu1CyDeEme8fmllfnQeTUjofi/XJnn
         6+fZoPYSkZOC1a/8RrrixLnN8Qy8sgSdtbBPKy21Nq5pwikkxNgkqtRPP4JoYLiPXSdv
         p2LA==
X-Gm-Message-State: ANoB5pk7Hite2cux1hJ3BEXgQQEK8D0ytTEk9OBKUvWoNYrrzszCqF6a
        XBUWOw6gNfOCDlVXfg9tZ4PT071rUZgyfZr1
X-Google-Smtp-Source: AA0mqf7hYXLiXkUQ/0/WosMgqvS1Pj1RHQdXb3IX/E7/tVcSfZUv/lX7pQ5EPOydZoTPHWTw09bmBw==
X-Received: by 2002:a6b:6d0d:0:b0:6c4:ad4d:b23a with SMTP id a13-20020a6b6d0d000000b006c4ad4db23amr13315493iod.2.1669643355600;
        Mon, 28 Nov 2022 05:49:15 -0800 (PST)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com. [209.85.166.45])
        by smtp.gmail.com with ESMTPSA id v4-20020a92ab04000000b00302a7165d9bsm3796626ilh.53.2022.11.28.05.49.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 05:49:14 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id g26so6916605iob.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:49:13 -0800 (PST)
X-Received: by 2002:a02:ccfb:0:b0:373:9d0a:33a0 with SMTP id
 l27-20020a02ccfb000000b003739d0a33a0mr1950090jaq.286.1669643353517; Mon, 28
 Nov 2022 05:49:13 -0800 (PST)
MIME-Version: 1.0
References: <20221128-mt8173-afe-v1-0-70728221628f@chromium.org>
 <a214fe55-fb5e-04b8-348b-895902470b18@collabora.com> <Y4S43XjRyrdm4Tha@sirena.org.uk>
In-Reply-To: <Y4S43XjRyrdm4Tha@sirena.org.uk>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Mon, 28 Nov 2022 14:49:02 +0100
X-Gmail-Original-Message-ID: <CANiDSCv8Ai2W10cOjBgthshi8XPCDoCvGxXfoL-47eFrRjrseg@mail.gmail.com>
Message-ID: <CANiDSCv8Ai2W10cOjBgthshi8XPCDoCvGxXfoL-47eFrRjrseg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: mediatek: mt8173: Enable IRQ when pdata is ready
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Mon, 28 Nov 2022 at 14:34, Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Nov 28, 2022 at 02:17:53PM +0100, AngeloGioacchino Del Regno wrote:
>
> > This commit needs a Fixes tag, as this is indeed a fix.... kexec isn't anything
> > new, so all kernel versions are affected by this bug.
>
> Fixes tags are a nice to have, they're not 100% a requirement - they're
> a lot more useful when they're fixing a bug that was introduced rather
> than just something that never worked.

I do not have any strong opinion here. If you want to add the tag. It should be:

Fixes: ee0bcaff109f ("ASoC: mediatek: Add AFE platform driver")

Let me know if I shall resend.

Thanks!

-- 
Ricardo Ribalda
