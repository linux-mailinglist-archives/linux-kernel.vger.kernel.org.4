Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623F76C1E8B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjCTRvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCTRur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:50:47 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8520C1448D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:45:20 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id c4so7474642pfl.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679334320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YT+7ATO+Dwh8LeAWhyYXzT48upUEJEWzs6S99xdX5+0=;
        b=V/bj/WKjHGwdQSSh+F7jQoNgBojGetJR1GMUxoBP+Y76AgvJhigK/oCYSXs3capHc7
         h7gPU5AdLWrykbsadD83ICz95567xUVKDmf7A+4m7eJCLygXud3N5bnlj5AzMzZrw22h
         9IgksBXEFc2diAmuGwYtVpWZLGjtYSSFTzxa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YT+7ATO+Dwh8LeAWhyYXzT48upUEJEWzs6S99xdX5+0=;
        b=jGNag3tq5y/4xx7nNsND1Z2IETxa+biBS7NxXzcJLm5PvdNrECWfLzWUtb6rTBdzkL
         sUIakbJ1nKvUsNppGxWFOJ94rQkFKJvHWkXQ/MLC3kbHWttwglhTF9CBcXKFW+YaCCpB
         zwieqbGnFVTxfH339YhHnBkTbulgKR/f/lpHkNz4m6Ml0IX3V9p8uPSkcDBl/b6GTOCp
         7JmH+glby4/m/JrDhLDLD3fwqjX694NHuVo4zzf0/m23WPWte0Nw1+O8sh1dBqeTU4d2
         1qBavHNmJDo5W27JrYTTb5/8UI8LlF/ivYVxzyAcnlZ4HzIIKeXPIN3AO3LU719aCAqn
         AaXQ==
X-Gm-Message-State: AO0yUKV5xS3Tllsq3Vc2KgVc8atH7SlO/AK0U3H7yQBlsrgiwxjyfj3D
        OCSBEbtvL1oZyR7phDu8ID40qUiWNje7GLMq9Tv4HA==
X-Google-Smtp-Source: AK7set+L6XVFaFoFys+NP3fmLtvLTx4h7+cjpO0Y1WfROQdIhvqsN5L3fnwCMIuMcaKPUeu8Q9wVx4W6w8qIOIkU+7M=
X-Received: by 2002:a05:6a00:d59:b0:625:96ce:f774 with SMTP id
 n25-20020a056a000d5900b0062596cef774mr6904230pfv.0.1679334319854; Mon, 20 Mar
 2023 10:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230316173811.1223508-1-revest@chromium.org> <20230316173811.1223508-6-revest@chromium.org>
 <ZBcqUoUTZSNyIjLx@krava> <20230319135443.1d29db2d@rorschach.local.home> <ZBdagJQFA/Z7Phj5@krava>
In-Reply-To: <ZBdagJQFA/Z7Phj5@krava>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 20 Mar 2023 18:45:08 +0100
Message-ID: <CABRcYmL_JCAGSoX98dZUhGkmek+5iL4kd+F_POJ65GfnZLADcg@mail.gmail.com>
Subject: Re: [PATCH 5/7] ftrace: Store direct called addresses in their ops
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
        mark.rutland@arm.com, ast@kernel.org, daniel@iogearbox.net,
        kpsingh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 7:55=E2=80=AFPM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, Mar 19, 2023 at 01:54:43PM -0400, Steven Rostedt wrote:
> > On Sun, 19 Mar 2023 16:29:22 +0100
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > > > +++ b/kernel/trace/ftrace.c
> > > > @@ -2582,9 +2582,8 @@ ftrace_add_rec_direct(unsigned long ip, unsig=
ned long addr,
> > > >  static void call_direct_funcs(unsigned long ip, unsigned long pip,
> > > >                         struct ftrace_ops *ops, struct ftrace_regs =
*fregs)
> > > >  {
> > > > - unsigned long addr;
> > > > + unsigned long addr =3D ops->direct_call;
> > >
> > > nice, should it be read with READ_ONCE ?
> >
> > Is there a "read tearing" too?
>
> don't know, saw the comment in __modify_ftrace_direct and got curious
> why it's not in here.. feel free to ignore, I'll look it up
>
> jirka

Mhh, that's a good question. Based on my current understanding, it
seems that it should have a READ_ONCE, indeed. However, I'd like Mark
to confirm/deny this. :)

If this should be a READ_ONCE, I can send a v2 series with this fixed.
