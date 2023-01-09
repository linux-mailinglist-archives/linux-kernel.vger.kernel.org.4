Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1588661CCB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:45:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjAIDpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:45:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjAIDo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:44:59 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8436C93;
        Sun,  8 Jan 2023 19:44:58 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-4c131bede4bso98129177b3.5;
        Sun, 08 Jan 2023 19:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yPfhgfBbYjtzQBCr9FbRdf6V8hXDk+MB1+uIqccKz80=;
        b=PiiGV0orIUzNoytUmWK2Hk73V6GvrZ3mOGmdtD9JJPyyTFyqd4rbXbxD9f9lrKyWWw
         fevi+ntk5KxbxDVOrrigfB7ckGVd/czt9oXOvvgaqNQVUCgbTpNXG0jSVXIjn/dTm2/E
         YfcTRFjPOmk/detqDhf6DFzwhIndaROuQ3hd6qr2nEHQJLoaZSjYwXcrwCHTYTEqIXyU
         oHHdEK9rJEhUNzEU9OVVAbsVMnCji8bsM/2TUrQ8857sQ7yIa/EGPhoINwwCB+0KicAV
         2IF/k4mYcy1ubSd6H9jxYduRSxMyuhAVWWf9BdOpYd0Db1IsN7kFvX+nrDSy4CSjztRm
         PI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPfhgfBbYjtzQBCr9FbRdf6V8hXDk+MB1+uIqccKz80=;
        b=3bPJ7pzJLQQFPexPGE8dE1jB/bLJsT5rUncFpm4cb0aPBo4p+OIO/ubggrVUijjwpf
         ffsxqE2ywcB4QXJNfx65PRmbUr8WujwNfMAwXQCCQqCxKPzRN3jgydDAWNNZdhxGoC7P
         bHupryLysBu3qvBVxISKqoKZJFjSzeMzJXH+GNFWAz0pVTYPnAOj5KfvkcJi2zem6+oC
         Qzdw74yoQ9RUPBO1WZR6toqyNXKYtzH7gib96I9q+O7Tv9oH9Ct8Zk/jL4lPWQNBkuN8
         J9X7+RxKocazwiBvnaP/vzSeU2HCa43tYFSggrmwtwGOd1usbgAZyBICAQlj6v2Jy9kk
         9FxA==
X-Gm-Message-State: AFqh2krae5ZUwGgnfmA3gSmrfekGnoZNk66svavYuVIpJOT7jWx5ucLb
        ZThhF0AncSk1ZkAP6ImphICtrqEw/50SLfKt5yM=
X-Google-Smtp-Source: AMrXdXsDvyB+kfguSnDk3YNKre75CBBnxUmhkZfZUpHXwZlk+A/0xmrM63HVggKfy6yP7iiU9zkufkJCVZ7mtM5K6DM=
X-Received: by 2002:a81:8942:0:b0:36f:d045:417 with SMTP id
 z63-20020a818942000000b0036fd0450417mr907888ywf.385.1673235897760; Sun, 08
 Jan 2023 19:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20230107034335.1154374-1-quanfafu@gmail.com> <20230108162222.146d136f@rorschach.local.home>
In-Reply-To: <20230108162222.146d136f@rorschach.local.home>
From:   Quanfa Fu <quanfafu@gmail.com>
Date:   Mon, 9 Jan 2023 11:44:46 +0800
Message-ID: <CAM4UoypG3c2TDKs7GDTkzP+uFVAzWSE2bdSFH5mLWud6tigCRg@mail.gmail.com>
Subject: Re: [PATCH] tracing/eprobe: Replace kzalloc with kmalloc
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     rostedt@goodmis.or, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
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

Thanks a lot. Learned a lot from here.

I replaced snprintf with memcpy in Patchv2


On Mon, Jan 9, 2023 at 5:22 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat,  7 Jan 2023 11:43:35 +0800
> Quanfa Fu <quanfafu@gmail.com> wrote:
>
> > Since this memory will be filled soon below, I feel that there is
>
> kzalloc() is also used as a safety measure to make sure nothing is
> accidentally exposed. I rather keep it for safety. Just because it
> doesn't need to be here doesn't mean it should be removed. There is no
> benefit to making this kmalloc(), as this is far from a fast path.
>
> > no need for a memory of all zeros here. 'snprintf' does not return
> > negative num according to ISO C99, so I feel that no judgment is
> > needed here.
>
> Also, it's best to remove "feelings" from change logs. Code updates are
> not made due to how one feels about something (at least it shouldn't
> be), but about having technical reasons for doing so. I do agree
> there's no reason to check snprintf() from returning negative, as
> looking at its implementation, there is no negative return. Thus, the
> change log should be:
>
>  "No need to check for negative return value from snprintf() as the
>  code does not return negative values."
>
> >
> > No functional change intended.
>
> And this does have functional changes. If the output of a compiler is
> different for a function, then that's a functional change. What we
> consider non functional changes is if functions get moved around, or
> possibly code in a function is moved into a helper function where the
> compiler *should* end up with the same assembly.
>
> Changing what malloc is called is definitely a functional change.
>
> >
> > Signed-off-by: Quanfa Fu <quanfafu@gmail.com>
> > ---
> >  kernel/trace/trace_eprobe.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> > index 352b65e2b910..cd1d271a74e7 100644
> > --- a/kernel/trace/trace_eprobe.c
> > +++ b/kernel/trace/trace_eprobe.c
> > @@ -917,15 +917,13 @@ static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const ch
> >       for (i = 0; i < argc; i++)
> >               len += strlen(argv[i]) + 1;
> >
> > -     ep->filter_str = kzalloc(len, GFP_KERNEL);
> > +     ep->filter_str = kmalloc(len, GFP_KERNEL);
> >       if (!ep->filter_str)
> >               return -ENOMEM;
> >
> >       p = ep->filter_str;
> >       for (i = 0; i < argc; i++) {
> >               ret = snprintf(p, len, "%s ", argv[i]);
>
> I wonder if this should be a strncat() instead?
>
> > -             if (ret < 0)
> > -                     goto error;
> >               if (ret > len) {
> >                       ret = -E2BIG;
> >                       goto error;
>
>         for (i = 0; i < arcc, i++)
>                 strncat(ep->filter_str, argv[i], len);
>
> I mean, before this code we have that loop already determining what len
> is, do we really need to check if it is going to be -E2BIG?
>
> -- Steve
