Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9377440D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjF3RFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233142AbjF3RFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:05:36 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB3235A5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:05:34 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-401f4408955so9331cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 10:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688144734; x=1690736734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3D1NO22NTJu1MOBGY7tF3xo48poE1uDp3veIeBVnBlI=;
        b=GYacckAkcPnWUplTlaekkOtdSFaf+lNU/SG0cw+5dp7yjaMMg9+c4+ymm4dQCO38Dz
         PdeHc8X6R5JAfcDF9pEpC+6ajTif3DHmMt3oQ1pnGmB4z6t4fZVtcvQDOywzhYQjNY4N
         ZrsLZi88nhs+AOGpef+VHTEBPVP+iJGc7S8ob7082O/VQlMOcC/mPJNjmHtq7Uxhg12+
         y1/8ti9u6rVypzIy6UFRV8AuNWz4nuRxB/b4IEi4uWs6Sj6ETn2sFI+QWnZNX9r+PsIY
         BgyRUFrSoyM296nO3MvEJ1qKgV7N6SlOdXyMnqVHJ9ROIGBfM5BXuc6Z2zFdnGTqm3As
         OZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688144734; x=1690736734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3D1NO22NTJu1MOBGY7tF3xo48poE1uDp3veIeBVnBlI=;
        b=hjmRkz3MbqiNV9VpH5hEhs1NAGVLzomcKSvDZGzZ/mM3NTLK+dAFeSC7SeXQ3d5T8f
         BLPJoiNCzC+IWxl/VOzUUGDRG6nOqwIuI1q9kgpbFfJPG7/EgZCbENdjpOWSuOxgxTBj
         OrEdX4N6vxgIgEEQq4hr+xGil2UryeCY9jHtIw736Scpvlmgwb6ULfnY+5sphVdt7CaH
         ssLXjxVtWEeqGWkgaf+JH7bgO4reSCkxjS5wlAS77kEG3JBwQAsXIhBEVMDbOKwziY2q
         xRGFJzInwZsU/AOmvE403kBJTKlSMzyXT1WRXRSL06velNiKRE75LH87SKmQmPu6LKKZ
         MAyg==
X-Gm-Message-State: ABy/qLauWt7O0VK2jDyygBk6oFfnVePf2IkL1yD+FtrNCRfYLHxLawh8
        uVjIcTgPbWuiZYcUfhDo22dQwDKjiyRCIaMV+HQYhw==
X-Google-Smtp-Source: APBJJlGFZH6uDfeEmQHjFg3l+Gr3kdJYkA2pz6Pf7n9i4u6wu+eAR+6jecdfSxzaXV6WzHsdQukovl+kgImmO77aQTU=
X-Received: by 2002:a05:622a:208:b0:3f7:ff4a:eae5 with SMTP id
 b8-20020a05622a020800b003f7ff4aeae5mr3290qtx.12.1688144733661; Fri, 30 Jun
 2023 10:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230627181030.95608-2-irogers@google.com> <8dab7522-31de-2137-7474-991885932308@web.de>
In-Reply-To: <8dab7522-31de-2137-7474-991885932308@web.de>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 30 Jun 2023 10:05:22 -0700
Message-ID: <CAP-5=fVxTYpiXgxDKX1q7ELoAPnAisajWcNOhAp19TZDwnA0oA@mail.gmail.com>
Subject: Re: [PATCH v2 01/13] perf parse-events: Remove unused
 PE_PMU_EVENT_FAKE token
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 9:35=E2=80=AFAM Markus Elfring <Markus.Elfring@web.=
de> wrote:
>
> > Removed by commit 70c90e4a6b2f ("perf parse-events: Avoid scanning
> > PMUs before parsing").
>
> Will the chances ever grow to add another imperative change suggestion?
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?h=3Dv6.4#n94


Sorry, I can't parse this.

Thanks,
Ian

> Regards,
> Markus
