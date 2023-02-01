Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CE2679E5F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjAXQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjAXQQC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:16:02 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C53A303CE
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:15:57 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z13so15189920plg.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aPk9FnaXAHwLaHrt31b8O1lKJt10Zrrny18ftuYst2s=;
        b=LYqDojeaQHL2HoA1wSz+SoLc9c2QOrTIbQbIpqZSAx0eM0iHqcmd08JhEl7Ul7xxl2
         LYHVkfSXEDLeUavkJCPh3ZEVEG7VMDoYBKj4D05y10tV8KuLQHcxIjp+u24F5rSEyZ60
         RmWRMJ1tXGlBKA13FAcjpzeUrnZEknGWR7osSZ1nuuB+45ddbxuxvANrWwjG7nEKuHmF
         FNFwL/oxOqpa4kSMxKAotuetta/cCpRLo3sA46mrdUsw6HqEz8/AGoyM/UCyrNoHO5QZ
         UDlXj9vOygeANg/36j0R1ei2MNxbLDfxoE8jjSfH8lx87qrS1+E0AMXorMkFsOsnqq4O
         +HMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPk9FnaXAHwLaHrt31b8O1lKJt10Zrrny18ftuYst2s=;
        b=tiy1AWeUX6zkrGMfHByukwoc9p20zoRqHaDIeSMaWQjpJx6XzI20GDipa2lwJ3eYQP
         HcMPG8T3gYIiGearws2CqNunFhUWqneuQIS1Kts98yccgJv1QpXgSJSklQYPQr5OOEyl
         fxCjvM7wg+DEdGgA2WRIJtc8dO8SdfeWC0sLD1vCK7ee1/VUr8qZqwBYq2x+cyPjk+yD
         Sz3AI1lFQr7qaTRrl4jlS1lRApLLrLWX0qTo32K9YO9iirS7xttl/oqCN10qZG0pSk4Z
         4Azjtrb+BxQQUdEqypzXRwn/zULO9uUE+qc9rkREp9PhJMTfTnSk7VeicQrSp7sGMTf0
         tVUQ==
X-Gm-Message-State: AO0yUKXHDUJRFhFaTSNyb6+V7rk7h6xdqd2C9IeqOANqwVjw9pfi5X1E
        XMuQ3kdNV3tiTr8E80TIuvgqQQ==
X-Google-Smtp-Source: AK7set8JayVzD/gktjyzi9/78oGfLr8uiYVAMw/+8m3wzEK0vHjiGUPHfsfLpijOnQN0Uno91anBiA==
X-Received: by 2002:a17:902:74c3:b0:194:6d3c:38a5 with SMTP id f3-20020a17090274c300b001946d3c38a5mr175718plt.1.1674576956432;
        Tue, 24 Jan 2023 08:15:56 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id ba1-20020a170902720100b00192e1590349sm1833789plb.216.2023.01.24.08.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 08:15:55 -0800 (PST)
Date:   Tue, 24 Jan 2023 16:15:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Marc Zyngier <maz@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        KVM <kvm@vger.kernel.org>,
        Christoffer Dall <cdall@cs.columbia.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the kvm-x86 tree
Message-ID: <Y9AEOHooQhbpGFka@google.com>
References: <20230124125515.7c88c9fb@canb.auug.org.au>
 <86a628mi9q.wl-maz@kernel.org>
 <CABgObfZxjbG+ZofDPfOdiY_QP4j09XtTNwQVmGnbwoc+oaocxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZxjbG+ZofDPfOdiY_QP4j09XtTNwQVmGnbwoc+oaocxA@mail.gmail.com>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,GUARANTEED_100_PERCENT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023, Paolo Bonzini wrote:
> On Tue, Jan 24, 2023 at 9:47 AM Marc Zyngier <maz@kernel.org> wrote:
> >
> > Hi Stephen,
> >
> > On Tue, 24 Jan 2023 01:55:15 +0000,
> > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Hi all,
> > >
> > > The following commits are also in other tree(s?) as different
> > > commits (but the same patches):
> > >
> > >   0b6639e8ed87 ("KVM: s390: Move hardware setup/unsetup to init/exit")
> > >   0c2be59e0b53 ("KVM: x86: Use KBUILD_MODNAME to specify vendor module name")
> > >   1334f214d19f ("KVM: s390: Unwind kvm_arch_init() piece-by-piece() if a step fails")
> >
> > [...]
> >
> > > I guess someone has rebased one of the kvm trees and it had already been
> > > merged into another (like the kvm or kvm-arm trees).
> >
> > Huh, that's worrying. I'm carrying the kvm-hw-enable-refactor branch
> > from the KVM tree, which I understood to be a stable branch[1], and
> > which I merged to avoid conflicts to be propagated everywhere.
> 
> It wasn't 100% guaranteed to be stable because it was meant to be
> tested and have fixes squashed in. But since I had no issues reported
> from either maintainers or bots,

There's one issue, but I didn't explicitly call out that it could be squashed.

https://lore.kernel.org/all/20230119182158.4026656-1-seanjc@google.com

> I will indeed merge commit 9f1a4c004869 aka kvm/kvm-hw-enable-refactor into
> kvm/next. Sean, please rebase to drop the duplicate commits.

Will do.
