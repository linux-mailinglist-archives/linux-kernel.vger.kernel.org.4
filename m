Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7296C20A8
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjCTTAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjCTS70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 14:59:26 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090F038B6B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:51:17 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id 16-20020a056a00071000b00627e9b4871eso2971698pfl.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679338273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cwkFpfls1/6cud8wVygwf0ElwmaxIhRMsIsiLVuOOos=;
        b=Dayu5fXCeLh47JsqiwpPciLjIjD3C0AAkOu61sC4pfDZuHIdddVPd9TBc7TrdvKaDs
         AesZNjWXlmN17p9fJyicCR9PmN9TQLMNsjZAaVj6jTeOHDai4456vD8cPE2gsFgNtmxw
         MzLQI5orQwtXhkBsCWC3pR7sKeepT8ci/xa4MND7VukYX7sfxi239uHpFR34abjq/95M
         4XZnLldT8gzO0pK1If53cNhanwUlb7QHf6h6SBOtG31tWABLvD3h9NVEKsDZUKJFCIGQ
         QorZSyegkyPc7JEL7Q6IjXeWMxAws8+jXaQmACJVt+bHpvkmMe+hLyjiIpAR/vKXPk5Z
         tyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679338273;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cwkFpfls1/6cud8wVygwf0ElwmaxIhRMsIsiLVuOOos=;
        b=nuQa5zlmuFKIbXfYgdegFD3dq6/g9l/Ci/U0aILVzXpXaLos36QliEDKs5HhtxPUZi
         E0plm1Mee8uR153ZR2xFc6ORTZJ0RXbZqCtp8or+wOlNP+eZMOhD4d7I5pRlCCqejWPU
         T1RiQtIl9HXqrSBOkXz3mRi00Z8AXXk2pINQfJAdlhSDWY8Ybzsg0m+JOtCmf3hucn4p
         9K4xR5r+7EMPUxjHM+jHaguyIKadPx9v40qFU9d4bQwcmBMk9pO1qXpmoMYG3CJU/+TR
         BWWZBJi1xsiV3+Jzw1sO6NTxdezzGW+Eb0Squ6YjDmueIjgtzC8fZykiZnwPH9CzFD3/
         hwUQ==
X-Gm-Message-State: AO0yUKXTdCz6qb4u61zWKJ59Mne2TS2izA/hWdiiKtoUyHwE1874oHmE
        FB8J2SNl1dxQhNZ2YSEN0Rr2z0CFI1U=
X-Google-Smtp-Source: AK7set9SaMo9esIin3QfhGtaAPr+Taa8pf+AmaYxRZlcsspkh3rbeDuEeWeqSJzmoNUbCuc7Is5QXPbYerU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:69a1:b0:23f:695a:1355 with SMTP id
 s30-20020a17090a69a100b0023f695a1355mr60129pjj.5.1679338273401; Mon, 20 Mar
 2023 11:51:13 -0700 (PDT)
Date:   Mon, 20 Mar 2023 11:51:11 -0700
In-Reply-To: <20230202182809.1929122-7-bgardon@google.com>
Mime-Version: 1.0
References: <20230202182809.1929122-1-bgardon@google.com> <20230202182809.1929122-7-bgardon@google.com>
Message-ID: <ZBirHz+aQJHxvuV9@google.com>
Subject: Re: [PATCH 06/21] KVM: x86/mmu: Get rid of is_cpuid_PSE36()
From:   Sean Christopherson <seanjc@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Vipin Sharma <vipinsh@google.com>,
        Ricardo Koller <ricarkol@google.com>
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

On Thu, Feb 02, 2023, Ben Gardon wrote:
> is_cpuid_PSE36() always returns 1 and is never overridden, so just get
> rid of the function. This saves having to export it in a future commit
> in order to move the include of paging_tmpl.h out of mmu.c.

Probably won't matter as I suspect this series is going to end up a burner way
in the back, but FWIW I'd prefer to preserve is_cpuid_PSE36() in some capacity.
I 100% agree the helper is silly, but the mere existice of the flag is so esoteric
these days that I like having obvious/obnoxious code to call it out.
