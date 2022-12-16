Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A3B64EE0E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbiLPPne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbiLPPnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:43:31 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C6819288
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:43:30 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c7so2948776qtw.8
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hRzoHlaRtllxxhng1OirGqerB1yq/2zcTl9e6GKVxwc=;
        b=HrpZgugAOFtKsf8qtT+VXBdNxUyebmbOvlKaLi1HMjNBPquPscP6ATHq9HVtqyopVW
         YecNb/5sx/H94gJwfmGP4iT9iBR+jhdqng3IVAGqEjoI2KskRTncug7A3UERFoPEdnSP
         eMmlUjifCCIxqHi05J2Q2SHmIvZPXBcaJKx9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hRzoHlaRtllxxhng1OirGqerB1yq/2zcTl9e6GKVxwc=;
        b=zZQlGjIwcPLfJ2lo6FUGSFweEdn3sZbza8jryYJ7H9Gzc6rA/cPNG7v5SdDjZIze1F
         MK4NCcqKZW4ew7h5JOqdtQa7osP+K7xC2emARcX2Jzro6JEynef+VK4IbPAG4cwC81rQ
         b0mIyPhtqAf7RrFAULDYuD+SQqz7LoQ4CAp026fxmo0bqDJx/nZ1kEFX6gv2cTetC5Ln
         XzsTvXpwGDeSKBezS3USlnk2T7oN0Uwd2jTkhBOkmHVsJzKOrwHkcmX9jd7+i9mfHoJ+
         mK8kkQ4Hl26SfHuRZJrmjKXgkKetb8xjZ9pztXE1PG5+AuQdLkRXdaR0XosBuwmO0KgN
         6ckw==
X-Gm-Message-State: ANoB5pmOAZWsIVhi3vKiylxFkbTyhVsj6Y96IxJZOkhBOqfC0e7A3fke
        v/m0NIzFsHMdiz1xSuQFx6Hmoxu7/l0EvnHq
X-Google-Smtp-Source: AA0mqf7HGYNniqmRC+0EMrd8vlLjNvPVJXwRBk17HJPoE4nFpO/SOW0b1kjLxccjdnGT+byfD6tymw==
X-Received: by 2002:ac8:7650:0:b0:3a7:e043:2d1b with SMTP id i16-20020ac87650000000b003a7e0432d1bmr45815442qtr.14.1671205408954;
        Fri, 16 Dec 2022 07:43:28 -0800 (PST)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id q56-20020a05620a2a7800b006fafaac72a6sm1686129qkp.84.2022.12.16.07.43.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 07:43:28 -0800 (PST)
Received: by mail-qt1-f177.google.com with SMTP id s9so2956684qtx.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:43:27 -0800 (PST)
X-Received: by 2002:ac8:4992:0:b0:3a7:648d:23d4 with SMTP id
 f18-20020ac84992000000b003a7648d23d4mr19721907qtq.180.1671205407691; Fri, 16
 Dec 2022 07:43:27 -0800 (PST)
MIME-Version: 1.0
References: <20221213174234.688534-1-dave.hansen@linux.intel.com>
 <CAHk-=wi=TY3Kte5Z1_nvfcsEh+rcz86pYnzeASw=pbG9QtpJEQ@mail.gmail.com>
 <20221215123007.cagd7qiidehqd77k@box.shutemov.name> <CAHk-=whC_ixb3FDdMhW_wiKw7-bB700kvUyqN+_cPUNp=1hNsQ@mail.gmail.com>
 <20221216021645.jn576zrhadocpt66@box.shutemov.name> <20221216150532.ll4oyff2tlrisqsh@box.shutemov.name>
In-Reply-To: <20221216150532.ll4oyff2tlrisqsh@box.shutemov.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 16 Dec 2022 09:43:11 -0600
X-Gmail-Original-Message-ID: <CAHk-=whjCVDeVa8jxEjnimfhKNnXiku7ku4NirmY+poKsnM5HQ@mail.gmail.com>
Message-ID: <CAHk-=whjCVDeVa8jxEjnimfhKNnXiku7ku4NirmY+poKsnM5HQ@mail.gmail.com>
Subject: Re: [GIT PULL] x86/mm for 6.2
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     kirill.shutemov@linux.intel.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com
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

On Fri, Dec 16, 2022 at 9:05 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> Below is preliminary fixup that suppose to address the issue. It does not
> include change to untagged_addr() interface to avoid the clutter.

Looks like the right direction.

And once you change untagged_addr() to take 'tsk', you should then be
able to cache all the information in the thread struct, and avoid the
'tsk->mm' dereference entirely.

> kthread_use_mm() should be safe as long as no arch actually implements
> per-thread tagging enabling.

I think in a perfect world the (few) users of kthread_use_mm() would
also just make sure they did the locking of thing, so that they can't
have that race with somebody that then would enable LAM later.

             Linus
