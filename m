Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1286AA62B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 01:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCDAPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 19:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCDAPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 19:15:31 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C459D2BF13
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 16:15:29 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id v10so1690992iox.8
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 16:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677888929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DH/huBKc05VkKi0Pa9Nd68GqeoHNsDb+c2sFg42hjVU=;
        b=tB9adW87yWkt3ipX0jZr1TZjqf3gaoWVCa+mUGjPziGhkp2HMOPi5zz3qEsyyBQYJx
         kF77+Nd7Hx9JYdF6k//pzzfcFBQVfAwUMmWQPyVTL2aIoIEfNLCg2V+g1hJ6E605YqxJ
         I5fziSLG+p+vLRu475n9rrhliCN0GFu3JEi+qMcouLX8R8m2hdThnh/wi3JpNHMrGGUe
         OwsWIShTWdyutCpTZOgPO0j65eVtZaD/YgFbwAaUC3JtSn19zDCLofnBA06eEql1VpXG
         qWJ7Pa9xkredIVxiJqvyTAHkPnXGXa1jSFgUNUbljEoc95P1UU1Er1GRB7grpMa52EtN
         m+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677888929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DH/huBKc05VkKi0Pa9Nd68GqeoHNsDb+c2sFg42hjVU=;
        b=oxCoSMup/cbZxWBBaclb6vaCUKlL+wqCSW/gT/gGxiQpxy+my/sgkJhHuFtdO1Rm+U
         mqwu60MhIBf+O1tXcLagf72mS4NAyWEJBPDHSr2pstexcdQrbTfAoKPgOuZ3Xdtk8Hrj
         rKg23ndyqE3fRg48h3ImXgBTfUpcYl56+fKnc4cTFa67z7UqlYufP9kyS6SdOFvp1ApH
         6b0zo/p9HUNCBTDEmH+RFY01vp+QVfRHti1aip6vc8qcgVzraMi7vP/oRWWkoq9MvSfT
         XwMm+YcKU4fqrVeHmZN+dG43EMox7drd+bhlbqJzNq69bKbH6UCL0ET0r14p6B85ESgF
         zEPQ==
X-Gm-Message-State: AO0yUKX35yiMl7JQa1eO00gDEl9VtoaNaYhZW1NhuAeDCNSv7dYKgfnT
        kbr0eFsew7/adAjuskihiYEMs8Vm1CqJApw8VckzHw==
X-Google-Smtp-Source: AK7set9uWODy1xGUkdXMgLnbJ4ULDScYxo3ilV9y0EjHQL/d09kg2Yld1urfbk6D7hr4nVs8UQb0goA7WjMH3pg+eUA=
X-Received: by 2002:a5e:c002:0:b0:74a:f35:ca88 with SMTP id
 u2-20020a5ec002000000b0074a0f35ca88mr1501692iol.2.1677888928991; Fri, 03 Mar
 2023 16:15:28 -0800 (PST)
MIME-Version: 1.0
References: <20230223071818.329671-1-irogers@google.com> <Y/dq4yO+zXYLCQ8d@kernel.org>
 <CAP-5=fXuZ=sWJcKFUSPVSpjmHFHzSWQEMfoisvjqzJz2dDOXWQ@mail.gmail.com> <ZAEJy6RXAGjd7Erb@kernel.org>
In-Reply-To: <ZAEJy6RXAGjd7Erb@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 3 Mar 2023 16:15:17 -0800
Message-ID: <CAP-5=fXS0pUsYXDrvwMgGJnYV=+1-PO+nE+b0FHR5YbNZzYSQg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf tests stat+csv_output: Switch CSV separator
 to @
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Claire Jensen <cjense@google.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 12:40=E2=80=AFPM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Mar 02, 2023 at 11:30:36AM -0800, Ian Rogers escreveu:
> > On Thu, Feb 23, 2023 at 5:32=E2=80=AFAM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > Em Wed, Feb 22, 2023 at 11:18:17PM -0800, Ian Rogers escreveu:
> > > > Commas may appear in events like:
> > > > cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> > > > which causes the commachecker to see more fields than expected. Use=
 @
> > > > as the CSV separator to avoid this.
> > >
> > > Thanks, applied both patches.
> >
> > Thanks Arnaldo, I don't see the patches in the git branches so perhaps
> > something went wrong?
>
> Its in my local branch, I'll push it.

Thanks Arnaldo! I see the change in perf-tools and perf/urgent which
means they should appear in Linux 6.3. How do these things get merged
into perf-tools-next? I'm building upon them for changes targeting
Linux 6.4.

Thanks,
Ian

