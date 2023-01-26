Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE25167D8D7
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 23:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjAZWwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 17:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjAZWwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 17:52:15 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840294FAFF
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:52:11 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id u21so3273241edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 14:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SD82zOaspevOeEQSejLit7Cpr8ItbQ3l177ZqiVDG9I=;
        b=l2cTR5GvHjafqVlkULshyG2UOQvlK7gNKCsddxasD9Q5CqKTjbJeV6Or9PoNvUqUOR
         iRNPCEbjww9FyhiinNsNrab0bo9th0czPElOb4amSuP59GygH6zV4EESHz7gahNTbtxV
         46jZljQN07WDq63g2rWI/q9ikFHMo9FKGmKdysoXunxb3UNSiW3kXtx1X86BVixIMhMI
         6INJAYqSUtXIx7XJfckAcuat8bpOurLU4ZZLa4itenToV2q0hhqO4qGdJWQIBhyXEo4q
         fvHoKEA6awYHov2UF4RY/ske6jJRxg/5/3PDtZ6Ax3vWaFrf94Qwh8a/yELdP3gKrRki
         xdxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SD82zOaspevOeEQSejLit7Cpr8ItbQ3l177ZqiVDG9I=;
        b=MBaeT/3F92M5y2tOlqB3qxisWFnP1j3IVbu/ftBkw0T25+QnCMypLzUxiSqLoc10oA
         2Mk/MNpQHOw+H99BpXUh4tc4lYqPLeVxXSzpzZH+SOlUZsGz5Lmm+o03izX1iJmOQlCR
         Uy4sB+sjOesngggbb6+hmmiDVvgBNVJFcAY6OgXm/WHmo6LmF6n2kzlsBFey/0G1HVSL
         WN7KHnxxexaFGsUs51FWOXvGBoiQ7/PmjV1zeowcGpZY85RddE75F2ApE5iQGSlIKDUL
         TWI4yR10oxs69NoNmY9hUYKH5hMTsJXN+0U3ylZ8ja9fDP83q41L9K7E2pw1xp6r44U1
         mIyA==
X-Gm-Message-State: AO0yUKWVuqrbmPW/kusx7xsScRYg8YnnFFkd9DLHtzltaxTVS4yzBN5A
        /jz+oB8D5yXgvn3hEsw+EMoQ+06yBrE1/h7aG8ltRw==
X-Google-Smtp-Source: AK7set/aG0kyDBS7fu9lncG4okb27EHuK+a+OnkRlqr9bHmOPC1WhC7tosd/mQgklwxp1okhEZL05Xe0SWMyoKSt9dY=
X-Received: by 2002:a05:6402:524c:b0:49f:aae0:9900 with SMTP id
 t12-20020a056402524c00b0049faae09900mr2893943edd.85.1674773529883; Thu, 26
 Jan 2023 14:52:09 -0800 (PST)
MIME-Version: 1.0
References: <20230125182311.2022303-1-bgardon@google.com> <20230125182311.2022303-3-bgardon@google.com>
 <CAHVum0ex4=X_iD_hKMQAkNVEcVzZSNUb_V0ApjPKxpCX+oFV6w@mail.gmail.com>
In-Reply-To: <CAHVum0ex4=X_iD_hKMQAkNVEcVzZSNUb_V0ApjPKxpCX+oFV6w@mail.gmail.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Thu, 26 Jan 2023 14:51:58 -0800
Message-ID: <CANgfPd-7Yb05BYBW7TOg67qq=_vSXqrRQ_XF7WUfstQjXgyPww@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] selftests: KVM: Add dirty logging page splitting test
To:     Vipin Sharma <vipinsh@google.com>
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

On Thu, Jan 26, 2023 at 12:06 PM Vipin Sharma <vipinsh@google.com> wrote:
>
> On Wed, Jan 25, 2023 at 10:23 AM Ben Gardon <bgardon@google.com> wrote:
>
> > +static void run_vcpus_get_page_stats(struct kvm_vm *vm, struct kvm_page_stats *stats, const char *stage)
> > +{
> > +       int i;
> > +
> > +       iteration++;
> > +       for (i = 0; i < VCPUS; i++) {
> > +               while (READ_ONCE(vcpu_last_completed_iteration[i]) !=
> > +                      iteration)
> > +                       ;
> > +       }
> > +
> > +       get_page_stats(vm, stats, stage);
>
> get_page_stats() is already called in run_test() explicitly for other
> stats. I think it's better to split this function and make the flow
> like:
>
> run_vcpus_till_iteration(iteration++);
> get_page_stats(vm, &stats_populated, "populating memory");
>
> This makes it easy to follow run_test_till_iteration() and easy to see
> where stats are collected. run_test_till_iteration() can also be a
> library function used by other tests like dirty_log_perf_test

Yeah, either way works. We can do it all in the run_tests function as
I originally had or we can have the run vcpus and get stats in a
helper as David suggested or we can separate run_vcpus and get_stats
helpers as you're suggesting. I don't think it makes much of a
difference.
If you feel strongly I can send out another iteration of this test.

>
>
> > +       dirty_log_manual_caps = 0;
> > +       for_each_guest_mode(run_test, NULL);
> > +
> > +       dirty_log_manual_caps =
> > +               kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
> > +
> > +       if (dirty_log_manual_caps) {
> > +               dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
> > +                                         KVM_DIRTY_LOG_INITIALLY_SET);
> > +               for_each_guest_mode(run_test, NULL);
> > +       }
>
> Should there be a message to show  that this capability is not tested
> as it is not available?
> Or, there can be a command line option to explicitly provide intent of
> testing combined,  split modes, or both? Then test can error out
> accordingly.

Sure, that would work too. If I send another version of this series I
can add a skip message, but I don't want to re-add an option to
specify whether to run with MANUAL_PROTECT, because that's what I had
originally and then David suggested I remove it and just always run
both.
