Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761406C1E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 18:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCTRqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 13:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbjCTRqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 13:46:12 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94DB138036
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:42:03 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id d13so12989467pjh.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 10:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679334118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LuTi8WvwEuK0bP5t+VXnMuUPRUBIkBImG20VNaAIQbY=;
        b=YYRZ1Gx2Tb8fzxR+TsFWwIOhsoDPle0rw5yQmG60khJQ3xrx5WjImFnntJ6AYGnjtM
         DdXS2B0a2kP9GbFFoesJpEhaEDIrzdBJ6YCpJepr8QzVOKpqY8FD67EWebnBFVS8Z/2u
         il43qwLp0pqLWPIMb4cL0RG2tLt4YzQsnTpUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679334118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LuTi8WvwEuK0bP5t+VXnMuUPRUBIkBImG20VNaAIQbY=;
        b=j7f89Xy9Dys3jCezUv9xIK80MScvmPRXnkfUCKuBzsf3WdTkfvEE284EgveSToxCpH
         r+ojeC4HuzVHdldr+23aSzzqv5+YiquEZQk5meap+ULAad0Sw8B8kRHZNSz3lZ/4nFNK
         13FDL4IuzozRDO3ecpm28c3Xz9mht2R8gyPmBDhvhK4jwd+CoFCxw23YqtMfEkHTnp0P
         vIsWfClw6cdWUmHr0ioqU0eruycMSzfRnsOz/bNTLYHGfp+DaBeFC7QRSntYi/UAhSme
         wZ9U+kwLi1efoibYoJm/2HUnnW4ZiFzTmG4dXJUfPNbKC5NdQW7NO3kWsdpI9xOo2GiE
         ep3g==
X-Gm-Message-State: AO0yUKWJuUhdIsO9TrK/BqZK3aQPyDDwgwSFicWD20C9uJe4EaqoCZzH
        h6QYvhaLfLxu2DdpjCrrFxtZFcq1IUhlIiV5TrVMu2v7HVfWY37l
X-Google-Smtp-Source: AK7set/AkBul2d5c5Zj837ZhzdH6N8mEj/IpUZ2m1zNk2PS7W99byHjvYrn/mxbWXSCxG8Shbbz5Bfk4dWaWyG153IY=
X-Received: by 2002:a17:90a:520e:b0:23d:1541:e529 with SMTP id
 v14-20020a17090a520e00b0023d1541e529mr3438pjh.9.1679334117858; Mon, 20 Mar
 2023 10:41:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230316173811.1223508-1-revest@chromium.org> <20230316173811.1223508-5-revest@chromium.org>
 <ZBcqWqWyq0uW/wj7@krava> <20230319135550.22aaa04b@rorschach.local.home>
 <ZBdTA0gKh2xAk5Ay@krava> <20230319204731.6691dedc@rorschach.local.home> <ZBgT0FINOmW7c4pK@krava>
In-Reply-To: <ZBgT0FINOmW7c4pK@krava>
From:   Florent Revest <revest@chromium.org>
Date:   Mon, 20 Mar 2023 18:41:46 +0100
Message-ID: <CABRcYmJcYgJBvzCXapbmyLdFiY+SFFEN6My5EofFqMT0TGbCSQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] ftrace: Rename _ftrace_direct_multi APIs to
 _ftrace_direct APIs
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

On Mon, Mar 20, 2023 at 9:05=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Sun, Mar 19, 2023 at 08:47:31PM -0400, Steven Rostedt wrote:
> > On Sun, 19 Mar 2023 19:22:59 +0100
> > Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > > > > >  config SAMPLE_FTRACE_DIRECT_MULTI
> > > > >
> > > > > nit, we could perhaps remove this config option as well
> > > > > and use SAMPLE_FTRACE_DIRECT_MULTI
> > > >
> > > > Remove SAMPLE_FTRACE_DIRECT_MULTI for SAMPLE_FTRACE_DIRECT_MULTI?
> > > >
> > >
> > > sorry typo, I meant SAMPLE_FTRACE_DIRECT
> >
> > I believe this was discussed before, and I thought we decided to keep
> > them separate. Or perhaps that was at least for testing?
> >
> > Anyway, we could merge this in the future, but I don't think that's
> > necessary now.
>
> yes, I said it's nit earlier

Happy to send a follow up cleanup later on if that helps. :)
