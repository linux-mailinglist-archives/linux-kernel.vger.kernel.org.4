Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45CEF62CC50
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 22:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239220AbiKPVJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 16:09:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbiKPVIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 16:08:50 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF04BC0D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:08:08 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1322d768ba7so21611141fac.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 13:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=g6WOXENW7WX8DdQN2AnIBv+P/H8oQWA5leDhKVCB5PU=;
        b=IN2JITV99+mFdxD4DTqauw+JFm0+ykGGIE0IXqgxPI11e0JooNYGLa6GV0g98jl3fi
         PoqLlDVoJTBDkRv/d4fAeMs8VtNFN5HtP051grWq2ZPyt13a3UcgPAwHxeg/HW/6dU94
         r6I1WMxTD/qqNss5NVb4PlwxPB4XcAKqBBN/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g6WOXENW7WX8DdQN2AnIBv+P/H8oQWA5leDhKVCB5PU=;
        b=IE7M85SmfWA8cRscRFkCEmIHhkXiQVTxcm3j+9F817cwCrpSLpHeO9at5iJu74nNVw
         CUkzSOrFusFPJixnhRp3+fr7l26woszWWIY6TDk1B2ikVCIkwaDKxLukuheEOf2TWRqF
         zK00u0lYn+KYIIuHJElJQesZJhFLgiZKhD/PhOuMhWR5WcZfS7fBDaoK3Yn3BV/S3Q8i
         vuasGdgTp7CsrvEbAJd7VE4ovbIzy29VqJwu/V9V5pD91LF/JfSvlkSHvIW+gQgU8CCS
         zzgMzC9wkUpRMhk1GVljqsr1xFb58nTjKjDC+uid46Cakgu7+jAQvmjGQUv4IzvOM7TF
         sQJA==
X-Gm-Message-State: ANoB5pkS5WlJrB6Fcj3yEXHPXkIV7gSawyEXfnUq1+ziGGJbWyuSK2LT
        B2/N/r6sqdYseG/cFSxoYZXiotuTMZCHmQakEb9PRKmH+54=
X-Google-Smtp-Source: AA0mqf6Mw2Z4CJsebYX3GVNqu7GYjb9m73oyQ3ljCp/6SYOSqjmmeBg8Tk+CrrGeJvli2sNkWgZ1NPwGWAMXUL6OtaA=
X-Received: by 2002:a05:6870:bacb:b0:13a:dd16:9b83 with SMTP id
 js11-20020a056870bacb00b0013add169b83mr2778705oab.15.1668632887526; Wed, 16
 Nov 2022 13:08:07 -0800 (PST)
MIME-Version: 1.0
References: <20221116195624.124092-1-joel@joelfernandes.org> <20221116151610.7294a9e8@gandalf.local.home>
In-Reply-To: <20221116151610.7294a9e8@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 16 Nov 2022 21:07:56 +0000
Message-ID: <CAEXW_YTu2-zM_Qmm5=giLoDvqEutMHFNxsi8Q2kT9axCgHFwEQ@mail.gmail.com>
Subject: Re: [PATCH RFC] kexec: Freeze processes before kexec
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, ribalda@google.com,
        zwisler@google.com, robdclark@gmail.com,
        Eric Biederman <ebiederm@xmission.com>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Steve,

On Wed, Nov 16, 2022 at 8:15 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 16 Nov 2022 19:56:24 +0000
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
>
> > --- a/kernel/kexec_core.c
> > +++ b/kernel/kexec_core.c
> > @@ -1175,6 +1175,12 @@ int kernel_kexec(void)
> >       } else
> >  #endif
> >       {
> > +             error = freeze_processes();
> > +             if (error) {
> > +                     error = -EBUSY;
> > +                     goto Unlock;
> > +             }
>
> If this is the path of a kernel panic, do we really want to check the
> return error of freeze_processes()? We are panicing, there's not much more
> we can do.

I am OK with not checking the return of freeze_processes() and trying
to shut down anyway. Will re-spin after any other feedback.

Thanks,

 - Joel
