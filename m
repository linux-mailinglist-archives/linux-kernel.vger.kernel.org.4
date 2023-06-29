Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32570742B88
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjF2Rtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjF2Rtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:49:43 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8C21FC3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:49:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-991f956fb5aso108003366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688060980; x=1690652980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8mOqBhtdl60cTKHqlJJvAt4fA4w+Uig7XN18wNz+bfw=;
        b=TUJE7nOJW7jtT4gZTXiuSurM2JBXWSMoFIjSgvRXWOMKQhkAPsPWQtl45xMaZhkYC4
         m49+8wCDTT7YFkR4HD8QrACpe8159CmAuACG5lV63NsuDIuhPvMCo6QN2jOAr2hWGclM
         TUTAcjrz0IV88qrJDJpjRq0hGDdHdJOBo1u7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688060980; x=1690652980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8mOqBhtdl60cTKHqlJJvAt4fA4w+Uig7XN18wNz+bfw=;
        b=M7w8j053cbsEHMHbtgs4KuLsvmXLEvVFAS8lvc0iFZZvQxVHY60Lflz1S1hKJQbjzB
         WquU4OMdOwK/EtvoeCIlqOjmBMXp03c5jtom54xTp3xHpsyxs5AvuyxXlK+3hhdN3WiW
         6dyW2oYsmhDIPaAYw396vN/LUjCjad+8BoeoHyZap03NDc1tW/FepcJToZIQgJ50s1Jq
         TVpyCz46B7jVt0YvTSJlMVTsTQ1+O2v458ZRlxS2uipi7tEi4qfs/VSM8Hj3t8ZBz5VA
         PX2I4WVgxIoebSgkPlh9mddQqdboBOlIh1s84eYsk+MzF66HoRBHpiXUyysvXbmtBoAt
         wUYw==
X-Gm-Message-State: ABy/qLZc9eWOj+ck3THdt5hbWHjZb67l/ZeAiIWGXGpnYFo9oYzZYrJC
        wgs8lKC8MByQXqI0WC9LcivGKReivfkLSfMyNwuqy7D9
X-Google-Smtp-Source: APBJJlF/UjuSwvAmsLSElTWG9Xf917Rk9jEQnOC5RmUEMJSPlAO6Us2XEMlUBEMJ03rH7YeP6zKFEw==
X-Received: by 2002:a17:906:6d5:b0:982:7505:fafa with SMTP id v21-20020a17090606d500b009827505fafamr142193ejb.47.1688060979732;
        Thu, 29 Jun 2023 10:49:39 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id l11-20020a170906938b00b00991dfb5dfbbsm4539407ejx.67.2023.06.29.10.49.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 10:49:39 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51ddbf83ff9so1220a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:49:39 -0700 (PDT)
X-Received: by 2002:a50:c01a:0:b0:51a:1fd1:952f with SMTP id
 r26-20020a50c01a000000b0051a1fd1952fmr147975edb.1.1688060978791; Thu, 29 Jun
 2023 10:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230628125612.1.I5cc6c3d916195f5bcfdf5b75d823f2037707f5dc@changeid>
 <20230629164809.GA2872423@aspen.lan>
In-Reply-To: <20230629164809.GA2872423@aspen.lan>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Jun 2023 10:49:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UFEhyqtSM9H4kEj72c5UEpeREZBszULhFsDAMnyLNCoA@mail.gmail.com>
Message-ID: <CAD=FV=UFEhyqtSM9H4kEj72c5UEpeREZBszULhFsDAMnyLNCoA@mail.gmail.com>
Subject: Re: [PATCH] kdb: Handle LF in the command parser
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 29, 2023 at 9:48=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> On Wed, Jun 28, 2023 at 12:56:17PM -0700, Douglas Anderson wrote:
> > The main kdb command parser only handles CR (ASCII 13 AKA '\r') today,
> > but not LF (ASCII 10 AKA '\n'). That means that the kdb command parser
> > can handle terminals that send just CR or that send CR+LF but can't
> > handle terminals that send just LF.
> >
> > The fact that kdb didn't handle LF in the command parser tripped up a
> > tool I tried to use with it. Specifically, I was trying to send a
> > command to my device to resume it from kdb using a ChromeOS tool like:
> >   dut-control cpu_uart_cmd:"g"
> > That tool only terminates lines with LF, not CR+LF.
> >
> > Arguably the ChromeOS tool should be fixed. After all, officially kdb
> > seems to be designed such that CR+LF is the official line ending
> > transmitted over the wire and that internally a line ending is just
> > '\n' (LF). Some evidence:
> > * uart_poll_put_char(), which is used by kdb, notices a '\n' and
> >   converts it to '\r\n'.
> > * kdb functions specifically use '\r' to get a carriage return without
> >   a newline. You can see this in the pager where kdb will write a '\r'
> >   and then write over the pager prompt.
>
> I'd view this as simply "what you have to do drive a terminal correctly"
> rather than indicating what the official newline protocol for kdb is.
> With a human and a terminal emulator I would expect the typical input to
> be CR-only (and that's what I setup the test suite to send ;-)).

Fair enough. I haven't done massive amounts of serial communications
across lots of platforms, but I do remember the history of line
endings in text files and so I wanted to document my findings a bit.
;-)


> > However, all that being said there's no real harm in accepting LF as a
> > command terminator in the kdb parser and doing so seems like it would
> > improve compatibility. After this, I'd expect that things would work
> > OK-ish with a remote terminal that used any of CR, CR+LF, or LF as a
> > line ending. Someone using CR as a line ending might get some ugliness
> > where kdb wasn't able to overwrite the last line, but basic commands
> > would work. Someone using just LF as a line ending would probably also
> > work OK.
> >
> > A few other notes:
> > - It can be noted that "bash" running on an "agetty" handles LF as a
> >   line termination with no complaints.
> > - Historically, kdb's "pager" actually handled either CR or LF fine. A
> >   very quick inspection would make one think that kdb's pager actually
> >   could have paged down two lines instead of one for anyone using
> >   CR+LF, but this is generally avoided because of kdb_input_flush().
>
> These are very convincing though!
>
> > - Conceivably one could argue that some of this special case logic
> >   belongs in uart_poll_get_char() since uart_poll_put_char() handles
> >   the '\n' =3D> '\r\n' conversion. I would argue that perhaps we should
> >   eventually do the opposite and move the '\n' =3D> '\r\n' out of
> >   uart_poll_put_char(). Having that conversion at such a low level
> >   could interfere if we ever want to transfer binary data. In
> >   addition, if we truly made uart_poll_get_char() the inverse of
> >   uart_poll_put_char() it would convert back to '\n' and (ironically)
> >   kdb's parser currently only looks for '\r' to find the end of a
> >   command.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> This arrived just as I was gathering up the patches (I know... running
> late). I've added a couple of cases to the test suite to cover the
> new feature.
>
> The code looks good to me. Are you happy for me to take it this
> merge cycle?

Yeah, it should be OK. It's really pretty straightforward. Thanks!

-Doug