> > Ian
> >
> > > - Arnaldo
> > >
> > >
> > > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > > ---
> > > >  tools/perf/tests/shell/stat+csv_output.sh | 23 ++++++++++++-------=
----
> > > >  1 file changed, 12 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf=
/tests/shell/stat+csv_output.sh
> > > > index b7f050aa6210..324fc9e6edd7 100755
> > > > --- a/tools/perf/tests/shell/stat+csv_output.sh
> > > > +++ b/tools/perf/tests/shell/stat+csv_output.sh
> > > > @@ -7,6 +7,7 @@
> > > >  set -e
> > > >
> > > >  skip_test=3D0
> > > > +csv_sep=3D@
> > > >
> > > >  function commachecker()
> > > >  {
> > > > @@ -34,7 +35,7 @@ function commachecker()
> > > >               [ "$x" =3D "Failed" ] && continue
> > > >
> > > >               # Count the number of commas
> > > > -             x=3D$(echo $line | tr -d -c ',')
> > > > +             x=3D$(echo $line | tr -d -c $csv_sep)
> > > >               cnt=3D"${#x}"
> > > >               # echo $line $cnt
> > > >               [[ ! "$cnt" =3D~ $exp ]] && {
> > > > @@ -54,7 +55,7 @@ function ParanoidAndNotRoot()
> > > >  check_no_args()
> > > >  {
> > > >       echo -n "Checking CSV output: no args "
> > > > -     perf stat -x, true 2>&1 | commachecker --no-args
> > > > +     perf stat -x$csv_sep true 2>&1 | commachecker --no-args
> > > >       echo "[Success]"
> > > >  }
> > > >
> > > > @@ -66,7 +67,7 @@ check_system_wide()
> > > >               echo "[Skip] paranoid and not root"
> > > >               return
> > > >       fi
> > > > -     perf stat -x, -a true 2>&1 | commachecker --system-wide
> > > > +     perf stat -x$csv_sep -a true 2>&1 | commachecker --system-wid=
e
> > > >       echo "[Success]"
> > > >  }
> > > >
> > > > @@ -79,14 +80,14 @@ check_system_wide_no_aggr()
> > > >               return
> > > >       fi
> > > >       echo -n "Checking CSV output: system wide no aggregation "
> > > > -     perf stat -x, -A -a --no-merge true 2>&1 | commachecker --sys=
tem-wide-no-aggr
> > > > +     perf stat -x$csv_sep -A -a --no-merge true 2>&1 | commachecke=
r --system-wide-no-aggr
> > > >       echo "[Success]"
> > > >  }
> > > >
> > > >  check_interval()
> > > >  {
> > > >       echo -n "Checking CSV output: interval "
> > > > -     perf stat -x, -I 1000 true 2>&1 | commachecker --interval
> > > > +     perf stat -x$csv_sep -I 1000 true 2>&1 | commachecker --inter=
val
> > > >       echo "[Success]"
> > > >  }
> > > >
> > > > @@ -94,7 +95,7 @@ check_interval()
> > > >  check_event()
> > > >  {
> > > >       echo -n "Checking CSV output: event "
> > > > -     perf stat -x, -e cpu-clock true 2>&1 | commachecker --event
> > > > +     perf stat -x$csv_sep -e cpu-clock true 2>&1 | commachecker --=
event
> > > >       echo "[Success]"
> > > >  }
> > > >
> > > > @@ -106,7 +107,7 @@ check_per_core()
> > > >               echo "[Skip] paranoid and not root"
> > > >               return
> > > >       fi
> > > > -     perf stat -x, --per-core -a true 2>&1 | commachecker --per-co=
re
> > > > +     perf stat -x$csv_sep --per-core -a true 2>&1 | commachecker -=
-per-core
> > > >       echo "[Success]"
> > > >  }
> > > >
> > > > @@ -118,7 +119,7 @@ check_per_thread()
> > > >               echo "[Skip] paranoid and not root"
> > > >               return
> > > >       fi
> > > > -     perf stat -x, --per-thread -a true 2>&1 | commachecker --per-=
thread
> > > > +     perf stat -x$csv_sep --per-thread -a true 2>&1 | commachecker=
 --per-thread
> > > >       echo "[Success]"
> > > >  }
> > > >
> > > > @@ -130,7 +131,7 @@ check_per_die()
> > > >               echo "[Skip] paranoid and not root"
> > > >               return
> > > >       fi
> > > > -     perf stat -x, --per-die -a true 2>&1 | commachecker --per-die
> > > > +     perf stat -x$csv_sep --per-die -a true 2>&1 | commachecker --=
per-die
> > > >       echo "[Success]"
> > > >  }
> > > >
> > > > @@ -142,7 +143,7 @@ check_per_node()
> > > >               echo "[Skip] paranoid and not root"
> > > >               return
> > > >       fi
> > > > -     perf stat -x, --per-node -a true 2>&1 | commachecker --per-no=
de
> > > > +     perf stat -x$csv_sep --per-node -a true 2>&1 | commachecker -=
-per-node
> > > >       echo "[Success]"
> > > >  }
> > > >
> > > > @@ -154,7 +155,7 @@ check_per_socket()
> > > >               echo "[Skip] paranoid and not root"
> > > >               return
> > > >       fi
> > > > -     perf stat -x, --per-socket -a true 2>&1 | commachecker --per-=
socket
> > > > +     perf stat -x$csv_sep --per-socket -a true 2>&1 | commachecker=
 --per-socket
> > > >       echo "[Success]"
> > > >  }
> > > >
> > > > --
> > > > 2.39.2.637.g21b0678d19-goog
> > > >
> > >
> > > --
> > >
> > > - Arnaldo
>
> --
>
> - Arnaldo
