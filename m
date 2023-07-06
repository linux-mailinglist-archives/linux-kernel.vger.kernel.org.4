Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF8749B8A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjGFMQU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Jul 2023 08:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjGFMQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:16:13 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F261BC9
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:16:11 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-56fff21c2ebso7537597b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 05:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688645771; x=1691237771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tzl2SvwgN5dAVGpY419AzobIOEk8FC71RqlBpVF0wLs=;
        b=ivPdjnPvnwNuTHBpODUBzAKHTQ6Donjm2JSPcGZnWL/jbB5ByugsyV4sEVyDdg7CQn
         poaQG1MgIUCpiKU7p0NLME9C6Tgvhu3kJY14Za2PbvacrEn5/O+wuyKZT8CR1d/zdR+e
         ttkKCljBlCi2NLTskN0wV5K86EQ07uiTbc7a5NkaVzLz6097xekPSPgMLiK8B8rRQ585
         zAqO+nu6UF+1SG1RRztUAxAe5W6U3RW4ABf2c3Fc+EHlKh18zgqgNlwNA0OJyvoqFVJC
         jL64HzpLvzdqGQDD2iA+MV6yS4xGwMFXohNLdq90NLFOFW/xThxuyhqRF0Nnv+0TVjTm
         Dpaw==
X-Gm-Message-State: ABy/qLZUgF+7HsEldEts5d/EQUuJMdwg1bmiOkJWWBfM3G82zMEe5EEL
        7DD4CWx7ASy8tFvlsKsWj7R8O73cK/3vZw==
X-Google-Smtp-Source: APBJJlGoxdollN9cdG6vKFkiwu8SZWGU5uBq9xEtg+4yNgr01rf0Ry3gj+dWOjus0tLJdFMGEnPePA==
X-Received: by 2002:a25:3253:0:b0:c68:e302:c906 with SMTP id y80-20020a253253000000b00c68e302c906mr1096263yby.21.1688645770986;
        Thu, 06 Jul 2023 05:16:10 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id c12-20020a5b014c000000b00c624de0d9absm281119ybp.5.2023.07.06.05.16.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 05:16:09 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-c5e76dfcc36so652399276.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 05:16:09 -0700 (PDT)
X-Received: by 2002:a25:c050:0:b0:bc4:515e:cb0f with SMTP id
 c77-20020a25c050000000b00bc4515ecb0fmr1494840ybf.1.1688645769466; Thu, 06 Jul
 2023 05:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1688643442.git.geert@linux-m68k.org> <cafd878747e7951914a7d9fea33788a4a230d1f0.1688643442.git.geert@linux-m68k.org>
 <bd265a83-ca5e-4196-936e-0f753ea47a25@sirena.org.uk>
In-Reply-To: <bd265a83-ca5e-4196-936e-0f753ea47a25@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 6 Jul 2023 14:15:57 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUc-6ga7G5xuXXcKXU0ya3XBBM-tEJ3tZ-BY-oa+wozsQ@mail.gmail.com>
Message-ID: <CAMuHMdUc-6ga7G5xuXXcKXU0ya3XBBM-tEJ3tZ-BY-oa+wozsQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] ASoC: codecs: SND_SOC_WCD934X should select REGMAP_IRQ
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Benjamin Gray <bgray@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Jul 6, 2023 at 2:09 PM Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jul 06, 2023 at 01:42:04PM +0200, Geert Uytterhoeven wrote:
> > If CONFIG_SND_SOC_WCD934X=y, CONFIG_COMPILE_TEST=y,
> > CONFIG_MFD_WCD934X=n, CONFIG_REGMAP_IRQ=n:
>
> There appears to be at best a marginal relationship between this and the
> rest of the series, please don't group things needlessly like this, it
> just creates spurious dependencies which complicates getting things
> merged.

Well, unless you have CONFIG_REGMAP=y due to some other reason, you
won't reach the mentioned link error without applying [PATCH 2/3] first.

It doesn't hurt to apply this patch independently, though.
Do you want me to resend it (to your sound-persona) as a separate patch?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
