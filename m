Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51B56C23FE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCTVlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCTVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:41:21 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E42D30D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:40:47 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3d7aef37dccso710591cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679348389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7bUIqqPSkOdKE/QUFapYRZ6AQqknKxD1e9cPy+gENc=;
        b=ZFhHXWpbbAsBnj5tgd+/fQka5nC40wyw5X7vX06CbOqQtAx3imrImdpCzXJNWPW+cP
         w5bodTlKvXpSArYk/pqbC6jcry+HUk17Os005zgm9Qzdg4CAk0LXBj97bubnxumcR/nw
         DN1vzVCojmo3YJWxc3O92+WBjR7Vx5WN1kOD0+p+TDMVKAaOGk+5AotfJj7PMprRIMlA
         5jN1g+M6iPVdvuqsUPc1gAdWY3gkz0ir4NzxFvuHug7ll/OXC/hMQPkJqybvwGO/aA4o
         tCR5a7rfK/SqGxFnqb1sIgX/0NyeaxYZKyC+Io1M8UxPcijr2liPb6bDXe0xM2faYPmv
         otjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679348389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7bUIqqPSkOdKE/QUFapYRZ6AQqknKxD1e9cPy+gENc=;
        b=N5SSoY5ZuJOUkazgXr5eHPIIrqz3/TyWj570I+Eb/mJNAL3bHuz8RpTzJQfyKRVnpX
         kmCrg+bdoCCTCU4dsSYMYUhXyESbAaOf0ZLXR2Ve2F+F8DVkQ9CU8jbeJfuLfAGU1WUN
         Y88CGlP/mblJs3hEiE8kmsmE4PgadOGzbOyOMNSXCEOIPdBJvJtsy7HoNZrhxAn6mbkz
         OPssbzoPvZXVujAl/Ithw6SEHoT6hvPuaFWZ2g0LntKnhNjbh73H76HRtw1IuSyCYDJI
         52S92U0GpvqGNLm7zAN3/EXnn1fGm/CXxMPPxV31Kbh0G82Syc9lPiU9fv+Uoh6Z5mp8
         9Dcw==
X-Gm-Message-State: AO0yUKUV6sFyXPq85fJcw7W0RuSEW+kQgYf/J6w4WV8ZUfXkT+GQ5Uqb
        1MAYoZMGTwHGGS8lInrCZgobTOHWiyEtJk4mUYx8Vw==
X-Google-Smtp-Source: AK7set/A9W//HEAlO3s4Q5Gpait/HW/x17AEGWfovWI6dJiEksGxiksvyrvnO5+TabKW4+YQyCqJHtLTA4gfL/RAsig=
X-Received: by 2002:ac8:5c52:0:b0:3e2:3de:3732 with SMTP id
 j18-20020ac85c52000000b003e203de3732mr38172qtj.7.1679348388679; Mon, 20 Mar
 2023 14:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230320201841.1133-1-bwiedemann@suse.de> <CAP-5=fUGbT8=spY=e6NPJvf_+Ct6VksFzWM6Eybf=gst_J=Xmw@mail.gmail.com>
 <5064f88a-952a-6f3f-f280-e76e09603c1b@suse.de>
In-Reply-To: <5064f88a-952a-6f3f-f280-e76e09603c1b@suse.de>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 14:39:37 -0700
Message-ID: <CAP-5=fXsY2BTkk2ugwq86n7OgqVXzG+n=pBGGpVDTixqyMC_Uw@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Sort list of input files
To:     "Bernhard M. Wiedemann" <bwiedemann@suse.de>
Cc:     Ben Hutchings <benh@debian.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 2:30=E2=80=AFPM Bernhard M. Wiedemann
<bwiedemann@suse.de> wrote:
>
> On 20/03/2023 21.48, Ian Rogers wrote:
> > I think this may already be addressed by sorting prior to output:
> > https://lore.kernel.org/r/20220812230949.683239-5-irogers@google.com
> >
> > Could you confirm?
>
> Hi Ian,
>
> I was testing on 6.2.6 which includes that patch and it was still affecte=
d.
> The trouble with sorting at the end is, that there can be influences of
> ordering in earlier processing steps, that don't get ironed out by the
> sort later.
>
> Some more experimenting showed that only the ftw scandir needed sorting,
> which allows to further simplify the patch to
>
>       """Replicate the directory/file walking behavior of C's ...
> -    for item in os.scandir(path):
> +    for item in sorted(os.scandir(path), key=3Dlambda e: e.name):
>         action(parents, item)
>
>
> Without the patch, a random diff in pmu-events.c starts with
> -static const struct compact_pmu_event pme_amdzen2[] =3D {
> +static const struct compact_pmu_event pme_silvermont[] =3D {
>
>
> While I'm testing on scratch ext4 filesystems where dirindex causes
> randomness, you could also use the disorderfs FUSE-filesystem with its
> shuffle mode to give you random order.
>
> Ciao
> Bernhard M.

Thanks Bernhard!

Acked-by: Ian Rogers <irogers@google.com>

I wonder about determining the order from the mapfile.csv, but that's
another problem for another day.

Thanks,
Ian
