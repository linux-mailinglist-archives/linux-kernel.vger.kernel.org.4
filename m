Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94E2D6ACF02
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCFUTQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Mar 2023 15:19:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjCFUTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:19:13 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B1F36471;
        Mon,  6 Mar 2023 12:19:12 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id m4so7519033qvq.3;
        Mon, 06 Mar 2023 12:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678133951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcreaCNrPDrsgbWu66UDBX9xNQSed4tnrRouXbHrbGA=;
        b=F50ku4Zl5mbG/MD2CE8JKyZM2H5vmlDwTOCI/4YI/SfCjj+cBiK6V9bE48sr6DVNd6
         LUXC7wJ0JnYo990WL4/0Uc9yKEiJK1N/lqbyCLqArJCL9Flox5GpaL4Nw4eQ9liPKwTe
         vVQZXce+hywJD5MRu3IBysNO+tbZqlIECZciXQMZM/nE4FDxPktJxhtSyOcOIDmuXPmm
         BXUCErzohBsfcNQIrkEws5VaoGjkhnjkepyBwof0Ze8rOdeF01n3VSjXV2j7Ki8xbpEB
         gOiL7IMUUA7Vsox9uB+uuMtMNMDL6WjFQY8CH2UlrY33Xdspuqq2YpzoXwgqSdFrgGaT
         6Gfg==
X-Gm-Message-State: AO0yUKVAm//b8dSfDgst5uUGR0+jMcHRqswgfsTTXqqyUNTRsUGLvn3s
        p2AlD1wlcWcDJN4X9PwbJgYuMIb56BFXgw==
X-Google-Smtp-Source: AK7set+ABH5/m7EEz75lu6ayOsyvOG2+9UZR7vf7AS0aZ0Q/0cbpVOKRvisG1CcUFDZSj2SD/1agVg==
X-Received: by 2002:a05:6214:19e8:b0:56e:9ab5:cd9f with SMTP id q8-20020a05621419e800b0056e9ab5cd9fmr19918410qvc.39.1678133950990;
        Mon, 06 Mar 2023 12:19:10 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id v1-20020a379301000000b0073b4a55a2d1sm8119617qkd.124.2023.03.06.12.19.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 12:19:10 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id v13so9488744ybu.0;
        Mon, 06 Mar 2023 12:19:10 -0800 (PST)
X-Received: by 2002:a25:d6d8:0:b0:8ed:3426:8a69 with SMTP id
 n207-20020a25d6d8000000b008ed34268a69mr10055836ybg.1.1678133949861; Mon, 06
 Mar 2023 12:19:09 -0800 (PST)
MIME-Version: 1.0
References: <CAMuHMdUKo_Sf7TjKzcNDa8Ve+6QrK+P8nSQrSQ=6LTRmcBKNww@mail.gmail.com>
 <CAHk-=wiAxtKyxs6BPEzirrXw1kXJ-7ZyGpgOrbzhmC=ud-6jBA@mail.gmail.com>
In-Reply-To: <CAHk-=wiAxtKyxs6BPEzirrXw1kXJ-7ZyGpgOrbzhmC=ud-6jBA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Mar 2023 21:18:58 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUMbbQM5-1M=OkGzWZ2cKJsOu6t1tJotL9jUChRH-ErXA@mail.gmail.com>
Message-ID: <CAMuHMdUMbbQM5-1M=OkGzWZ2cKJsOu6t1tJotL9jUChRH-ErXA@mail.gmail.com>
Subject: Re: cpumask: re-introduce constant-sized cpumask optimizations
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Mon, Mar 6, 2023 at 8:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Mar 6, 2023 at 3:20 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Your final commit 596ff4a09b898179 ("cpumask: re-introduce
> > constant-sized cpumask optimizations") in v6.3-rc1 introduced a
> > regression.  During Debian userspace startup, the kernel crashes with:
>
> I'm pretty sure the attached patch should fix it. If you can confirm,
> that would be lovely.

Thanks, works fine again!
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
