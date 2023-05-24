Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3474270EE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239723AbjEXGnD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 02:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239477AbjEXGm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:42:27 -0400
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7561FEF
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:40:24 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-561da492bcbso7925067b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910420; x=1687502420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vr2MntkgqtW/rKvOcW5bbJn6xN2wNk/NNHYHNMo3fRo=;
        b=bn9prfgqNhoKBosibtR/6n+b1MmFVFMRBD3GIjrS5hMAf8EUX1FUOpG/ZoeyvohQhx
         iOboiJDNHKs1qlbhPhhyZ2QTNUtnv+ipQGkw7lTgBNRCny3ll0hnWKdtk12atJwvWBmw
         z5u2P2tAQa3fVbW4ozUxc+xt4bJikeF8OjKIv9JNadXMD36NqOkcFZMuIQ9fj/ZRfZWQ
         gzIWsuEn9wWh8SSpwNFWVqaMAkkg4JIHK/jBLQ5/RCTukHOroGRI+8ynYfukLo5jZ+JZ
         qql9mffAN9CsWlN5+6N9xeEXKFvaNGNepNUgATI38WCpp6GOckIPGd5PEe9rbodkpQfj
         p6PA==
X-Gm-Message-State: AC+VfDzqbLh8Wrpm3LHhEjzrsgNPqDIXwe7uEDci7laiwa69GO1NHqSI
        vqqJLYkL62m1iOzOaKpUnUykp5ToDy4AcQ==
X-Google-Smtp-Source: ACHHUZ4mOk3LAC0PwaMpAEGvMN10rZLq0M/hP7+j+Yl9PZxPTZjup5PwCMgYdPm45oSV0GGWrbei6w==
X-Received: by 2002:a0d:fdc6:0:b0:565:5478:713c with SMTP id n189-20020a0dfdc6000000b005655478713cmr4179195ywf.0.1684910420139;
        Tue, 23 May 2023 23:40:20 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id d18-20020a81ab52000000b00564d7328c59sm3054905ywk.76.2023.05.23.23.40.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 23:40:19 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ba71cd7ce7fso954986276.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:40:19 -0700 (PDT)
X-Received: by 2002:a25:342:0:b0:ba8:5009:db33 with SMTP id
 63-20020a250342000000b00ba85009db33mr16875830ybd.59.1684910418943; Tue, 23
 May 2023 23:40:18 -0700 (PDT)
MIME-Version: 1.0
References: <587f259fb8634daa268595f60fa52c3c4d9bbec2.1684854090.git.geert+renesas@glider.be>
 <2c26f143-47ae-4c2f-bd55-2e3b7a6300f0@sirena.org.uk>
In-Reply-To: <2c26f143-47ae-4c2f-bd55-2e3b7a6300f0@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 May 2023 08:40:07 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXb+w6dSnFHvx6zTrXq1bKogrRjsodp+s_9jJcs=X5yFg@mail.gmail.com>
Message-ID: <CAMuHMdXb+w6dSnFHvx6zTrXq1bKogrRjsodp+s_9jJcs=X5yFg@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Streamline debugfs operations
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Osama Muhammad <osmtendev@gmail.com>,
        linux-kernel@vger.kernel.org
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

On Tue, May 23, 2023 at 5:16 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 23, 2023 at 05:03:58PM +0200, Geert Uytterhoeven wrote:
>
> > -     if (!regulator->debugfs) {
> > +     if (IS_ERR(regulator->debugfs))
> >               rdev_dbg(rdev, "Failed to create debugfs directory\n");
> > -     } else {
> > -             debugfs_create_u32("uA_load", 0444, regulator->debugfs,
> > -                                &regulator->uA_load);
> > -     }
> > +
> > +     debugfs_create_u32("uA_load", 0444, regulator->debugfs,
> > +                        &regulator->uA_load);
>
> No, it's actually useful to not just dump these files in the root
> directory if we fail to create the per regulator directory.

If regulator->debugfs is an error, no files are dumped in the root
directory.

By design, all debugfs functions are no-ops when passed an error,
cfr. the comment quoted above:

    Other debugfs functions handle the fact that the "dentry"
    passed to them could be an error and they don't crash in that case.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
