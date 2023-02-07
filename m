Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B78E68DF6B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjBGRwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjBGRwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:52:19 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DAB3D924
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:52:01 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-51ba4b1b9feso204896467b3.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O3E0KsrZ9oAW+b1aCUfQHj96dbPRqwoGdBYkLlh8FMw=;
        b=BnlnfNpm8hN1xEk3cCUyU216nabUr2USJGPYqGEGpu9FVnmvE+LBsLl0vBVzbzx6Dh
         9K3q0Aba+vc5xhk4pXnWn5YArjpAxDgk20truk6vqe+TweG3yqckxUHhvvxXVG5Auwt1
         Mz+upZ2Og7k6QUzLbxhOScEI7MAZLVjwlZRDeZom8EiP0YQMrs4knQKe1wm46leHR3oz
         iTW578+2yXbBp7Uf3m6IvX03j97+xeZ8V4HitCIRbIz4L/mbdojmLegVU077S2qs5fD5
         BvIzMBf1LSQYWiM6HlWGGF+B+DQDcTLtoQzMayZfza0C/TBYQGltkAXwY/IVU4OJ2Fy9
         h7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3E0KsrZ9oAW+b1aCUfQHj96dbPRqwoGdBYkLlh8FMw=;
        b=iz12ynhaq/+i2vtve/XMhCWE8uqtRn1ezWzgTy0E3+0xrSyLsC6ZIpPOpPCGS8az/B
         pZvc6K/VgrPmBT0sF9pcIGOVQmUklKGw3yXTf3KqWj3bdVDBucQNx7UYFOqlVHDKr7mq
         mzBr4RduAPO8NWQeWmUt3LnndlxMGF8Y+GlzZMFCVxakOALxpe+cYzQA77vJJpASnoDX
         GdOnzfPP7yHGE+x0j+sEf0V36CE/+T17Bhf6qlGMK21dtovICwTrms40FCw+KbAD4hS3
         Yys0k8wDBi5jRz19fYyVe5slAb8ZwhPM07oUdHlzZTuOUMXy4ogfUtBZTww7d5drXipr
         bi2g==
X-Gm-Message-State: AO0yUKXuKwcE0IcSgkd/8ZZxMTVCWhBzciZXJcC4L0pepqas7qtfzn/H
        j5qFiwsMuH+FhPahU8clRfc0+JK5Gbqr2kqpfhO6ZQ==
X-Google-Smtp-Source: AK7set8Lx4TfwZQ6IKZwYWKjwzYVpo6A0JhqFkkDI5N5RJ1+bZI3EcqyHjlZl2U35xQ+xrfb+VoMHjsIBvvUpfxwCaI=
X-Received: by 2002:a0d:c745:0:b0:506:39b1:a6e5 with SMTP id
 j66-20020a0dc745000000b0050639b1a6e5mr374207ywd.398.1675792313944; Tue, 07
 Feb 2023 09:51:53 -0800 (PST)
MIME-Version: 1.0
References: <20230203192822.106773-1-vipinsh@google.com> <20230203192822.106773-5-vipinsh@google.com>
 <Y+GUUr/UE0V0WsrR@google.com>
In-Reply-To: <Y+GUUr/UE0V0WsrR@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Tue, 7 Feb 2023 09:51:18 -0800
Message-ID: <CAHVum0cyGD+4cC4gO+8YDOrpbkgFA5=VPyNyo5DCvC5jTVV80w@mail.gmail.com>
Subject: Re: [Patch v2 4/5] KVM: x86/mmu: Remove handle_changed_spte_dirty_log()
To:     David Matlack <dmatlack@google.com>
Cc:     seanjc@google.com, pbonzini@redhat.com, bgardon@google.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Feb 6, 2023 at 3:59 PM David Matlack <dmatlack@google.com> wrote:
>
> On Fri, Feb 03, 2023 at 11:28:21AM -0800, Vipin Sharma wrote:
> > Remove handle_changed_spte_dirty_log() as there is no code flow which
> > sets leaf SPTE writable and hit this path.
>
> Heh, way too vague again. e.g. This needs to explain how make_spte()
> marks pages are dirty when constructing new SPTEs for the TDP MMU.

Okay, I will try to be more detailed in the next version.
