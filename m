Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312F66F713E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:40:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjEDRk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEDRkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:40:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34108526E
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:40:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-956ff2399b1so146325966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1683222005; x=1685814005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y2Hj/xXniQ3p/G8virxCDkuXfo6F0oMzvKaeNUWhIHY=;
        b=U2ENXljIbcgQ3YnBB1djs5gG4JF9It9eTDiUCbbFuJzvmex97yi/CQlJmD6Um175mg
         Nrb0pFhdrwAKQoWt552AeiLmv0dtvowmYYeer/IylYWTmEVs7Nyn6R8iDQkUXHGCgmyx
         lXpRuLTgDI5EvnMntZjKa4F6PKEGlNC1uqgWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683222005; x=1685814005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y2Hj/xXniQ3p/G8virxCDkuXfo6F0oMzvKaeNUWhIHY=;
        b=DMKHLrwH0CU3DNyNxCKPqi7pbMrKZXKSaSb2lQa/CCtXd36msjKdpNl+gXQPezD8Rx
         y3M2ONS/qpgFSXK+VPWKsUaqAQJHGD7sRpel5KC6oBdhQX4JKVjkW12/wTTS5zlqHc05
         ulxid8M+FCrH99PtkEwiKNw3QhI01vVozPgh2W1wQhmKCjMz/+2DgRDtv6MG6wV5VmAA
         Kqsis2aSqDVlxYxNaoCY23Adn1aW4w82zUpILLcAWunAtiUHtF1J8Uz3ukY+Czs98Kip
         qIQpBKQY60K8Jl2Ljn4Z93w0RjrfMSXhorpBw/S+yvutSLricxAGwKar6FCa4n195Atd
         MH4Q==
X-Gm-Message-State: AC+VfDxkHKV4FoiHv2/+VsQwfU33jZDAr86p5/nuaWgN1wQiIndbpsYT
        pjOfrL74IHVXE0mi3Q0cKYXNWmqK2EuVvrWPCaYRo2tU
X-Google-Smtp-Source: ACHHUZ43hTRq3zAtHrqRqGoc+n5JDlVVdHBlt4BYZ+CIF/fjw9fErQ0gaMXJ+fLqQHql5T1vWaBDjg==
X-Received: by 2002:a17:907:9302:b0:94e:cefc:8df0 with SMTP id bu2-20020a170907930200b0094ecefc8df0mr7188555ejc.61.1683222005465;
        Thu, 04 May 2023 10:40:05 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709070b1400b009658f5a90d2sm1758281ejl.189.2023.05.04.10.40.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:40:04 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-95678d891d6so146470666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:40:04 -0700 (PDT)
X-Received: by 2002:a17:907:1c24:b0:965:819b:1e73 with SMTP id
 nc36-20020a1709071c2400b00965819b1e73mr4458281ejc.59.1683222004473; Thu, 04
 May 2023 10:40:04 -0700 (PDT)
MIME-Version: 1.0
References: <202305041446.71d46724-yujie.liu@intel.com>
In-Reply-To: <202305041446.71d46724-yujie.liu@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 May 2023 10:39:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYqsXvK0zA0o061NSkc=dXX4LoP_4m41TyskN9RHrojQ@mail.gmail.com>
Message-ID: <CAHk-=wgYqsXvK0zA0o061NSkc=dXX4LoP_4m41TyskN9RHrojQ@mail.gmail.com>
Subject: Re: [linus:master] [x86] adfcf4231b: blogbench.read_score -10.9% regression
To:     kernel test robot <yujie.liu@intel.com>
Cc:     oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
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

On Thu, May 4, 2023 at 1:12=E2=80=AFAM kernel test robot <yujie.liu@intel.c=
om> wrote:
>
> Since there are both improvements and regressions in various micro
> benchmarks, we are sending this report to provide some data and hope
> this can be helpful for further investigation. Thanks.

Heh, yes. As that makes clear, the 10% regression on one load was a
25% improvement on another.

That said, while I was expecting these kinds of results, the absolute
percentages are much higher than I expected. I would have expected a
lot of "couple of percent either way".

Even with memory copies being as important as they are, moving the
needle by -10% to +25% is a much bigger swing than expected.

> Details are as below:

One of the issues with the details is that these benchmarks are
running on different machines, so there's a mix of

  Xeon(R) Platinum 8358 CPU @ 2.60GHz (Ice Lake)
  Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake)

in those details, and it might matter.

That said, the big picture is probably independent - both have ERMS
with 'rep movs' doing some cacheline optimizations, and the big
changes in the perf data is in things like 'perf-stat.ps.dTLB-stores'
and 'perf-stat.ps.node-store-misses' which is probably exactly about
that.

And I suspect that the 'blogbench.read_score' thing probably does
mostly big reads, and really really liked the cacheline optimizations
of 'rep movs' even when it was slow in other things.

Let me think about how ugly it would be to re-introduce that case just
for large copies.

                     Linus
