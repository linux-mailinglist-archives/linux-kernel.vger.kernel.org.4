Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03B170EE50
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239637AbjEXGn1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 02:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232536AbjEXGnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:43:01 -0400
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8179410EA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:40:52 -0700 (PDT)
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-b9a7e639656so1286711276.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684910451; x=1687502451;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/WVghxlsJWRUKZZynjPREoTbk29D78eUZOEJqV+SNIE=;
        b=H0vxnK38GS8sRZMmSa/WgEileb9rZjFRChZdhFS0smK8HkSX6uA0soBmrJOMwwUOEB
         4jfVdM0MubxXmT5/grDpwf6TnuSjBZy3pW1T9ofhj47iUhQuC/JULLaH6XxQX1YWoq76
         peeI097seymoeU2er8NxJ3WvlrVX6lgUmFQNNQ5NUWmtwZh5HZFoOHPJ+YaiioaUZMQe
         vVVI+j3wA6RdqORev2ByTdf/SCCYzVO1GPFaqXvmj15pWGRGtnvpMpCyHwS4xTZr8cCt
         mhCd6FkcRyTGkeUv80eXisAMaGMFuwWKKzGyozodL+UfhI4yFlJrNSrv9Zjmj4OctSPa
         3FGA==
X-Gm-Message-State: AC+VfDx+JBRdw711iN9QQKib2NudpoxdzCHUOw5pdbFMZdBGohcQ4LBV
        KN0jiEENMysQ5zbZAmGzot0jBHCDtZZHYA==
X-Google-Smtp-Source: ACHHUZ6B/P4jKaQJAaxK7KXZZ5p19oTrj+uTP97GnnHIH8yYHB6eKIMk9+CuHmImMJ7lSKdgzdX0JA==
X-Received: by 2002:a25:b120:0:b0:ba6:f32b:28e3 with SMTP id g32-20020a25b120000000b00ba6f32b28e3mr17772940ybj.6.1684910450625;
        Tue, 23 May 2023 23:40:50 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id h11-20020a25210b000000b00ba7c2112650sm2572462ybh.30.2023.05.23.23.40.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 23:40:49 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-ba82059eec9so1241249276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 23:40:49 -0700 (PDT)
X-Received: by 2002:a0d:d857:0:b0:544:57ba:a32e with SMTP id
 a84-20020a0dd857000000b0054457baa32emr16518395ywe.9.1684910449718; Tue, 23
 May 2023 23:40:49 -0700 (PDT)
MIME-Version: 1.0
References: <587f259fb8634daa268595f60fa52c3c4d9bbec2.1684854090.git.geert+renesas@glider.be>
 <96def590-4ffa-4201-a1b8-0ad2c8ec718e@sirena.org.uk>
In-Reply-To: <96def590-4ffa-4201-a1b8-0ad2c8ec718e@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 24 May 2023 08:40:38 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUTFzCTAKB9S-EhA4Th8xsDdzE+ycyD48D8mL0VJqpDMQ@mail.gmail.com>
Message-ID: <CAMuHMdUTFzCTAKB9S-EhA4Th8xsDdzE+ycyD48D8mL0VJqpDMQ@mail.gmail.com>
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

On Tue, May 23, 2023 at 5:17 PM Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 23, 2023 at 05:03:58PM +0200, Geert Uytterhoeven wrote:
> > Fix the error check on the return value of debugfs_create_dir() in
> > create_regulator(), which was missed before.
> >
> > Fixes: 2bf1c45be3b8f3a3 ("regulator: Fix error checking for debugfs_create_dir")
>
> Also: this should be a separate patch.

I can  do that, sure (patch stats++ ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
