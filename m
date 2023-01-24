Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717C9679DB8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjAXPlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235266AbjAXPlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:41:01 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3C448A32
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:40:58 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id b6so11524666pgi.7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfrAQ8c+lQmozz6wI3CJdSN0luYdljLfbreYdoxdA48=;
        b=XjVvXIYI5DZAKv/v0+oZmSajU1T19S8rt42twtbfWHfPRg9W46ohb15iC2tUQFXHHX
         T/ARNnZ5hF+EEmXQ0WdZb7uyY6SrUv58VRSkkMbUWiRS47bm1dGctU9TmQjhmKjcIU1c
         r+DMal3Go7wPvCZN1hunqP0aOygR+7Aoh9YnwY8LZolwgzQhkyTN9asjiqzdGDJb2plP
         sVkuqgVd0EJdn3U1GPQul7GUpj4a+jvMDM59jcZ0viznDjI5cfr0uY+87CzLV4SZiBn/
         FYVsK3m0GEIb99fXhgwvC2wbOYHhkPZfiY0pnM7ahb5znYCYYyPiSwQComzD8gW3nU+5
         7Dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IfrAQ8c+lQmozz6wI3CJdSN0luYdljLfbreYdoxdA48=;
        b=Dr6czQpGfYzl38eDANskTVcMS10DO0aNSgtykHhq4uktt/07DO9fhRCz5dZtkkIzv8
         pQ7z8KwOYMkTI0WdD4naIDF3HF3TPw7mgcbJ8hRR6vUDxDLNfoWFwRMRi1Iryx/15zDv
         lBhVDX0ckmqNxV5fjVMDo/mRTrmfFj7HSegnypj8BzdzYb5rHvCS59Yn9o0O5iqMXS90
         uow2fIdnwWOmWbHsrfJzlY+WtOZAHPOLrbc73izaTu36fAXtbAoxYTBcQOigK3nM6IYu
         kX4pXUfDxedlLryeIStCzgDaAcZjoMj4UtkAS+e3spn9rsuHFOghs3fbdlBDH72mQzfu
         zAkA==
X-Gm-Message-State: AO0yUKU1PqQCHds9lztb4NIuiEYRqmVpNV6QZLNjqArjZrKI+c/mr2vb
        L1MtpzQyoqASMgbyUGohQUBD9Q==
X-Google-Smtp-Source: AK7set/HtyrgJjemStqQjN62dh5mKKRzW+Hg1Vs/WR12Dz9T0Qob+Or04HzPBxCUfV4t3j9uBGITpg==
X-Received: by 2002:a05:6a00:b55:b0:576:9252:d06 with SMTP id p21-20020a056a000b5500b0057692520d06mr284751pfo.0.1674574857542;
        Tue, 24 Jan 2023 07:40:57 -0800 (PST)
Received: from google.com (220.181.82.34.bc.googleusercontent.com. [34.82.181.220])
        by smtp.gmail.com with ESMTPSA id v10-20020a056a00148a00b0058da56f8b95sm1742261pfu.115.2023.01.24.07.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 07:40:56 -0800 (PST)
Date:   Tue, 24 Jan 2023 07:40:53 -0800
From:   Ricardo Koller <ricarkol@google.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     David Matlack <dmatlack@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vipin Sharma <vipinsh@google.com>
Subject: Re: [PATCH 2/2] selftests: KVM: Add page splitting test
Message-ID: <Y8/8BX5ehAyZjyAD@google.com>
References: <20230119212510.3938454-1-bgardon@google.com>
 <20230119212510.3938454-3-bgardon@google.com>
 <Y8nKerX9tDRHkFq+@google.com>
 <CANgfPd8B_0w39d7V+c4GnUxdqrc8qN78r8Pq0Con3Mx9WO0hkQ@mail.gmail.com>
 <Y8qj1QS1VadgaX7A@google.com>
 <CAOHnOrzKBh2Cq7ZQece+6f6P5wS6gZ1R2vjEQ5=QLTy7BmUvFQ@mail.gmail.com>
 <CANgfPd_B0q6uU1Be7A-QOj5_YoWi8z9g9LO63mc+=136hO5K4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANgfPd_B0q6uU1Be7A-QOj5_YoWi8z9g9LO63mc+=136hO5K4Q@mail.gmail.com>
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

On Fri, Jan 20, 2023 at 12:04:04PM -0800, Ben Gardon wrote:
> On Fri, Jan 20, 2023 at 6:34 AM Ricardo Koller <ricarkol@google.com> wrote:
> >
> ...
> > > > > > +
> > > > > > +     run_test(&p);
> > > > >
> > > > > Use for_each_guest_mode() to run against all supported guest modes.
> > > >
> > > > I'm not sure that would actually improve coverage. None of the page
> > > > splitting behavior depends on the mode AFAICT.
> > >
> > > You need to use for_each_guest_mode() for the ARM case. The issue is
> > > that whatever mode (guest page size and VA size) you pick might not be
> > > supported by the host. So, you first to explore what's available (via
> > > for_each_guest_mode()).
> >
> > Actually, that's fixed by using the default mode, which picks the
> > first available
> > mode. I would prefer to use for_each_guest_mode() though, who knows and
> > something fails with some specific guest page size for some reason.
> 
> Okay, will do. I wasn't sure if we did eager page splitting on ARM, so
> I was only planning on making this test for x86_64 initially, hence it

Thanks Ben, just saw that V2 has the for_each_guest_mode() change.
> being in that directory. If ARM rolls with the same behavior, then
> I'll add the for_each_mode bit and move the test up a directory.

No wories, I can take care of that as part of my ARM changes, maybe even
as part of the eager splitting series.

> >
> > >
> > > Thanks,
> > > Ricardo
> > >
> > > >
> > > > >
> > > > > > +
> > > > > > +     return 0;
> > > > > > +}
> > > > > > --
> > > > > > 2.39.1.405.gd4c25cc71f-goog
> > > > > >
