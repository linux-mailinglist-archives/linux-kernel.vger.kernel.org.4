Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E495C608ED2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 19:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbiJVRbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 13:31:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiJVRbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 13:31:12 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2C167065
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:31:09 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id i12so3979602qvs.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vNO4n1X5BpGP+j0JDX4vtFFXwAjuMrA9O/wBbEdNfDc=;
        b=ddSbbairWn90T3DOQN+X79nE6dPhX/Lt11JVyrVfHbKBT6ajo5tFCHdSCq6BYJO0WM
         lfXxT/CvjAvgRJV/9iVAxeyUUTzEur2hHAwlxtcT/VqQTHEpb2SFFolNxt4IDjHahnzX
         0ZIIHBl44TSHwCyKiwenfDzD7VY93ZJPXGsuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vNO4n1X5BpGP+j0JDX4vtFFXwAjuMrA9O/wBbEdNfDc=;
        b=0xVmMoYY0QfJ8WE4in5onFpce/kWVhD3Eemy7EtUQJFUZGESSaQBj/bCs8y6dPLyUt
         qUBcp/OomDxL5/eBbFKwA0JzzlsZXQGILt8O4jEz6g5N3DW/esMDjOtF41Fq6ATTTTxD
         XeJWIR9ApIfUxglnItMy0deFQUcXmYRcTVupnWNBxPmt+zgPqflfng2UDmIWAGHbe/kG
         I7n3AeHwrz+Cz4Sy3CaFulY1lmvwQaBWubEpCoRfTfpns9IkyobdpFd70MhfSi3qtDMX
         SaBW/ee1sy7mz9XzTpwD4sKQB+CeFdwDFoRSpcWVW5kfsEdceeQ7piU4+n+y4T9tdqeO
         PUDQ==
X-Gm-Message-State: ACrzQf116WRHJk4gmGl845NbiCQa3+PbY7VoIxLwuIl+Zjkqotj2FzQX
        ycFL1hu7yRY+2mzgXSzg2ToozsEVaOJCug==
X-Google-Smtp-Source: AMsMyM6plYi3l2Jq+X8DhgyTpzumW2yb23ZHtqrhlPdKkbUp7yezSgvrxsI6I5oteOSiDuduQOoU4w==
X-Received: by 2002:a05:6214:d0c:b0:4b3:36b4:c89a with SMTP id 12-20020a0562140d0c00b004b336b4c89amr22090022qvh.93.1666459868668;
        Sat, 22 Oct 2022 10:31:08 -0700 (PDT)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id fx12-20020a05622a4acc00b0039cc7ebf46bsm9899838qtb.93.2022.10.22.10.31.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Oct 2022 10:31:08 -0700 (PDT)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-368edbc2c18so51019957b3.13
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 10:31:08 -0700 (PDT)
X-Received: by 2002:a81:114e:0:b0:36a:fc80:fa62 with SMTP id
 75-20020a81114e000000b0036afc80fa62mr3963111ywr.58.1666459867739; Sat, 22 Oct
 2022 10:31:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221022111403.531902164@infradead.org> <20221022114424.711181252@infradead.org>
In-Reply-To: <20221022114424.711181252@infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Oct 2022 10:30:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=whKxHeW3tx8Q2_0sf=NW9RGUQYC1S2Km3eLC9jJ=whSRw@mail.gmail.com>
Message-ID: <CAHk-=whKxHeW3tx8Q2_0sf=NW9RGUQYC1S2Km3eLC9jJ=whSRw@mail.gmail.com>
Subject: Re: [PATCH 04/13] mm: Fix pmd_read_atomic()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        aarcange@redhat.com, kirill.shutemov@linux.intel.com,
        jroedel@suse.de, ubizjak@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 4:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -258,6 +258,13 @@ static inline pte_t ptep_get(pte_t *ptep
>  }
>  #endif
>
> +#ifndef __HAVE_ARCH_PMDP_GET
> +static inline pmd_t pmdp_get(pmd_t *pmdp)
> +{
> +       return READ_ONCE(*pmdp);
> +}
> +#endif

What, what, what?

Where did that __HAVE_ARCH_PMDP_GET come from?

I'm not seeing it #define'd anywhere, and we _really_ shouldn't be
doing this any more.

Please just do

    #ifndef pmdp_get
    static inline pmd_t pmdp_get(pmd_t *pmdp)
    ..

and have the architectures that do their own pmdp_get(), just have that

   #define pmdp_get pmdp_get

to let the generic code know about it. Instead of making up a new
__HAVE_ARCH_XYZ name.

That "use the same name for testing" pattern means that it shows up
much nicer when grepping for "where does this come from", but also
means that you really never need to make up new names for "does this
exist".

             Linus
