Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C839D652628
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 19:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbiLTSYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 13:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiLTSY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 13:24:28 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A216264
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:24:27 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d7so13086744pll.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 10:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o7XRAbsxNuIYu3KQ5/USPQPXIGs2guhsK+wps5cunj4=;
        b=GFCimm18q8wY/9h430uhcQ/hM8cVruVSMQMNt0m/PbuC/5FH4uhgVLM3NstUsLhseA
         inMCDdiG1w/UBbL6GCuSN+smbrRnGLJX+biDLLQLpVpFUQPJ/36H2gXGI8r8Jz16RVT0
         bSPPSNv9Oh8RuRRZQrmkDdIhGlPHMRYR95WxGg4Vo8abdwPGhNV614fX5CRqduKkayaY
         y8hC7XN5a/qWk2WGm9OuDjw8682vSrRI6aIa4mBb7mXiOd2beZi3c8gCa2hFkl9pTR7h
         6+xPm/KVF9dkZNMGJJusIB2Hf7k8zZABDTDYrqx8DGHuf6t3TtLtlR6n4fd93OTqfGcz
         926A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7XRAbsxNuIYu3KQ5/USPQPXIGs2guhsK+wps5cunj4=;
        b=Gre0kEO2JheRvWO/1TRuISs1FZvXLi8woWR4TD54uNKKI3qWjyC9ljxZkQCMkMcYik
         w00qcVO/Jy50PkzN2zUHU8BDxCy+HBqD9qfrS0ViTZE2+ZVu7TwAHw6zCB4iLXCVTNTQ
         saR14GC3hKNPszrHtMtmJyslgdydpnwSJj6vqmhW4SVpS5fCEu6hIP6ASUA4mWHOsaI7
         uE0Q+iJFg49Hsc6E/Siya9iVffuxcJiYIobVf9E81tS0Q8/v7SY/jp8Mtcso2+xNb+g9
         fvJLn2dGRXxtB/yUSYtP+zHf1Cm8f/YPEQE+QvreP/AmQJaqPgWLPAaDh9qC2NAblyJz
         FmUw==
X-Gm-Message-State: ANoB5pmjDabXd0lvssgB5YX0m9/L+VZUKf0q6U7KkaaSkzSvvvNg6xRi
        1s7WTgXehauXNwxqIOM1uHy6RA==
X-Google-Smtp-Source: AA0mqf7WGh5q57NqYW/sta5mWz33Ig1/oATnC1/Qe4LITz31fdCYepKYrQ4ZELmnD1F8VXOM5aUevA==
X-Received: by 2002:a17:902:930a:b0:188:da5c:152b with SMTP id bc10-20020a170902930a00b00188da5c152bmr46790309plb.9.1671560666986;
        Tue, 20 Dec 2022 10:24:26 -0800 (PST)
Received: from google.com (223.103.125.34.bc.googleusercontent.com. [34.125.103.223])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903244800b001894dc5fdf2sm9632987pls.296.2022.12.20.10.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 10:24:26 -0800 (PST)
Date:   Tue, 20 Dec 2022 10:24:22 -0800
From:   David Matlack <dmatlack@google.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Robert Hoo <robert.hu@linux.intel.com>,
        Greg Thelen <gthelen@google.com>,
        Ben Gardon <bgardon@google.com>,
        Mingwei Zhang <mizhang@google.com>
Subject: Re: [PATCH 4/5] KVM: x86/mmu: Don't install TDP MMU SPTE if SP has
 unexpected level
Message-ID: <Y6H91qfq24CaCi6l@google.com>
References: <20221213033030.83345-1-seanjc@google.com>
 <20221213033030.83345-5-seanjc@google.com>
 <CALzav=d-9G6SSBCB=TbVWi9Szprm1wD3AqqgZzoCq26_LF_ySw@mail.gmail.com>
 <Y5jBXIF26odk6jWC@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5jBXIF26odk6jWC@google.com>
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

On Tue, Dec 13, 2022 at 06:15:56PM +0000, Sean Christopherson wrote:
> On Tue, Dec 13, 2022, David Matlack wrote:
> > On Mon, Dec 12, 2022 at 7:30 PM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > Don't install a leaf TDP MMU SPTE if the parent page's level doesn't
> > > match the target level of the fault, and instead have the vCPU retry the
> > > faulting instruction after warning.  Continuing on is completely
> > > unnecessary as the absolute worst case scenario of retrying is DoSing
> > > the vCPU, whereas continuing on all but guarantees bigger explosions, e.g.
> > 
> > Would it make sense to kill the VM instead via KVM_BUG()?
> 
> No, because if bug that hits this escapes to a release, odds are quite high that
> retrying will succeed.  E.g. the fix earlier in this series is for a rare corner
> case that I was able to hit consistently only by hacking KVM to effectively
> synchronize the page fault and zap.  Other than an extra page fault, no harm has
> been done to the guest, e.g. there's no need to kill the VM to protect it from
> data corruption.

Good points, agreed!
