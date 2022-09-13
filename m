Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3769E5B7951
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbiIMSWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiIMSWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:22:14 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69BE7B287;
        Tue, 13 Sep 2022 10:38:02 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-11e9a7135easo34114503fac.6;
        Tue, 13 Sep 2022 10:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=RbaTlR9lfyBwWmVOT3CAlFS+dYWp09UmUVuRxE8xWKQ=;
        b=P3MpqQYDRBhV3cGge1ROj74olVWcUtxAZkHFmyH/jTyH+OsgHOednBKAcP6v7ZN700
         M6G0IedUHcIu4zfWn7VhXtoYflv6Wd4DSQLExyDHY0f0pWaDQTqskMmLOPThhr7HhGSg
         j0wsS/YgDDtjtHCZ7XIayO83JvJZ3nWgYawAYYeHIvSX7nOxFqOp95vNFXFsQSaAIafT
         RREVvE1MrMjLl9wS4JQqWXftFWdomddnBBFeiQOIY82Ln4ACWD6K6o+qGa4JpjTreb1E
         7aJlSIk15bFMraTK/2S9slOMl+Eq3xmPsfOZ88k/JYTXo9kCV8nKAAJtsiNx+iJ6klfX
         zizA==
X-Gm-Message-State: ACgBeo0Fj7lzMPtWcg6QWoLe+LMBp1++0VnhKPt2QaDrQi2XUMzkw54U
        EHoQRu9bApRk1HyH6nkUAmdYOdtz1r55T4E5hbo=
X-Google-Smtp-Source: AA6agR4+eHYP4nL505FNZo1+kkgNZDAsv+txkff5IP6657UR5Zmb3dB+FZtxxXjvU/5Ubbt91qBiE0EWQm0OKBmwG5s=
X-Received: by 2002:aca:120a:0:b0:34f:ffd3:4dd9 with SMTP id
 10-20020aca120a000000b0034fffd34dd9mr179018ois.271.1663090681657; Tue, 13 Sep
 2022 10:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220912083412.7058-1-adrian.hunter@intel.com> <20220912083412.7058-12-adrian.hunter@intel.com>
