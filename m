Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E0E6C619C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjCWI0J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Mar 2023 04:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjCWI0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:26:04 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3648230B3F;
        Thu, 23 Mar 2023 01:25:53 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id r5so25696328qtp.4;
        Thu, 23 Mar 2023 01:25:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679559952;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YLwa8WskLyA8HRsaKD+rmyXpE99G5zG0nLdln1xHQs8=;
        b=TNMKF0V5tmOBoxaqMcVrKlZJKxUhHwG42vHE72qT2F5wOSP/42kTPD4p3OUYgtKWl0
         /U+0nKrEVkCzLlvBCo62V862orLyxgW0CvBfpWnylNkavfJvE8PjwfWWUMRYhFM75NVM
         iWCQpWeBS3roXsedDqsgPG0J60lcsJILMne8V0VIPBj75k0IpiRFWONFIa9gfkxVIkPS
         4Dl4cj/CsuHZW9xClIIEmJhDbmPXLg6A8eRKexIeD5WIw3NPxzdHh3cJHcsyr0CbPh1t
         pjxoK5yICJTRwsucZ3QIoutfUL55mL9tGQXnBBNiB+uwGI/j4tifX2riivmC+WuTy/9n
         ZpKQ==
X-Gm-Message-State: AO0yUKVkyHIhaMZKQHEQs+gxXZal/MZv2vRmh5WKZEt0yIwcd6f3UWmG
        kSSLasaLEhl14s/ONpIWk1EALFhqTUPkPQ==
X-Google-Smtp-Source: AK7set+MzqZEiIaqkd4Cs+SmPUkl2Ofj2n7GOQQNJRbcQAp44BSlBSdiWmd8tfI1gbno9ZvDFjfgnQ==
X-Received: by 2002:a05:622a:13d1:b0:3db:9289:6949 with SMTP id p17-20020a05622a13d100b003db92896949mr8044624qtk.3.1679559951982;
        Thu, 23 Mar 2023 01:25:51 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id y3-20020a37f603000000b0074382b756c2sm12809242qkj.14.2023.03.23.01.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:25:50 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-544b959a971so348549777b3.3;
        Thu, 23 Mar 2023 01:25:50 -0700 (PDT)
X-Received: by 2002:a81:4424:0:b0:52f:184a:da09 with SMTP id
 r36-20020a814424000000b0052f184ada09mr1197947ywa.2.1679559949876; Thu, 23 Mar
 2023 01:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
 <ZBneELQuakjva1xa@casper.infradead.org> <6320abf6-0898-361b-d5f6-bcc58306f55c@intel.com>
 <ZBsw9lRbJU4c2wLD@casper.infradead.org>
In-Reply-To: <ZBsw9lRbJU4c2wLD@casper.infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Mar 2023 09:25:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdW1ed0ns=Xb-ug=wfUuBTU1Pr0V6Deds1GkSb_f-Ac3Xw@mail.gmail.com>
Message-ID: <CAMuHMdW1ed0ns=Xb-ug=wfUuBTU1Pr0V6Deds1GkSb_f-Ac3Xw@mail.gmail.com>
Subject: Re: [PATCH] mm/slab: Fix undefined init_cache_node_node() for NUMA
 and !SMP
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
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

Hi Matthew,

On Wed, Mar 22, 2023 at 5:47 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Mar 22, 2023 at 09:16:55AM -0700, Dave Hansen wrote:
> > On 3/21/23 09:40, Matthew Wilcox wrote:
> > > On Tue, Mar 21, 2023 at 09:30:59AM +0100, Geert Uytterhoeven wrote:
> > >> -#if (defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)) || defined(CONFIG_SMP)
> > >> +#if defined(CONFIG_NUMA) || defined(CONFIG_SMP)
> > > I'm amused by the thought of CONFIG_NUMA without CONFIG_SMP.
> > > Is it possible to have one node with memory and a single CPU, then
> > > another node with memory and no CPU?
> >
> > It's _possible_ for sure, just unlikely.  The most likely place these
> > days is probably a teensy tiny VM that just happens to have some
> > performance-differentiated memory exposed to it for some reason.  Maybe
> > it's got a slice of slow PMEM or fast High-Bandwidth memory for whatever
> > reason.
>
> Right, you can construct such a system, but do we support the CONFIG
> options of NUMA enabled and SMP disabled?  It seems so niche that we
> shouldn't be spending time testing that combination.

SH has been using this for a long time.

It's supported. Dave just forgot to update the #ifdef around the
definition of init_cache_node_node() when updating an #ifdef around
a code block that contains one of the callers.

P.S. To me, this discussion reminds me of the old discussion about
     discontigmem without NUMA. Yes, not all systems are PCs with
     contiguous memory on a single fast bus ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
