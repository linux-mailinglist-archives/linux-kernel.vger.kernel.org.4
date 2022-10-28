Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86749611B7F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJ1U0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ1U0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:26:42 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A385F1D3744
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:26:41 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id ay12so3551565qtb.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gTPXa66WScCOD+TihgL/pelOfuGybpZw4Q2zgEn6Uks=;
        b=axc9wCWQbNp9cqW208cThSPQcuPUVsA/Gg/sB6x4kEvy0MCwUDn+ZiUPD/NYefPwCR
         QWspaFxy1kcipJH1yuwnwVpIuMA7131f+fjZl9J5LuQR5Llv3GzbqeiBajePD9+hT660
         JZAa5bbWivuy5cu4qJu147E1UqC8BZaP5IGMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gTPXa66WScCOD+TihgL/pelOfuGybpZw4Q2zgEn6Uks=;
        b=FyhodqTxhD9xKyK0wvsL78/zt+8V7Kli+KWSXCz/negAjTT8r2T3bPFbVKNGXAZiQX
         Tgf3BQWk4ja0qSmUHZjH0jG9TfFrfHw+R/m6Lz1zqskIu9Z+f6JlzJV2ppEdNn/LoLE3
         6+qgIi7ZxUKii471G7+CUHVhWVlOJ6UORqI2bVPyP5b2TetXNv0yiLEio3s5rBp+8B28
         qIoJT3TkxqwUwR85rjfBfEOtbtRE1+JzzRapnNGfibPB+F9o1ITZBiO7+w3zB74nupHu
         61BtQV7fKr5a6LKIXqYVBKtbd7q55hoTnjaTrPRLnDV5SrQh08QgRN5+cYuvQHgiSX6F
         IURA==
X-Gm-Message-State: ACrzQf3zaGG52+s/GdsM8bldGV/axhZF5v0PgfFowUepVvI/SgPpi/9O
        rHmjc+IkgWqhVcLP+/lYMq72vR/ZZIFjYw==
X-Google-Smtp-Source: AMsMyM6aMenZvRB8RMWrE0su5lGhxpYfERIEmvhDwCfpEGt+uFBral5VvfSivo5f1aHYdVK4ufDDWg==
X-Received: by 2002:ac8:7fc6:0:b0:39c:fdf3:6540 with SMTP id b6-20020ac87fc6000000b0039cfdf36540mr1176392qtk.185.1666988800563;
        Fri, 28 Oct 2022 13:26:40 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a258a00b006ceb933a9fesm3669793qko.81.2022.10.28.13.26.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 13:26:39 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 187so7412411ybe.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 13:26:39 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr1075970ybu.310.1666988799325; Fri, 28
 Oct 2022 13:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <Y1wHlSE0S5QZ+QCI@shell.armlinux.org.uk> <E1ooSWP-000FDy-5t@rmk-PC.armlinux.org.uk>
 <CAHk-=wi63Sw3vNJ86gzg1Tdr=_xGwGyj+mH-eT0UgaAfGAHX+A@mail.gmail.com>
 <Y1wVTkIZjoMVfxOK@shell.armlinux.org.uk> <CAHk-=wh75aOWvaEhYsAcCJSRzhy8MO_SdvDzB6zmvVs+FeAr6w@mail.gmail.com>
 <Y1wxqPccRE+biAfw@shell.armlinux.org.uk>
In-Reply-To: <Y1wxqPccRE+biAfw@shell.armlinux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Oct 2022 13:26:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6KH0yK3EKEbnFCDgnD9prf3C8d9vQS0hadusR+EspaQ@mail.gmail.com>
Message-ID: <CAHk-=wj6KH0yK3EKEbnFCDgnD9prf3C8d9vQS0hadusR+EspaQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] ARM: findbit: document ARMv5 bit offset calculation
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
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

On Fri, Oct 28, 2022 at 12:46 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> You've missed how the min() is coded.

Yes, I realised that and sent another email about my mea culpa.

           Linus
