Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6D46526C1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:07:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiLTTHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:07:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiLTTHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:07:13 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FDFBFCED
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:07:11 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id y4so13372656ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cvSkWXFLAfUfeI8+TD0Jkq54zIRWt87Qnu/Wnpu0eNI=;
        b=QQ9uF9DKIhKCAQFEnFnKCD4RdxqyzYtws4v3Zb8gym43Ma39i0fdfF63hF6pyVU5v7
         G7Zlan2IFXrD9rzbP7Slcra3GWdc3QDwxw2VURJbSOcOV+/j3dKQcHYNIjCOUhTB9bA4
         kMxAiJhYK3DdZ0gyeeW6ngEmQqvhwRYA1djeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cvSkWXFLAfUfeI8+TD0Jkq54zIRWt87Qnu/Wnpu0eNI=;
        b=gxm6NCYA/+VqpBjBgQSLI770X7sH9MQ8Oq4P5PtQgDNBzuaQTREgbuSyxCvcASgDwy
         CuIfCKAYByp4XnuP9ota7s3LyNY75cziXhuSzNwlMknaUJXwJ5jsXGoLjTtR43DBkyXM
         uc85MPrO4HX7QjXNnZQSH/omaJfkrLPZQPh+JGryqaleDeaZkr1gzPQHvXJ9r56HI3IL
         pJHTHv4t5+PZ6AnfadCceM3Ok4aywIzAzzQTVFS9pX6gvGOgaA9Y+T2AazqAGkvZTxnZ
         Msw6GJkNTw0zG1lSy1+W8E3f6XffWg3HkiqvKxDNF772YuI6qVdIuM30y+xo08js6xrJ
         OSVQ==
X-Gm-Message-State: ANoB5pmI9H+1lO3YeNMp6fqPOU+X8xEt86m5YkmpZz7wdXuFeC4V9BXa
        7ynpKwPoIn+kEElIO5DpLLsiyDFx0oMU5tF2kg8cXw==
X-Google-Smtp-Source: AA0mqf5pnPk28QBdYwXHYvciy1OrTmLBHm/c+ghzHab0VL+/HkDT1xAeS4p5GNyf8BPSrxzhhjETfB3uOHH1PjVCHtU=
X-Received: by 2002:a05:651c:160b:b0:276:4462:2d20 with SMTP id
 f11-20020a05651c160b00b0027644622d20mr24038161ljq.19.1671563229633; Tue, 20
 Dec 2022 11:07:09 -0800 (PST)
MIME-Version: 1.0
References: <6438d903-ab97-48c7-c338-9f0bc2686f94@efficios.com>
 <7A9876BA-C375-42A7-A5C9-FD940D2898D7@joelfernandes.org> <5bd5ee4a-710a-96bc-abe8-772b2e60f478@efficios.com>
In-Reply-To: <5bd5ee4a-710a-96bc-abe8-772b2e60f478@efficios.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 20 Dec 2022 19:06:57 +0000
Message-ID: <CAEXW_YRFbsCzT9iPdVfmeZ5qK+2fnVAwSzxbj1EXmU+vepOKdg@mail.gmail.com>
Subject: Re: [RFC 0/2] srcu: Remove pre-flip memory barrier
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 7:01 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> On 2022-12-20 13:29, Joel Fernandes wrote:
> >
>
> > I do want to finish my memory barrier studies of SRCU over the holidays=
 since I have been deep in the hole with that already. Back to the post fli=
p memory barrier here since I think now even that might not be needed=E2=80=
=A6
>
> I strongly suspect the memory barrier after flip is useless for the same
> reasons I mentioned explaining why the barrier before the flip is useless=
.
>
> However, we need to double-check that we have memory barriers at the
> beginning and end of synchronize_srcu, and between load of "unlock"
> counters and load of "lock" counters.
>
> Where is the barrier at the beginning of synchronize_srcu ?

I believe we don't need another memory barrier at the beginning of
synchronize_srcu() (but this part of my SRCU study is still pending
;)) . The grace period guarantee (read-side critical sections don't
span the GP) is already enforced by the memory barrier between
scanning for all unlocks, and scanning for all locks (Paired with
corresponding memory barriers on the read-side).

Accordingly, before we scan all locks and match lock =3D=3D unlock, there
is an smp_mb(). Why is that not sufficient?

Thanks,

 - Joel

>
> Thanks,
>
> Mathieu
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com
>
