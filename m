Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E3E69FD12
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 21:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbjBVUi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 15:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbjBVUiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 15:38:24 -0500
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8985320546
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:38:23 -0800 (PST)
Received: by mail-vs1-xe34.google.com with SMTP id v27so3338331vsa.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 12:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fJA+zsV5qSI969tpBcyTL/lOhAe4Cm1NTxwtEEPwLq4=;
        b=Ap/awrE5ww8FZCPqktvkKgsdbcE4W+6+GQRZTqTPzov3XYs3ZK9nzb/4WN03HEn2P3
         GEr2CQJHDhqBTCyJNliPrxviYWshlR/ntb38rQLzZQc1KJmYY2nUHexboQWXteayKos+
         NI31DtClN0OSVw9H5VOD5OULWuuAP42LTWEpt7Fz8zXZ+v9GQMAvvocsUIEcANob1g7K
         XREDdpeFUhM47Sil/CD594FRUqlHyDG5LM98kPlw+S5uFL9SgWZvL5RBF/c+s3xGkPJd
         yuMcBHVQ+D8WUECMY2uf4pxziBn/kGEDralzs9uWwfjaxPuJGzXDvGB2ytYbRpjxnpi/
         mh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fJA+zsV5qSI969tpBcyTL/lOhAe4Cm1NTxwtEEPwLq4=;
        b=qaVp16eBegpDP+TKy+oZry55faF5jqwnWcWjqofsL9Nziq8+NwiADopK0yF4novGth
         c13wFUvydzWJJkgcxoZm2YblFY2mUZN2yvKgvtBCgm8BTRfLGmIDy7iAAAHkWj+82XMn
         T/StpPa/KIe3fWNBa5eZHQggVOwCxg1hb8gy5mjqi+qFJrc59DDYVxyESM7dOt61Fo66
         a4EVu9oXFqeuSRMuntsvZpchkr1tQiQYazevEmx1G8YGmiwEgWV8rSeTwOLx1k/AM0Fa
         nlyfDFt9n4T02yun6SVw3+oPyEgM5A0KkKIOOHdMhV2VnHpyq4R5rBal0WJF7pen5U71
         t5WQ==
X-Gm-Message-State: AO0yUKVoaiB/KAbWcRzlr6v53kZp5wyrsJa5skJ8gS8GQFYHWbJd/Kel
        R6lr868yY2/oQ62cm3SqZ8XOHFCkvofiLoVacCiFCw==
X-Google-Smtp-Source: AK7set8zzhIf13VQwYICChL7PvhGLC/k97spvzngGKKEN51DOdb23UFPOp5vou5/VlCAxlHOtApRv0aIE8sd1m4sz6Y=
X-Received: by 2002:a1f:3184:0:b0:410:258b:94e6 with SMTP id
 x126-20020a1f3184000000b00410258b94e6mr1028363vkx.17.1677098302365; Wed, 22
 Feb 2023 12:38:22 -0800 (PST)
MIME-Version: 1.0
References: <20230222082002.97570-1-likexu@tencent.com> <Y/Zs0M48SnI1WMCr@google.com>
In-Reply-To: <Y/Zs0M48SnI1WMCr@google.com>
From:   Aaron Lewis <aaronlewis@google.com>
Date:   Wed, 22 Feb 2023 20:38:11 +0000
Message-ID: <CAAAPnDEHj8mqRp3mx2grOjR2EbgicHO7OR0-XSguJ7TSix0Mjg@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86/pmu: Apply event filter mechanism to emulated instructions
To:     Sean Christopherson <seanjc@google.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinrong Liang <cloudliang@tencent.com>
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

On Wed, Feb 22, 2023 at 7:28 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Wed, Feb 22, 2023, Like Xu wrote:
> > From: Like Xu <likexu@tencent.com>
> >
> > The check_pmu_event_filter() prevents the perf_event from being created
> > and stops the associated counters from increasing, the same check should
> > also be applied to counter increases caused by emulated instructions.
> > Otherwise this filter mechanism cannot be considered to be in effect.
> >
> > Reported-by: Jinrong Liang <cloudliang@tencent.com>
>
> Already posted by Aaron[*], but I don't think there's been a follow-up.  Aaron?
>
> [*] https://lore.kernel.org/all/20221209194957.2774423-2-aaronlewis@google.com

There hasn't been a follow-up yet.  I'll try to get one out in the
next week or so.