In-Reply-To: <20220912083412.7058-12-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 13 Sep 2022 10:37:50 -0700
Message-ID: <CAM9d7ci3JKNaLDMo6patFHZbLSm-r1UmOmZtrwCX8Gu0nsPMBA@mail.gmail.com>
Subject: Re: [PATCH 11/11] perf test: test_intel_pt.sh: Add per-thread test
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 1:34 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> When tracing the kernel with Intel PT, text_poke events are recorded
> per-cpu. In per-thread mode that results in a mixture of per-thread and
> per-cpu events and mmaps. Check that happens correctly.
>
> The debug output from perf record -vvv is recorded and then awk used to
> process the debug messages that indicate what file descriptors were opened
> and whether they were mmapped or set-output.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/tests/shell/test_intel_pt.sh | 247 ++++++++++++++++++++++++
>  1 file changed, 247 insertions(+)
>
> diff --git a/tools/perf/tests/shell/test_intel_pt.sh b/tools/perf/tests/shell/test_intel_pt.sh
> index 2d489de9097b..051d088c1b74 100755
> --- a/tools/perf/tests/shell/test_intel_pt.sh
> +++ b/tools/perf/tests/shell/test_intel_pt.sh
> @@ -4,6 +4,8 @@
>
>  set -e
>
> +tenths=date\ +%s%1N
> +
>  # Skip if no Intel PT
>  perf list | grep -q 'intel_pt//' || exit 2
>
> @@ -15,6 +17,10 @@ temp_dir=$(mktemp -d /tmp/perf-test-intel-pt-sh.XXXXXXXXXX)
>
>  tmpfile="${temp_dir}/tmp-perf.data"
>  perfdatafile="${temp_dir}/test-perf.data"
> +outfile="${temp_dir}/test-out.txt"
> +errfile="${temp_dir}/test-err.txt"
> +workload="${temp_dir}/workload"
> +awkscript="${temp_dir}/awkscript"
>
>  cleanup()
>  {
> @@ -35,6 +41,37 @@ trap_cleanup()
>
>  trap trap_cleanup EXIT TERM INT
>
> +have_workload=false
> +cat << _end_of_file_ | /usr/bin/cc -o "${workload}" -xc - -pthread && have_workload=true
> +#include <time.h>
> +#include <pthread.h>
> +
> +void work(void) {
> +       struct timespec tm = {
> +               .tv_nsec = 1000000,
> +       };
> +       int i;
> +
> +       /* Run for about 30 seconds */
> +       for (i = 0; i < 30000; i++)
> +               nanosleep(&tm, NULL);
> +}
> +
> +void *threadfunc(void *arg) {
> +       work();
> +       return NULL;
> +}
> +
> +int main(void) {
> +       pthread_t th;
> +
> +       pthread_create(&th, NULL, threadfunc, NULL);
> +       work();
> +       pthread_join(th, NULL);
> +       return 0;
> +}
> +_end_of_file_
> +
>  can_cpu_wide()
>  {
>         echo "Checking for CPU-wide recording on CPU $1"
> @@ -69,6 +106,214 @@ test_system_wide_side_band()
>         return 1
>  }
>
> +can_kernel()
> +{
> +       perf record -o "${tmpfile}" -B -N --no-bpf-event -e dummy:k true >/dev/null 2>&1 || return 2
> +       return 0
> +}
> +
> +wait_for_threads()
> +{
> +       start_time=$($tenths)
> +       while [ -e "/proc/$1/task" ] ; do
> +               th_cnt=$(find "/proc/$1/task" -mindepth 1 -maxdepth 1 -printf x | wc -c)
> +               if [ "${th_cnt}" -ge "$2" ] ; then
> +                       return 0
> +               fi
> +               # Wait at most 5 seconds
> +               if [ $(($($tenths) - start_time)) -ge 50 ] ; then

It's a shame that we would use this syntax but I couldn't find any better. :(


> +                       echo "PID $1 does not have $2 threads"
> +                       return 1
> +               fi
> +       done
> +       return 1
> +}
> +
> +wait_for_perf_to_start()
> +{
> +       echo "Waiting for \"perf record has started\" message"
> +       start_time=$($tenths)
> +       while [ -e "/proc/$1" ] ; do
> +               if grep -q "perf record has started" "${errfile}" ; then
> +                       echo OK
> +                       break
> +               fi
> +               # Wait at most 5 seconds
> +               if [ $(($($tenths) - start_time)) -ge 50 ] ; then
> +                       echo "perf recording did not start"
> +                       return 1
> +               fi
> +       done
> +       return 0
> +}
> +
> +wait_for_process_to_exit()
> +{
> +       start_time=$($tenths)
> +       while [ -e "/proc/$1" ] ; do
> +               # Wait at most 5 seconds
> +               if [ $(($($tenths) - start_time)) -ge 50 ] ; then
> +                       echo "PID $1 did not exit as expected"
> +                       return 1
> +               fi
> +       done
> +       return 0
> +}
> +
> +is_running()
> +{
> +       start_time=$($tenths)
> +       while [ -e "/proc/$1" ] ; do
> +               # Check for at least 0.3s
> +               if [ $(($($tenths) - start_time)) -gt 3 ] ; then
> +                       return 0
> +               fi
> +       done
> +       echo "PID $1 exited prematurely"
> +       return 1
> +}

Can we move this into the lib directory with an optional argument
specifying the timeout?

Thanks,
Namhyung


> +
> +test_per_thread()
> +{
> +       k="$1"
> +       desc="$2"
> +
> +       echo "--- Test per-thread ${desc}recording ---"
> +
> +       if ! $have_workload ; then
> +               echo "No workload, so skipping"
> +               return 2
> +       fi
> +
> +       if [ "${k}" = "k" ] ; then
> +               can_kernel || return 2
> +       fi
> +
> +       cat <<- "_end_of_file_" > "${awkscript}"
> +       BEGIN {
> +               s = "[ ]*"
> +               u = s"[0-9]+"s
> +               d = s"[0-9-]+"s
> +               x = s"[0-9a-fA-FxX]+"s
> +               mmapping = "idx"u": mmapping fd"u
> +               set_output = "idx"u": set output fd"u"->"u
> +               perf_event_open = "sys_perf_event_open: pid"d"cpu"d"group_fd"d"flags"x"="u
> +       }
> +
> +       /perf record opening and mmapping events/ {
> +               if (!done)
> +                       active = 1
> +       }
> +
> +       /perf record done opening and mmapping events/ {
> +               active = 0
> +               done = 1
> +       }
> +
> +       $0 ~ perf_event_open && active {
> +               match($0, perf_event_open)
> +               $0 = substr($0, RSTART, RLENGTH)
> +               pid = $3
> +               cpu = $5
> +               fd = $11
> +               print "pid " pid " cpu " cpu " fd " fd " : " $0
> +               fd_array[fd] = fd
> +               pid_array[fd] = pid
> +               cpu_array[fd] = cpu
> +       }
> +
> +       $0 ~ mmapping && active  {
> +               match($0, mmapping)
> +               $0 = substr($0, RSTART, RLENGTH)
> +               fd = $5
> +               print "fd " fd " : " $0
> +               if (fd in fd_array) {
> +                       mmap_array[fd] = 1
> +               } else {
> +                       print "Unknown fd " fd
> +                       exit 1
> +               }
> +       }
> +
> +       $0 ~ set_output && active {
> +               match($0, set_output)
> +               $0 = substr($0, RSTART, RLENGTH)
> +               fd = $6
> +               fd_to = $8
> +               print "fd " fd " fd_to " fd_to " : " $0
> +               if (fd in fd_array) {
> +                       if (fd_to in fd_array) {
> +                               set_output_array[fd] = fd_to
> +                       } else {
> +                               print "Unknown fd " fd_to
> +                               exit 1
> +                       }
> +               } else {
> +                       print "Unknown fd " fd
> +                       exit 1
> +               }
> +       }
> +
> +       END {
> +               print "Checking " length(fd_array) " fds"
> +               for (fd in fd_array) {
> +                       if (fd in mmap_array) {
> +                               pid = pid_array[fd]
> +                               if (pid != -1) {
> +                                       if (pid in pids) {
> +                                               print "More than 1 mmap for PID " pid
> +                                               exit 1
> +                                       }
> +                                       pids[pid] = 1
> +                               }
> +                               cpu = cpu_array[fd]
> +                               if (cpu != -1) {
> +                                       if (cpu in cpus) {
> +                                               print "More than 1 mmap for CPU " cpu
> +                                               exit 1
> +                                       }
> +                                       cpus[cpu] = 1
> +                               }
> +                       } else if (!(fd in set_output_array)) {
> +                               print "No mmap for fd " fd
> +                               exit 1
> +                       }
> +               }
> +               n = length(pids)
> +               if (n != thread_cnt) {
> +                       print "Expected " thread_cnt " per-thread mmaps - found " n
> +                       exit 1
> +               }
> +       }
> +       _end_of_file_
> +
> +       $workload &
> +       w1=$!
> +       $workload &
> +       w2=$!
> +       echo "Workload PIDs are $w1 and $w2"
> +       wait_for_threads ${w1} 2
> +       wait_for_threads ${w2} 2
> +
> +       perf record -B -N --no-bpf-event -o "${perfdatafile}" -e intel_pt//u"${k}" -vvv --per-thread -p "${w1},${w2}" 2>"${errfile}" >"${outfile}" &
> +       ppid=$!
> +       echo "perf PID is $ppid"
> +       wait_for_perf_to_start ${ppid} || return 1
> +
> +       kill ${w1}
> +       wait_for_process_to_exit ${w1} || return 1
> +       is_running ${ppid} || return 1
> +
> +       kill ${w2}
> +       wait_for_process_to_exit ${w2} || return 1
> +       wait_for_process_to_exit ${ppid} || return 1
> +
> +       awk -v thread_cnt=4 -f "${awkscript}" "${errfile}" || return 1
> +
> +       echo OK
> +       return 0
> +}
> +
>  count_result()
>  {
>         if [ "$1" -eq 2 ] ; then
> @@ -85,6 +330,8 @@ count_result()
>
>  ret=0
>  test_system_wide_side_band || ret=$? ; count_result $ret
> +test_per_thread "" "" || ret=$? ; count_result $ret
> +test_per_thread "k" "(incl. kernel) " || ret=$? ; count_result $ret
>
>  cleanup
>
> --
> 2.25.1
>
