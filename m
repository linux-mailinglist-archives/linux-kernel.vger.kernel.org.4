Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D48DF5EB5FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIZXyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:54:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiIZXyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:54:06 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A321F96FD6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:54:05 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id e81so10307966ybb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HwKLS+p+kzaLysWHkGSka85DTvLRdK+675PcR0q9v3w=;
        b=pm0ElfRJfwGKSuhNjHi2Hrm6ChvnLcu8n9EQR2swES7EBtcz6U72fX3JbsrJXY9g6Y
         eqNib96zQ9YIvlGADNXevxAeyvbZ7zZncUvNb5gHxAmFwpC4+UK3a5/WkWNJ+SzZ4947
         FuQ4zyIG8xJ7t3NkEWR3gI6EygLJVRCKL4NonduFnmLPEu66SSPcwShT2tMmhOV24CJp
         etvD8mJ7Lh8NZbOhd/w7VUECgt46pLy7mLS2h+TXGHGgftLAyWrv50Gwc80LCwhV0byJ
         cDCbcJHqr+aFEyRfOMQA9xCYVaTXoCSXL2zwfJ0usep3SFk+IvKeStX9PaeEKRSp7s7G
         2jxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HwKLS+p+kzaLysWHkGSka85DTvLRdK+675PcR0q9v3w=;
        b=sJH1kxQPkIkxMiWSCvxDnaYVfAcJEuAnQAx4T5wlf46ya99cpS9m/paGFI5Zwt6u0W
         HioMnPGWETA4u3R1vl9yKFzViY5gn9OPpwX9Aily3pyqKnifnGhfuZ7exZdPKOrs8kGV
         sJpzwMSzxOtvi0bry9DTKX7caj1VnkwypolkBz3tzN23GBZDApwh+QGnARUTqGDE3wfC
         GPmcxPSMZ+YIz1AMa4+37P85xXz3VzvBoa018jid4ljRryRY+iqxCV3uPmxlpUNpd2/f
         7mGHTnB5n7KsFHzcaWPBcTW1HWZTulWeKss8I3rLqdsGaFVue80M8E6735VkU9xGUn9D
         IyHA==
X-Gm-Message-State: ACrzQf2X/TocvdVbEIniXhiRojU6lAvVvrlaMdFJIpI6Oc4/bFotJZWP
        sn2kdq3pbQ/1LfjlogfwG+5GOahipeBet8fr9oe8LA==
X-Google-Smtp-Source: AMsMyM5d1u3qvJiaXnCTboC2C1dkUPnHl5oQjUdRN08V2TQJKfzcOVQuGaTUUx0kZUjMHA4xDwlyeKtWBVza49Aqisg=
X-Received: by 2002:a25:4fc2:0:b0:680:f309:48e5 with SMTP id
 d185-20020a254fc2000000b00680f30948e5mr24258349ybb.0.1664236444719; Mon, 26
 Sep 2022 16:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-5-vannapurve@google.com> <YyuEhxW4URWVvHyW@google.com>
 <CAGtprH-YsgkeD2qpY4kRvhX=goRC20wzLPrEKHBVX73urhqh4g@mail.gmail.com>
In-Reply-To: <CAGtprH-YsgkeD2qpY4kRvhX=goRC20wzLPrEKHBVX73urhqh4g@mail.gmail.com>
From:   David Matlack <dmatlack@google.com>
Date:   Mon, 26 Sep 2022 16:53:38 -0700
Message-ID: <CALzav=eyYN=EX0mJGc5p+jybJygxtXyXSwUb0UEsVt0YzSng5A@mail.gmail.com>
Subject: Re: [V2 PATCH 4/8] KVM: selftests: x86: Precompute the result for is_{intel,amd}_cpu()
To:     Vishal Annapurve <vannapurve@google.com>
Cc:     x86 <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Oliver Upton <oupton@google.com>, Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 4:48 PM Vishal Annapurve <vannapurve@google.com> wrote:
>
> On Wed, Sep 21, 2022 at 2:39 PM David Matlack <dmatlack@google.com> wrote:
> >
> > On Thu, Sep 15, 2022 at 12:04:44AM +0000, Vishal Annapurve wrote:
> > > Cache the vendor CPU type in a global variable so that multiple calls
> > > to is_intel_cpu() do not need to re-execute CPUID.
> > >
> > > Add cpu vendor check in kvm_hypercall() so that it executes correct
> > > vmcall/vmmcall instruction when running on Intel/AMD hosts. This avoids
> > > exit to KVM which anyway tries to patch the instruction according to
> > > the cpu type.
> >
> > Out of curiousity, why do we want to avoid this exit?
>
> Referring to the patch set posted for UPM selftests with
> non-confidential VMs [1], vmcall patching will not work for selftests
> executed with UPM feature enabled since guest memory can not be
> modified by KVM. So I tried to add a kvm_hypercall implementation that
> will execute the hypercall according to the cpu type.
>
> Hypercall updates in this series are done to ensure that such a change
> is done for all callers to allow consistency and avoid relying on KVM
> behavior to patch the vmmcall/vmcall instruction.
>
> [1] https://lore.kernel.org/lkml/20220819174659.2427983-5-vannapurve@google.com/

Thanks! That makes a ton of sense. Please include that in the cover
letter and any of the commit messages that avoid hypercall patching.
That will help reviewers understand the context of why the changes are
being made, and help anyone reviewing the git history in the future
understand the same.
