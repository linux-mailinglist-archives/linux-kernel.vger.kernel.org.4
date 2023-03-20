Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0986C2323
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 21:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCTUsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 16:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjCTUsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 16:48:53 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F9593C0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:48:50 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3d7aef37dccso703771cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679345330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iGj9gwcm4e4ac0NCSGO8171w0NDeoSnjyBfeexxjTo=;
        b=GomZIKXsD6iYzuOydfHF7Vmd+/a2V5ldYR8Nc+H906JlSAkGrNW/aCrrn+jWPH74l4
         le8ZJDTPI7d/OrLg4BFEvdt0iaTeKN6e/CNnty2h8rW7sDWYKk5GmN8DoP7epXQZjKGd
         zBDqInSq3D5KL/4+eAMvClcwKo3onL3m9rUG1sIjrlPgiK107rc4QOInKrcqsP0+K2Sm
         Iwgvo3iKQcW9TxKp/QFo39S9YtxuWk8YWLjkzBXOTTu+A9tC4Gk21hzAYyF8Taqv63EP
         Nu5+dt9F1klOu6rBl+WSli0l8vnlqABd5wePDZ2s5jmer9uD9f462wVG/hOsBzXuAzGu
         FU2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679345330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iGj9gwcm4e4ac0NCSGO8171w0NDeoSnjyBfeexxjTo=;
        b=YDqbnZBYGs9bXcECTslyfyiw/CJ3eKset8udbnRwxoQhs9m9/dNfqYCwFVORm2sK8z
         LkmJ66r7LkEGw0BR8dl17hbpeak+taf831nXdd+sMcD1MGa77fuTsw1FIPHf9PPNfl8b
         frhBZ0a4R5e3p2xPZAjGO6QM+PHofK/U2xF3a7YFiOriFE2MXCdi5xXIMWCT7VT/D2Wk
         N9Yy5NptdEoDIH3azp41XMaQmgxYaoMGXMlSe0YjUYCFr48BNY7LR8QH5mP0y9Z8jF/x
         M7cKgCRpHhAo0gjdmX5Ah6yXNKLE9h9OCw2N8jrJ/LOEVGjzcvSYcIBvx6TCb92FNhf1
         fgLA==
X-Gm-Message-State: AO0yUKVhbqEl74goqbUZqXwK+TACHKvth1/e8WMLc4UMR6ZjPLA66LFY
        8JD73hgzHqWk4aCHuZbbrcmTKkVi4UD5q/J2HyKbQg==
X-Google-Smtp-Source: AK7set/G9GbTxjCo4Pwsbe2Elo0X85937zZME0lUs/FSvigtRHGSnx6jYbVWcur4ZREWNa4Zz4O32o9PXllUVNM0u0o=
X-Received: by 2002:a05:622a:170f:b0:3b9:f696:c759 with SMTP id
 h15-20020a05622a170f00b003b9f696c759mr132455qtk.10.1679345329601; Mon, 20 Mar
 2023 13:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230320201841.1133-1-bwiedemann@suse.de>
In-Reply-To: <20230320201841.1133-1-bwiedemann@suse.de>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 20 Mar 2023 13:48:38 -0700
Message-ID: <CAP-5=fUGbT8=spY=e6NPJvf_+Ct6VksFzWM6Eybf=gst_J=Xmw@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: Sort list of input files
To:     "Bernhard M. Wiedemann" <bwiedemann@suse.de>,
        Ben Hutchings <benh@debian.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Mon, Mar 20, 2023 at 1:19=E2=80=AFPM Bernhard M. Wiedemann
<bwiedemann@suse.de> wrote:
>
> Without this, pmu-events.c would be generated with variations in ordering
> depending on non-deterministic filesystem readdir order.
>
> I tested that pmu-events.c still has the same number of lines
> and that perf list output works.
>
> This patch was done while working on reproducible builds for openSUSE,
> but also solves issues in Debian [1] and other distributions.
>
> [1] https://tests.reproducible-builds.org/debian/rb-pkg/unstable/i386/lin=
ux.html
>
> Signed-off-by: Bernhard M. Wiedemann <bwiedemann@suse.de>
> CC: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/pmu-events/jevents.py | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Thanks Bernhard,

I think this may already be addressed by sorting prior to output:
https://lore.kernel.org/r/20220812230949.683239-5-irogers@google.com

Could you confirm?

Thanks,
Ian

>
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 2bcd07ce609f..f06e1abac7c7 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -381,10 +381,13 @@ def read_json_events(path: str, topic: str) -> Sequ=
ence[JsonEvent]:
>
>    return events
>
> +def sorted_scandir(path: str) -> list[os.DirEntry]:
> +  return sorted(os.scandir(path), key=3Dlambda e: e.name)
> +
>  def preprocess_arch_std_files(archpath: str) -> None:
>    """Read in all architecture standard events."""
>    global _arch_std_events
> -  for item in os.scandir(archpath):
> +  for item in sorted_scandir(archpath):
>      if item.is_file() and item.name.endswith('.json'):
>        for event in read_json_events(item.path, topic=3D''):
>          if event.name:
> @@ -497,7 +500,7 @@ def preprocess_one_file(parents: Sequence[str], item:=
 os.DirEntry) -> None:
>  def process_one_file(parents: Sequence[str], item: os.DirEntry) -> None:
>    """Process a JSON file during the main walk."""
>    def is_leaf_dir(path: str) -> bool:
> -    for item in os.scandir(path):
> +    for item in sorted_scandir(path):
>        if item.is_dir():
>          return False
>      return True
> @@ -889,7 +892,7 @@ def main() -> None:
>    def ftw(path: str, parents: Sequence[str],
>            action: Callable[[Sequence[str], os.DirEntry], None]) -> None:
>      """Replicate the directory/file walking behavior of C's file tree wa=
lk."""
> -    for item in os.scandir(path):
> +    for item in sorted_scandir(path):
>        if _args.model !=3D 'all' and item.is_dir():
>          # Check if the model matches one in _args.model.
>          if len(parents) =3D=3D _args.model.split(',')[0].count('/'):
> @@ -930,7 +933,7 @@ struct compact_pmu_event {
>
>  """)
>    archs =3D []
> -  for item in os.scandir(_args.starting_dir):
> +  for item in sorted_scandir(_args.starting_dir):
>      if not item.is_dir():
>        continue
>      if item.name =3D=3D _args.arch or _args.arch =3D=3D 'all' or item.na=
me =3D=3D 'test':
> --
> 2.35.3
>
