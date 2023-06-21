Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11AF0737CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjFUIBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFUIBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:01:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10D2170D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:01:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-987341238aeso680033766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1687334487; x=1689926487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/uzmr18bm+TTjaklP1XdaDPfpw9sySrUHmwXE1mODw=;
        b=e7vij1IPM9/UbQv7lIkfk8Pums7FuQF+Z4+boaRaq/yOmX5bRKsQ0mrPS3Nymz1VBd
         D5+sCrSIWI15UDJDg3dotNPf8SGLFkWOSu1UaY6atV+NXgkdQTzBpbFcQV7VxSsaJ3XK
         sPzb826AwJaHlXnRoouS1CGTsh4cJz/T9xQ2q1LJBpEBIkQ0yYZHUI+SkzDsny7n1MKx
         8j4OZcdBBOPx/MifQDfJLAkUYJtPabtLnY3FxTzDV0Js4uCMarY+tYYns35KlJX7t4Vr
         6E5qhNN1jySgnuAhgC38rBXoZIRUH+DXXCW8nAGs92odcVULACwpKbPON4RLt2T1EjnU
         APtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687334487; x=1689926487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/uzmr18bm+TTjaklP1XdaDPfpw9sySrUHmwXE1mODw=;
        b=Pm86X7RdcxwVyqocFAM9pg8xrKlbrAQFEY+R2lpJDGAkg6K7mjYm6Sbeyn03ihWuq5
         M7eskR/jPRleDggk84f7B8Vw7lR/KsL6iXYB8wSJvv4omZJPNiAXTrdxag+j1BlM8lCA
         c6P0PevEFRlOFX0+CPMmTAPPHxXUWpertt/kNhNqx+QG2rns9xmFWlrO9iER5HFps0iA
         IVNUAxBDVGnLcv37InL64sxdByJv+RIld/uzBUWkwxmZfQE0aWPy+LAiHGtC4VRsfGlA
         jSUkMvl+mdW1Mn4phtyXwj5ob0uSj7NqAuj9PuymBKWElhfisu5fK5l2L5IebauR3V4v
         OKRw==
X-Gm-Message-State: AC+VfDykYW9Oyh99lw1nYjDx1X7F/ANGCiv8l+jPJ0XUs1gyFFWj0fcN
        8aVC2gjl1okV6dTk1bgoPX+5N4vbzkivC9pmF3DI2A==
X-Google-Smtp-Source: ACHHUZ6zgnnZUzg5X4rETT0LUikk9eZ0usOgOL/ZRXRSJfQR8fNVFL4zwQoeQchY/gMVrgg7I66L8mMB3WJKnc5S+DQ=
X-Received: by 2002:a17:907:6095:b0:989:1cc5:24a with SMTP id
 ht21-20020a170907609500b009891cc5024amr4346200ejc.13.1687334486859; Wed, 21
 Jun 2023 01:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAN+4W8ge-ZQjins-E1=GHDnsi9myFqt7pwNqMkUQHZOPHQhFvQ@mail.gmail.com>
 <20230620183123.74585-1-kuniyu@amazon.com>
In-Reply-To: <20230620183123.74585-1-kuniyu@amazon.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Wed, 21 Jun 2023 09:01:15 +0100
Message-ID: <CAN+4W8iSA0Y8iEvYg79=CTNvwkQB5qs_F3vjE7vep-eHR01oJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/6] net: remove duplicate reuseport_lookup functions
To:     Kuniyuki Iwashima <kuniyu@amazon.com>
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, davem@davemloft.net, dsahern@kernel.org,
        edumazet@google.com, haoluo@google.com, hemanthmalla@gmail.com,
        joe@wand.net.nz, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev,
        mykolal@fb.com, netdev@vger.kernel.org, pabeni@redhat.com,
        sdf@google.com, shuah@kernel.org, song@kernel.org,
        willemdebruijn.kernel@gmail.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 7:31=E2=80=AFPM Kuniyuki Iwashima <kuniyu@amazon.co=
m> wrote:
>
> Good point.  This is based on an assumption that all SO_REUSEPORT
> sockets have the same score, which is wrong for two corner cases
> if reuseport_has_conns() =3D=3D true :
>
>   1) SO_INCOMING_CPU is set
>      -> selected sk might have +1 score
>
>   2) BPF prog returns ESTABLISHED and/or SO_INCOMING_CPU sk
>      -> selected sk will have more than 8
>
> Using the old score could trigger more lookups depending on the
> order that sockets are created.

So the result will still be correct, but it's less performant? Happy
to fix a perf regression, but if the result is incorrect this might
need a separate fix?

Best
Lorenz
