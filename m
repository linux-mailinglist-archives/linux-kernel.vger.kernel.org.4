Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9396A8980
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 20:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbjCBTaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 14:30:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjCBTax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 14:30:53 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEF442822D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 11:30:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id bw19so152790wrb.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 11:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677785450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdfkaCxTTajRPSsbsJ97SHWhUVr+A+uzvn+OY5HHtX8=;
        b=nCcHELpdSKKenDMqLjWJfap/VwM2vZ4RxJym41kpnMRXLSUldD2SYidfIQyQ1EEhK6
         qFzrOpwT7VcixwxYMReCpVH7iMWXzUqq4hR1Mrt1CRI95JU5inf7NGToeNmvj6ynp1eT
         HnnXSvyAwvg42yGLoy4wjMRbZcxvhuLE4JWVMVguwbZqTrOU+MA12VQUZNrpkZjkWZW6
         JQlHwtMsiN+Cd/e54W4/sUppHXv1kHWg800rz6XmyZjhocQvUiyYvlhuU9B9/lrDvRa4
         UZjx6iqcSLTOjUWKUg8YgR0DOEPdrKLAlStXw1ocJXtjqfV950ppG1EWRlsozix5mVV0
         c4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677785450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mdfkaCxTTajRPSsbsJ97SHWhUVr+A+uzvn+OY5HHtX8=;
        b=RLWDrVZB5e0N5rvoL5iz0S3MpEnOaUEeE9QSrxhC3s7xz8s3XZgbQ9hYXd4l2Gq8H8
         GSRd4Sc+tHAqMHO83M/tY/ZfgmSLdCPIVjbisT+RtvFK/I/oXBuZg2ePVo7Ut5AD25E5
         yfyS70UWo1Oy2+ogi8gPfdxWFeqPlIs+tnbdd5LGpyQs4zxSHpLxqQA7otNNffT3qG+M
         V/Zr2vCvxItAa27+prZHj+uoCyflwWADxmGPB5a8CUWZGbkmdoL9vSFo8sbKrci189IO
         ufbiaogQ3apAuwmIhiTvNAB5TpK04yEmVJAQ1IzfNBVvRiPI6dIEBokH+KSyNX3ev52/
         CJRg==
X-Gm-Message-State: AO0yUKVoNfbRZF1S+TrX9biQoyyb/aF0dKFTssd1pBpYP55MWQfQko4+
        pTHXcgaLZ1iSVIkh0ixQyfLYbGeoWgOeazUlt1Uxbg==
X-Google-Smtp-Source: AK7set8v8kkp4qS9ZFKIM2fncYdYWOiv+Tuu978JsleCGV6ETTqLN8XqF54d5C0eUR01uokzyOKFNY6BIVI1Iab5zVI=
X-Received: by 2002:a5d:4dc3:0:b0:2c9:868e:91a with SMTP id
 f3-20020a5d4dc3000000b002c9868e091amr1890975wru.9.1677785449870; Thu, 02 Mar
 2023 11:30:49 -0800 (PST)
MIME-Version: 1.0
References: <20230223071818.329671-1-irogers@google.com> <Y/dq4yO+zXYLCQ8d@kernel.org>
In-Reply-To: <Y/dq4yO+zXYLCQ8d@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 2 Mar 2023 11:30:36 -0800
Message-ID: <CAP-5=fXuZ=sWJcKFUSPVSpjmHFHzSWQEMfoisvjqzJz2dDOXWQ@mail.gmail.com>
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 5:32=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Wed, Feb 22, 2023 at 11:18:17PM -0800, Ian Rogers escreveu:
> > Commas may appear in events like:
> > cpu/INT_MISC.RECOVERY_CYCLES,cmask=3D1,edge/
> > which causes the commachecker to see more fields than expected. Use @
> > as the CSV separator to avoid this.
>
> Thanks, applied both patches.

Thanks Arnaldo, I don't see the patches in the git branches so perhaps
something went wrong?

Ian

