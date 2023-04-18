Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61976E65B4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjDRNTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjDRNTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:19:50 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17887167F0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:19:48 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id v9so8476883ybm.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1681823987; x=1684415987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBnC5mM7IRjKgDTtiT1xO0lGo5nu3wZ3UZ7UhsqhPt8=;
        b=EesxlTC4t3WRpgD8mYrwdUWbYXQbyjYcjqG1AFdlIIoIz8dCzf4Qwc9oJcsSlxoNsM
         yTcBLKg+zLa5XkedtRFcrjDGhBldFyYhQzh849hbXX2WZEgzmwJWK/5Z5KnPzkkjirU2
         z5cHoqrIzr8ov/DP21CQ83vSZKvopvgDpfEztmGo8DeS4ZOzfxCf3PhGZzu7qXIhla7N
         smiy8A4C08P/+TIzqyrmg0MTjHNqLynvu5LRUNTlq16xbOEaVg8aREmFYhBAVaP5wHPK
         FwYTCjcGRU+qKVDNX0HqKF34JWggYo+KmE71tN1ksvOkkUZJP5Q6hIJVef4jWdXYLquK
         74gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681823987; x=1684415987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBnC5mM7IRjKgDTtiT1xO0lGo5nu3wZ3UZ7UhsqhPt8=;
        b=KAjR24X22uCeugPtVhaYcTdvrZoJCzehewa5NhqkrEiMj6M9/PISnNhtMpVqdWwCLV
         RVOXhlOLYgmE4VN9UgCXZR6225rdr5FnOPzStgo+vuE17cpqN7TJFLidWY29KIg6Or73
         7y09coRQyhlpUABNXJnuOOwrcR9VK3dlVanwBM1LgofcUZozEJPW/ndCCcVliE0vzFuL
         J52CHeWtXmCoC6aheDXov2USQWZP8CCaAQJ5TFIHvUTeAsSkwdsyDDDBYncbpWjoBQEE
         moFA55SGzGEjEbf3zqRJAu3J7gn1U1oqgqysAVZb+wllgSFIs2vyX0hK5Wl9Ck+MGguW
         OPHw==
X-Gm-Message-State: AAQBX9ep4WWJ5VHTx6askibu0OkiutLTAY8bLDhrI3HgLFLBZtLysCLP
        H5E9kv9u5xB8HCuTQHT7S6XXqfWR/S7lCPuX93ZM
X-Google-Smtp-Source: AKy350Z6+iEzLZbxHCluPTabOdwCDIahnihVezPoiKD2wQm/6fTMj5hbeSY+F4irIaAGbDlAkwuvkUSiS89bGSAmvek=
X-Received: by 2002:a25:d7d3:0:b0:b68:7a4a:5258 with SMTP id
 o202-20020a25d7d3000000b00b687a4a5258mr12186999ybg.3.1681823987160; Tue, 18
 Apr 2023 06:19:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230418110919.221578-1-eiichi.tsukata@nutanix.com> <20230418110919.221578-2-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230418110919.221578-2-eiichi.tsukata@nutanix.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 18 Apr 2023 09:19:36 -0400
Message-ID: <CAHC9VhQO8bSdbFYszvjWNT1GCCBr8yusDEq1f52akJApXq8kGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] audit: add global auditd_pid to make
 auditd_test_task() faster
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Cc:     eparis@redhat.com, linux-kernel@vger.kernel.org,
        audit@vger.kernel.org
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

On Tue, Apr 18, 2023 at 7:10=E2=80=AFAM Eiichi Tsukata
<eiichi.tsukata@nutanix.com> wrote:
>
> auditd_test_task() is a hot path of system call auditing. This patch
> introduces a global auditd_pid pid struct which can be used for faster
> check of registered audit daemon.
>
> Benchmarks
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Run the following micro benchmarks:
>
>   (1) dd:
>     dd if=3D/dev/zero of=3D/dev/null bs=3D1 count=3D5M
>
>   (2) UnixBench syscall:
>     ./Run syscall -i 10 -c 1
>
> With rule:
>
>   -a never,exit -F arch=3Db64 -S uname
>
> Results:
>
>   (1) dd
>     Base line    : 2.572 sec
>     /w this patch: 2.418 sec (6.3% faster)
>
>   (2) UnixBench syscall Index Score
>     Base line    : 860
>     /w this patch: 953 (10.8% faster)
>
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  kernel/audit.c | 39 +++++++++++----------------------------
>  kernel/audit.h |  4 +++-
>  2 files changed, 14 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/audit.c b/kernel/audit.c
> index 9bc0b0301198..9426980368e4 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -71,6 +71,7 @@ static int    audit_initialized =3D AUDIT_UNINITIALIZED=
;
>
>  u32            audit_enabled =3D AUDIT_OFF;
>  bool           audit_ever_enabled =3D !!AUDIT_OFF;
> +struct pid      *auditd_pid;

As discussed previously, I want to keep the auditd tracking PID in the
auditd_connection struct.

--=20
paul-moore.com
