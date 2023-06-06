Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC79724F6E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239814AbjFFWDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239830AbjFFWDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:03:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18428172D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:03:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bacfa4eefd3so8997673276.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 15:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686089020; x=1688681020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzo6RJjpAJUJYOMKM0Jqd4fwCnwZoeYzFNIgfiAwB3g=;
        b=uR0RPAfUhKWNYrPJmlq4JqollYxJRzaaYHNTinGJzQ0UDAjZ1A99PmrbE9KlMMY0Xw
         AaCXh+SabY/hli0vgtnUweQMfUplnfSqzwqslXHnVfhTSxTVUxumC8ij8FoUggptlvhr
         8Yo0vW1a2zkGUEbHjtIA204rq2AM+9fzVnCj7KLLJ5FioYEmzMn7tvP6tp1sqJy1DrlA
         sz+gS9g3PYN4g+XIkS3dnIqM3/awjguYS+WXoEsi3E9eIaKLghOb0Q6ZiInKpyHYH8S3
         iMWwOoV8oQ7dgAGnQmzLb8f4UxYaWQas5wUQlmfVOKLbrnViDkN0s1VqdlmyyC95AP9A
         aixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686089020; x=1688681020;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzo6RJjpAJUJYOMKM0Jqd4fwCnwZoeYzFNIgfiAwB3g=;
        b=hBi2lC7dMM0KfKWr5637Ka39aN98nbhDKwyZLknuXVNZU4QMd+weabYWXKQxtoTvGi
         XHfc9o70q69PM8km0L86AhHCniAtl9+GC/pVNwKL+Tgr5iboufM4PbJGrZtyVuvqvJZL
         x0Z4pouTEizkE52jyvqny43TVRtYQgmkNV167YuduLxc55WQtIdyj9BeJp14tchCqFbY
         0FYUBBKFisFdzh579kJCL6mImaQX25YUAJhN3dHZnN8eiwElVyCN3lu78xmTKwIA6dre
         a4bUKhJdI2XvZXHZuYKl7b7+ylIFidV8Xdp7Nl+7HEJDCW9Prp+dWpy/6xtYbbI+xHRT
         /m/g==
X-Gm-Message-State: AC+VfDxzXydp2MjMNUkhGqjqjFvS3rEVkBgd/FUr1Q5w9p8UqgdeTPIF
        RJi9TsBVgfz8TQEza2j8NU41xnksFkw=
X-Google-Smtp-Source: ACHHUZ57BiBI98J4zHz3ZHlT5ojtbCViEJsfkWXPRSaWzbeuvNCrblHLWDgeXNjy3P3Wq+lTHOAeKyai3yw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:2613:0:b0:bb4:f968:6c76 with SMTP id
 m19-20020a252613000000b00bb4f9686c76mr27336ybm.6.1686089020336; Tue, 06 Jun
 2023 15:03:40 -0700 (PDT)
Date:   Tue, 6 Jun 2023 15:03:38 -0700
In-Reply-To: <20230606202557.GA71782@dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com>
Mime-Version: 1.0
References: <20230602005859.784190-1-seanjc@google.com> <20230606202557.GA71782@dev-dsk-luizcap-1d-37beaf15.us-east-1.amazon.com>
Message-ID: <ZH+tOj7lRAGsua9X@google.com>
Subject: Re: [PATCH] KVM: x86/mmu: Add "never" option to allow sticky
 disabling of nx_huge_pages
From:   Sean Christopherson <seanjc@google.com>
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li RongQing <lirongqing@baidu.com>,
        Yong He <zhuangel570@gmail.com>,
        Robert Hoo <robert.hoo.linux@gmail.com>,
        Kai Huang <kai.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023, Luiz Capitulino wrote:
> On Thu, Jun 01, 2023 at 05:58:59PM -0700, Sean Christopherson wrote:
> However, why don't we make nx_huge_pages=never the default behavior if the
> CPU is not vulnerable?

Mainly because the mitigation has been around for 3.5 years, and there's a non-zero
chance that making "never" the default could cause hiccups for unsuspecting users.
If this were brand new code, I would definitely opt for "never" as the default.

> If there are concerns about not being able to restart the worker thread, then
> maybe we could make this a .config option?

Eh, a Kconfig is unnecessarily complex, and wouldn't really change anything, e.g.
for users in the know, it's just as easy to force a module param as it is to force
a Kconfig, and to gain any benefit from the param being !never by default, the
Kconfig would also have to be off by default.

If "everyone" wants never to be the default, and Paolo doesn't object, I'd rather
just tack on a patch to make that happen, and cross my fingers there's no fallout :-)
