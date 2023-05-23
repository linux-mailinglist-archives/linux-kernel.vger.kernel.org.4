Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977D970E6ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 22:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238263AbjEWUzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 16:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjEWUzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 16:55:51 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E307AE41
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:55:38 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-563874afe98so2571397b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 13:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684875338; x=1687467338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MN4E6iUtsQjZfLkF3i7CiEIofVPA2cKwz0ZGyJmE7mI=;
        b=Oc6M9rpHqYdNsnjsb4vqbdgybhIUckny+YVoj4ULygXeFeEzYDGgIWwysczYQUM3re
         eCTCD2P0+0H1xScFXIVmSaw2cCEeekZVwGjMLAT504yhvaHVVoIcIWscBRDKa0YWblzm
         aX4rHV6b0gPIwFbE+gNoXaKJzyi75jMrE3xmtlNaMnFPRKDb8Xt73sEPaiwpxVFQTjGm
         7cTQxlDLtaqfB1NS+AcgDiKXW5KNltjeHwsmr3E4u5fdQ+uReGL7bBvSF447kJot4TCa
         n/RN3HB9A9EnHTK20VYkqPXRauTzAKB5Za+8+6HIB+2Ts8Pf2hTTWeZ73KDJV7e4Ba+8
         bwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684875338; x=1687467338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MN4E6iUtsQjZfLkF3i7CiEIofVPA2cKwz0ZGyJmE7mI=;
        b=LGdU+S08yRwrn3DO55Bi0iNgWaSLcrDrkLEvyjXRc5jEkzZXdO+JfwbvtMnSuWDziB
         Z9u4czljqkO5vMFUz8dpg75pj8zJQlxx6yJBQOTAAvb1E6ljbIRPZm7lAGmzaiLbm1IP
         E20rSCZq8uQoAMBITCqcSmB/nxTqDdWkYalurJxzZL6ht4wRaJjAWl88NZseuGfMO260
         sAl6WhYz9tPnHRA5Fn6oOGEJ8lNqv6E6Z5uRkn5NTcqZd/XrZB2YhkMBkSMnbwetHyDg
         pRoc7gTB7gbUZOoKhZVhhK6T69uIrBTJMVoI3UkxGdY3JPDeQESimjYxfbtnN5Il4v/q
         c1oA==
X-Gm-Message-State: AC+VfDyvI3Fk42p+l/aPEjTCrr/5+iNHXN8AvZwD6YuUqtoMsMICg0fJ
        hnIhPUqDOHFMeKLv/9qF0Cfe9mIzHaUwX4HvmHqk
X-Google-Smtp-Source: ACHHUZ4t+Fcvuqxuoa8c0McC3FnrKB51DfRQlYW4AcY4FXRAkFix15al8EtqXrM/HOxrD/tx6jScSENxlCadfYtjl/M=
X-Received: by 2002:a0d:d9d3:0:b0:55a:98ff:f07e with SMTP id
 b202-20020a0dd9d3000000b0055a98fff07emr16474721ywe.16.1684875337916; Tue, 23
 May 2023 13:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230511052116.19452-3-eiichi.tsukata@nutanix.com>
 <18aac53d73e41b33b71d9e5d0f5d4286.paul@paul-moore.com> <B407A72B-68D3-4FE8-B3E7-20B4DA3070C6@nutanix.com>
In-Reply-To: <B407A72B-68D3-4FE8-B3E7-20B4DA3070C6@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 23 May 2023 16:55:26 -0400
Message-ID: <CAHC9VhR_CumgqoXYdso7z+tMvkbPHc8K4ygk66wHDheyG+bpRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] audit: account backlog waiting time in audit_receive()
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     "eparis@redhat.com" <eparis@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "audit@vger.kernel.org" <audit@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 12:22=E2=80=AFAM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
> > On May 20, 2023, at 5:54, Paul Moore <paul@paul-moore.com> wrote:
> > On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> >>
> >> Currently backlog waiting time in audit_receive() is not accounted as
> >> audit_backlog_wait_time_actual. Accounts it as well.
> >>
> >> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> >> ---
> >> kernel/audit.c | 44 ++++++++++++++++++++++++++------------------
> >> 1 file changed, 26 insertions(+), 18 deletions(-)
> >
> > The audit_receive() wait is different from that in audit_log_start()
> > as processes calling into audit_receive() are performing an explicit
> > audit operation whereas those processes calling audit_log_start() are
> > likely doing something else, e.g. opening a file, that happens to
> > result in an audit record being generated.  The fact that the
> > audit_receive() accounting logic, as well as the timeout calculation
> > used, is different from audit_log_start() is intentional.
> >
>
> The intention still sounds a bit not clear to me as both cases wait using
> the same parameter =E2=80=9Cbacklog_wait_time=E2=80=9D and use the same w=
ait
> queue.
>
> IMHO, it will be better to have some comprehensive code comments there.

A fair point.  I'll add that to the todo list.

--=20
paul-moore.com