> - Arnaldo
>
>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/tests/shell/stat+csv_output.sh | 23 ++++++++++++-----------
> >  1 file changed, 12 insertions(+), 11 deletions(-)
> >
> > diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tes=
ts/shell/stat+csv_output.sh
> > index b7f050aa6210..324fc9e6edd7 100755
> > --- a/tools/perf/tests/shell/stat+csv_output.sh
> > +++ b/tools/perf/tests/shell/stat+csv_output.sh
> > @@ -7,6 +7,7 @@
> >  set -e
> >
> >  skip_test=3D0
> > +csv_sep=3D@
> >
> >  function commachecker()
> >  {
> > @@ -34,7 +35,7 @@ function commachecker()
> >               [ "$x" =3D "Failed" ] && continue
> >
> >               # Count the number of commas
> > -             x=3D$(echo $line | tr -d -c ',')
> > +             x=3D$(echo $line | tr -d -c $csv_sep)
> >               cnt=3D"${#x}"
> >               # echo $line $cnt
> >               [[ ! "$cnt" =3D~ $exp ]] && {
> > @@ -54,7 +55,7 @@ function ParanoidAndNotRoot()
> >  check_no_args()
> >  {
> >       echo -n "Checking CSV output: no args "
> > -     perf stat -x, true 2>&1 | commachecker --no-args
> > +     perf stat -x$csv_sep true 2>&1 | commachecker --no-args
> >       echo "[Success]"
> >  }
> >
> > @@ -66,7 +67,7 @@ check_system_wide()
> >               echo "[Skip] paranoid and not root"
> >               return
> >       fi
> > -     perf stat -x, -a true 2>&1 | commachecker --system-wide
> > +     perf stat -x$csv_sep -a true 2>&1 | commachecker --system-wide
> >       echo "[Success]"
> >  }
> >
> > @@ -79,14 +80,14 @@ check_system_wide_no_aggr()
> >               return
> >       fi
> >       echo -n "Checking CSV output: system wide no aggregation "
> > -     perf stat -x, -A -a --no-merge true 2>&1 | commachecker --system-=
wide-no-aggr
> > +     perf stat -x$csv_sep -A -a --no-merge true 2>&1 | commachecker --=
system-wide-no-aggr
> >       echo "[Success]"
> >  }
> >
> >  check_interval()
> >  {
> >       echo -n "Checking CSV output: interval "
> > -     perf stat -x, -I 1000 true 2>&1 | commachecker --interval
> > +     perf stat -x$csv_sep -I 1000 true 2>&1 | commachecker --interval
> >       echo "[Success]"
> >  }
> >
> > @@ -94,7 +95,7 @@ check_interval()
> >  check_event()
> >  {
> >       echo -n "Checking CSV output: event "
> > -     perf stat -x, -e cpu-clock true 2>&1 | commachecker --event
> > +     perf stat -x$csv_sep -e cpu-clock true 2>&1 | commachecker --even=
t
> >       echo "[Success]"
> >  }
> >
> > @@ -106,7 +107,7 @@ check_per_core()
> >               echo "[Skip] paranoid and not root"
> >               return
> >       fi
> > -     perf stat -x, --per-core -a true 2>&1 | commachecker --per-core
> > +     perf stat -x$csv_sep --per-core -a true 2>&1 | commachecker --per=
-core
> >       echo "[Success]"
> >  }
> >
> > @@ -118,7 +119,7 @@ check_per_thread()
> >               echo "[Skip] paranoid and not root"
> >               return
> >       fi
> > -     perf stat -x, --per-thread -a true 2>&1 | commachecker --per-thre=
ad
> > +     perf stat -x$csv_sep --per-thread -a true 2>&1 | commachecker --p=
er-thread
> >       echo "[Success]"
> >  }
> >
> > @@ -130,7 +131,7 @@ check_per_die()
> >               echo "[Skip] paranoid and not root"
> >               return
> >       fi
> > -     perf stat -x, --per-die -a true 2>&1 | commachecker --per-die
> > +     perf stat -x$csv_sep --per-die -a true 2>&1 | commachecker --per-=
die
> >       echo "[Success]"
> >  }
> >
> > @@ -142,7 +143,7 @@ check_per_node()
> >               echo "[Skip] paranoid and not root"
> >               return
> >       fi
> > -     perf stat -x, --per-node -a true 2>&1 | commachecker --per-node
> > +     perf stat -x$csv_sep --per-node -a true 2>&1 | commachecker --per=
-node
> >       echo "[Success]"
> >  }
> >
> > @@ -154,7 +155,7 @@ check_per_socket()
> >               echo "[Skip] paranoid and not root"
> >               return
> >       fi
> > -     perf stat -x, --per-socket -a true 2>&1 | commachecker --per-sock=
et
> > +     perf stat -x$csv_sep --per-socket -a true 2>&1 | commachecker --p=
er-socket
> >       echo "[Success]"
> >  }
> >
> > --
> > 2.39.2.637.g21b0678d19-goog
> >
>
> --
>
> - Arnaldo
