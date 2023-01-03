Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B578065C071
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237569AbjACNGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237649AbjACNGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:06:50 -0500
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AF0267E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 05:06:49 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id c124so32939901ybb.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 05:06:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cg9NBeuSYbmn+DA79/KjX0RMB03P0+uV8JtF3hf3uM8=;
        b=3sz9FlCvhHPwLkdpXYnFPsXdtgUnAr2DElPd0GUC3tqwaQ1kQbOovSBWeNoDKcRTi3
         fLSTrOZP28Rd0rTooBRFwk2DEgG1RxZPt1SIWJi9JofDutM0tvJrUhlqSgUUllKNbs6E
         o8HvDuQtw8Qq9aXRcG/HQxmCEXW1J4y1AbUr8jqKFfj326YHvrldqfUrCW396gpAuxq+
         ZXxoWPMpq2pTtkhFEphZuEVY/RO5aUlcEjxL0fj3b/RQA+unG3BKB5YH2Pdsm9hKB5I/
         rcni2OQtmhWEazE4sO8wK/i3lNdw/BUIsFN1tHlUt/VfQv/IFX37Xxie0s7ZvZ3iRfo7
         pYug==
X-Gm-Message-State: AFqh2kqnUg6TLifGhC56iG8oyGyFr0mQpnmUwcfwWjL0PelY0J6SppAj
        0EuDyuCZrF8hTgBQVETii19pKzQhmY3g0Q==
X-Google-Smtp-Source: AMrXdXt3BIXLP6+e4et9TPLHQcFYXg4gop5FlVVZXDjYAOJq/77VIsqumXEZL+P1iTHaQjJpUP1VSw==
X-Received: by 2002:a25:3c85:0:b0:70c:419a:faf0 with SMTP id j127-20020a253c85000000b0070c419afaf0mr36983204yba.49.1672751208437;
        Tue, 03 Jan 2023 05:06:48 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id n78-20020a374051000000b006f9ddaaf01esm21887473qka.102.2023.01.03.05.06.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 05:06:48 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id b16so33050117yba.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 05:06:47 -0800 (PST)
X-Received: by 2002:a25:3143:0:b0:77a:b5f3:d0ac with SMTP id
 x64-20020a253143000000b0077ab5f3d0acmr2508697ybx.202.1672751207466; Tue, 03
 Jan 2023 05:06:47 -0800 (PST)
MIME-Version: 1.0
References: <20221229075323.1394010-1-linmq006@gmail.com> <CAMuHMdWFyKA7nUojivvTwWcmxaiUQifRRB=Kn1q-qzmn20Xkuw@mail.gmail.com>
 <eaedf019-349c-c686-0f23-093371b4b61f@cambridgegreys.com> <a098244c-fe15-2c88-5c02-59aaa6cc3c6d@gmail.com>
In-Reply-To: <a098244c-fe15-2c88-5c02-59aaa6cc3c6d@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 3 Jan 2023 14:06:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVYCsGDGeub8-mduNw45qX_tMr0sZ5oMNfJ_eqFnPgs4g@mail.gmail.com>
Message-ID: <CAMuHMdVYCsGDGeub8-mduNw45qX_tMr0sZ5oMNfJ_eqFnPgs4g@mail.gmail.com>
Subject: Re: [PATCH] um: vector: Fix memory leak in vector_config
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

On Tue, Jan 3, 2023 at 1:17 PM Miaoqian Lin <linmq006@gmail.com> wrote:
> On 2023/1/3 18:28, Anton Ivanov wrote:
> > On 03/01/2023 08:00, Geert Uytterhoeven wrote:
> >> On Thu, Dec 29, 2022 at 8:53 AM Miaoqian Lin <linmq006@gmail.com> wrote:
> >>> kstrdup() return newly allocated copy of the string.
> >>> Call kfree() to release the memory when after use.
> >>>
> >>> Fixes: 49da7e64f33e ("High Performance UML Vector Network Driver")
> >>> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> >> Thanks for your patch!
> >>
> >>> --- a/arch/um/drivers/vector_kern.c
> >>> +++ b/arch/um/drivers/vector_kern.c
> >>> @@ -765,6 +765,7 @@ static int vector_config(char *str, char **error_out)
> >>>
> >>>          parsed = uml_parse_vector_ifspec(params);
> >>>
> >>> +       kfree(params);
> >> Are you sure the memory pointed to by "params" is no longer used?
> >> "parsed" seems to contain pointers pointing to (parts of) the string
> >> pointed to by "params", so it cannot be freed.
> >
> > +1.
> >
> > I was just about to send the same comment.
> >
> Oh yes, thanks for spotting this. We should only perform release when uml_parse_vector_ifspec() fails (returns NULL). In this situation, 'params' is no longer used. Do you agree?

Yes, that sounds fine to me.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
