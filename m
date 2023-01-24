Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0277C67A437
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234217AbjAXUrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjAXUrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:47:03 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB712E0CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:47:03 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id nn18-20020a17090b38d200b0022bfb584987so1636946pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WOhLQgtHBlaa6/9LcTJQIUBbipAiIKcaff5d+EZnw10=;
        b=Q9gpybKmfISWIWI7icZ/j4B9dtug7cEdulG6e47k+p0EFCzhK/+TfbYdyZVsh6yBnP
         7TYsVdZ911gg4mQsznLX3p8Ux+mXGNFarFPMcz2mbRBkGdftYFnFoE7rZbV5ItNX9z+6
         W++mbyjNiqvSK3OmnuS5msFNxrdKqF8fP+YTg5dNz/t1vDazcd6VvmaLVdo83hOfLUaB
         ARJQUPCo9NUEJL2WZjaBEDWNSr+WQy+UEZisC+4sRWZ40kthXKGph+A55AzusHZr6RL1
         HCG4zs6VnSiIsWkveqlPbQYuyayWbPAc2ZK/bwvuiFYHgFKxuYGrzB4lsd46ZqZhWp1p
         yKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WOhLQgtHBlaa6/9LcTJQIUBbipAiIKcaff5d+EZnw10=;
        b=YruBOufgw+V+4nx1dIpecjQDs2YZsBM9S4Ymp8nVbWFiDYFjJeVpzpYSxKLfVqPAqn
         qzieJLEbmz8bd1aU6U5AsIipTSqoa9JWz0SOodgGf7k4OeqC/cd/U0tWviYu0bpLtE1K
         R/Tgn1rRC5ytxhFqmD193u/YfbvBTL8mE2/9Vu2PpU4K8owb1Py/tZQwDaTlHq+PapiZ
         RD/vIWJaHKks364ae+kGW3Z7UM9WZKsOg+VzWYWa/1Diul06mzN3jDNUrAL3BXgxi51n
         yMgTXv0Sl6K7OMOlJbHPDo9NYHrU0i45YXTqDeVVIxupRCwulAVZc28KVSod7OqC52OL
         yyXg==
X-Gm-Message-State: AFqh2krdDo04JpWo6GgjyeBObUWCFn9MdDzpUlVQDgtW/5O7wTdwSZzA
        +kRUWFSB7KnXgOzdjsc6phELdsKSjPa2LLfUirc=
X-Google-Smtp-Source: AMrXdXsS70rHo2N+FPLWUuDXEgJl0EoZKll493iXdf5EU3bDYdWcTSyssJJl2zqYAWiN9Ryhcx6DYMIRjcy7S3HsQFs=
X-Received: by 2002:a17:90b:2541:b0:229:3af9:a0ac with SMTP id
 nw1-20020a17090b254100b002293af9a0acmr4227709pjb.47.1674593222835; Tue, 24
 Jan 2023 12:47:02 -0800 (PST)
MIME-Version: 1.0
References: <24ea20c1b19c2b4b56cf9f5b354915f8dbccfc77.1674592496.git.andreyknvl@google.com>
 <20230124124504.2b21f0fde58af208a4f4e290@linux-foundation.org>
In-Reply-To: <20230124124504.2b21f0fde58af208a4f4e290@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 24 Jan 2023 21:46:51 +0100
Message-ID: <CA+fCnZeDWxFB0BgUy_tEybtagth=bcGcqqu9LPSOEjKr5j-o8A@mail.gmail.com>
Subject: Re: [PATCH mm] kasan: reset page tags properly with sampling
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 9:45 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Tue, 24 Jan 2023 21:35:26 +0100 andrey.konovalov@linux.dev wrote:
>
> > The implementation of page_alloc poisoning sampling assumed that
> > tag_clear_highpage resets page tags for __GFP_ZEROTAGS allocations.
> > However, this is no longer the case since commit 70c248aca9e7
> > ("mm: kasan: Skip unpoisoning of user pages").
> >
> > This leads to kernel crashes when MTE-enabled userspace mappings are
> > used with Hardware Tag-Based KASAN enabled.
> >
> > Reset page tags for __GFP_ZEROTAGS allocations in post_alloc_hook().
> >
> > Also clarify and fix related comments.
>
> I assume this is a fix against 44383cef54c0 ("kasan: allow sampling
> page_alloc allocations for HW_TAGS") which is presently in mm-stable,
> yes?

Correct. I assumed I shouldn't include a Fixes tag, as the patch is
not in the mainline.
