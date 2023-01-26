Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C341067C729
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 10:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236851AbjAZJ11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 04:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbjAZJ1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 04:27:23 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1840F3C04;
        Thu, 26 Jan 2023 01:27:19 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id e19so1018868qvw.13;
        Thu, 26 Jan 2023 01:27:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=akgSxlu78ii0feJ5R8t4wHMvuhlQqEfCO4FxGUUx8Oc=;
        b=BXlI0h26kK157rNj5IgGtVUU+chK7+W0unfQp0ZSJXJenoesWBXuqNKNj16ImoLD7v
         rMAL/gOjko7QCPQjSS14VW9iccKPVR9yUAGj0soFt1eBLBW+06JYAMilvuT/sX91IbTe
         HFLstxS6vfBqs+zQc8Xu9yxU6EXIR4wQu3X8rWV5uOrPlMVMg/Cv/yxyjoZVx1CwM/5j
         2vFdfSlzTepBRZkd/OJhDPLL/R37qdMUp+1uvLJFnkCojhKKuvpQXAEcBzhtH1Q/Wej4
         h0mzz/lGTPVMLLllnB7BYQ9Go2393UokyTByJiYcmWn23KZPtwUOzUIqjf3Wt7aS8b12
         Tjhg==
X-Gm-Message-State: AO0yUKWJ4oMTVnhLD4AFi+EpGdK3h3dJ85+ugBPF+Fl3vqmLSeXAquPI
        XxYVRs0a5f2U+KYw1O97XVr27oDSLx6zzg==
X-Google-Smtp-Source: AK7set/YvWTU1OTQ6JSXflbrkkYMNEdHBQwzEBPWr1lh2R3ikRzo7zHo3bwDwW6lm/uFsiH60M6T6A==
X-Received: by 2002:a05:6214:2422:b0:537:8107:109c with SMTP id gy2-20020a056214242200b005378107109cmr1819190qvb.52.1674725237832;
        Thu, 26 Jan 2023 01:27:17 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id dt3-20020a05620a478300b00706a1551428sm635313qkb.6.2023.01.26.01.27.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 01:27:17 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-4c131bede4bso15386727b3.5;
        Thu, 26 Jan 2023 01:27:17 -0800 (PST)
X-Received: by 2002:a81:5204:0:b0:507:86ae:c733 with SMTP id
 g4-20020a815204000000b0050786aec733mr554405ywb.358.1674725236924; Thu, 26 Jan
 2023 01:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20230118104656.67706-1-wsa+renesas@sang-engineering.com>
 <fb2a6e85-42ad-8b17-4433-8d5e96c87a80@linaro.org> <Y84wDxiBE6CZqSO5@ninjato>
 <8f9d6e07-6549-9b2e-a45b-f262b59bfe5f@linaro.org> <Y9JBfTVqjXZqi1r3@ninjato>
In-Reply-To: <Y9JBfTVqjXZqi1r3@ninjato>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 26 Jan 2023 10:27:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWbEJ3kdAWXfMb5wqDhtjbDgJ8cCdnT-CTe2P4FAyAb7A@mail.gmail.com>
Message-ID: <CAMuHMdWbEJ3kdAWXfMb5wqDhtjbDgJ8cCdnT-CTe2P4FAyAb7A@mail.gmail.com>
Subject: Re: [PATCH v2] memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

Thanks for reminding me I still had to chime in on this ;-)

On Thu, Jan 26, 2023 at 10:03 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> > > I need it because of ".revision". This only applies to "ES1.*",
> > > there are "ES2.*" and "ES3.*" around which have the same SoC number.
> > > Also, there is usually no version numbering for the IP core. We need to
> > > use this scheme in a number of other places already, sadly.
> >
> > I did not get whether this is runtime characteristics or it can be
> > customized with compatible (just you did not do it)?
>
> We have compatibles per SoC, i.e. "r8a7795". We don't have compatibles
> for ES versions, i.e. no "r8a7795-es10" or "r8a7795-es20".
>
> The latter would not be practical. We can't know in advance how many ES
> revisions there will be, so we can't prepare DTs accordingly. Updating
> later would be also difficult because we are usually not notified if
> there is a new ES version. Only if there are problems with it. And which
> board is available with which ES version is chaotic^2.
>
> Also, if we update DTs later, old DTBs would not work with newer kernels
> (requiring a later added compaible for a new ES version). This all still
> ignores that it would be a churn to update for every ES version of every
> SoC. We have quite many to support. That's why we use soc_device_match()
> for ES versions in many places alreday. It was never a problem so far.
>
> That's my reasoning, probably Geert has something to add. He maintains
> the Renesas DT files.

Exactly. We only use soc_device_match() to distinguish where we do not
have a compatible value to do so.  As we have SoC-specific compatible
values for about everything, this means we usually use soc_device_match()
only to handle quirks on specific revisions of SoCs.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
