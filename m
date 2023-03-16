Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9443E6BD9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 20:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjCPT60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 15:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbjCPT6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 15:58:13 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B93C0805
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:57:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n203-20020a25dad4000000b0091231592671so2915940ybf.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 12:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678996646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6hZkF2wD5S148YOwsLKgyhW8hSKyz5z+vIxAoDqNEoU=;
        b=ppopHHPSmlauEReZkK5sf465mFh6p3Uf5alXDjm/6jJiPejFz3RHB7aixjA2ozrvOi
         LjIiAi2RABPxvySD7Ql+1dTFgTiDAABrEGBxcuHmTvN2QnJJqaMEmm//EYMn+z2kO/bY
         CmbWGysimF0nov7NS8ciC0fRQ5IaNXJlk2BHJr3BmSi1LabFKkFEwy90ULpt9//mAQem
         ttXH3ONv2j2YWZoLkIcJ2UTDoJ6pR2hXdifOR4fdTv/7X7W4WnprLdJyiCr/i3PL3YKK
         allvt39YWr14dR2/4YRKS+ACYy7NUzOxfL0NeLmQ6PYa/DALfNx3f2DPgXpkhnnpw7b+
         UwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678996646;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hZkF2wD5S148YOwsLKgyhW8hSKyz5z+vIxAoDqNEoU=;
        b=DHi7PGH8H8KQluSugZjhkaLIdI/vT4FXBR6lkHihjqToffVO9J8zs/YCdDywdHHXWG
         6ZwySZxMw9BpwsENEngavT57rArVR8ElhPe7GcRJl3O0LlPRiOlmP6+fxe76SOTfttdp
         QXspmI7JwBS3kDk9UIZbCO1odZ2eZtVKzBF6XS1SHs92G+donPR/6Xa6yXxwhlhVzvFz
         XVT7/8mqSuunLGA8klLCzX5PbqSRl9mwW68xIgg3eRjsXzLf2psTw7OymF4U08rd5v7G
         9/qUSVx3W2Y07SwPcjvN9CQXsLE4kLXKvQnG128Tzogw4Zu8YTdE3B3pQufjp7+ZMFGv
         lKtA==
X-Gm-Message-State: AO0yUKXtZWeBgzeNfN0JgQpAOYRW0N9e2srqboI0t4KsYxox0kCuF6fH
        i03ewR9ir2hSphXSPNpmZkGXVp3CM+I=
X-Google-Smtp-Source: AK7set90USqlvs8yez6D/amNzNA42LXhWOo0jeJaT0oOsHZyg7uk4XQQlogtskg3otXzxSL5LVe+YTvWptQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:208:b0:a98:bd27:91de with SMTP id
 j8-20020a056902020800b00a98bd2791demr28961776ybs.7.1678996646536; Thu, 16 Mar
 2023 12:57:26 -0700 (PDT)
Date:   Thu, 16 Mar 2023 19:57:24 +0000
In-Reply-To: <6b9e8589281c4d2bae46eba36f77afe7@huawei.com>
Mime-Version: 1.0
References: <20230316154554.1237-1-shameerali.kolothum.thodi@huawei.com>
 <ZBNLnp7c1JvDsmHm@google.com> <6b9e8589281c4d2bae46eba36f77afe7@huawei.com>
Message-ID: <ZBN0pFN/nF8G3fWl@google.com>
Subject: Re: [PATCH] KVM: Add the missing stub function for kvm_dirty_ring_check_request()
From:   Sean Christopherson <seanjc@google.com>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "gshan@redhat.com" <gshan@redhat.com>,
        "maz@kernel.org" <maz@kernel.org>
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

On Thu, Mar 16, 2023, Shameerali Kolothum Thodi wrote:
> > From: Sean Christopherson [mailto:seanjc@google.com]
> > On Thu, Mar 16, 2023, Shameer Kolothum wrote:
> > > The stub for !CONFIG_HAVE_KVM_DIRTY_RING case is missing.
> > 
> > No stub is needed.  kvm_dirty_ring_check_request() isn't called from
> > common code,
> > and should not (and isn't unless I'm missing something) be called from arch
> > code
> > unless CONFIG_HAVE_KVM_DIRTY_RING=y.
> > 
> > x86 and arm64 are the only users, and they both select
> > HAVE_KVM_DIRTY_RING
> > unconditionally when KVM is enabled.
> 
> Yes, it is at present not called from anywhere other than x86 and arm64.
> But I still think since it is a common helper, better to have a stub.

Why?  It buys us nothing other than dead code, and even worse it could let a bug
that would otherwise be caught during build time escape to run time.
