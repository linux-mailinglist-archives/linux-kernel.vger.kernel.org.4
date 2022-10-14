Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB865FE70E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 04:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiJNCji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 22:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiJNCjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 22:39:35 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B1B188132
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:39:34 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j4so5292271lfk.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 19:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IYcpGFYA4tlaPRplJh/qmchEKo1IP+Kds1bJAp9w+SY=;
        b=fRmXzLk7dLPUNleua18FGLEk5ALwx9DJvsr8rkWiR1BkS3XHs6CWrkA7JWX6FryhC3
         CZq4/IPfLhA/B0ZAgtVwgYrIb6dVmYfB3l6Ty/tg5UdPceyEI5gvhBxAgyFDUueX6rLQ
         ssuBorzVoD+wJum9hELvIZVe56ZdfL7Ox2PCdk9r2ipyUMesgVirfEv2rUtvYz9S7zm2
         0sD8J3Gyvy6ea/1O6QEOrWXINpqxYafFHWM+93EDjXdIQKWU7dNKat2PAbyf9lZu+YIc
         YOC5KR8wCkbFkNH9jLqSv2oAGiZq0GJ1+gfsqJmOnUXpG3U91lPRL2sMARk1cBqusXx8
         yg5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IYcpGFYA4tlaPRplJh/qmchEKo1IP+Kds1bJAp9w+SY=;
        b=DFoOyyHwGctjsolycl6gkwKkoAalmxT9tr+ayR8VJwZmfV5P1si4trtd9JtJjX/Yrq
         5idVk1csjQCN1HGxupO9REMsPlZBhNn09x3k8YaxrhN4gEoaQoJw8B9fCbVDMHG7pdi3
         TqcEtiT5V0oaKDsybPDF4hV6K+WgmFnsb8+OZ/BydQbd4m98xhDBoFQXciZVwt7+0pwA
         wU0YPzyZnY+OL5noght2bZdQlCwABbO387iSuQ1NNmhk0+rhppNfSj3vsJxQjvtDCDMS
         v0p0ZSPCDM9DxKSnjWKAgzYexA0JPzVvEaSU4TWQAt4Xi6lyW6WsnbSFmo2ERe4RPZU1
         8frQ==
X-Gm-Message-State: ACrzQf1gYY3EwtbfTplwPdE3RSCX0/byAwLk4xQrLVr0zWRFxBlbhbu7
        KW893/2l+7Rd84k1fmAQIFj1aXIeSF/Su2NpQEaK
X-Google-Smtp-Source: AMsMyM7gEL2DXqaawmEOk6tj1kIVwgaGbmN2kt1p2widEMWB+KPPfZjoEAZRrW0GlOGgWMBQ/GoY5QtPkwjgEpc2ETY=
X-Received: by 2002:a05:6512:2616:b0:4a2:1723:cf40 with SMTP id
 bt22-20020a056512261600b004a21723cf40mr973094lfb.354.1665715172392; Thu, 13
 Oct 2022 19:39:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
In-Reply-To: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Thu, 13 Oct 2022 19:39:21 -0700
Message-ID: <CANDhNCq-ewTnuuRPoDtq+14TCFEwUpyo-pxn3J8=x1qCZzcgKQ@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
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

On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
>
> I have a question about ktime_get_mono_fast_ns(), which is used by the
> BPF helper bpf_ktime_get_ns() among other use cases. The comment above
> this function specifies that there are cases where the observed clock
> would not be monotonic.
>
> I had 2 beginner questions:

Thinking about this a bit more, I have my own "beginner question": Why
does bpf_ktime_get_ns() need to use the ktime_get_mono_fast_ns()
accessor instead of ktime_get_ns()?

I don't know enough about the contexts that bpf logic can run, so it's
not clear to me and it's not obviously commented either.

Looking at some of the uses of ktime_get_mono_fast_ns() spread around
the kernel, some are clearly necessary (trying to get timestamps in
suspend paths after timekeeping might be shutdown, etc). But there's
also a few cases where the need isn't clear and I'm worried the
reasoning is because it says "fast" in its name.
  "Why stop with ktime_get_mono_fast_ns() when you could instead use
ktime_get_real_fast()! It's *real fast*!" :)

thanks
-john
