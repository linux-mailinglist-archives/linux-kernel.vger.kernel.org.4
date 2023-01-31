Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FD268285A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjAaJMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:12:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjAaJMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:12:09 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82D14C6D6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:09:39 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id i185so15370405vsc.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ahEni0vEoNstNN4puWfSl0I1TRpDbWT6saFFu8LT9dw=;
        b=sGuXmQgy7fDR1rKCzZt5UMQht6+7DH0x6DAlL7Sce1QlorgtKchNH3jySV9wVGyDRE
         uS79UdqXctE41UgKA+u9zVUr0f2EI0SaPS4rrzLMgadqALs6CbPTuKx9XMf1Udjyt3cj
         R4h9fL6pyaxzFAsSXSPs0chSrBXkHdCTfjxBRJ2TomZTnt+nyc7lRv/pzKsKs2ud8Fqq
         X1YnOjSlQatGeBlskWUeOicLapRQ6Vu8Gf7Ldjmw6CaARi7jhYJNjC5IGspjNyazSh3S
         L0rNMbzY8fyGAv10rUQqtvQ/TCYzN5cmbAqG1laaDW3qzoHerrWApJOfIIq5Ujsh/PJ9
         TCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahEni0vEoNstNN4puWfSl0I1TRpDbWT6saFFu8LT9dw=;
        b=lYHRwZpqTHx42S7wJ/UhSnk3oU4/k4TB0BfVoHrEbn0QWRllD3taysdSaI8rnXOtBc
         Vjsq06Uq+clDTpdYQHif5SBfz5Wl1gIHTxCsKHa7MwzmPaJu4UbEQaTzjl1K3EwWkbO8
         ktzyimpBCzIOyRKnF4NUPlNuBcFAYaGJqj3aDrNOX5ZZhvfbICQa/o+cPm9uyny6eSI+
         OqlSF2cCupr04H9yjjoJCFuxR3RmIgfmGeQe9Pxh4XbmtakujK/KdXy8JBSPi4e7RXaq
         ZMx3g9Src0OItHRjWMhHkXMAOyxxbuSVEzpJ0Qv4Q9tpBGXb+E1I6RhyTFIg95IZVaBL
         QAag==
X-Gm-Message-State: AO0yUKXx4RiVZD8OkUDJHyjRFIEjcIjDYkJXuvHT65Fs9S+pZcWrwBqA
        dy0c6mcr96HFjB9VbXbhjz3HTY72rIEXIg2nT/72yQ==
X-Google-Smtp-Source: AK7set9KOq1qsK4tfr85oQrSa246WDWxkItg3+dwzH1IwyEgdnmwdGOPPnP0UdfR7d3xYktL27QVnVfk/TpiqpFd1Lw=
X-Received: by 2002:a67:c31e:0:b0:3ed:1e92:a87f with SMTP id
 r30-20020a67c31e000000b003ed1e92a87fmr2260239vsj.1.1675156115140; Tue, 31 Jan
 2023 01:08:35 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <9fbb4d2bf9b2676a29b120980b5ffbda8e2304ee.1675111415.git.andreyknvl@google.com>
In-Reply-To: <9fbb4d2bf9b2676a29b120980b5ffbda8e2304ee.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 10:07:58 +0100
Message-ID: <CAG_fn=U_WraAkVi9sdTNuk9sjQ8gEHWafsjcYEMYq2G8KX4HTg@mail.gmail.com>
Subject: Re: [PATCH 01/18] lib/stackdepot: fix setting next_slab_inited in init_stack_slab
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 9:49 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> In commit 305e519ce48e ("lib/stackdepot.c: fix global out-of-bounds in
> stack_slabs"), init_stack_slab was changed to only use preallocated
> memory for the next slab if the slab number limit is not reached.
> However, setting next_slab_inited was not moved together with updating
> stack_slabs.
>
> Set next_slab_inited only if the preallocated memory was used for the
> next slab.
>
> Fixes: 305e519ce48e ("lib/stackdepot.c: fix global out-of-bounds in stack_slabs")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
