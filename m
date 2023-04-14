Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DEE6E2B19
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 22:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDNU3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 16:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDNU3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 16:29:30 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEBC6E9B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 13:29:29 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-54f8d4f1ca1so102825517b3.20
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 13:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681504169; x=1684096169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DLToSh8SFFWLZRyFSn4i7JQlNzNszta4xTWyY36zPEY=;
        b=dpmv8GYPJG9Y6ih8+TvcQ+edTHglKG2Js/rYBcWjl6NW+0M+pqgW39ylCfa60dexZi
         DcikGg0YcUK//c4DDFSsXjVyBtKVstj55BDa4latJZZfT6BZXQdFKZur+CF1NiYnfv1r
         Ar3WhQ0JRYTCKTGlxXqJipp203cmSB1iWZAMC+pOHuds04YM74nbogb2hDxmdW8Ls8d2
         m25JHxXb9tbOm6r+h9sfHSfr79rvJoEqQ1bxRGN3yrhvn6941TNduBebF8CUwf92Eot2
         vkhRoqGuQW+iAMTUW+reMvp6CjV3n2Bx/CxA3aVlKcQjdI2FlYFi2kqbdG1tyYwGxr5v
         LIIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681504169; x=1684096169;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLToSh8SFFWLZRyFSn4i7JQlNzNszta4xTWyY36zPEY=;
        b=DVmyeMEY//WwBzRLWICOC/bZH5Lovp+ePdsXgaUw219ilHmb2Fvm4tNnS0C5jmZPcW
         1pUlYeIeBZhEfA6RY840eLyIVhU5iPIMARPjvv6Rjk0AM9FIOYswYa+S9L3GY0A4XVDi
         mxvHpjQkn8+Fjl9tweZJKgyXAmqyUdDYWlMBlfV6nTnzdZk/sAnbaLnHv2btnMf0dSFm
         JnNlUjCE//FjdRpxpOzYGGh4r9qUojYXwvGJaoocRFp6TItXDrpaaSMT5I4I/ZgLAqXT
         Uvrh34Nay8NBYP7xK1bW3ackwsQkWYkNZnA02hGVazbzMn8ki+Jdf6HTuLgz2ixrwFMJ
         ReUQ==
X-Gm-Message-State: AAQBX9f57gQH23aEH+VqLH36vI2y6MxYjzLcqiR544pZ/obwCfFNBPSB
        3AwAZSTIWBCemayO2Yf2SxM/54tYiwc=
X-Google-Smtp-Source: AKy350YGjJSkhSWbMFiapNaVp2vMMOdjYO4P14f48+AuxLsAITPxtQITPLvVcWwdaknrUYlaSrf7ZfMHlGk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:da0b:0:b0:b8f:6f3f:ed20 with SMTP id
 n11-20020a25da0b000000b00b8f6f3fed20mr2167663ybf.5.1681504169043; Fri, 14 Apr
 2023 13:29:29 -0700 (PDT)
Date:   Fri, 14 Apr 2023 13:29:21 -0700
In-Reply-To: <20230407233254.957013-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230407233254.957013-1-seanjc@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <168150370438.1550830.5816847574112858499.b4-ty@google.com>
Subject: Re: [PATCH v4 0/6] KVM: selftests: Add "instructions required" testcase
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aaron Lewis <aaronlewis@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Apr 2023 16:32:48 -0700, Sean Christopherson wrote:
> This is the selftests portion of Aaron's series[*] to fix incorrect
> "instructions required" counting.  The big change from v3 is to use a
> common struct to copy counter values to/from the guest instead of smushing
> the values into a single 64-bit value.
> 
> [*] https://lkml.kernel.org/r/20230307141400.1486314-1-aaronlewis%40google.com
> 
> [...]

Applied to kvm-x86 pmu, thanks!

[1/6] KVM: selftests: Add a common helper for the PMU event filter guest code
      https://github.com/kvm-x86/linux/commit/33ef1411a36b
[2/6] KVM: selftests: Add helpers for PMC asserts in PMU event filter test
      https://github.com/kvm-x86/linux/commit/fa32233d51b9
[3/6] KVM: selftests: Print detailed info in PMU event filter asserts
      https://github.com/kvm-x86/linux/commit/c140e93a0c11
[4/6] KVM: selftests: Use error codes to signal errors in PMU event filter test
      https://github.com/kvm-x86/linux/commit/c02c74428288
[5/6] KVM: selftests: Copy full counter values from guest in PMU event filter test
      https://github.com/kvm-x86/linux/commit/e9f322bd2396
[6/6] KVM: selftests: Test the PMU event "Instructions retired"
      https://github.com/kvm-x86/linux/commit/457bd7af1a17

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
