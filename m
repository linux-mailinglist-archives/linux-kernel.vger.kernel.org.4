Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609E35E85FD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 00:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiIWWnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 18:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiIWWni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 18:43:38 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FDD13D851
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:43:25 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11eab59db71so2144611fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=kCgD34UU8ES5MVzzCYgU4UND5PZG62ntJ4PKktQ2G7g=;
        b=OzV7deYrp2xxMO6Y22c+5ayN670OcwA5ME+cynaHdFenNUNgqIsE9nGLtSkTbPwqYC
         euatWPFtXNbEMfiY1z8MBqRC/aoH7fIUuAl1mH317BtjLg4URMj+JTiedoLdGvhi7XJm
         jEZom03PA/NJ8w6rTUh5ci56Jixgekk4mC4+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=kCgD34UU8ES5MVzzCYgU4UND5PZG62ntJ4PKktQ2G7g=;
        b=fhkBBxu2jhNmv3/NKL789CnXTfU6qQOJql/e0+40unPm9RyzN8mWA3k+KTI0QNIgIM
         PRZvrBcJk1fPVuDm/iRDS4G2Nte2eap9MR5CllT7/UQJib9g3m5uwNdfOWmGEyXLdubq
         ONHrJvv4l+cUGznV377n3Elp9GU971T+kKI2xghA7IqPyeQRKvlpqSp1bSMbbOib87qB
         j0eJC/EeXChTMDt4t5XhHg118KGCPieLHFt2QCP0rSCn9PlD8m+ya8/tPcDebpyLqJWa
         mvk8H3agx2CIbt7QNSqjw5gdR0rPMWs53NnzlpLb0sceZ6W6rMKB0ZDrMMTGL8x0kUPy
         YkkQ==
X-Gm-Message-State: ACrzQf2dArH18HTfGl3AebDv/6B3LfdOHolsf05iKxQ87TuLFQnQ/kFV
        bIYeIsXqNQP783ZTlWqwlYfrr2e28Mm9pQ==
X-Google-Smtp-Source: AMsMyM5V4heda+Ms9bnegzRQqNYMrsGxdVCgot4eAujvKgzPFZpL52/c0n7MDYmU8WtHUxScOqid+g==
X-Received: by 2002:a05:6870:d692:b0:127:9458:3b71 with SMTP id z18-20020a056870d69200b0012794583b71mr12452072oap.58.1663973003246;
        Fri, 23 Sep 2022 15:43:23 -0700 (PDT)
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com. [209.85.160.52])
        by smtp.gmail.com with ESMTPSA id p6-20020a9d76c6000000b00616e2d2204csm4640753otl.21.2022.09.23.15.43.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 15:43:21 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1279948d93dso2147726fac.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 15:43:21 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr6281385oad.126.1663973001165; Fri, 23
 Sep 2022 15:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220923182800.GA14450@willie-the-truck>
In-Reply-To: <20220923182800.GA14450@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 23 Sep 2022 15:43:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjRtRUm4fkqTed+MKgDanxbAH_eePR_gh6iWXJvAXSdNw@mail.gmail.com>
Message-ID: <CAHk-=wjRtRUm4fkqTed+MKgDanxbAH_eePR_gh6iWXJvAXSdNw@mail.gmail.com>
Subject: Re: [GIT PULL] arm64 fixes for -rc7
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
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

On Fri, Sep 23, 2022 at 11:28 AM Will Deacon <will@kernel.org> wrote:
>
> Please pull these arm64 fixes for -rc7. They're all very simple and
> self-contained, although the CFI jump-table fix touches the generic
> linker script as that's where the problematic macro lives.

The commit message is a bit confusing. It talks about "hysterical
raisins on x86", but CONFIG_CFI_CLANG has always been arm64-only. No?

So I'm not seeing what the x86 comment is about?

Anyway, pulled. That alignment was obviously horrendous.

                Linus
