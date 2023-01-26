Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A28A67D5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjAZUGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAZUGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:06:48 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750E4171F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:06:47 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id 123so3425642ybv.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 12:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kjtLi/8WKn2oW5QyDUOhA67hgly+UmbkPzhgpNv8AMU=;
        b=oH3bXQN+JoJrVUu+Bz51byhgL8DsonLwrvM3zDrglgjuerp6zGBifzPPKrO554Mgzd
         pc/nBHlOhF3mzB3iCssigSAh234VYPnccD4sFe5zf65HSpjX9uTG+SjVMHsBWLDHbEPJ
         88GjLBRCtx+6g5g3Uhg0EoLU2sLieJ1QyUCSnbInSf1ydeItkvirLZIf+dwIz7A5WF7z
         bFvFt6r315QxZFoH11EK/oo0z8VFmRtNj3LhECRcQpu3V2blKJGOTorbknjZ0AA5UB8S
         wMAgmR5jzmCfdH824v6Vy8MsfEMckIIylbhZV2gsgYfRaVmubSZm9OPymf9ZEWNgy8MC
         4sCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kjtLi/8WKn2oW5QyDUOhA67hgly+UmbkPzhgpNv8AMU=;
        b=SitEleXkV4vsZtk0N1GcH+PVIj5hKfP9suWLDTY8xXBjb9m4WeBg+4HjvE/JhSpuON
         UmS3bYt3lfrbOtGuLaaWLN3L0/KQQNWLA/tRSrtRcFQOBbKcy+X6tAeE91dUCex7cEwI
         MJSlRyBrjN5lf35Cl41lLtpbdk8rT7/OlXEYGv+vcBoxNHd4+kaIP7vEAc1kioEdbMBb
         W00fFdpOnGUouksAyf95HCoLX1k+Xd96USP6FWIBxDP6fyz0cEuD1XK+eJaWsAPcM85A
         jQu0dZbgFcwmhQhdCZf/diGWwMBdpmufoGTb6K0v+gTbiTzeAd+o8wxfSoEPQxr+5Pps
         MQ4g==
X-Gm-Message-State: AFqh2kr4v8jgD4vopMa70nRgN4y3IJ2XKSZIBTOpPh9Xp/745359/D40
        ouOxquNQVU4Xh7Zut7JyiP3aOSggLjesEwiSndPUiA==
X-Google-Smtp-Source: AMrXdXvulrX9qsSyygd1hulQLBBseHXK9nztfSRV2xngfTj5Kv9OdDT4Le8mrK95TeaxnpS6iQKCwUMin1YiuVJUDIg=
X-Received: by 2002:a25:6a0b:0:b0:7d1:5a92:eb5c with SMTP id
 f11-20020a256a0b000000b007d15a92eb5cmr4400549ybc.166.1674763606261; Thu, 26
 Jan 2023 12:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20230125182311.2022303-1-bgardon@google.com> <20230125182311.2022303-3-bgardon@google.com>
In-Reply-To: <20230125182311.2022303-3-bgardon@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Thu, 26 Jan 2023 12:06:10 -0800
Message-ID: <CAHVum0ex4=X_iD_hKMQAkNVEcVzZSNUb_V0ApjPKxpCX+oFV6w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] selftests: KVM: Add dirty logging page splitting test
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>
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

On Wed, Jan 25, 2023 at 10:23 AM Ben Gardon <bgardon@google.com> wrote:

> +static void run_vcpus_get_page_stats(struct kvm_vm *vm, struct kvm_page_stats *stats, const char *stage)
> +{
> +       int i;
> +
> +       iteration++;
> +       for (i = 0; i < VCPUS; i++) {
> +               while (READ_ONCE(vcpu_last_completed_iteration[i]) !=
> +                      iteration)
> +                       ;
> +       }
> +
> +       get_page_stats(vm, stats, stage);

get_page_stats() is already called in run_test() explicitly for other
stats. I think it's better to split this function and make the flow
like:

run_vcpus_till_iteration(iteration++);
get_page_stats(vm, &stats_populated, "populating memory");

This makes it easy to follow run_test_till_iteration() and easy to see
where stats are collected. run_test_till_iteration() can also be a
library function used by other tests like dirty_log_perf_test


> +       dirty_log_manual_caps = 0;
> +       for_each_guest_mode(run_test, NULL);
> +
> +       dirty_log_manual_caps =
> +               kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
> +
> +       if (dirty_log_manual_caps) {
> +               dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
> +                                         KVM_DIRTY_LOG_INITIALLY_SET);
> +               for_each_guest_mode(run_test, NULL);
> +       }

Should there be a message to show  that this capability is not tested
as it is not available?
Or, there can be a command line option to explicitly provide intent of
testing combined,  split modes, or both? Then test can error out
accordingly.
