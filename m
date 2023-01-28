Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3E067F2A9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232159AbjA1AH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:07:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbjA1AHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:07:25 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C645286609
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:07:22 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id d10-20020a631d4a000000b00491da16dc44so2805339pgm.16
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 16:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uHsr2oJUItSi3vqA6tkcnF07ysr7z0zXfg4n2h1yTQE=;
        b=J1SQgyRtJK/Zu2QQvkc7mBgYGUZiPn1Bz8v0O2XcSB0lKHhi3LH3gZPTwN9nKQ/EWc
         cLS2uKCN+6G4VUH3++bNzvCPwhsLkIVT940ggF2W/alKMiAu+HK9S9DY637ZAbUPGhLS
         eyfyJ6ZtR1hbIJo4E+NwzZpsx4zz8FIoDofnMZSk0Kmb6/v902SXxTAYs+U0cvS4Fx4r
         YYDcTfbAsz2i51AWU4rgE2hs8KvEZs7a915gH7DybFRmprvfbeydswuWjiMKijDXS/fq
         hl/rZxwjQTUFyfPwrOlim7VK94WV/F2XxbjEaHy2ekTG9oV3gSypm9HLCZrEHYJezsfN
         RBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHsr2oJUItSi3vqA6tkcnF07ysr7z0zXfg4n2h1yTQE=;
        b=EyHJqY1ezdufiGB8bzlW/i4kQQdSUgPmBGo8v/8R283/+XX/UHRWvDfnBiX9FG8CLS
         fnEFYogFJAuKxzD3zQOv821leryYW46gE+ScZw3YLduGISCFxwRBRTX3pKlfEA0WNodF
         pP3HZe9zaZ5MPVS9KCKPRhp7QBP0oL1feVpu+GOT1fz6/urvaaXmbZzf2gx4Ely/cHnk
         DPX0oI+LYVlfvcP9eTCvpi56SKYa02mENbjLl/vHFls0WSSl0mKy4PsMLNxS84OTYj1f
         UQV+cOTK7m0q1mW3/XL4dtADb9AII1Q1xymFamZSYf0PvyHwfjOBMS1tXEbJ8A4/iS3r
         sWYg==
X-Gm-Message-State: AFqh2krVGCXbQqiI5Pqj9jEGSeo7YKAIjClz6eAqAjHQNNNQpul/UNj+
        Fe3GL2jhjdu5EuEW4SmuDHq4449oiFw=
X-Google-Smtp-Source: AMrXdXuvu1sGU1vYAwHwXwDXKHxOUXsgegJAQwa8tvXvso1A8LdaRdJsA6zWArCPjuoYm/jCvqWVi0rND9Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:b217:b0:194:7c22:1885 with SMTP id
 t23-20020a170902b21700b001947c221885mr4493000plr.26.1674864442136; Fri, 27
 Jan 2023 16:07:22 -0800 (PST)
Date:   Sat, 28 Jan 2023 00:07:16 +0000
In-Reply-To: <20221205122048.16023-1-likexu@tencent.com>
Mime-Version: 1.0
References: <20221205122048.16023-1-likexu@tencent.com>
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <167477056207.187359.3952314052374339122.b4-ty@google.com>
Subject: Re: [PATCH] KVM: x86/pmu: Drop event_type and rename "struct kvm_event_hw_type_mapping"
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Like Xu <like.xu.linux@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2022 20:20:48 +0800, Like Xu wrote:
> After commit ("02791a5c362b KVM: x86/pmu: Use PERF_TYPE_RAW
> to merge reprogram_{gp,fixed}counter()"), vPMU starts to directly
> use the hardware event eventsel and unit_mask to reprogram perf_event,
> and the event_type field in the "struct kvm_event_hw_type_mapping"
> is simply no longer being used.
> 
> After discarding this field, the name of the structure also lost
> its mapping semantics, renaming it "struct kvm_pmu_hw_event" and
> reorganizing the comments to continue to help newcomers.
> 
> [...]

Applied to kvm-x86 pmu, thanks!

[1/1] KVM: x86/pmu: Drop event_type and rename "struct kvm_event_hw_type_mapping"
      https://github.com/kvm-x86/linux/commit/4996f87f9385

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
