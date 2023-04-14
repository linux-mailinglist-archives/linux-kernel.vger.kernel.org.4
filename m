Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851EE6E2608
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbjDNOo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjDNOoz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:44:55 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8924A9ED0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:44:51 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id q5so21900780ybk.7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681483490; x=1684075490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xFfbL1uh84j9xAURtkr7szI6BF3AAYp2+zwUT6jEQ6U=;
        b=EYtip8WWBJQoX04+52+MVKW/KhiIr2LTzrmtuKqHP6PvHKOzSvl3muC9uUU/3ng6jC
         DFYHzJajx6mxHCOVTYUEmZ3BXRhMtJIPZaF27zw3/pmCX8FhgDoXvhVFFb+a8domyEys
         8/7IgRTQbquDsMoN5K/L7DNry/C+2N5HtHQ/qU6toJ+Qf7OEyDH39TBdXeF9llzOL9dL
         Wg4Y/4emvGnaU27ill+c0zb2euKsmGJukzIyRcgrH4PGkVXEluolDc676jk65gJo1gIj
         hsKIUgqCiEi5O15YIAKLQ/EWuXn0gJAXXN5s70/AE0YSSSf/HSwGcTVzQ3+cAnnrX1ZX
         9Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681483490; x=1684075490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xFfbL1uh84j9xAURtkr7szI6BF3AAYp2+zwUT6jEQ6U=;
        b=W6+HUGJGGZUgeWCnHy16pqlk/s5oadw7FDSzJCl3SEFzE5tZGxqTcFQF2iGUPiUsuD
         4doLUUIqk6Hx4tbm8tZ/XTyZ9is/68AEqq8/4cqeXSXzH7TeozYoS79Fx82jmt4dvDuM
         ivPJdvx7U2S7bVo+4sLK1OYlsWh4gQPyEwcGeJpTyV3EBoVbuO01YX0bIhZeDoopPLm9
         D8ys1cUk92RCsHxKWBMBjCa0OZuAZsni+38NLDANBmm9X1M3lX+Q4i9IRpvQce/OvJ+S
         YUusT/4tSNN3Z4SC2d/wjiH1+gk0tHRUBDbTh5wW7BNb1EzJ5MKk51fmRkiro2hqEv5N
         W4vQ==
X-Gm-Message-State: AAQBX9ecu4JAB2mHjFtfocEKTkPJYgDKEy9Q+F+mYGLfeqQCQIAbSYB0
        /y0NM7P20dmbB+eXexof7jcATuCovaJG3tXCN/6f
X-Google-Smtp-Source: AKy350asV6Ywm6W48mRTCbkqKaalljOMXFrkeb1KrorvpTIeczOiKumCux1SnY7bxHWSAm+yqPTMaetSdh6Tdy7oQ3I=
X-Received: by 2002:a25:d14e:0:b0:b92:258c:e409 with SMTP id
 i75-20020a25d14e000000b00b92258ce409mr374295ybg.3.1681483490661; Fri, 14 Apr
 2023 07:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230414031325.82840-1-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230414031325.82840-1-eiichi.tsukata@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 14 Apr 2023 10:44:40 -0400
Message-ID: <CAHC9VhSM9Pfe-HEHh0zGK473d=sWAEvoAxYVWVmsTos=EqqQOg@mail.gmail.com>
Subject: Re: [PATCH] audit: use pid.is_auditd to make auditd_test_task() faster
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     eparis@redhat.com, linux-kernel@vger.kernel.org,
        audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 11:14=E2=80=AFPM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
>
> auditd_test_task() is a hot path of system call auditing. This patch
> introduces a new bit field "is_auditd" in pid struct which can be used
> for faster check of registered audit daemon.
>
> Benchmark
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Run the following command:
>
>   dd if=3D/dev/zero of=3D/dev/null bs=3D1 count=3D5M
>
> With rule:
>
>   -a never,exit -F arch=3Db64 -S uname
>
> Result:
>
>   Base line    : 2.572 sec
>   /w this patch: 2.412 sec (6.6% faster)
>
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  include/linux/pid.h |  4 ++++
>  kernel/audit.c      | 22 ++--------------------
>  kernel/audit.h      |  3 ++-
>  kernel/pid.c        |  3 +++
>  4 files changed, 11 insertions(+), 21 deletions(-)
>
> diff --git a/include/linux/pid.h b/include/linux/pid.h
> index 343abf22092e..5fe38e254c9a 100644
> --- a/include/linux/pid.h
> +++ b/include/linux/pid.h
> @@ -68,6 +68,10 @@ struct pid
>         wait_queue_head_t wait_pidfd;
>         struct rcu_head rcu;
>         struct upid numbers[1];
> +#ifdef CONFIG_AUDIT
> +       /* registered audit daemon tgid */
> +       unsigned is_auditd:1;
> +#endif
>  };

Thank you for the patch, but I don't think we want to add an audit
specific field to the pid struct at this time.

--=20
paul-moore.com
