Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3FAF725182
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 03:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240311AbjFGB1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 21:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240121AbjFGB1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 21:27:11 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87491981;
        Tue,  6 Jun 2023 18:27:09 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f122ff663eso8407072e87.2;
        Tue, 06 Jun 2023 18:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686101228; x=1688693228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AocMQ+e+Td8Ov9i0CF6sYvZu1zVVcBTKduhGqLyYOsU=;
        b=DFmaDogHAer9Fxml11hhtM6P3bM7iRK+qzFd5owLEveg3f3C89Uu5PSukKTL9otYDU
         4Om4UArQszjytyCDaoYeQ88HIOMZo7lwq3MPZdcfr9x2G/RmY6PXnyvar+ImorflXFc9
         792/vQsTrNpHGeOSmu9zMFuXG+YHuRGLgFJfiGM3Byf8PGXJQZ/cfeBJEF5TwvqvTfJf
         j6LcVSeIACwflX02xSUe/AZAqd/oijN68/IHLfHib74ExaqW8yxfAFgPXdfGBVyUw5IZ
         TBQek7gMdFVsZW+tb7RaLkJX6z0QsJtAyqCKN0M91/RgtK6Y+1KhsLwqe1l4Y09sFHiH
         tUHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686101228; x=1688693228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AocMQ+e+Td8Ov9i0CF6sYvZu1zVVcBTKduhGqLyYOsU=;
        b=Sp2LluYfFNmiS/ZvHtKQdWBHYhDJj2YWZDEaahpbfxraDLOQ4/JaC+aoUxTOjzyeB4
         s7Fld7qPUTZyRbwtyKF5g/2NswNYcvE02z6LoY4Wc28I9cqtcQPR5jTVQzNXTAsIHef9
         00d4EON1OFMKZvUsH5JeUI6tQ4tYbskpx3uxRRbHaTIKCrUiH9R/KbgU5gyKIcKqrHvs
         fsFXbUpNs7pwg/sVXrFeiHfG50IfarZAzfRzx/I+sjqn6qMLt7vJE+rWD61CwhmNn/Rz
         f0c5bH0zKqQiLlz6NSckEYCL47K+N9gg2sd+eO0nxBwbDu23RpzAabeK2HIMpFjEM8RR
         7Jag==
X-Gm-Message-State: AC+VfDxr9OdxSUdx4P4mHTp/vcf/WKMB02j2r/M6JTdP7H4M5Cfed9GP
        d7ugLbJjx3qGyaqg97MMT0vOStAIte+uM27vcAFkpR2a
X-Google-Smtp-Source: ACHHUZ58ZDWo8eE5G6dk8YWyXRUqA8QE6PH5NFaGIfisgEHFf/fF/UWMshoFQk6bttNBRBCB+Z6zL77XZX05+6O4AkU=
X-Received: by 2002:ac2:48b3:0:b0:4ed:ca3b:40f0 with SMTP id
 u19-20020ac248b3000000b004edca3b40f0mr1795600lfg.9.1686101227519; Tue, 06 Jun
 2023 18:27:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230605233900.2838-1-beaub@linux.microsoft.com> <20230605233900.2838-4-beaub@linux.microsoft.com>
In-Reply-To: <20230605233900.2838-4-beaub@linux.microsoft.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 6 Jun 2023 18:26:56 -0700
Message-ID: <CAADnVQL3bJaXW6mzTrTFTbAyCaBfiHYet+gNorF1N69a0X5TXQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] tracing/user_events: Add auto cleanup and a flag
 to persist events
To:     Beau Belgrave <beaub@linux.microsoft.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>, dcook@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 5, 2023 at 4:39=E2=80=AFPM Beau Belgrave <beaub@linux.microsoft=
.com> wrote:
> +       /*
> +        * When the event is not enabled for auto-delete there will alway=
s
> +        * be at least 1 reference to the event. During the event creatio=
n
> +        * we initially set the refcnt to 2 to achieve this. In those cas=
es
> +        * the caller must acquire event_mutex and after decrement check =
if
> +        * the refcnt is 1, meaning this is the last reference. When auto
> +        * delete is enabled, there will only be 1 ref, IE: refcnt will b=
e
> +        * only set to 1 during creation to allow the below checks to go
> +        * through upon the last put. The last put must always be done wi=
th
> +        * the event mutex held.
> +        */
> +       if (!locked) {
> +               lockdep_assert_not_held(&event_mutex);
> +               delete =3D refcount_dec_and_mutex_lock(&user->refcnt, &ev=
ent_mutex);
> +       } else {
> +               lockdep_assert_held(&event_mutex);
> +               delete =3D refcount_dec_and_test(&user->refcnt);
> +       }
> +
> +       if (!delete)
> +               return;
> +
> +       /* We now have the event_mutex in all cases */
> +
> +       if (user->reg_flags & USER_EVENT_REG_PERSIST) {
> +               /* We should not get here when persist flag is set */
> +               pr_alert("BUG: Auto-delete engaged on persistent event\n"=
);
> +               goto out;
> +       }
> +
> +       /*
> +        * Unfortunately we have to attempt the actual destroy in a work
> +        * queue. This is because not all cases handle a trace_event_call
> +        * being removed within the class->reg() operation for unregister=
.
> +        */
> +       INIT_WORK(&user->put_work, delayed_destroy_user_event);
> +
> +       /*
> +        * Since the event is still in the hashtable, we have to re-inc
> +        * the ref count to 1. This count will be decremented and checked
> +        * in the work queue to ensure it's still the last ref. This is
> +        * needed because a user-process could register the same event in
> +        * between the time of event_mutex release and the work queue
> +        * running the delayed destroy. If we removed the item now from
> +        * the hashtable, this would result in a timing window where a
> +        * user process would fail a register because the trace_event_cal=
l
> +        * register would fail in the tracing layers.
> +        */
> +       refcount_set(&user->refcnt, 1);

The recnt-ing scheme is quite unorthodox.
Atomically decrementing it to zero and then immediately set it back to 1?
Smells racy.
Another process can go through the same code and do another dec and set to =
1
and we'll have two work queued?
Will mutex_lock help somehow? If yes, then why atomic refcnt?
