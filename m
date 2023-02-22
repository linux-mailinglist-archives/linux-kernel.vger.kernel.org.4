Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A4969FABB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 19:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbjBVSGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 13:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjBVSGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 13:06:03 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4A52A99C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:06:01 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id x10so33143139edd.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cGpZFU2UcyLBydYiuqKlsQusqJUYTSHZymwHyqf4dkc=;
        b=Xkx03R7iomk5nIEr8uA5j4kl8AmgbyUaJcMuYDQL6IMZAsqZk4vY7foqn3wxGQQMy1
         NBVIwOkF82w3lG/JUIhE1hTT/K4ncaMS6R30z4+NAGQmt4eLAMVdYnty7qGBJrQl/zdI
         PTANY91znSBzv2Rt0b/823er0ArDX1ilVOnjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cGpZFU2UcyLBydYiuqKlsQusqJUYTSHZymwHyqf4dkc=;
        b=dnQ3Uvlb1DJM+mLIawZYTV76PdCY8CfjSJhv3YGgudOVMnqaanzSxWkG/WzU82m6lP
         Yil8rsOdLEC9CSJTmVCIKhy4weFM7pddtSa0ITRT0LRPge4LCktHUC3ei8UfiKjBGI6z
         fF1pKxRXB6QDgVrrRNC8HXsbZY6WP01mY29cEPUggdBscrZG7vGH+6IXGE0zDquoaxZn
         yMNbb1uktqnoIk1wFOibMMZD4rsoq+Kc2EHfYSB83tiuBzoFHOsUsTWEkmPHTnZKORqp
         SLAkmOvDfyvzOBb96AxobwUe5rcjDJyjfo4PyEJSf8XeyXQNPbbtNuv9nydKvBiV1oQq
         X1pQ==
X-Gm-Message-State: AO0yUKUKsYzkxT/XSXupiOBiK2g9UnItt3vk7u2nlYF6l6aja4S3QQeS
        O72Njlngg/xVKAPto5v//nLqQ16B47WccUmXSJ4=
X-Google-Smtp-Source: AK7set8SctDWFfDv+YzHkpep1R+tyILa70tLY1p4KAcMlu9cjNCmm2EAe7B5gBFDgRA2ZCzdp+kpkw==
X-Received: by 2002:a17:906:869a:b0:8b1:3131:76e9 with SMTP id g26-20020a170906869a00b008b1313176e9mr16385993ejx.46.1677089159178;
        Wed, 22 Feb 2023 10:05:59 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id r10-20020a1709063d6a00b00882f9130eafsm8712176ejf.26.2023.02.22.10.05.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 10:05:58 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id cq23so33670050edb.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 10:05:58 -0800 (PST)
X-Received: by 2002:a50:d619:0:b0:4ab:3a49:68b9 with SMTP id
 x25-20020a50d619000000b004ab3a4968b9mr4197830edi.5.1677089157879; Wed, 22 Feb
 2023 10:05:57 -0800 (PST)
MIME-Version: 1.0
References: <9c476aa64c9588205817833dbaa622f87c0e0081.1677051600.git.viresh.kumar@linaro.org>
 <CAMuHMdXd3876o+petD51xfnJRBOOg=oqkO_pdsmcr8=Uec2KDg@mail.gmail.com>
 <7189da9a-f634-01ae-194d-a4d14a319a1c@intel.com> <CAADnVQKX0ZD=8Xu4U2H_vbyuNoXJv0UZ1OffUtqw3vs0v95ELQ@mail.gmail.com>
In-Reply-To: <CAADnVQKX0ZD=8Xu4U2H_vbyuNoXJv0UZ1OffUtqw3vs0v95ELQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Feb 2023 10:05:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg8E68rT2X1fHjxxn0GQhmz7vSVOmmY4Kk1W0VEYjFjnA@mail.gmail.com>
Message-ID: <CAHk-=wg8E68rT2X1fHjxxn0GQhmz7vSVOmmY4Kk1W0VEYjFjnA@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix undeclared function 'barrier_nospec' warning
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>
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

On Wed, Feb 22, 2023 at 8:29 AM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> Linus,
> Since the blast radius is big, may be apply the fix directly ?

Yup, done. Of the different patches I picked the same location you had
taken so that there shouldn't be any conflicts if that ends making it
to me later.

                  Linus
