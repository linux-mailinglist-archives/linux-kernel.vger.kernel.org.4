Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E3E72ECD5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240825AbjFMUVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjFMUVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:21:43 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604E298
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:21:42 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f9a81da5d7so70171cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 13:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686687701; x=1689279701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0Cy2vujaFKSDY95ZmH0ol5S2C2EMV/ACOqku8ieMcw=;
        b=aqmVAmW/QwJ8tG2J7VEOnkJGL6QuO0tHCpFh6i20oWXnOI5bwChepbEsI4gaRivsoi
         gKqzR1YJbo482DP0Aif9O7IJAAkuQup5tVzZaqxyNy3qljk66VIVcVKh4+ovANZkeyBe
         dXoO2aivMvIqDg18wFe3gEdhVXTIDlt2iwbhyCNTlA1nWg7xw5MgD3fTZVbp6tTBq6bJ
         pA1nEjShefn1Gk30S80p3YfEZEvTYe3fAWMvXqN8j9BP+9wDCOKiBfKZhfbThTeZvJQk
         7thv67SFLWjA99JfjBMJUp2lRnDQRzXbH6I4RvXmbeAgi+Kl7VsDnTSu0DxpFvngOvF+
         wrog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686687701; x=1689279701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0Cy2vujaFKSDY95ZmH0ol5S2C2EMV/ACOqku8ieMcw=;
        b=TOOqMM3Nvo/VXOHjjyDv4JK4qr9WYsAtmK229ufNOO9TwA9RXYIUJpscWkVCuc4Xo2
         BZGGb0mbAnf17VGfRXW3K1N2/7alvgylXhb0T9mqPgea/DV1FEMIKo+LHHY9FsH5WAks
         nGrOWnLxz/JbTG3E8U4ADCyN10XXceTEaH0azrvxdB+OkOXSEkVQhDhioBXjS0nWfx0u
         R89yuDrhxEaPZz+jGkmq+KVnUR+QIWXMeNXB75Jymg4gzK4sHXRN45z8SQnogmVU2nLL
         gghFi/VEYB63cReh2JT0pLk28HaQowddqodVDJBKH/FNHhsfWhT+epigybpnAw0VVJ3N
         5ZVw==
X-Gm-Message-State: AC+VfDwbjdjR6VasEIkB1i6knHldALFfabvDuQpUzQffLiacrkoqGz/D
        /qC1wXgPuCt8z1tAINqiMnPCQXBJpoJcge1OUfTWPw==
X-Google-Smtp-Source: ACHHUZ7FtTKF6BY6NqpaeF6aacL/pSEK+AEn81qDhoywfyv4zpPxc6f1V4uGmmUVIHopR5Cu7OTqKjfNRO7oiq2mvqw=
X-Received: by 2002:a05:622a:11d1:b0:3e0:c2dd:fd29 with SMTP id
 n17-20020a05622a11d100b003e0c2ddfd29mr51724qtk.4.1686687701335; Tue, 13 Jun
 2023 13:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230607162700.3234712-1-kan.liang@linux.intel.com> <20230607162700.3234712-9-kan.liang@linux.intel.com>
