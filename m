Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1156F5C31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 18:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjECQjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 12:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjECQjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 12:39:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8957C40C6
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 09:39:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so8211019a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683131947; x=1685723947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GDOEJmPCkMAXwP4EM4fFCOknLeOQGECRZYdt6JA8Vkc=;
        b=MGfKnsXqGgWnbh0d3jvS1tq/OTAX8EEgrNSaq1g1H1gPXD6uDO4WKqK4I3bxrKXzhr
         jqeXmZWT3LF+n/41ZBNJqqtGyu76XuhbveJmWqa5SvfjOS0ySnNCurg3vOkwnV5EKc3+
         DQ+vtQXb3G/qSqxqpSO3Vo+vctU4wdoGy47y4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683131947; x=1685723947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GDOEJmPCkMAXwP4EM4fFCOknLeOQGECRZYdt6JA8Vkc=;
        b=EiZ0GvyNuXpeRGm9rklBrmG/ixNn2FpyRA6gbs5Ui7ktiwEI9ottAL8GDJIjlBUvyk
         +PMlrTs+4/ZFBQOmvze5cD58gPOEs0IN8s8RYf775awJ7DplOvcfpEVUnQ0kiZK0AExI
         Tk06vLrRGeQr/Lgqn9NpwXBXjIN+ICqsocEY/8ZiWdpv5mS94yXQoBWD9Lm/8DYXfnDk
         KbGk0gZ0o3nromg7q3VehV5Oy3B7fw1RZ+fQQScq/4xt7TanQMw04/PYMYZmoafUoKBW
         PHY4SGSN0ylYUSdiiX5MYgm/mjhfrmXU5kUPUmJVfHX5Y+dNgg+f0m/8TNyoOKzFpiF/
         n+nA==
X-Gm-Message-State: AC+VfDwwfWABJWT2hfgaAyFDf5dkF+A7qO2RuKnQ/bwSF4a7WVHMVCGa
        zJ011wiHeh3Ycjm6pi2HbzjkcrmXgfVOfHU5UrlUXw==
X-Google-Smtp-Source: ACHHUZ4XAa49RFgw8KbvXQv2jxcWVJPsX0Jiz8Pig0JVugH9ZZkiY7J5Co5zOSe5WyT+Cnr8MMGmiw==
X-Received: by 2002:a17:907:7249:b0:95e:de94:5bea with SMTP id ds9-20020a170907724900b0095ede945beamr3536865ejc.56.1683131946765;
        Wed, 03 May 2023 09:39:06 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id jl15-20020a17090775cf00b009658e92c321sm279328ejc.142.2023.05.03.09.39.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 09:39:06 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-50be0d835aaso2601211a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 09:39:05 -0700 (PDT)
X-Received: by 2002:a17:906:dc8c:b0:957:db05:a35d with SMTP id
 cs12-20020a170906dc8c00b00957db05a35dmr4556056ejc.48.1683131945656; Wed, 03
 May 2023 09:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230427225647.1101172-1-dave.hansen@linux.intel.com>
 <CAHk-=wgrdOm8RwO+u8bydrbgs0wXJV_9mBYAtzX9d9hEY7a25A@mail.gmail.com>
 <CAHk-=wiHvdgbLxayyCsRU45JnKCZkCOpEJPfOvE3eYCnGjVcSA@mail.gmail.com>
 <20230429003822.n3mglslg666j3npp@box.shutemov.name> <641a9348-a052-6bb5-e6c7-64acb6405328@intel.com>
 <CAHk-=wgnGoj8qZg3SRh1Z1-mU=b3ryydXZykUuarnrAn6LuHBw@mail.gmail.com>
 <CAHk-=wgN=GY2A0htYQQRmPaLCorWnFatY_XO0X2w_m9xXQDcPA@mail.gmail.com> <20230503080126.GA1676736@hirez.programming.kicks-ass.net>
In-Reply-To: <20230503080126.GA1676736@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 May 2023 09:38:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wja6qVtyR3gL33QLTYwXu7OA0z4ydhCMbF2odCsQ8HhZA@mail.gmail.com>
Message-ID: <CAHk-=wja6qVtyR3gL33QLTYwXu7OA0z4ydhCMbF2odCsQ8HhZA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.4
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 1:01=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> So I had a poke around, trying to figure out where it came from, and
> yes. Commit ae31fe51a3cc ("perf/x86: Restore TASK_SIZE check on frame
> pointer") is the reason that WARN_ON_IN_IRQ() thing got added.

I added a pointer to that commit in the commit message, and took the
above to mean 'Ack' from you.

               Linus
