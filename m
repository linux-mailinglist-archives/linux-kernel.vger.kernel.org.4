Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A465E6A90
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 20:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIVSUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 14:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbiIVSUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 14:20:09 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEED674E0C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:20:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id u132so10106330pfc.6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 11:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=KaDp6FRZ6c/KnColTs4cUMkFgR81w4nP6/sZqAWGhbM=;
        b=QpYbP12FnBR1piretPlCLIrG6KfXafgQ/82SvI7U0WC2kA3Pw8Vw0XKce1xMf4BYfj
         3nlut7536BtJmJO+esGc8iIw621Gy5IgP+AQnPxrddVjwokn1o4o2E1tuyYu6zrUWjlB
         Heg8EpiZZhBZX1qIYBADXpr4nhNefovl+MkCy0PVsRHr/B12tZWjJp6iXtzvDtgnYeAg
         rZHQAACvqzdhFGh/SNlFGqqC7SChDi9gKchr8udhBPZTZo8PVdss/U/8w9dlzanheBco
         mvwMI8VlQwhkZ4/dx2pVgrqkSbYkh7Norvg7asAVl5WZxDWA4bM+UFj8826re9xDjzMa
         Acuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=KaDp6FRZ6c/KnColTs4cUMkFgR81w4nP6/sZqAWGhbM=;
        b=LNtQPsOxKsyYfmhi0KY+6eyVi/bmoqyHLdOxdWpej3xJVpcqR6TFN6bTlIlLIlDBj1
         vmAh1dLUE1988QU35U8Jyl3ar3S2kS2n2OrKVp0a/U24KxeEg+OQAr9zvIQzRe3gTP/z
         3CjJEpNwnf8csg8RDEwb/Xl391TDJVrUDuUZSZ/XWfkliFlhMtukc9EpG9x+Abqf8y6W
         ZKSzYcKLQNiC2rIGtB/a5ek+fkwRNJ/zr9X2B694Ucdlp13Q2c9lL6xVzYRjn5WmwxnM
         DYW7utU7GZHmLSAk2YvVm0ByRlpyPPlOPsy0hjRmBOEe4v+hdKwA/wILJ1zL4RLPy3HA
         uZVw==
X-Gm-Message-State: ACrzQf07wTh12cqOnJj9dQok9iUvyYB/GclzZ637VhJHTZVDGPKcyHYl
        TYKf/JAOZtnOFlr58SwcvL635w==
X-Google-Smtp-Source: AMsMyM5aql0TsC6m2Ozrf3FMN7EEpMB0rWFkxsZrsMJIUiUzO99v3lMampT9DGk6gF4UBxO/R35gJw==
X-Received: by 2002:a05:6a00:9a9:b0:541:787f:f2c with SMTP id u41-20020a056a0009a900b00541787f0f2cmr4829324pfg.12.1663870807085;
        Thu, 22 Sep 2022 11:20:07 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090a0c4100b001f2ef3c7956sm94269pje.25.2022.09.22.11.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:20:06 -0700 (PDT)
Date:   Thu, 22 Sep 2022 18:20:02 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     David Matlack <dmatlack@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Jones <andrew.jones@linux.dev>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH 1/5] KVM: selftests: Implement memcmp(), memcpy(), and
 memset() for guest use
Message-ID: <YyynUog5sEDScYyX@google.com>
References: <20220908233134.3523339-1-seanjc@google.com>
 <20220908233134.3523339-2-seanjc@google.com>
 <Yyybg3DxgLt4NVn+@google.com>
 <Yyyd8UN+ZO1Yf/Co@google.com>
 <CALzav=dfL+DCFnKQnUP27SzWLMdWY0kKXr93=nL_VC1nj=aNkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=dfL+DCFnKQnUP27SzWLMdWY0kKXr93=nL_VC1nj=aNkg@mail.gmail.com>
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

On Thu, Sep 22, 2022, David Matlack wrote:
> On Thu, Sep 22, 2022 at 10:40 AM Sean Christopherson <seanjc@google.com> wrote:
> >
> > On Thu, Sep 22, 2022, David Matlack wrote:
> > > > +LIBKVM_STRING += lib/kvm_string.c
> > >
> > > Can this file be named lib/string.c instead? This file has nothing to do
> > > with KVM per-se.
> >
> > Yes and no.  I deliberately chose kvm_string to avoid confusion with
> > tools/lib/string.c and tools/include/nolibc/string.h.  The implementations
> > themselves aren't KVM specific, but the reason the file _exists_ is 100% unique
> > to KVM as there is no other environment where tools and/or selftests link to
> > glibc but need to override the string ops.
> >
> > I'm not completely opposed to calling it string.c, but my preference is to keep
> > it kvm_string.c so that it's slightly more obvious that KVM selftests are a
> > special snowflake.
> 
> Makes sense, the "kvm" prefix just made me do a double-take. Perhaps
> string_overrides.c? That would make it clear that this file is
> overriding string functions. And the fact that this file is in the KVM
> selftests directory signals that the overrides are specific to the KVM
> selftests.

I like that, string_overrides.c it is.
