Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA8705EF5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 06:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjEQEvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 00:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjEQEvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 00:51:11 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920592D63
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:50:44 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6ab094a7c04so188407a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684299044; x=1686891044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdpDNOc9IaRuXWWVjAWL4lPisTwamC4JuamnxWVl6aE=;
        b=ZohEZycebbexSIQM0Ql/0E6KK0YPr6BzbEZTe+tngAPEGD/paFD3oAqhjkfLHe9/Sf
         OrYnlCEwKocjgVyBCijJ1WCKZlFh+hTVcjuK4669s1299beA2zJl6d8pOjCDe9yN7ZNV
         TaENAEhYCD95ZvD+k6mj3Tvw3gf6BYQ7tEUvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684299044; x=1686891044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdpDNOc9IaRuXWWVjAWL4lPisTwamC4JuamnxWVl6aE=;
        b=farZH7KHY7MCfJ5IVhf9LGGYTCV9hHTNOeskLpPn2xwdJtxAe34d+PZnb+eToMmTUG
         UqQJLO4q+0CM+rIpORCFZx4/pJn8Rnxj0Cl3/yOfnJpmHhTZYEqF1M7Y9iR8P1yjg4el
         2wHxnata/V1NKLgvoendmqCjIWrjT6VVzY3nkThrI1UV2Kg0ZuwrWtLpfR5JUp75s/CI
         w9yEaDS6ueuXTJv2c7cR92UgASpXdEfeHcnWcqOF05fzROBCo6prWIOP13cYktCdrH/X
         fNtSUKy1SXEZXX6Qn4+v+9mPVgrKGozqWfoCDjqGM4Kku0/Z9O+iGDsonUgGONTQ+Y3R
         v7pw==
X-Gm-Message-State: AC+VfDzgSY92Y/o3bOt3l56Fi0HkqnbIMcoTfzoqE5sGkvhmLJE+hoTd
        Rvp7AS723l553ZWZXl7UkYYhCPzCjHRiBTI9jNcybA==
X-Google-Smtp-Source: ACHHUZ6bP3yE1SLmRxIXkPdAaJJQitOTouGMseQ0lvlM4x1DeANqZcZ97RNjV1Jnv4U8agiHfeX6phHwNYamuOI+eN4=
X-Received: by 2002:a05:6808:624e:b0:38c:1266:117e with SMTP id
 dt14-20020a056808624e00b0038c1266117emr13723618oib.44.1684299043940; Tue, 16
 May 2023 21:50:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230515130553.2311248-1-jeffxu@chromium.org> <20230515130553.2311248-4-jeffxu@chromium.org>
 <78bb0097-7dca-254f-45a6-5cea6baec0c4@intel.com> <CALmYWFvC55idHEyRiiuAwDOVv+rjP-3DejCfLW8c0iK8AGoJcw@mail.gmail.com>
In-Reply-To: <CALmYWFvC55idHEyRiiuAwDOVv+rjP-3DejCfLW8c0iK8AGoJcw@mail.gmail.com>
From:   Jeff Xu <jeffxu@chromium.org>
Date:   Tue, 16 May 2023 21:50:31 -0700
Message-ID: <CABi2SkXr6ubHFCCPBBZZhDzxOY+dtfbVa3rGYVxei+urhqhc3g@mail.gmail.com>
Subject: Re: [PATCH 3/6] PKEY: Apply PKEY_ENFORCE_API to mprotect
To:     Jeff Xu <jeffxu@google.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, luto@kernel.org,
        jorgelo@chromium.org, keescook@chromium.org, groeck@chromium.org,
        jannh@google.com, sroettger@google.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 4:37=E2=80=AFPM Jeff Xu <jeffxu@google.com> wrote:
>
> On Tue, May 16, 2023 at 4:19=E2=80=AFPM Dave Hansen <dave.hansen@intel.co=
m> wrote:
> >
> > On 5/15/23 06:05, jeffxu@chromium.org wrote:
> > >  /*
> > >   * pkey=3D=3D-1 when doing a legacy mprotect()
> > > + * syscall=3D=3Dtrue if this is called by syscall from userspace.
> > > + * Note: this is always true for now, added as a reminder in case th=
at
> > > + * do_mprotect_pkey is called directly by kernel in the future.
> > > + * Also it is consistent with __do_munmap().
> > >   */
> > >  static int do_mprotect_pkey(unsigned long start, size_t len,
> > > -             unsigned long prot, int pkey)
> > > +             unsigned long prot, int pkey, bool syscall)
> > >  {
> >
> > The 'syscall' seems kinda silly (and a bit confusing).  It's easy to
> > check if the caller is a kthread or has a current->mm=3D=3DNULL.  If yo=
u
> > *really* want a warning, I'd check for those rather than plumb a
> > apparently unused argument in here.
> >
> > BTW, this warning is one of those things that will probably cause some
> > amount of angst.  I'd move it to the end of the series or just axe it
> > completely.
>
Okay, I will move the logging part to the end of the series.


> Agreed. syscall is not a good name here.
> The intention is to check this at the system call entry point
> For example, munmap can get called inside mremap(), but by that time
> mremap() should already check that all the memory is writeable.
>
> I will remove "syscall" from do_mprotect_pkey signature, it seems it caus=
ed
> more confusion than helpful.  I will keep the comments/note in place to r=
emind
> future developer.
