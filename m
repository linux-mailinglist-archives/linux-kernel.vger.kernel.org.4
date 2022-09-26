Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EFA5EB5F8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 01:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbiIZXsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 19:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIZXsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 19:48:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69391956A9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:48:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s90-20020a17090a2f6300b00203a685a1aaso8507630pjd.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 16:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1s21+lS83pLYX71MT6ciy21wLuhZLK05BQsfQd+BxjU=;
        b=rWDAcDvSW0v+juJ3nm6pam7AooYCMCOCr67yEk9YcFrj+sWW9936Gf94fSBBowmuvY
         BCSvQrh1dqZh+FoalwAE+3Q4IYrhHt8vHYgVbgC4qX8BeLMQJHQ9t+0DYhO+mV2jUqjr
         nz6YfTGuq2pXFQXgpbZVzGovkAus7n06jK/QxBBkk46z3ZODVL5BgaIcVt9JO+n2HLLh
         dAlKRqS/NrNl4k8iPGxTirTxFTpib2w1AsF6umgMjWlVz50HTusVnwIiIXK3G/d3kcVm
         xLyMVsc2DQhqJWlj7S/BJx6/Q39FsoSC32XgxxbWn5xo54upnrIG5VuV3no6JPpQ/91H
         yqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1s21+lS83pLYX71MT6ciy21wLuhZLK05BQsfQd+BxjU=;
        b=iKuZMri2p3rZyYFci+3DKHDUkID7sKWwLyryDjjXoDgUGpTPweH9jyQYrzsQQv+Yvz
         ivxrrhpEahlbDvJx6KWKULFG2oUy+agCfzUYZyVz88XE4cIB+xKzCvY8n89wM67+I+EC
         CXtozn0pWp8CEsFlpN0K0DAwIfCS9aePQoiZspgESctZBjMS35GGtywy4rexsNj81YuK
         r4aVg4ZMym1ARmZZ9hKkfYLpR9cIla30KFuaxgrs7qlYOdIBOd2MH6uzldgy0CEGSBCo
         eBidxtEyShKLWZ/lOXTw2exaiyXqWgQ5DJKgPhp8JM4ZVWwRRaow3upBYcxxFxGYE9Zc
         Kscw==
X-Gm-Message-State: ACrzQf3uWnU/NTinWLHXxDBLksonQ7lsrb5rpB+fHJxFPcWI0uPVhUak
        x3aT3siflcQd8n6WJFA9iSaQiP/FeEEHhS10OI+/aw==
X-Google-Smtp-Source: AMsMyM74skeRHgwTvpDtJqFStX8ZUG+H1vsGA7vXJ6ng3obEtom59E5zhyYrPrFGPrg18+9oa9lCONeI/VFTj6i2m5Y=
X-Received: by 2002:a17:902:d143:b0:178:456b:8444 with SMTP id
 t3-20020a170902d14300b00178456b8444mr24550422plt.137.1664236092737; Mon, 26
 Sep 2022 16:48:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220915000448.1674802-1-vannapurve@google.com>
 <20220915000448.1674802-5-vannapurve@google.com> <YyuEhxW4URWVvHyW@google.com>
In-Reply-To: <YyuEhxW4URWVvHyW@google.com>
From:   Vishal Annapurve <vannapurve@google.com>
Date:   Mon, 26 Sep 2022 16:48:01 -0700
Message-ID: <CAGtprH-YsgkeD2qpY4kRvhX=goRC20wzLPrEKHBVX73urhqh4g@mail.gmail.com>
Subject: Re: [V2 PATCH 4/8] KVM: selftests: x86: Precompute the result for is_{intel,amd}_cpu()
To:     David Matlack <dmatlack@google.com>
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

On Wed, Sep 21, 2022 at 2:39 PM David Matlack <dmatlack@google.com> wrote:
>
> On Thu, Sep 15, 2022 at 12:04:44AM +0000, Vishal Annapurve wrote:
> > Cache the vendor CPU type in a global variable so that multiple calls
> > to is_intel_cpu() do not need to re-execute CPUID.
> >
> > Add cpu vendor check in kvm_hypercall() so that it executes correct
> > vmcall/vmmcall instruction when running on Intel/AMD hosts. This avoids
> > exit to KVM which anyway tries to patch the instruction according to
> > the cpu type.
>
> Out of curiousity, why do we want to avoid this exit?

Referring to the patch set posted for UPM selftests with
non-confidential VMs [1], vmcall patching will not work for selftests
executed with UPM feature enabled since guest memory can not be
modified by KVM. So I tried to add a kvm_hypercall implementation that
will execute the hypercall according to the cpu type.

Hypercall updates in this series are done to ensure that such a change
is done for all callers to allow consistency and avoid relying on KVM
behavior to patch the vmmcall/vmcall instruction.

[1] https://lore.kernel.org/lkml/20220819174659.2427983-5-vannapurve@google.com/
