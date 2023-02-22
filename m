Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE94569FC20
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjBVT2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjBVT2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:28:19 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A321A492
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:28:18 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-536a4eba107so103912877b3.19
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1ncgyXSBsgJeq7wrxsMy4LqhbZKIDHoclZTNSNLUENI=;
        b=lPp3P/+jAqBvgQohTYmTDD0TAQQX8vElx+SGA/Fdjpqpgp7X4ZXAkUUWiwp2DNFT3X
         GqB559DmNdRCk/fizAD3aSPNa9ZdtOrDO1fqiBLbp5FhmgOyzBznOvh2//7F0L0rrTaf
         ADY3pMXCuIPU6Bwv4GP4ZGhYHCN2PdfHnbWI+dFzcbAtLVrYHjEk7bIS1U9sAoQeEfL5
         LK3y/wuYUVlFNRWsnGRbZ0Iq76k0HJ1OG/na75dFBnYikMRq9f1ZA2bHba4++hOCEHqG
         YxBRwMkxGfkslTEmPOBEhz35wceGoIQttwp0eQlUQDiFj/LwDawGyXUf6BmRdbj6apn4
         A54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ncgyXSBsgJeq7wrxsMy4LqhbZKIDHoclZTNSNLUENI=;
        b=Yh5vuDaWOQcaEc+h7SYIoJtbT4YBSr6hzsKyQz4dBrT3uYxJiXiHBBwmFmH89rEwv+
         lJ7noh5pvbBhKGUf5oHAOq5pPuGOmH3E5uAoDdxs5D170sjdwEy5V+c7mITgnMc8CFm4
         bavzOScw1N58tBeZuUiBai6xAIgXZKq5Tf9MrzIgTfqK8YaATEAl7F9pGrUBy4C75Lia
         2Xse0uYLSEyjcCRkeXLukGTlCFhL+T5wptEA48P330MmzcF2ENn1w4reZt+KAAXEMG8Y
         CCOjkQvxJTWr2oekfmBA+13VvGvGOIqbbN9x/079ozr+gSSR/22jwTDm9lZ1kaev9vLU
         WlMg==
X-Gm-Message-State: AO0yUKXK9FRwqiGAkEjrNveVZSAzOiJhPPgYt9utyNbb6h6iE2EfovZp
        uyItWSqfZqxJeNl8PewJIkhntBGnXQU=
X-Google-Smtp-Source: AK7set/migc9eZDF9Jt8DO4SyvFLBdhry2B2rzLsJS06zwAZEaYvIiX2Jf9s9qcrBQhnsS38/zTdxuNH4GA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:df82:0:b0:527:ac6f:625b with SMTP id
 i124-20020a0ddf82000000b00527ac6f625bmr1330959ywe.431.1677094097863; Wed, 22
 Feb 2023 11:28:17 -0800 (PST)
Date:   Wed, 22 Feb 2023 11:28:16 -0800
In-Reply-To: <20230222082002.97570-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20230222082002.97570-1-likexu@tencent.com>
Message-ID: <Y/Zs0M48SnI1WMCr@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Apply event filter mechanism to emulated instructions
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinrong Liang <cloudliang@tencent.com>,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> The check_pmu_event_filter() prevents the perf_event from being created
> and stops the associated counters from increasing, the same check should
> also be applied to counter increases caused by emulated instructions.
> Otherwise this filter mechanism cannot be considered to be in effect.
> 
> Reported-by: Jinrong Liang <cloudliang@tencent.com>

Already posted by Aaron[*], but I don't think there's been a follow-up.  Aaron?

[*] https://lore.kernel.org/all/20221209194957.2774423-2-aaronlewis@google.com
