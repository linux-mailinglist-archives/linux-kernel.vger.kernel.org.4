Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9309E6923CD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 17:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjBJQ67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 11:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232178AbjBJQ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 11:58:52 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5072795FB
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:58:48 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n13so4266537wmr.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 08:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bvBG9ca92jYkJz3+IO9cCEyUcRP6k+bZzqDzIUYmZjQ=;
        b=HK+qzuC5d2RclQ8Pm2S9sVWA2HP7CRYTtKiSJN8HKHhqUeZ9KShks13w8PUjOsVisy
         S5Pt+YtUcdwmt1K/dxY4FL0oB40ZzzHSxrRsayXxNF6BhIoEugtLe63kl6wZnf7376qS
         +NrlEsFk0CxxRB/sk7ikVZU1Cm2QdlC5Qpz7vkvXMjHKQzG0KYbtr7W4AgbAcSO1gkVV
         ZatsAG0RZ4ZP9QUoCoT6xk8j+4D2Spl4aV4qiQ/b7rxrG7njTd0bjXNjdXe8SgtYG2p2
         QWCxGvVALP34ApkjiBry/37Cr2C76CNCVlttTGZqvZDcaR4BiF69i5RV9WNfSRXLJOlI
         yIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bvBG9ca92jYkJz3+IO9cCEyUcRP6k+bZzqDzIUYmZjQ=;
        b=CpZCxRWuld50n+mtfvliqTuidcU/zfv9+SBoBtKLscJzEympnVuz0EfBAb5ssRmUyS
         bK7f4UaVQH0DImN8YTVZA6iUqES5AVFrZQ5iUfSHP1xQc6k4UBJfM8KYHpjLAy8FZBNE
         F6lWbPBoZyg21L9qojMtD5lIia3S04fFIYj0pJxxNu7mwLrOr2U6pv8H/GLf/D1O51OE
         LNKKHp0S90ORcAQ96ysM8GgAorVYbFgGRx3ATnNxmcyMC4aPEPX1fVPay4Up+BDSYRVL
         zRSCROrpClXla61+tzsQrOFxppGfo4ejWnGp8dSvnkrJZIXSeqOoHYw5OeNdq4jQeDk1
         geKA==
X-Gm-Message-State: AO0yUKWYFY+1RCIdauTjYHy7i07fOOMVhHWqjI1LEs+8YOPw4rgvuSU4
        CdltBNJ3YjZZKfdfuuHHsS8OpDpevdDXOcYw8WAeBw==
X-Google-Smtp-Source: AK7set8Gfoavx/5SCFT72EvQpyGbHidMzDJwPbirW66XrJirkHDkJTcACVpIH5e5LlQjObybnrdM2NGHuvBaDezUzvw=
X-Received: by 2002:a05:600c:c8:b0:3df:f29c:ec3a with SMTP id
 u8-20020a05600c00c800b003dff29cec3amr969617wmm.38.1676048327368; Fri, 10 Feb
 2023 08:58:47 -0800 (PST)
MIME-Version: 1.0
References: <20230126204444.2204061-1-zalbassam@google.com> <86fsbgyutf.wl-maz@kernel.org>
In-Reply-To: <86fsbgyutf.wl-maz@kernel.org>
From:   Zaid Al-Bassam <zalbassam@google.com>
Date:   Fri, 10 Feb 2023 11:58:36 -0500
Message-ID: <CALBRaFmj4Nvr=bjti+yCrRhtX61_aJhiCRDfbMJPLDhqVW8u1A@mail.gmail.com>
Subject: Re: [PATCH 0/8] perf: arm: Make PMUv3 driver available for aarch32
To:     Marc Zyngier <maz@kernel.org>
Cc:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, kvmarm@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu
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

Thank you Marc for reviewing the change and fixing the issues, I have
picked up your patches and sent out v2. Tested on Cortex-A32.

Best Regards,
Zaid Al-Bassam


On Wed, Feb 8, 2023 at 11:40 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 26 Jan 2023 20:44:36 +0000,
> Zaid Al-Bassam <zalbassam@google.com> wrote:
> >
> > Currently, PMUv3 driver is only available for ARMv8 aarch64
> > platforms, ARMv8 running in aarch32 mode dont have access to
> > the driver. This is, especially, a problem for ARMv8 platforms
> > that only have aarch32 support, like the Cortex-A32.
>
> FWIW, I've pushed out my own interpretation of this series to [1],
> including the changes I suggested. The results seems to correctly work
> in a 32bit guest on a 64bit host, which is what I (used to) care
> about.
>
> Feel free to pick it up.
>
>         M.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=arm/pmuv3
>
> --
> Without deviation from the norm, progress is not possible.
