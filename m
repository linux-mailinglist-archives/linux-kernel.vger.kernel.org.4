Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E444730EEC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 08:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjFOGAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 02:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237640AbjFOGAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 02:00:00 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F34D10E9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:59:57 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f98276f89cso108971cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 22:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686808796; x=1689400796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwLXNvmJWq+30nrmcBy4VuXtVSXUFElMyNebY4rwbYw=;
        b=Owki3kfyj2jk4cXw5jBbVygHfQAIZD3VYDTG+NbrBQCulZH5ObQ4CUviJo/EXG5P+m
         R25V8eRW/AEYszvBDos9vZ4kQyt5zhmD6s3yVs+ECQYd5eTcg2iaBZPK+eeNpBTEtXyD
         zH7NP8gYW6XmlryDXsmFm7Y46Snw393hLDfeYSanBBtNsYcTfRKzSql6zSCleVfg5GAh
         JeiwhUB3sm+6oPUYmrOsyl/WRCNu2rJefUcsJeDWV3+2DFw/ytX8Qpk6Ay/zrKoP/H2Y
         ZSgrEXrteAn4PWYmFEJC0DD+9Hdll5XqczH39W0w72uVhdv8C6Gk7H8IWjzEZp2Xj33D
         kWug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686808796; x=1689400796;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iwLXNvmJWq+30nrmcBy4VuXtVSXUFElMyNebY4rwbYw=;
        b=iyqKIWIO9ZbiXH0Cw6b5vmMzYvy3WTSLBRDoTvawZMLLU9y0EJtmOMzWSHzMINEYzR
         nEslU2CAO/cxyf2txB0TFHGX4uH+MDbyFkOfu961D4CCKVLwTgsg24ex8DfdR6AZID6D
         hgsjmla6PJB+MbP6gXu7+ouj4lydeBx5TE2yNDw4hyQs1JKYFVHwBMVwvEB6YNi9pYsp
         CioRKgYZzp43KCa5S3y6UPp55d3qIlnzK/iiTxKWv8TovABm0w+1M++BjVugt0ZrCs88
         nQANe3+nmdrG0iUMT0y2XuWz4aaRKwbzZbmCeRbHgSWgYoeP18y31J0IIJtrhJSZPoE4
         uSzg==
X-Gm-Message-State: AC+VfDy2D7kMlFviqk5USfddNlTENKJ7gnCDkzYMfm/voJujhDUSfPCU
        YxV/q8qEJ3bt6qwk8Do3vrLW4rS5ra8QPVnIMmXqxitMIxSwPHxbnaKWgw==
X-Google-Smtp-Source: ACHHUZ7dB7aOllkbSj8zY+iHzILOAFLv5ZA2onSNwUYkdbbXXcNBqzJe7ovQiDJJDF0+iaJ/++u3Xv6xSEQ9NsPU0l4=
X-Received: by 2002:ac8:4e83:0:b0:3f9:a73b:57bb with SMTP id
 3-20020ac84e83000000b003f9a73b57bbmr95837qtp.4.1686808796473; Wed, 14 Jun
 2023 22:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230615001735.3643996-1-kan.liang@linux.intel.com> <20230615001735.3643996-8-kan.liang@linux.intel.com>
In-Reply-To: <20230615001735.3643996-8-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 14 Jun 2023 22:59:44 -0700
Message-ID: <CAP-5=fWHBjBtViACSsGDRN+R+BYYjnRfxqGak1ticwZ0hnZKMw@mail.gmail.com>
Subject: Re: [PATCH V2 7/8] perf test: Move all the check functions of stat
 csv output to lib
To:     kan.liang@linux.intel.com
Cc:     acme@kernel.org, mingo@redhat.com, peterz@infradead.org,
        namhyung@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ak@linux.intel.com, eranian@google.com, ahmad.yasin@intel.com
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

