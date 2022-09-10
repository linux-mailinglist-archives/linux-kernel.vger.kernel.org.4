Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C955B4375
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 02:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiIJAye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 20:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIJAy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 20:54:29 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC5EC73
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 17:54:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n17-20020a05600c3b9100b003b3235574dbso2833706wms.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 17:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9Ztwre21GCjHUMNtK/HGLGU0r9pbtZVuDPqXh18HLmU=;
        b=Mycs5Q3nWJwijGxU5dJJMM01xHs05pLw7B8pR5B/w2Sga1p/Vkn3ykACVn7m4cco4Y
         Lzpl2NzhpySPA9DAxpqeJu4wuD7mxytxVBkLNlsBkczu5Ym3zaQDomXSiKW5gYGwjQjz
         8tgj8d/DDFQ1Hh2CrRHJbYaPp2yM9P3/nY/PLkTVBVTG+Z7DoCHLSjOYg1mqLwk2McCA
         ezyVNKK0ntE2GlCknqPhS+Eum/A7nOHAzrLYZn4G1eJK3KYLtDQNUG7oIwvmCSuErgCB
         qXvueN8T2ZHCeBZY7YeS6aUpe39VTTTTOy86gAGBRLLQ1fznPs4nxzOkUTGa6yosX91c
         qBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9Ztwre21GCjHUMNtK/HGLGU0r9pbtZVuDPqXh18HLmU=;
        b=FQr9eZFVGqWAh56rct73NmlM3K0l5Tt0UuOA4rAwfErlxdSoHRugh9btCM8//lc7Ku
         VPyWTfQMS5gscH4rosY2WBepY3BO7UZlS3dtaB+yr/W33EotSPnBLcbZ7ztHPg5/Jhwv
         3Zxx9uZlpuD3u4d8zoQ0YRsDY67Gh4j2rCgvk2NxBMMfL4Ixo1yBLN9SfOyxQZu/z13L
         lAoTpAju4xwu3zX4z0NLCUsHQClu7diAZ7UVjV1Vafan9B2gqebDs2mOPoBpNkeEFFiS
         mEKioX8dGu6/Mb+l/SaTFrQfVgFyYxfivOGWujt6J7YhSVip3s44OjxZX1T5y3gjupEF
         87LA==
X-Gm-Message-State: ACgBeo3BYjfoZqpXHHfRb/JmM5oqpgaofSs1MFc5dVik1cZ2F/Bwp6BL
        Vq6EKROzITdaIZsskVEq08ounbsV14xXz51PyUrUJA==
X-Google-Smtp-Source: AA6agR624o4oCcwoh88uEPgDcPoWpagjQc6CQZxPjnCtqdVZOBRCA8B81UqdQFycSdMhGHLLv/+SvTT389qF5e33GlQ=
X-Received: by 2002:a05:600c:2202:b0:3b4:6189:fc6a with SMTP id
 z2-20020a05600c220200b003b46189fc6amr2788680wml.171.1662771264775; Fri, 09
 Sep 2022 17:54:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220907003630.1115439-1-eugenis@google.com>
In-Reply-To: <20220907003630.1115439-1-eugenis@google.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 9 Sep 2022 17:54:13 -0700
Message-ID: <CAMn1gO4X93khAqOOvCJjWmm410rv8S5847GfsPckJwqtLSzc-Q@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: mte: move register initialization to C
To:     Evgenii Stepanov <eugenis@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Kenny Root <kroot@google.com>, Marc Zyngier <maz@kernel.org>,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 6, 2022 at 5:36 PM Evgenii Stepanov <eugenis@google.com> wrote:
>
> If FEAT_MTE2 is disabled via the arm64.nomte command line argument on a
> CPU that claims to support FEAT_MTE2, the kernel will use Tagged Normal
> in the MAIR. If we interpret arm64.nomte to mean that the CPU does not
> in fact implement FEAT_MTE2, setting the system register like this may
> lead to UNSPECIFIED behavior. Fix it by arranging for MAIR to be set
> in the C function cpu_enable_mte which is called based on the sanitized
> version of the system register.
>
> There is no need for the rest of the MTE-related system register
> initialization to happen from assembly, with the exception of TCR_EL1,
> which must be set to include at least TBI1 because the secondary CPUs
> access KASan-allocated data structures early. Therefore, make the TCR_EL1
> initialization unconditional and move the rest of the initialization to
> cpu_enable_mte so that we no longer have a dependency on the unsanitized
> ID register value.

Moving the register initialization to C also fixes a bug where the
kernel's zeroing of TFSR_EL1 has no practical effect when the kernel
is started in VHE mode because the register is currently being zeroed
prior to the kernel enabling the redirect of TFSR_EL2 to TFSR_EL1 when
it enables VHE. As a result, without this patch it is possible to get
a spurious KASAN error report if TFSR_EL2 is non-zero out of reset.

Peter
