Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F154A7270B7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 23:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjFGVs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 17:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbjFGVs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 17:48:58 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E030B1BFF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 14:48:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb76a9831so11701117276.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 14:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686174536; x=1688766536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=24i4ZpInVA9Du9a9Xo0Uv6MiWYisMUzqAG7CEIdELlw=;
        b=JNOphaD6vaP2jz4GZ7/nvvTJ+7lf8NXrHCn6+xM7huMaIHaBzll97XCcOmWn2vCMhF
         TCMHu1r+1P8ywMiiMfOuLL/SvFz7nvRtuGzzLBdsDRdNxv7QKfGbJsxNJutv4ZgUx4Wy
         pqexacpZNlTNplJrhEs6G3pDORqKb8trSMnFtY9WpOSjcKHx2APiRuJGDC6f3taJLVRJ
         D9nwMXS/0r+oSLK6sAzUr9qjG76vPSgStCIiUsNfG8JlQDxMaV+LCE4eNUrZTsqtJAnQ
         UkkASsfCF7Tg2dqNkkxS50JIyxtif5ynw5Z5B3+kYrr5L/xsWpny6fvxOvyIjvf0WaiG
         B+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686174536; x=1688766536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=24i4ZpInVA9Du9a9Xo0Uv6MiWYisMUzqAG7CEIdELlw=;
        b=CXeInnz9pK9kFAESf/y4iA217I8c4DgVvUm+lcwEUt3sYiIV3fvsJNX88dcKPbLZPG
         PxU2cPZ2eqY0NuwfjSghcbcpLuNOA2eVo+A3e5QR4dqD69CZpu12plCbrpb3x2D+6IbM
         9yPQNtAGuVdg/38jYhhHqNO5CpuwoD6GaZBzALIBwney1XvVNUpecJ2w3KnKXS+lS25r
         DFCK0XNZh05KRWVdPo/+Es6h5hDDcZ1uqInCF9RUjSK7LNgLj8pcgQ6eZpZ0aYYLP4O2
         TjMvKrNlm2h8A1xbiQ/qUMZhY1dVbOYC9mf7tzXfw2zwJzxPu1VVUnPDDLp2Mxe33yn/
         ueFg==
X-Gm-Message-State: AC+VfDw5Odkx+AApDhWsjpJZ1pHtDJZ17fTOC7BdVCbSsGzcyCWiHoyO
        Gb8dO+YEetSgWvOIMCiG993v++jK9sM=
X-Google-Smtp-Source: ACHHUZ6+ybG/Ek3u5Dm2xCl7Ns7IwNNHmAl34QtjSmMPcBlQD4GKtKc2lihfgWUuI11fqdvKJU2Rv97Apv0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:7602:0:b0:565:ce25:2693 with SMTP id
 r2-20020a817602000000b00565ce252693mr3565111ywc.3.1686174536191; Wed, 07 Jun
 2023 14:48:56 -0700 (PDT)
Date:   Wed, 7 Jun 2023 14:48:54 -0700
In-Reply-To: <20230221082925.16014-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20230221082925.16014-1-likexu@tencent.com>
Message-ID: <ZID7Ro8vTnhAl2jo@google.com>
Subject: Re: [PATCH kvm-unit-tests] x86/pmu: Check counter is working properly
 before AMD pmu init
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> Avoid misleading pmu initialisation when vPMU is globally disabled
> by performing a read/write consistency test on one of AMD's counters.
> Without this check, pmu test will fail rather than be skipped.

This is unnecessary, the testcases can instead check KVM's enable_pmu module param.
Of course, runtime.bash has a bug and doesn't play nice with multiple requirements,
but that's easy enough to fix.  Patches incoming.

@@ -206,7 +206,7 @@ extra_params = -cpu max,vendor=GenuineIntel
 [pmu]
 file = pmu.flat
 extra_params = -cpu max
-check = /proc/sys/kernel/nmi_watchdog=0
+check = /sys/module/kvm/parameters/enable_pmu=Y /proc/sys/kernel/nmi_watchdog=0
 accel = kvm
 groups = pmu
