Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F674334C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 05:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjF3DoV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 23:44:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjF3DoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 23:44:19 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4196F2681
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 20:44:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-986d8332f50so167818266b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 20:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688096656; x=1690688656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DtdBcJGSafD9v1Gyc2SS9XYrmiGJVVhtneeuVwTi0t4=;
        b=MMKICGoQxSyosBvkESXPQp0shoQIMuWxB3nqsnT7wmyREw9srQKiXKv2yx/Xmf5asw
         FN6EeIEQKjwn6jw0mIKTUTMQq+jjO9jvF3aW8iJ0vCMbwXyude8HL4j222u/BXCvmRLd
         Ni7dVmF0G1TpKp3v4hX6k95xZON1IpGjOoU4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688096656; x=1690688656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DtdBcJGSafD9v1Gyc2SS9XYrmiGJVVhtneeuVwTi0t4=;
        b=WMURkrcU+O5E6FtigOCutfpZHynR5oKu6nsLChj9dLc1+V1LprCXoXFULhtNqIfcfw
         o+kCeCnw8UtsDDntCe7HXGcWv0Wte7kW3i0x2hVpvBlwDp9gb0CT8lYkLnv1cEdQBsUb
         dzwBCxY1wCU5WYdzu3MszpUS0oDgm7Nof1HG4cJSxQ0sDZzEyzMKfCpS8hCvikniLclk
         XwzZGrwY69HMmxW+Ve+uyQHUfGP11ntVxi4gug8fEIl5XktJFgeV1AX9vHtS+TPT0khQ
         EcRBt/1euCh6i2Y99x8SuWmWJqYpixY9xo96lTaQfkw9gwyLiBQGYg54oy1oD2I/2wNx
         Mnww==
X-Gm-Message-State: ABy/qLZ1ucvA5kwJeUWOBUlH32YLDb35RmH0izih06z5H2kXCarLr2mG
        EPS4/b58YGFYrwWpA01SQWh+E9x9uschC0iyBtlYZIDC
X-Google-Smtp-Source: APBJJlF6Af+NUAJ6TrRDg6EXTHjJqLQXv7mg/2ULi21Wg9Pk3Pvguhs5RkfhtnIUlrYF/aGTBv2RpQ==
X-Received: by 2002:a17:906:5f9a:b0:98a:29ca:c58e with SMTP id a26-20020a1709065f9a00b0098a29cac58emr946953eju.27.1688096656432;
        Thu, 29 Jun 2023 20:44:16 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id p20-20020a170906605400b0098ec690e6d7sm5929219ejj.73.2023.06.29.20.44.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 20:44:15 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-51d8fa4dbf9so1431441a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 20:44:15 -0700 (PDT)
X-Received: by 2002:a50:ef16:0:b0:51d:d48b:9978 with SMTP id
 m22-20020a50ef16000000b0051dd48b9978mr583174eds.8.1688096655507; Thu, 29 Jun
 2023 20:44:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230630125926.785699c1@canb.auug.org.au>
In-Reply-To: <20230630125926.785699c1@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 20:43:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wio8YpV0L2urem4ZoJJgnis0s=P=PmFgVGKLhR_6+ZvSQ@mail.gmail.com>
Message-ID: <CAHk-=wio8YpV0L2urem4ZoJJgnis0s=P=PmFgVGKLhR_6+ZvSQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the origin tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Thu, 29 Jun 2023 at 19:59, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> After merging the origin tree, today's linux-next build (sparc defconfig)
> failed like this:
>
> /home/sfr/next/next/arch/sparc/mm/fault_32.c: In function 'force_user_fault':
> /home/sfr/next/next/arch/sparc/mm/fault_32.c:315:49: error: 'regs' undeclared (first use in this function)
>   315 |         vma = lock_mm_and_find_vma(mm, address, regs);

Duh. Yeah, the register window faults don't pass the user register
state pointer around, and as noted in commit a050ba1e7422 those
left-over conversions were mostly done blind.

The fix is trivial - just pass in NULL for the regs pointer. It's not required.

Said fix pushed out. Thanks,

               Linus