In-Reply-To: <20230607162700.3234712-9-kan.liang@linux.intel.com>
From:   Ian Rogers <irogers@google.com>
Date:   Tue, 13 Jun 2023 13:21:30 -0700
Message-ID: <CAP-5=fV7b=xGuSED88mNJ1k86mTt3YH185+PsedqWPYg4EL0zQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] perf test: Add test case for the standard perf stat output
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 7, 2023 at 9:27=E2=80=AFAM <kan.liang@linux.intel.com> wrote:
>
> From: Kan Liang <kan.liang@linux.intel.com>
>
> Add a new test case to verify the standard perf stat output with
> different options.
>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  tools/perf/tests/shell/stat+std_output.sh | 259 ++++++++++++++++++++++
>  1 file changed, 259 insertions(+)
>  create mode 100755 tools/perf/tests/shell/stat+std_output.sh
>
> diff --git a/tools/perf/tests/shell/stat+std_output.sh b/tools/perf/tests=
/shell/stat+std_output.sh
> new file mode 100755
> index 000000000000..b9db0f245450
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat+std_output.sh
> @@ -0,0 +1,259 @@
> +#!/bin/bash
> +# perf stat STD output linter
> +# SPDX-License-Identifier: GPL-2.0
> +# Tests various perf stat STD output commands for
> +# default event and metricgroup
> +
> +set -e
> +
> +skip_test=3D0
> +
> +stat_output=3D$(mktemp /tmp/__perf_test.stat_output.std.XXXXX)
> +
> +event_name=3D(cpu-clock task-clock context-switches cpu-migrations page-=
faults cycles instructions branches branch-misses stalled-cycles-frontend s=
talled-cycles-backend)
> +event_metric=3D("CPUs utilized" "CPUs utilized" "/sec" "/sec" "/sec" "GH=
z" "insn per cycle" "/sec" "of all branches" "frontend cycles idle" "backen=
d cycles idle")
> +
> +metricgroup_name=3D(TopdownL1 TopdownL2)
> +
> +cleanup() {
> +  rm -f "${stat_output}"
> +
> +  trap - EXIT TERM INT
> +}
> +
> +trap_cleanup() {
> +  cleanup
> +  exit 1
> +}
> +trap trap_cleanup EXIT TERM INT
> +
> +function commachecker()
> +{
> +       local -i cnt=3D0
> +       local prefix=3D1
> +
> +       case "$1"
> +       in "--interval")        prefix=3D2
> +       ;; "--per-thread")      prefix=3D2
> +       ;; "--system-wide-no-aggr")     prefix=3D2
> +       ;; "--per-core")        prefix=3D3
> +       ;; "--per-socket")      prefix=3D3
> +       ;; "--per-node")        prefix=3D3
> +       ;; "--per-die")         prefix=3D3
> +       ;; "--per-cache")       prefix=3D3
> +       esac
> +
> +       while read line
> +       do
> +               # Ignore initial "started on" comment.
> +               x=3D${line:0:1}
> +               [ "$x" =3D "#" ] && continue
> +               # Ignore initial blank line.
> +               [ "$line" =3D "" ] && continue
> +               # Ignore "Performance counter stats"
> +               x=3D${line:0:25}
> +               [ "$x" =3D "Performance counter stats" ] && continue
> +               # Ignore "seconds time elapsed" and break
> +               [[ "$line" =3D=3D *"time elapsed"* ]] && break
> +
> +               main_body=3D$(echo $line | cut -d' ' -f$prefix-)
> +               x=3D${main_body%#*}
> +               # Check default metricgroup
> +               y=3D$(echo $x | tr -d ' ')
> +               [ "$y" =3D "" ] && continue
> +               for i in "${!metricgroup_name[@]}"; do
> +                       [[ "$y" =3D=3D *"${metricgroup_name[$i]}"* ]] && =
break
> +               done
> +               [[ "$y" =3D=3D *"${metricgroup_name[$i]}"* ]] && continue
> +
> +               # Check default event
> +               for i in "${!event_name[@]}"; do
> +                       [[ "$x" =3D=3D *"${event_name[$i]}"* ]] && break
> +               done
> +
> +               [[ ! "$x" =3D=3D *"${event_name[$i]}"* ]] && {
> +                       echo "Unknown event name in $line" 1>&2
> +                       exit 1;
> +               }
> +
> +               # Check event metric if it exists
> +               [[ ! "$main_body" =3D=3D *"#"* ]] && continue
> +               [[ ! "$main_body" =3D=3D *"${event_metric[$i]}"* ]] && {
> +                       echo "wrong event metric. expected ${event_metric=
[$i]} in $line" 1>&2
> +                       exit 1;
> +               }
> +       done < "${stat_output}"
> +       return 0
> +}
> +
> +# Return true if perf_event_paranoid is > $1 and not running as root.
> +function ParanoidAndNotRoot()
> +{
> +        [ $(id -u) !=3D 0 ] && [ $(cat /proc/sys/kernel/perf_event_paran=
oid) -gt $1 ]
> +}
> +
> +check_no_args()
> +{
> +       echo -n "Checking STD output: no args "
> +       perf stat -o "${stat_output}" true
> +        commachecker --no-args
> +       echo "[Success]"
> +}
> +
> +check_system_wide()
> +{
> +       echo -n "Checking STD output: system wide "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat -a -o "${stat_output}" true
> +        commachecker --system-wide
> +       echo "[Success]"
> +}
> +
> +check_system_wide_no_aggr()
> +{
> +       echo -n "Checking STD output: system wide no aggregation "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat -A -a --no-merge -o "${stat_output}" true
> +        commachecker --system-wide-no-aggr
> +       echo "[Success]"
> +}
> +
> +check_interval()
> +{
> +       echo -n "Checking STD output: interval "
> +       perf stat -I 1000 -o "${stat_output}" true
> +        commachecker --interval
> +       echo "[Success]"
> +}
> +
> +
> +check_per_core()
> +{
> +       echo -n "Checking STD output: per core "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat --per-core -a -o "${stat_output}" true
> +        commachecker --per-core
> +       echo "[Success]"
> +}
> +
> +check_per_thread()
> +{
> +       echo -n "Checking STD output: per thread "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat --per-thread -a -o "${stat_output}" true
> +        commachecker --per-thread
> +       echo "[Success]"
> +}
> +
> +check_per_cache_instance()
> +{
> +       echo -n "Checking STD output: per cache instance "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat  --per-cache -a true 2>&1 | commachecker --per-cache
> +       echo "[Success]"
> +}
> +
> +check_per_die()
> +{
> +       echo -n "Checking STD output: per die "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat --per-die -a -o "${stat_output}" true
> +        commachecker --per-die
> +       echo "[Success]"
> +}
> +
> +check_per_node()
> +{
> +       echo -n "Checking STD output: per node "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat --per-node -a -o "${stat_output}" true
> +        commachecker --per-node
> +       echo "[Success]"
> +}
> +
> +check_per_socket()
> +{
> +       echo -n "Checking STD output: per socket "
> +       if ParanoidAndNotRoot 0
> +       then
> +               echo "[Skip] paranoid and not root"
> +               return
> +       fi
> +       perf stat --per-socket -a -o "${stat_output}" true
> +        commachecker --per-socket
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
> +check_for_topology()
> +{
> +       if ! ParanoidAndNotRoot 0
> +       then
> +               socket_file=3D`ls $FILE_LOC/$FILE_NAME | head -n 1`
> +               [ -z $socket_file ] && return 0
> +               socket_id=3D`cat $socket_file`
> +               [ $socket_id =3D=3D -1 ] && skip_test=3D1
> +               return 0
> +       fi
> +}

Tests, great! This logic is taken from
tools/perf/tests/shell/stat+csv_output.sh, could we share the
implementation between that and here by moving the code into something
in the lib directory?

Thanks,
Ian

> +
> +check_for_topology
> +check_no_args
> +check_system_wide
> +check_interval
> +check_per_thread
> +check_per_node
> +if [ $skip_test -ne 1 ]
> +then
> +       check_system_wide_no_aggr
> +       check_per_core
> +       check_per_cache_instance
> +       check_per_die
> +       check_per_socket
> +else
> +       echo "[Skip] Skipping tests for system_wide_no_aggr, per_core, pe=
r_die and per_socket since socket id exposed via topology is invalid"
> +fi
> +cleanup
> +exit 0
> --
> 2.35.1
>