On Wed, Jun 14, 2023 at 5:18=E2=80=AFPM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> These functions can be shared with the stat std output test.
>
> There is no functional change.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/stat_output.sh | 169 +++++++++++++++++++
>  tools/perf/tests/shell/stat+csv_output.sh | 188 ++--------------------
>  2 files changed, 184 insertions(+), 173 deletions(-)
>  create mode 100755 tools/perf/tests/shell/lib/stat_output.sh
>
> diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests=
/shell/lib/stat_output.sh
> new file mode 100755
> index 000000000000..363979b1123d
> --- /dev/null
> +++ b/tools/perf/tests/shell/lib/stat_output.sh
> @@ -0,0 +1,169 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +# Return true if perf_event_paranoid is > $1 and not running as root.
> +function ParanoidAndNotRoot()
> +{
> +        [ "$(id -u)" !=3D 0 ] && [ "$(cat /proc/sys/kernel/perf_event_pa=
ranoid)" -gt $1 ]
> +}
> +
> +# $1 name $2 extra_opt
> +check_no_args()
> +{
> +        echo -n "Checking $1 output: no args"
> +        perf stat $2 true
> +        commachecker --no-args
> +        echo "[Success]"
> +}
> +
> +check_system_wide()
> +{
> +       echo -n "Checking $1 output: system wide "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat -a $2 true
> +       commachecker --system-wide
> +       echo "[Success]"
> +}
> +
> +check_system_wide_no_aggr()
> +{
> +       echo -n "Checking $1 output: system wide no aggregation "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat -A -a --no-merge $2 true
> +       commachecker --system-wide-no-aggr
> +       echo "[Success]"
> +}
> +
> +check_interval()
> +{
> +       echo -n "Checking $1 output: interval "
> +       perf stat -I 1000 $2 true
> +       commachecker --interval
> +       echo "[Success]"
> +}
> +
> +check_event()
> +{
> +       echo -n "Checking $1 output: event "
> +       perf stat -e cpu-clock $2 true
> +       commachecker --event
> +       echo "[Success]"
> +}
> +
> +check_per_core()
> +{
> +       echo -n "Checking $1 output: per core "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat --per-core -a $2 true
> +       commachecker --per-core
> +       echo "[Success]"
> +}
> +
> +check_per_thread()
> +{
> +       echo -n "Checking $1 output: per thread "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat --per-thread -a $2 true
> +       commachecker --per-thread
> +       echo "[Success]"
> +}
> +
> +check_per_cache_instance()
> +{
> +       echo -n "Checking $1 output: per cache instance "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat --per-cache -a $2 true
> +       commachecker --per-cache
> +       echo "[Success]"
> +}
> +
> +check_per_die()
> +{
> +       echo -n "Checking $1 output: per die "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat --per-die -a $2 true
> +       commachecker --per-die
> +       echo "[Success]"
> +}
> +
> +check_per_node()
> +{
> +       echo -n "Checking $1 output: per node "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat --per-node -a $2 true
> +       commachecker --per-node
> +       echo "[Success]"
> +}
> +
> +check_per_socket()
> +{
> +       echo -n "Checking $1 output: per socket "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat --per-socket -a $2 true
> +       commachecker --per-socket
> +       echo "[Success]"
> +}
> +
> +# The perf stat options for per-socket, per-core, per-die
> +# and -A ( no_aggr mode ) uses the info fetched from this
> +# directory: "/sys/devices/system/cpu/cpu*/topology". For
> +# example, socket value is fetched from "physical_package_id"
> +# file in topology directory.
> +# Reference: cpu__get_topology_int in util/cpumap.c
> +# If the platform doesn't expose topology information, values
> +# will be set to -1. For example, incase of pSeries platform
> +# of powerpc, value for  "physical_package_id" is restricted
> +# and set to -1. Check here validates the socket-id read from
> +# topology file before proceeding further
> +
> +FILE_LOC=3D"/sys/devices/system/cpu/cpu*/topology/"
> +FILE_NAME=3D"physical_package_id"
> +
> +function check_for_topology()
> +{
> +       if ! ParanoidAndNotRoot 0
> +       then
> +               socket_file=3D`ls $FILE_LOC/$FILE_NAME | head -n 1`
> +               [ -z $socket_file ] && {
> +                       echo 0
> +                       return
> +               }
> +               socket_id=3D`cat $socket_file`
> +               [ $socket_id =3D=3D -1 ] && {
> +                       echo 1
> +                       return
> +               }
> +       fi
> +       echo 0
> +}
> diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests=
/shell/stat+csv_output.sh
> index ed082daf839c..34a0701fee05 100755
> --- a/tools/perf/tests/shell/stat+csv_output.sh
> +++ b/tools/perf/tests/shell/stat+csv_output.sh
> @@ -6,7 +6,8 @@
>
>  set -e
>
> -skip_test=3D0
> +. $(dirname $0)/lib/stat_output.sh
> +
>  csv_sep=3D@
>
>  stat_output=3D$(mktemp /tmp/__perf_test.stat_output.csv.XXXXX)
> @@ -63,181 +64,22 @@ function commachecker()
>         return 0
>  }
>
> -# Return true if perf_event_paranoid is > $1 and not running as root.
> -function ParanoidAndNotRoot()
> -{
> -        [ "$(id -u)" !=3D 0 ] && [ "$(cat /proc/sys/kernel/perf_event_pa=
ranoid)" -gt $1 ]
> -}
> -
> -check_no_args()
> -{
> -       echo -n "Checking CSV output: no args "
> -       perf stat -x$csv_sep -o "${stat_output}" true
> -        commachecker --no-args
> -       echo "[Success]"
> -}
> -
> -check_system_wide()
> -{
> -       echo -n "Checking CSV output: system wide "
> -       if ParanoidAndNotRoot 0
> -       then
> -               echo "[Skip] paranoid and not root"
> -               return
> -       fi
> -       perf stat -x$csv_sep -a -o "${stat_output}" true
> -        commachecker --system-wide
> -       echo "[Success]"
> -}
> -
> -check_system_wide_no_aggr()
> -{
> -       echo -n "Checking CSV output: system wide no aggregation "
> -       if ParanoidAndNotRoot 0
> -       then
> -               echo "[Skip] paranoid and not root"
> -               return
> -       fi
> -       perf stat -x$csv_sep -A -a --no-merge -o "${stat_output}" true
> -        commachecker --system-wide-no-aggr
> -       echo "[Success]"
> -}
> -
> -check_interval()
> -{
> -       echo -n "Checking CSV output: interval "
> -       perf stat -x$csv_sep -I 1000 -o "${stat_output}" true
> -        commachecker --interval
> -       echo "[Success]"
> -}
> -
> -
> -check_event()
> -{
> -       echo -n "Checking CSV output: event "
> -       perf stat -x$csv_sep -e cpu-clock -o "${stat_output}" true
> -        commachecker --event
> -       echo "[Success]"
> -}
> -
> -check_per_core()
> -{
> -       echo -n "Checking CSV output: per core "
> -       if ParanoidAndNotRoot 0
> -       then
> -               echo "[Skip] paranoid and not root"
> -               return
> -       fi
> -       perf stat -x$csv_sep --per-core -a -o "${stat_output}" true
> -        commachecker --per-core
> -       echo "[Success]"
> -}
> -
> -check_per_thread()
> -{
> -       echo -n "Checking CSV output: per thread "
> -       if ParanoidAndNotRoot 0
> -       then
> -               echo "[Skip] paranoid and not root"
> -               return
> -       fi
> -       perf stat -x$csv_sep --per-thread -a -o "${stat_output}" true
> -        commachecker --per-thread
> -       echo "[Success]"
> -}
> -
> -check_per_cache_instance()
> -{
> -       echo -n "Checking CSV output: per cache instance "
> -       if ParanoidAndNotRoot 0
> -       then
> -               echo "[Skip] paranoid and not root"
> -               return
> -       fi
> -       perf stat -x$csv_sep --per-cache -a true 2>&1 | commachecker --pe=
r-cache
> -       echo "[Success]"
> -}
> -
> -check_per_die()
> -{
> -       echo -n "Checking CSV output: per die "
> -       if ParanoidAndNotRoot 0
> -       then
> -               echo "[Skip] paranoid and not root"
> -               return
> -       fi
> -       perf stat -x$csv_sep --per-die -a -o "${stat_output}" true
> -        commachecker --per-die
> -       echo "[Success]"
> -}
> -
> -check_per_node()
> -{
> -       echo -n "Checking CSV output: per node "
> -       if ParanoidAndNotRoot 0
> -       then
> -               echo "[Skip] paranoid and not root"
> -               return
> -       fi
> -       perf stat -x$csv_sep --per-node -a -o "${stat_output}" true
> -        commachecker --per-node
> -       echo "[Success]"
> -}
> -
> -check_per_socket()
> -{
> -       echo -n "Checking CSV output: per socket "
> -       if ParanoidAndNotRoot 0
> -       then
> -               echo "[Skip] paranoid and not root"
> -               return
> -       fi
> -       perf stat -x$csv_sep --per-socket -a -o "${stat_output}" true
> -        commachecker --per-socket
> -       echo "[Success]"
> -}
> -
> -# The perf stat options for per-socket, per-core, per-die
> -# and -A ( no_aggr mode ) uses the info fetched from this
> -# directory: "/sys/devices/system/cpu/cpu*/topology". For
> -# example, socket value is fetched from "physical_package_id"
> -# file in topology directory.
> -# Reference: cpu__get_topology_int in util/cpumap.c
> -# If the platform doesn't expose topology information, values
> -# will be set to -1. For example, incase of pSeries platform
> -# of powerpc, value for  "physical_package_id" is restricted
> -# and set to -1. Check here validates the socket-id read from
> -# topology file before proceeding further
> -
> -FILE_LOC=3D"/sys/devices/system/cpu/cpu*/topology/"
> -FILE_NAME=3D"physical_package_id"
> -
> -check_for_topology()
> -{
> -       if ! ParanoidAndNotRoot 0
> -       then
> -               socket_file=3D`ls $FILE_LOC/$FILE_NAME | head -n 1`
> -               [ -z $socket_file ] && return 0
> -               socket_id=3D`cat $socket_file`
> -               [ $socket_id =3D=3D -1 ] && skip_test=3D1
> -               return 0
> -       fi
> -}
> +perf_cmd=3D"-x$csv_sep -o ${stat_output}"
>
> -check_for_topology
> -check_no_args
> -check_system_wide
> -check_interval
> -check_event
> -check_per_thread
> -check_per_node
> +skip_test=3D$(check_for_topology)
> +check_no_args "CSV" "$perf_cmd"
> +check_system_wide "CSV" "$perf_cmd"
> +check_interval "CSV" "$perf_cmd"
> +check_event "CSV" "$perf_cmd"
> +check_per_thread "CSV" "$perf_cmd"
> +check_per_node "CSV" "$perf_cmd"
>  if [ $skip_test -ne 1 ]
>  then
> -       check_system_wide_no_aggr
> -       check_per_core
> -       check_per_cache_instance
> -       check_per_die
> -       check_per_socket
> +       check_system_wide_no_aggr "CSV" "$perf_cmd"
> +       check_per_core "CSV" "$perf_cmd"
> +       check_per_cache_instance "CSV" "$perf_cmd"
> +       check_per_die "CSV" "$perf_cmd"
> +       check_per_socket "CSV" "$perf_cmd"
>  else
>         echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, pe=
r_die and per_socket since socket id exposed via topology is invalid"
>  fi
> --
> 2.35.1
>
