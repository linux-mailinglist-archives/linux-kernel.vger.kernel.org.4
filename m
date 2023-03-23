Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B4D6C61FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjCWIij convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Mar 2023 04:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjCWIiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:38:08 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3F9F35EF7;
        Thu, 23 Mar 2023 01:36:53 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id c19so25702661qtn.13;
        Thu, 23 Mar 2023 01:36:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679560613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLvOHhjGtQPAGxbfhV5i2RzlDMu0DOqPCzbtGbv4UHg=;
        b=wUD+P+CNiRq5ncqepbhg9mtUuXC9Z7FWsgBQvs+uU7DCX7jpufVeVnruutUYbyJ+CC
         QzLr+hGotRBzvijOm8Xi1Ye/AeO5DHt70rbatvf1Ql/j3vXscsfutS1E7vLH5N2SNQlB
         ilrMZqYYXVLNlds4TG0lOGL0KQA7oqHG9trQfLnqXViAKTKKMq+2H58GN6vHiRKnGybb
         N1U4T2Olnn7W2WGPdK5kMrI3TTB7iwXYucA95wAWQr4YtMpKclgyEPVEMjSbCoIzLFa4
         nH+vZB8BDykcLj6X6JAceN2kMz7ljjeoS4Kd2wkq6NpuPANSntn1d9663Su9rLJnD9lo
         ZhQg==
X-Gm-Message-State: AO0yUKWii5BMcSgkHLBQ9FQBKWIO0kp/cfJi/jjUrAfxjUeDqBxKoAif
        eO7n0wZaQQ3qK/4MclwXehYhHg6QgjbqgQ==
X-Google-Smtp-Source: AK7set9P5xWan7eeEzD1Ah340/W3CLp6dOjOm+sFWYiQgdCBZ4CPsWzGOblq/4C3IvC/YsQewdDIMw==
X-Received: by 2002:a05:622a:58a:b0:3bb:8a14:badd with SMTP id c10-20020a05622a058a00b003bb8a14baddmr7016607qtb.29.1679560612906;
        Thu, 23 Mar 2023 01:36:52 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id i14-20020ac84f4e000000b003e3895903bfsm3006909qtw.8.2023.03.23.01.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:36:51 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id y5so23909930ybu.3;
        Thu, 23 Mar 2023 01:36:51 -0700 (PDT)
X-Received: by 2002:a25:6b0e:0:b0:a27:3ecc:ffe7 with SMTP id
 g14-20020a256b0e000000b00a273eccffe7mr1426444ybc.3.1679560611303; Thu, 23 Mar
 2023 01:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
 <ZBneELQuakjva1xa@casper.infradead.org> <6320abf6-0898-361b-d5f6-bcc58306f55c@intel.com>
 <ZBsw9lRbJU4c2wLD@casper.infradead.org> <CAMuHMdW1ed0ns=Xb-ug=wfUuBTU1Pr0V6Deds1GkSb_f-Ac3Xw@mail.gmail.com>
 <4cd6f0c8d7603254df9e2eb1e7b80973e75c4e45.camel@physik.fu-berlin.de>
In-Reply-To: <4cd6f0c8d7603254df9e2eb1e7b80973e75c4e45.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Mar 2023 09:36:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW52q5d8R4DawXRhLGj7sNoaZiwayAsMh6eWPGxUW=_HA@mail.gmail.com>
Message-ID: <CAMuHMdW52q5d8R4DawXRhLGj7sNoaZiwayAsMh6eWPGxUW=_HA@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: Fix undefined init_cache_node_node() for NUMA
 and !SMP
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, Mar 23, 2023 at 9:28 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Thu, 2023-03-23 at 09:25 +0100, Geert Uytterhoeven wrote:
> > It's supported. Dave just forgot to update the #ifdef around the
> > definition of init_cache_node_node() when updating an #ifdef around
> > a code block that contains one of the callers.
> >
> > P.S. To me, this discussion reminds me of the old discussion about
> >      discontigmem without NUMA. Yes, not all systems are PCs with
> >      contiguous memory on a single fast bus ;-)
>
> I'm wondering: Could the NUMA code be used to work with the different
> memory types found on the Amiga, i.e. chip RAM, fast RAM etc?

I guess so, but only for 32-bit motherboard RAM on A3000/A4000
vs. RAM on an accelerator card vs. Zorro-III RAM on e.g. BigRamPlus.
Chip RAM and Zorro-II RAM do not support RMW-cycles on
Zorro-III capable machines.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
