Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E636AE5DE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjCGQGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjCGQFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:05:19 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57144907A7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:03:36 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id i7-20020a626d07000000b005d29737db06so7456490pfc.15
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 08:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678205016;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MtdRNvUrdbSW35Pbg1JV1sS6c88t0x/0o2K8YaL2y8s=;
        b=HPL1zfpCG9Gg2fXBNJEmDbmuTnm5oxoQaYyzCrR+su2HC5v8YdKSxapt0aBdivlmWp
         YVqPJ2NxlC9mQHHQNJjkPQIrESHpxkcOtYrT1HtvQGyI9TxK4dVTuKVPwpvdpuDkgUQZ
         1CEJQ34gdxOEqDMagqB0xhEpEPMWsHGtPRlcQQj2TDitEkkYR8KRjin5En3/udUhkMmJ
         1ifucZSxXZ9qa37bXbmjNOsVL2D/RfkDN1oqPXz/ZEYKwwzauWOMDm6vGCk0fQ+AWgUo
         5wMcRf0dXxkqUF2+4Jq0Jv+KsC0NlIZ3sODvpiVcgc/tx4g9fwIXQg18mRKhugM0CsCR
         1ABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678205016;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MtdRNvUrdbSW35Pbg1JV1sS6c88t0x/0o2K8YaL2y8s=;
        b=cXFiB5ne0+wuq/Q0NUUICXw2uvsdCb5x3AYJcyXjcsWKbx/0TulY+hP+DLixgUe7Rj
         EqZ0ZhOzbz7lE971C0wB3z8ddy3iQ1vSvVeeEx61Ik61YxJCDs5HLlPOVJ/R5fLVszrj
         oJ40QuaHyktahMxEgcUAnZ7mMbJIAETn1RTfTXpvt3fCr9GONJAcgGEoM2kmpQqMKwgs
         shWL7GqmRgiYJNHckH9iBA6HMgCkkJUeUQMJgnqo15wXzX95MXBm1AG+5UsWDJaBMwhl
         WeJjhWOVbr/K1AAPGtZdLWa9U2pcQsFLIgW8Xz+e0fFx1K9S8Oe+MVdHbuMvoTc5V1fI
         EHxw==
X-Gm-Message-State: AO0yUKWrwTMBCFxSa3DoexSHKYcR6Lwt7ZhYQz2J9035BtDDY0Kw280h
        COf3uXRThnBPkbjt9RhtBORuWJWn6RQ=
X-Google-Smtp-Source: AK7set9zAK91judnO5Y2ew6Tpe/VZozIcObxh6e4aNlWQ7bNVPyBR6SFnGxOkNGmOsrKQddYehv5m70z6ac=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:4503:0:b0:503:a269:33b7 with SMTP id
 s3-20020a634503000000b00503a26933b7mr5558747pga.8.1678205015797; Tue, 07 Mar
 2023 08:03:35 -0800 (PST)
Date:   Tue, 7 Mar 2023 08:03:34 -0800
In-Reply-To: <CAD=HUj7P8XmWLVpwB_XABKT7GT1sLPRozmr=guVktOyk9R+3fw@mail.gmail.com>
Mime-Version: 1.0
References: <20230127044500.680329-1-stevensd@google.com> <Y9QjquvzoL7kKHWE@google.com>
 <CAD=HUj7P8XmWLVpwB_XABKT7GT1sLPRozmr=guVktOyk9R+3fw@mail.gmail.com>
Message-ID: <ZAdgVrkKKUNyLe8M@google.com>
Subject: Re: [PATCH 0/3] KVM: x86: replace kvm_vcpu_map usage in vmx
From:   Sean Christopherson <seanjc@google.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     David Woodhouse <dwmw@amazon.co.uk>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023, David Stevens wrote:
> On Sat, Jan 28, 2023 at 4:19=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, Jan 27, 2023, David Stevens wrote:
> > > From: David Stevens <stevensd@chromium.org>
> > >
> > > This series replaces the usage of kvm_vcpu_map in vmx with
> > > gfn_to_pfn_cache. See [1] for details on why kvm_vcpu_map is broken.
> > >
> > > The presence of kvm_vcpu_map blocks another series I would like to
> > > try to merge [2]. Although I'm not familiar with the internals of vmx=
,
> > > I've gone ahead and taken a stab at this cleanup. I've done some manu=
al
> > > testing with nested VMs, and KVM selftests pass, but thorough feedbac=
k
> > > would be appreciated. Once this cleanup is done, I'll take a look at
> > > removing kvm_vcpu_map from svm.
> >
> > Woot, been waiting for someone to take this one, thanks!  It'll likely =
be a week
> > or two until I get 'round to this, but it's definitely something I want=
 to get
> > merged sooner than later.
>=20
> Sean, will you be able to get to this in the next few weeks?

Yes, so long as your definition of "few" means 2-4 ;-)
