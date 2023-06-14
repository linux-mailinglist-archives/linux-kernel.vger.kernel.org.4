Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AF6724A45
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238772AbjFFRbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbjFFRbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:31:05 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1D210F7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 10:30:55 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-543a25df980so866050a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686072654; x=1688664654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dXKYuUg7HoIp7PZjxrN4e8/tttddAPBgDCmI9zzNWIM=;
        b=SdF8/Z8EJeQRk6nebFYNKI2ucCPZHcq5xy8rfaeU4njQPuJ7kQD4azGin/4+gcsoYN
         T9nCw0DFwLMYDwiicyCl+XEXq94tp9cQFrvkr7ZFTRPM/JB+daXfx0nXheK8kXrPF/dc
         /aC6zuULKdGJLxMhHBrUt+V4MzKkdO4sAQe+keAXvWNSCMaApSLvB3SBe+8DVBkjOYes
         P5hTSpCcJmIzeoyw+GZbX6//R83wPKpDiFqvMwtkpzDpUg9qrBi290KMuxvUwJuagkIm
         TzQoatrZ8G21t/ztprM6CizXlJOLzoQt+N/156P0Wvc97YTtFzZ242UvZXCanXGzqmri
         RQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686072654; x=1688664654;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dXKYuUg7HoIp7PZjxrN4e8/tttddAPBgDCmI9zzNWIM=;
        b=GT0QPJ7qLvT1vPfX+DGt/Arrw8Wl7FT7XLQ4422v3/pwKj2ho8BOVq5eZT3BbEp3Fe
         DaA2yxOEI1nCHly62Uh92UDM97/1mAv2Wv2HUP4OOwrVS1YdNGxpZz7EV0y5/OQKS28U
         CSY0qtpV9bTHCQoq7ibBkBmg/9icwzV3aGq80aWCO1zDMxbRjebDR3zXxtDy4Dy63vlL
         +2lihoywkPvFXRcjcyj5gx+hM+DnYW1/G13Aegk9rLa7t0DPeVTWriIecxvEFrfixT1V
         SB5vleUiCcSjMtPtU2+2zRdNI7102BFAcrqH/ogYA+nhGwY8/Z7RkRwVKd5BbceoPQ8E
         L4sg==
X-Gm-Message-State: AC+VfDyl+GEp+/oUztEcC5DG1g7q1Q4BQHnuYbIpb7blop8C/+R4oa4p
        +HnDYsHDKyUqWKvguGrFWd+HiVweEb8=
X-Google-Smtp-Source: ACHHUZ4i/DCFPvysT54z4dqzO5kTYCE62ZranopSaW8d8GEcgURpwx2SFcJj3U6mfewoMduvG5M7OXMP73Y=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:58c5:0:b0:540:ca81:4a1d with SMTP id
 e5-20020a6558c5000000b00540ca814a1dmr571812pgu.11.1686072654653; Tue, 06 Jun
 2023 10:30:54 -0700 (PDT)
Date:   Tue,  6 Jun 2023 10:26:57 -0700
In-Reply-To: <20230524061634.54141-1-chao.gao@intel.com>
Mime-Version: 1.0
References: <20230524061634.54141-1-chao.gao@intel.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <168607240700.1276728.3313479971658390819.b4-ty@google.com>
Subject: Re: [PATCH v2 0/3] MSR_IA32_ARCH_CAPABILITIES cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        x86@kernel.org, Chao Gao <chao.gao@intel.com>
Cc:     xiaoyao.li@intel.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
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

On Wed, 24 May 2023 14:16:30 +0800, Chao Gao wrote:
> Do some cleanups about MSR_IA32_ARCH_CAPABILITIES in KVM e.g, fix stale
> comments, elimite open-coded MSR reads, track features that can be exposed to
> guests to avoid computing them runtime. They are found when reading the code.
> 
> No functional change intented.
> 
> Changes from v1 -> v2:
> 1. toggle ARCH_CAP_SKIP_VMENTRY_L1DFLUSH bit when l1tf mitigation state is
>    changed by module param. [Xiaoyao, Sean]
> 2. add more cleanups (patch 2/3)
> 
> [...]

Applied [2/3] to kvm-x86 misc, no need for that one to wait for the dust to
settle on the "supported" snapshot.  Thanks!

[2/3] KVM: x86: Correct the name for skipping VMENTER l1d flush
      https://github.com/kvm-x86/linux/commit/02f1b0b73660

--
https://github.com/kvm-x86/linux/tree/next
https://github.com/kvm-x86/linux/tree/fixes
