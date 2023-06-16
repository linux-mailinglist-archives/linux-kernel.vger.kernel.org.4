Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24830733856
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 20:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbjFPSuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 14:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231308AbjFPSux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 14:50:53 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299AE35AD
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:50:52 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98646e2fc70so155860466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686941450; x=1689533450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Fn/qWt62UcmmaaPkId4UDrJc21A6804tWR7mlup1U/g=;
        b=bI88/h029pU5pmJdvUquADcF/Hv3Cn+FDaQYxd2XC5ACQIY2/p6Borz3hEMGKS2pY1
         cskFCeIBlU4rmEuhjDPFVQwO4Icz3Bmkli6V7si6jhkgRZJ3Rr7ZggEDy1IOLUDgpoy6
         3CgkFWXbuuL5mr2BHnEuOxuQolxs9qRGE7tlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686941450; x=1689533450;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fn/qWt62UcmmaaPkId4UDrJc21A6804tWR7mlup1U/g=;
        b=CPctbE9o+bdeucooHyVBxp2D9q5D8B5NjiCQ3t8N9U7TZrVmTFpglDKmeqM8LB3akR
         XS6d3ukYtgtzqVJlkeGlkg9hJ6Tc16jpHdC0piqHu5aECxRc8YFLhhyn3QinGKg77Fi/
         dur4z6rz3YCcnmzZ+1AYlLvkOWRdQertaJEbltMS3mnR9tDGRBFSuHIQFWMldRxbXd3I
         RJfrQffRaEnmUZpWwifrcJ4Qy+80fVafGgsZPtvQawtUKUzw8JVhpHuS1/6zGlME7aG4
         P3BG++COzMxqyAe9VagLHSU2GcUujVzYJ13clsDtttvy5Ri7g35P/T41yjshpuiXmy7W
         4McA==
X-Gm-Message-State: AC+VfDwymnobRMBNV0Oq6nhn8vd/L5uS0MnjyMeMwhXy8AN0nZ039br1
        IeZGGbX0UgI9kwvAyYSGefzE1fBFH65qppW086J8KPpO
X-Google-Smtp-Source: ACHHUZ4Ye5ZbsNSug9jbHG9gCHCfmLM9In0NsrfVUg4SnZsHD/zEENQI4jn2WSl1JKEwftNjdy+I8A==
X-Received: by 2002:a17:907:9703:b0:95e:ce3b:a471 with SMTP id jg3-20020a170907970300b0095ece3ba471mr3106171ejc.55.1686941450452;
        Fri, 16 Jun 2023 11:50:50 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id m15-20020a1709060d8f00b00982aa9db473sm2361530eji.55.2023.06.16.11.50.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 11:50:49 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51a3e6a952aso1015515a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 11:50:49 -0700 (PDT)
X-Received: by 2002:aa7:cf19:0:b0:518:922a:bc38 with SMTP id
 a25-20020aa7cf19000000b00518922abc38mr2364463edy.2.1686941448730; Fri, 16 Jun
 2023 11:50:48 -0700 (PDT)
MIME-Version: 1.0
References: <21bdc866-f9ae-4cda-a996-370bde183fd0@paulmck-laptop>
In-Reply-To: <21bdc866-f9ae-4cda-a996-370bde183fd0@paulmck-laptop>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Jun 2023 11:50:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiPA8d0z2K1huqP0jCKxfmjBG_VYnJtoADeQWsvWLv9UQ@mail.gmail.com>
Message-ID: <CAHk-=wiPA8d0z2K1huqP0jCKxfmjBG_VYnJtoADeQWsvWLv9UQ@mail.gmail.com>
Subject: Re: [GIT PULL] RCU regression fix for v6.4
To:     paulmck@kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rcu@vger.kernel.org, jonathanh@nvidia.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com,
        rafael.j.wysocki@intel.com, mirq-linux@rere.qmqm.pl,
        dmitry.osipenko@collabora.com, sachinp@linux.ibm.com,
        qiang.zhang1211@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jun 2023 at 09:34, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> Yes, it would be nice to abstract this somehow in order to hide it in
> SRCU, but I still don't see a good way of doing this.

Ehh - like we actually do spinlocks in general, perhaps?

Spinlocks always exist. On UP - with no spinlock debugging - it turns
into a zero-sized data structure, and the spin lock/unlock operations
are no-ops.

Why don't you just do the exact same thing with the "struct
srcu_usage". For Tiny SRCU, just make it an empty struct, with an
empty initializer.

IOW, don't "abstract it out". Abstract it IN. Make tiny-rcu still have
it, just as a no-op.

Anyway, I've pulled your fix, but maybe the above would have been the
cleaner solution?

          Linus
