Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DDA6F0F94
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 02:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344256AbjD1A2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 20:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbjD1A2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 20:28:03 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C682711
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:28:02 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3ef34c49cb9so868391cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 17:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682641681; x=1685233681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHkXe29J0rH8JTdbNwSRd8QPJhbLRY43ryyovIJGnsM=;
        b=hgdsAO6uMrKNw2z6LsvZgPvbnSKIfLf7zoTS4QxqdYtQEGgQC0dm7qlPV+zlHFkGPY
         skPeyJ99yRfgNsWydkwncjcTZveFiA3JxHgYbCVxCdsQQdBGQFqwC5f0xnbpeOTzAZua
         5gCpwgssgA0XZ40bB6PU+Mpsq0QhoFPav4JX/Ra5Xr19C5kgHcAVFMTlnxs+FlqWMZnH
         jkYbKynFHQ/Bd0c3s07U9bJVfcg/5P4BGWhQBco5+tW2NAs/ZqC7dak9bWMod6+NIQgR
         xmuaJjASiIDNpB4jaD3abUU9wWy0URSq95LWJMbGWoGa7DLOB7rkvUe3xvx/OZRwiZ5/
         /gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682641681; x=1685233681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHkXe29J0rH8JTdbNwSRd8QPJhbLRY43ryyovIJGnsM=;
        b=QO4cSzjOgF9xc0kTWFtfZKiq6lFZV3MqvUOHzsNq/qOAusnV2p56isoimcvWSqvQs8
         y7cKvaoxhwL/kuQgD459O/v9R3okqalLZcNh6CPJwpEvEePh/aapO0N+jV3yyjmscNRj
         P8KxUVdhPu77DSX2GV3OruFIP5cPikPD8zRWCBw9AWfYrmukblEHrzYGAjlrQRLnW/30
         LC+d2B5EuSrG3kki1LESqJHm5ShiMSxpBgRuv2mJN2A+cPQkoVC0ssuXmwqTyh/mrE6A
         wNDnYHK2sunVZVMckNk30+WT5DwpRizk4x6dj+oqTpplbSeLLUeetV7LDnzpju42NC2Z
         eiIQ==
X-Gm-Message-State: AC+VfDzeHbIkx5oyIdNXZpFASLVCGkF+WGB1f//Za8QKM6UHjyDjQC+E
        PZiBKSUJTw1aGCyGgKQ/z3Y7YxGf3pUty2UuTiGJ8g==
X-Google-Smtp-Source: ACHHUZ7e+gtNGqUY0Us2JQuPzoAFOc54z7qsE4n4ASaCnlqteYLhb7K23F8WHD1MYYV7YKDMkAeIFxwvlTigifKrgK8=
X-Received: by 2002:ac8:57d3:0:b0:3d6:5f1b:1e7c with SMTP id
 w19-20020ac857d3000000b003d65f1b1e7cmr74403qta.9.1682641681488; Thu, 27 Apr
 2023 17:28:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230427230502.1526136-1-namhyung@kernel.org>
In-Reply-To: <20230427230502.1526136-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 27 Apr 2023 17:27:50 -0700
Message-ID: <CAP-5=fUYfVDfi_+JGqU=o_TcPRNVboMwZewuhU6q+K3md6nUkA@mail.gmail.com>
Subject: Re: [PATCH 1/2] perf list: Fix memory leaks in print_tracepoint_events()
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27, 2023 at 4:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It should free entries (not only the array) filled by scandirat()
> after use.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/print-events.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-event=
s.c
> index d416c5484cd5..0a97912fd894 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -83,11 +83,11 @@ void print_tracepoint_events(const struct print_callb=
acks *print_cb __maybe_unus
>                 if (sys_dirent->d_type !=3D DT_DIR ||
>                     !strcmp(sys_dirent->d_name, ".") ||
>                     !strcmp(sys_dirent->d_name, ".."))
> -                       continue;
> +                       goto next_sys;
>
>                 dir_fd =3D openat(events_fd, sys_dirent->d_name, O_PATH);
>                 if (dir_fd < 0)
> -                       continue;
> +                       goto next_sys;
>
>                 evt_items =3D scandirat(events_fd, sys_dirent->d_name, &e=
vt_namelist, NULL, alphasort);
>                 for (int j =3D 0; j < evt_items; j++) {
> @@ -98,12 +98,12 @@ void print_tracepoint_events(const struct print_callb=
acks *print_cb __maybe_unus
>                         if (evt_dirent->d_type !=3D DT_DIR ||
>                             !strcmp(evt_dirent->d_name, ".") ||
>                             !strcmp(evt_dirent->d_name, ".."))
> -                               continue;
> +                               goto next_evt;
>
>                         snprintf(evt_path, sizeof(evt_path), "%s/id", evt=
_dirent->d_name);
>                         evt_fd =3D openat(dir_fd, evt_path, O_RDONLY);
>                         if (evt_fd < 0)
> -                               continue;
> +                               goto next_evt;
>                         close(evt_fd);
>
>                         snprintf(evt_path, MAXPATHLEN, "%s:%s",
> @@ -119,9 +119,13 @@ void print_tracepoint_events(const struct print_call=
backs *print_cb __maybe_unus
>                                         /*desc=3D*/NULL,
>                                         /*long_desc=3D*/NULL,
>                                         /*encoding_desc=3D*/NULL);
> +next_evt:
> +                       free(evt_namelist[j]);
>                 }
>                 close(dir_fd);
>                 free(evt_namelist);
> +next_sys:
> +               free(sys_namelist[i]);
>         }
>
>         free(sys_namelist);
> --
> 2.40.1.495.gc816e09b53d-goog
>
