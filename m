Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC3B68DD7C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:57:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbjBGP5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjBGP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:57:20 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E5B8A47
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:57:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id z13so3891329wmp.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 07:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UmeU/kdhBO7XqGPtfKBv9yIOYYG4GxNWHmPeVymMlSk=;
        b=JgfNzpS6vm4jI/ig86lSvi/UfIsFWVK5xgmTjDvoqEvAbEoM3ewslD0LAYvLsmxrjE
         3ftjM8GtgYhkFoJlS8i+LHEgvK0BcqQEVCsyOr0THnI3k7B3wfvRBa/n0I4kXLvd8Dh1
         HBLzZ24rFGB2SHw6rIhwicGUdNT5zaJLNz6HS9jMUGW/K4K9ek5euT21bIYlIitNytYB
         y/GwqJYenMEL1HINk9KJ9izVJQSqZbtInbPhKN0xaszILLdPjCBlbMziFbk6172IRCNp
         Rkc6PiIMxblNspJ+7GxRKBZdE2zYXBQ5Y9WymKYGQk0o8iB88CLvY6vDrBs/Ak9Tmjb2
         Ww/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmeU/kdhBO7XqGPtfKBv9yIOYYG4GxNWHmPeVymMlSk=;
        b=tG8voA28ax+GxwI0JmcxBjCZBwOolLrdVF19iWLUc7yf4ZcWweof9RSGERBYXxy4wH
         JdBcaZ6LAAKBwlvobQH8+ldmralCDnx/2IsAqqV5BTmg8Yo+XMA07QzMTiEbCtJE373d
         CMTXIhEh1ScG5PIqPhgLiV+gpuVzyDwDDJ0VJRVEV+7xLy/miSDRunLqp8JLkCzPc5j4
         0Y3CZbTRVS8WyUc36Regx82Fly9nA0VM8vCZf12Hw7AZJLDuZEm6ySTS5IINnv6iN8ob
         hIBA50kLaUNpgEPBQoHvRpNeWETyI2iWs9J2+O7+/MkFxPhF7kHzCxb6rD/Ta6AjQlpv
         Q+6A==
X-Gm-Message-State: AO0yUKXJvVO6OCJMPi36HW2BMajUAEkOmbpPLKEQ4qcvKnVRn104LdLP
        iS/SGEOOFYbs7T9Gn9nb7GdtpiMNWm1U4FR/KHR2Fw==
X-Google-Smtp-Source: AK7set8+u6tdWke4vMZvca0h8lft43X0EZk3tFEUk91XommWgzTy3aoiaR0kZJ/qKA4sGkMdyA/4oJzIzQnlLUwSbSY=
X-Received: by 2002:a05:600c:354b:b0:3e0:c45:3456 with SMTP id
 i11-20020a05600c354b00b003e00c453456mr438239wmq.44.1675785410384; Tue, 07 Feb
 2023 07:56:50 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <5456286e2c9f3cd5abf25ad2e7e60dc997c71f66.1675111415.git.andreyknvl@google.com>
 <CAG_fn=XhboCY1qz6A=vw3OpOv=u6x=QBq-yS5MmA0RbkD7vVJQ@mail.gmail.com> <CA+fCnZfJdjgwoONLXcq4qdbMcJvRavhVp021XNM_7VM+4pUGyA@mail.gmail.com>
In-Reply-To: <CA+fCnZfJdjgwoONLXcq4qdbMcJvRavhVp021XNM_7VM+4pUGyA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 7 Feb 2023 16:56:13 +0100
Message-ID: <CAG_fn=UuJomZqSDc-WiMipW_r+v_o8na2YRtMVUo5=7vCYUV1A@mail.gmail.com>
Subject: Re: [PATCH 09/18] lib/stackdepot: rename hash table constants and variables
To:     Andrey Konovalov <andreyknvl@gmail.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
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

On Tue, Jan 31, 2023 at 8:02 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
>
> On Tue, Jan 31, 2023 at 12:34 PM Alexander Potapenko <glider@google.com> wrote:
> >
> > On Mon, Jan 30, 2023 at 9:50 PM <andrey.konovalov@linux.dev> wrote:
> > >
> > > From: Andrey Konovalov <andreyknvl@google.com>
> > >
> > > Give more meaningful names to hash table-related constants and variables:
> > >
> > > 1. Rename STACK_HASH_SCALE to STACK_TABLE_SCALE to point out that it is
> > >    related to scaling the hash table.
> >
> > It's only used twice, and in short lines, maybe make it
> > STACK_HASH_TABLE_SCALE to point that out? :)
>
> Sure, sounds good :)
>
> > > 2. Rename STACK_HASH_ORDER_MIN/MAX to STACK_BUCKET_NUMBER_ORDER_MIN/MAX
> > >    to point out that it is related to the number of hash table buckets.
> >
> > How about DEPOT_BUCKET_... or STACKDEPOT_BUCKET_...?
> > (just bikeshedding, I don't have any strong preference).
>
> This is what I had initially actually but then decided to keep the
> prefix as STACK_ to match the stack_slabs and stack_table variables.

Ok, let's keep your version then.
Thanks!
