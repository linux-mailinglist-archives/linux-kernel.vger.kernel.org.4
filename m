Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4D86D0E52
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 21:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjC3TIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 15:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231886AbjC3TIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 15:08:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A2ED534
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:08:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id br6so25793384lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680203281; x=1682795281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UkfHhmuNDtES3wYzezkCW7sqz9SEBsf93iKb4NtAWWA=;
        b=OAORZJ8B+8ILUveEQSOditFI7MMuGWICgBkrpgTQ2xdhvDWj7J/d0D4CvFK7NkGQ+f
         KkshquZXiFWKUu9VIJPRxmzVwn2aDGy0L+9JkgeaH7qOD3cd8G0WZSV+5erFU9jx8KOI
         OxNzjaUcyKtiNUoumP5e8zlQycBurpLjhXrn4pjRBwTUfApID38epXge+2vkQjCD2gKr
         Cr+42b1RJDE/kSlr1oaWM73CegUJ2A2GV1lHYoRyTL+PbabmBOaSWv9zc9YLr4nnfXZy
         MLT7UJHXlwCmrgzV2qYlqkAmqxM54pdZUJM5aMMjpNtjy8qGsTOXkCR+JjVxYIeiAFD+
         lp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680203281; x=1682795281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkfHhmuNDtES3wYzezkCW7sqz9SEBsf93iKb4NtAWWA=;
        b=3r58JAqkLi+9cZjMfSkOWCmmqq7Db+zab//DlUlNm3gJZz8CgMS7pEGkDalWV15jLc
         AoqZm2YJzu7s8ej482wN+Tvo0NM8ULetLFTH6vi3f9zrQI1UDR5YGtqztvoBVf9m7b4j
         uQFy31bw6ZKnci7wFMJH0lPVqome/Y70z3IZmDlpPSxNPnOCKp+aOcmsvOX4sRAjwT+B
         kff69vpa0bMJlKl1fXYDxX2GGTn8CZEJGkFhgt1lpbw7CClWfiFrdfF4PcWUzvMYeauD
         8HSibzrYMgcHwzkKOywQRI7uqcERJj7xrs8vp8N/WsXnysL++4T/Gj8rSRbIxCpIUOAx
         tOzg==
X-Gm-Message-State: AAQBX9cWQpXpg+hPJMj/n/LMqRhLhO3riGoLJXO+FELNFAhXDzPDb7dP
        M2ItiGT/tUn7hXpKqOkd4dKdHktTubIZ738rT1tGEA==
X-Google-Smtp-Source: AKy350YDDs/afajur7OK3Ca3KVN76ejnOJuk5Tc5kvk9hEjc+j+Mk0udD+7c4Hm707MMe6h5g0SuPMQWzFpnMlMK98U=
X-Received: by 2002:ac2:50c3:0:b0:4d5:ca32:6aea with SMTP id
 h3-20020ac250c3000000b004d5ca326aeamr7320661lfm.10.1680203280564; Thu, 30 Mar
 2023 12:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230330155707.3106228-1-peterx@redhat.com> <20230330160646.3106903-1-peterx@redhat.com>
In-Reply-To: <20230330160646.3106903-1-peterx@redhat.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 30 Mar 2023 12:07:24 -0700
Message-ID: <CAJHvVciUGEfdgTLHUxAxCpKxXbMt202nsPhArsckHm7bDOdqFg@mail.gmail.com>
Subject: Re: [PATCH 03/29] selftests/mm: Dump a summary in run_vmtests.sh
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 9:06=E2=80=AFAM Peter Xu <peterx@redhat.com> wrote:
>
> Dump a summary after running whatever test specified.  Useful for human
> runners to identify any kind of failures (besides exit code).
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tools/testing/selftests/mm/run_vmtests.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/testing/selftests/mm/run_vmtests.sh b/tools/testing/se=
lftests/mm/run_vmtests.sh
> index c0f93b668c0c..9cc33984aa9f 100644
> --- a/tools/testing/selftests/mm/run_vmtests.sh
> +++ b/tools/testing/selftests/mm/run_vmtests.sh
> @@ -5,6 +5,9 @@
>  # Kselftest framework requirement - SKIP code is 4.
>  ksft_skip=3D4
>
> +count_pass=3D0
> +count_fail=3D0
> +count_skip=3D0
>  exitcode=3D0
>
>  usage() {
> @@ -149,11 +152,14 @@ run_test() {
>                 "$@"
>                 local ret=3D$?
>                 if [ $ret -eq 0 ]; then
> +                       count_pass=3D$(( $count_pass + 1 ))

Actually, inside $(( )) there's no need to prefix variable names with
$ too. Running "shellcheck" over the script written this way will
generate a warning.

Same applies below.

>                         echo "[PASS]"
>                 elif [ $ret -eq $ksft_skip ]; then
> +                       count_skip=3D$(( $count_skip + 1 ))
>                         echo "[SKIP]"
>                         exitcode=3D$ksft_skip
>                 else
> +                       count_fail=3D$(( $count_fail + 1 ))
>                         echo "[FAIL]"
>                         exitcode=3D1
>                 fi
> @@ -279,4 +285,6 @@ CATEGORY=3D"soft_dirty" run_test ./soft-dirty
>  # COW tests
>  CATEGORY=3D"cow" run_test ./cow
>
> +echo "SUMMARY: PASS=3D${count_pass} SKIP=3D${count_skip} FAIL=3D${count_=
fail}"
> +
>  exit $exitcode
> --
> 2.39.1
>

Besides the nitpick:

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
