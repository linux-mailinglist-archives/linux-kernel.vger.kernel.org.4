Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDB16D4EDB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 19:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjDCRXr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 13:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDCRXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 13:23:45 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2868E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:23:43 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-3e392e10cc4so1226551cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 10:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680542622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LWXh2Y7TR4i0kK2b3BIDbsK7NSRKBd9ezRImoQdMgo8=;
        b=Ifw3fZP1SKO5ALwaLp8RWF4fO34QCaOd0iO/DhCIS3MfyLWXZiAGSItD6P/h4zHP/0
         VXjnmHa6BK9D8k+N9LI/J7U5B4P8vjSp6hq4pWkr1VByfNB57OvzImGO/5r5lYorP26Z
         sxM0lcV6tisaXQJbIctHBVkasU2GAg6RWDPIl1AC+NmOaAZ6Nn3evk17eOvUssEbNq9j
         lS0dhOt3bskbrMFySL+sCZ4eWDk1giNM8FMk7i0ST4Eyq5fUpbdz0Jj/q65FeYRv2n4v
         RFkRlWdgUhSIZ7S/woXX/Q9oyPcv3V9SFw1nf970ABCbtK83Lbsy/k2BHp4qn8Deo6oR
         2EVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680542622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LWXh2Y7TR4i0kK2b3BIDbsK7NSRKBd9ezRImoQdMgo8=;
        b=comxOiuXeW795S4YQa3OwLKDgVD8Kmwy/sd347Mb7TvPVPSj59/Q/dfeiYWvkKO5bC
         gpsTXWKxTPyUlsIZ8PyKCkxt6HIO3QJTPz+o6QqmC6a8vYIUMjKXvgDTkbu74V2aWitF
         Cyl+UpB37fPuLkYJgFg5rACo7qAQBwKTlmqkvrPhamjplh2AGUnfwtM/RA6emZqDxDsQ
         G4RQME/b/tmyBpffCjGRG4FjAZKMClQwv3iYM9rufICA24RHD6GXxfLq4qmC2EiaoPIM
         DGmKwanUds5UfAyPPSbfeEV/4PkUSwN8GM+JkDyQa+47hTKDMp/7LkfJbsGzxsLsLI0S
         2FSQ==
X-Gm-Message-State: AAQBX9fOyG1M4F8yOZuWenDETkI0h6iqLrtYrr7jIxdQ/W5UiKxYtnqo
        QZbw61vxTJpyCqdwd2w8+cpe5oQjS0qS/ispzZUIuA==
X-Google-Smtp-Source: AKy350a8QcGFOeP2ELfV5GH2gi8jD9tNVzi15WDxkuu7qyfc/hcnhZbT0BsSpK63Nu+kk1DvQR7gnQC8JboeY1/vDGY=
X-Received: by 2002:a05:622a:134e:b0:3b9:f696:c762 with SMTP id
 w14-20020a05622a134e00b003b9f696c762mr694617qtk.19.1680542622280; Mon, 03 Apr
 2023 10:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230331202949.810326-1-namhyung@kernel.org> <20230331202949.810326-6-namhyung@kernel.org>
In-Reply-To: <20230331202949.810326-6-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 3 Apr 2023 10:23:27 -0700
Message-ID: <CAP-5=fX1pktRMBrbzc+xFPOG8VsH9+zthck61aRstavvjn0YPw@mail.gmail.com>
Subject: Re: [PATCH 5/9] perf pmu: Use relative path for sysfs scan
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>
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

On Fri, Mar 31, 2023 at 1:30=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> The PMU information is in the kernel sysfs so it needs to scan the
> directory to get the whole information like event aliases, formats
> and so on.  During the traversal, it opens a lot of files and
> directories like below:
>
>   dir =3D opendir("/sys/bus/event_source/devices");
>   while (dentry =3D readdir(dir)) {
>     char buf[PATH_MAX];
>
>     snprintf(buf, sizeof(buf), "%s/%s",
>              "/sys/bus/event_source/devices", dentry->d_name);
>     fd =3D open(buf, O_RDONLY);
>     ...
>   }
>
> But this is not good since it needs to copy the string to build the
> absolute pathname, and it makes redundant pathname walk (from the /sys)
> unnecessarily.  We can use openat(2) to open the file in the given
> directory.  While it's not a problem ususally, it can be a problem
> when the kernel has contentions on the sysfs.
>
> Add a couple of new helper to return the file descriptor of PMU
> directory so that it can use it with relative paths.
>
>  * perf_pmu__event_source_devices_fd()
>    - returns a fd for the PMU root ("/sys/bus/event_source/devices")
>
>  * perf_pmu__pathname_fd()
>    - returns a fd for "<pmu>/<file>" under the PMU root
>
> Now the above code can be converted something like below:
>
>   dirfd =3D perf_pmu__event_source_devices_fd();
>   dir =3D fdopendir(dirfd);
>   while (dentry =3D readdir(dir)) {
>     fd =3D openat(dirfd, dentry->d_name, O_RDONLY);
>     ...
>   }
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/pmu.c |   9 ++-
>  tools/perf/util/pmu.c  | 161 +++++++++++++++++++++++++----------------
>  tools/perf/util/pmu.h  |   4 +-
>  3 files changed, 111 insertions(+), 63 deletions(-)
>
> diff --git a/tools/perf/tests/pmu.c b/tools/perf/tests/pmu.c
> index 8507bd615e97..3cf25f883df7 100644
> --- a/tools/perf/tests/pmu.c
> +++ b/tools/perf/tests/pmu.c
> @@ -3,6 +3,7 @@
>  #include "pmu.h"
>  #include "tests.h"
>  #include <errno.h>
> +#include <fcntl.h>
>  #include <stdio.h>
>  #include <linux/kernel.h>
>  #include <linux/limits.h>
> @@ -149,10 +150,16 @@ static int test__pmu(struct test_suite *test __mayb=
e_unused, int subtest __maybe
>
>         do {
>                 struct perf_event_attr attr;
> +               int fd;
>
>                 memset(&attr, 0, sizeof(attr));
>
> -               ret =3D perf_pmu__format_parse(format, &formats);
> +               fd =3D open(format, O_DIRECTORY);
> +               if (fd < 0) {
> +                       ret =3D fd;
> +                       break;
> +               }
> +               ret =3D perf_pmu__format_parse(fd, &formats);
>                 if (ret)
>                         break;
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index b112606f36ec..9fc6b8b5732b 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -62,38 +62,38 @@ extern FILE *perf_pmu_in;
>
>  static bool hybrid_scanned;
>
> +static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name);
> +
>  /*
>   * Parse & process all the sysfs attributes located under
>   * the directory specified in 'dir' parameter.
>   */
> -int perf_pmu__format_parse(char *dir, struct list_head *head)
> +int perf_pmu__format_parse(int dirfd, struct list_head *head)
>  {
>         struct dirent *evt_ent;
>         DIR *format_dir;
>         int ret =3D 0;
>
> -       format_dir =3D opendir(dir);
> +       format_dir =3D fdopendir(dirfd);
>         if (!format_dir)
>                 return -EINVAL;
>
>         while (!ret && (evt_ent =3D readdir(format_dir))) {
> -               char path[PATH_MAX];
>                 char *name =3D evt_ent->d_name;
> -               FILE *file;
> +               int fd;
>
>                 if (!strcmp(name, ".") || !strcmp(name, ".."))
>                         continue;
>
> -               snprintf(path, PATH_MAX, "%s/%s", dir, name);
>
>                 ret =3D -EINVAL;
> -               file =3D fopen(path, "r");
> -               if (!file)
> +               fd =3D openat(dirfd, name, O_RDONLY);
> +               if (fd < 0)
>                         break;
>
> -               perf_pmu_in =3D file;
> +               perf_pmu_in =3D fdopen(fd, "r");
>                 ret =3D perf_pmu_parse(head, name);
> -               fclose(file);
> +               fclose(perf_pmu_in);

Eek, I hadn't realized that the pmu parser wasn't reentrant. I sent out:
https://lore.kernel.org/lkml/20230403172031.1759781-1-irogers@google.com/
to fix this.

Thanks,
Ian

>         }
>
>         closedir(format_dir);
> @@ -105,17 +105,16 @@ int perf_pmu__format_parse(char *dir, struct list_h=
ead *head)
>   * located at:
>   * /sys/bus/event_source/devices/<dev>/format as sysfs group attributes.
>   */
> -static int pmu_format(const char *name, struct list_head *format)
> +static int pmu_format(int dirfd, const char *name, struct list_head *for=
mat)
>  {
> -       char path[PATH_MAX];
> -
> -       if (!perf_pmu__pathname_scnprintf(path, sizeof(path), name, "form=
at"))
> -               return -1;
> +       int fd;
>
> -       if (!file_available(path))
> +       fd =3D perf_pmu__pathname_fd(dirfd, name, "format", O_DIRECTORY);
> +       if (fd < 0)
>                 return 0;
>
> -       if (perf_pmu__format_parse(path, format))
> +       /* it'll close the fd */
> +       if (perf_pmu__format_parse(fd, format))
>                 return -1;
>
>         return 0;
> @@ -158,7 +157,7 @@ int perf_pmu__convert_scale(const char *scale, char *=
*end, double *sval)
>         return ret;
>  }
>
> -static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, char *dir=
, char *name)
> +static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, int dirfd=
, char *name)
>  {
>         struct stat st;
>         ssize_t sret;
> @@ -166,9 +165,9 @@ static int perf_pmu__parse_scale(struct perf_pmu_alia=
s *alias, char *dir, char *
>         int fd, ret =3D -1;
>         char path[PATH_MAX];
>
> -       scnprintf(path, PATH_MAX, "%s/%s.scale", dir, name);
> +       scnprintf(path, PATH_MAX, "%s.scale", name);
>
> -       fd =3D open(path, O_RDONLY);
> +       fd =3D openat(dirfd, path, O_RDONLY);
>         if (fd =3D=3D -1)
>                 return -1;
>
> @@ -190,15 +189,15 @@ static int perf_pmu__parse_scale(struct perf_pmu_al=
ias *alias, char *dir, char *
>         return ret;
>  }
>
> -static int perf_pmu__parse_unit(struct perf_pmu_alias *alias, char *dir,=
 char *name)
> +static int perf_pmu__parse_unit(struct perf_pmu_alias *alias, int dirfd,=
 char *name)
>  {
>         char path[PATH_MAX];
>         ssize_t sret;
>         int fd;
>
> -       scnprintf(path, PATH_MAX, "%s/%s.unit", dir, name);
> +       scnprintf(path, PATH_MAX, "%s.unit", name);
>
> -       fd =3D open(path, O_RDONLY);
> +       fd =3D openat(dirfd, path, O_RDONLY);
>         if (fd =3D=3D -1)
>                 return -1;
>
> @@ -221,14 +220,14 @@ static int perf_pmu__parse_unit(struct perf_pmu_ali=
as *alias, char *dir, char *n
>  }
>
>  static int
> -perf_pmu__parse_per_pkg(struct perf_pmu_alias *alias, char *dir, char *n=
ame)
> +perf_pmu__parse_per_pkg(struct perf_pmu_alias *alias, int dirfd, char *n=
ame)
>  {
>         char path[PATH_MAX];
>         int fd;
>
> -       scnprintf(path, PATH_MAX, "%s/%s.per-pkg", dir, name);
> +       scnprintf(path, PATH_MAX, "%s.per-pkg", name);
>
> -       fd =3D open(path, O_RDONLY);
> +       fd =3D openat(dirfd, path, O_RDONLY);
>         if (fd =3D=3D -1)
>                 return -1;
>
> @@ -239,14 +238,14 @@ perf_pmu__parse_per_pkg(struct perf_pmu_alias *alia=
s, char *dir, char *name)
>  }
>
>  static int perf_pmu__parse_snapshot(struct perf_pmu_alias *alias,
> -                                   char *dir, char *name)
> +                                   int dirfd, char *name)
>  {
>         char path[PATH_MAX];
>         int fd;
>
> -       scnprintf(path, PATH_MAX, "%s/%s.snapshot", dir, name);
> +       scnprintf(path, PATH_MAX, "%s.snapshot", name);
>
> -       fd =3D open(path, O_RDONLY);
> +       fd =3D openat(dirfd, path, O_RDONLY);
>         if (fd =3D=3D -1)
>                 return -1;
>
> @@ -332,7 +331,7 @@ static bool perf_pmu_merge_alias(struct perf_pmu_alia=
s *newalias,
>         return false;
>  }
>
> -static int __perf_pmu__new_alias(struct list_head *list, char *dir, char=
 *name,
> +static int __perf_pmu__new_alias(struct list_head *list, int dirfd, char=
 *name,
>                                  char *desc, char *val, const struct pmu_=
event *pe)
>  {
>         struct parse_events_term *term;
> @@ -391,14 +390,14 @@ static int __perf_pmu__new_alias(struct list_head *=
list, char *dir, char *name,
>         }
>
>         alias->name =3D strdup(name);
> -       if (dir) {
> +       if (dirfd >=3D 0) {
>                 /*
>                  * load unit name and scale if available
>                  */
> -               perf_pmu__parse_unit(alias, dir, name);
> -               perf_pmu__parse_scale(alias, dir, name);
> -               perf_pmu__parse_per_pkg(alias, dir, name);
> -               perf_pmu__parse_snapshot(alias, dir, name);
> +               perf_pmu__parse_unit(alias, dirfd, name);
> +               perf_pmu__parse_scale(alias, dirfd, name);
> +               perf_pmu__parse_per_pkg(alias, dirfd, name);
> +               perf_pmu__parse_snapshot(alias, dirfd, name);
>         }
>
>         alias->desc =3D desc ? strdup(desc) : NULL;
> @@ -419,7 +418,7 @@ static int __perf_pmu__new_alias(struct list_head *li=
st, char *dir, char *name,
>         return 0;
>  }
>
> -static int perf_pmu__new_alias(struct list_head *list, char *dir, char *=
name, FILE *file)
> +static int perf_pmu__new_alias(struct list_head *list, int dirfd, char *=
name, FILE *file)
>  {
>         char buf[256];
>         int ret;
> @@ -433,7 +432,7 @@ static int perf_pmu__new_alias(struct list_head *list=
, char *dir, char *name, FI
>         /* Remove trailing newline from sysfs file */
>         strim(buf);
>
> -       return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL);
> +       return __perf_pmu__new_alias(list, dirfd, name, NULL, buf, NULL);
>  }
>
>  static inline bool pmu_alias_info_file(char *name)
> @@ -457,17 +456,17 @@ static inline bool pmu_alias_info_file(char *name)
>   * Process all the sysfs attributes located under the directory
>   * specified in 'dir' parameter.
>   */
> -static int pmu_aliases_parse(char *dir, struct list_head *head)
> +static int pmu_aliases_parse(int dirfd, struct list_head *head)
>  {
>         struct dirent *evt_ent;
>         DIR *event_dir;
> +       int fd;
>
> -       event_dir =3D opendir(dir);
> +       event_dir =3D fdopendir(dirfd);
>         if (!event_dir)
>                 return -EINVAL;
>
>         while ((evt_ent =3D readdir(event_dir))) {
> -               char path[PATH_MAX];
>                 char *name =3D evt_ent->d_name;
>                 FILE *file;
>
> @@ -480,15 +479,14 @@ static int pmu_aliases_parse(char *dir, struct list=
_head *head)
>                 if (pmu_alias_info_file(name))
>                         continue;
>
> -               scnprintf(path, PATH_MAX, "%s/%s", dir, name);
> -
> -               file =3D fopen(path, "r");
> +               fd =3D openat(dirfd, name, O_RDONLY);
> +               file =3D fdopen(fd, "r");
>                 if (!file) {
> -                       pr_debug("Cannot open %s\n", path);
> +                       pr_debug("Cannot open %s\n", name);
>                         continue;
>                 }
>
> -               if (perf_pmu__new_alias(head, dir, name, file) < 0)
> +               if (perf_pmu__new_alias(head, dirfd, name, file) < 0)
>                         pr_debug("Cannot set up %s\n", name);
>                 fclose(file);
>         }
> @@ -501,17 +499,16 @@ static int pmu_aliases_parse(char *dir, struct list=
_head *head)
>   * Reading the pmu event aliases definition, which should be located at:
>   * /sys/bus/event_source/devices/<dev>/events as sysfs group attributes.
>   */
> -static int pmu_aliases(const char *name, struct list_head *head)
> +static int pmu_aliases(int dirfd, const char *name, struct list_head *he=
ad)
>  {
> -       char path[PATH_MAX];
> -
> -       if (!perf_pmu__pathname_scnprintf(path, sizeof(path), name, "even=
ts"))
> -               return -1;
> +       int fd;
>
> -       if (!file_available(path))
> +       fd =3D perf_pmu__pathname_fd(dirfd, name, "events", O_DIRECTORY);
> +       if (fd < 0)
>                 return 0;
>
> -       if (pmu_aliases_parse(path, head))
> +       /* it'll close the fd */
> +       if (pmu_aliases_parse(fd, head))
>                 return -1;
>
>         return 0;
> @@ -544,14 +541,15 @@ static int pmu_alias_terms(struct perf_pmu_alias *a=
lias,
>  /* Add all pmus in sysfs to pmu list: */
>  static void pmu_read_sysfs(void)
>  {
> -       char path[PATH_MAX];
> +       int fd;
>         DIR *dir;
>         struct dirent *dent;
>
> -       if (!perf_pmu__event_source_devices_scnprintf(path, sizeof(path))=
)
> +       fd =3D perf_pmu__event_source_devices_fd();
> +       if (fd < 0)
>                 return;
>
> -       dir =3D opendir(path);
> +       dir =3D fdopendir(fd);
>         if (!dir)
>                 return;
>
> @@ -559,7 +557,7 @@ static void pmu_read_sysfs(void)
>                 if (!strcmp(dent->d_name, ".") || !strcmp(dent->d_name, "=
.."))
>                         continue;
>                 /* add to static LIST_HEAD(pmus): */
> -               perf_pmu__find(dent->d_name);
> +               perf_pmu__find2(fd, dent->d_name);
>         }
>
>         closedir(dir);
> @@ -763,7 +761,7 @@ static int pmu_add_cpu_aliases_map_callback(const str=
uct pmu_event *pe,
>
>  new_alias:
>         /* need type casts to override 'const' */
> -       __perf_pmu__new_alias(data->head, NULL, (char *)pe->name, (char *=
)pe->desc,
> +       __perf_pmu__new_alias(data->head, -1, (char *)pe->name, (char *)p=
e->desc,
>                               (char *)pe->event, pe);
>         return 0;
>  }
> @@ -814,7 +812,7 @@ static int pmu_add_sys_aliases_iter_fn(const struct p=
mu_event *pe,
>
>         if (!strcmp(pmu->id, pe->compat) &&
>             pmu_uncore_alias_match(pe->pmu, pmu->name)) {
> -               __perf_pmu__new_alias(idata->head, NULL,
> +               __perf_pmu__new_alias(idata->head, -1,
>                                       (char *)pe->name,
>                                       (char *)pe->desc,
>                                       (char *)pe->event,
> @@ -863,7 +861,7 @@ static int pmu_max_precise(struct perf_pmu *pmu)
>         return max_precise;
>  }
>
> -static struct perf_pmu *pmu_lookup(const char *lookup_name)
> +static struct perf_pmu *pmu_lookup(int dirfd, const char *lookup_name)
>  {
>         struct perf_pmu *pmu;
>         LIST_HEAD(format);
> @@ -884,13 +882,13 @@ static struct perf_pmu *pmu_lookup(const char *look=
up_name)
>          * type value and format definitions. Load both right
>          * now.
>          */
> -       if (pmu_format(name, &format))
> +       if (pmu_format(dirfd, name, &format))
>                 return NULL;
>
>         /*
>          * Check the aliases first to avoid unnecessary work.
>          */
> -       if (pmu_aliases(name, &aliases))
> +       if (pmu_aliases(dirfd, name, &aliases))
>                 return NULL;
>
>         pmu =3D zalloc(sizeof(*pmu));
> @@ -1024,6 +1022,27 @@ bool evsel__is_aux_event(const struct evsel *evsel=
)
>  }
>
>  struct perf_pmu *perf_pmu__find(const char *name)
> +{
> +       struct perf_pmu *pmu;
> +       int dirfd;
> +
> +       /*
> +        * Once PMU is loaded it stays in the list,
> +        * so we keep us from multiple reading/parsing
> +        * the pmu format definitions.
> +        */
> +       pmu =3D pmu_find(name);
> +       if (pmu)
> +               return pmu;
> +
> +       dirfd =3D perf_pmu__event_source_devices_fd();
> +       pmu =3D pmu_lookup(dirfd, name);
> +       close(dirfd);
> +
> +       return pmu;
> +}
> +
> +static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name)
>  {
>         struct perf_pmu *pmu;
>
> @@ -1036,7 +1055,7 @@ struct perf_pmu *perf_pmu__find(const char *name)
>         if (pmu)
>                 return pmu;
>
> -       return pmu_lookup(name);
> +       return pmu_lookup(dirfd, name);
>  }
>
>  static struct perf_pmu_format *
> @@ -1938,6 +1957,18 @@ int perf_pmu__event_source_devices_scnprintf(char =
*pathname, size_t size)
>         return scnprintf(pathname, size, "%s/bus/event_source/devices/", =
sysfs);
>  }
>
> +int perf_pmu__event_source_devices_fd(void)
> +{
> +       char path[PATH_MAX];
> +       const char *sysfs =3D sysfs__mountpoint();
> +
> +       if (!sysfs)
> +               return -1;
> +
> +       scnprintf(path, sizeof(path), "%s/bus/event_source/devices/", sys=
fs);
> +       return open(path, O_DIRECTORY);
> +}
> +
>  /*
>   * Fill 'buf' with the path to a file or folder in 'pmu_name' in
>   * sysfs. For example if pmu_name =3D "cs_etm" and 'filename' =3D "forma=
t"
> @@ -1957,6 +1988,14 @@ int perf_pmu__pathname_scnprintf(char *buf, size_t=
 size,
>         return scnprintf(buf, size, "%s%s/%s", base_path, pmu_name, filen=
ame);
>  }
>
> +int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *f=
ilename, int flags)
> +{
> +       char path[PATH_MAX];
> +
> +       scnprintf(path, sizeof(path), "%s/%s", pmu_name, filename);
> +       return openat(dirfd, path, flags);
> +}
> +
>  static void perf_pmu__delete(struct perf_pmu *pmu)
>  {
>         perf_pmu__del_formats(&pmu->format);
> diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
> index 72fd5de334c0..751c7016e7b6 100644
> --- a/tools/perf/util/pmu.h
> +++ b/tools/perf/util/pmu.h
> @@ -211,7 +211,7 @@ void perf_pmu_error(struct list_head *list, char *nam=
e, char const *msg);
>  int perf_pmu__new_format(struct list_head *list, char *name,
>                          int config, unsigned long *bits);
>  void perf_pmu__set_format(unsigned long *bits, long from, long to);
> -int perf_pmu__format_parse(char *dir, struct list_head *head);
> +int perf_pmu__format_parse(int dirfd, struct list_head *head);
>  void perf_pmu__del_formats(struct list_head *formats);
>
>  struct perf_pmu *perf_pmu__scan(struct perf_pmu *pmu);
> @@ -257,6 +257,8 @@ double perf_pmu__cpu_slots_per_cycle(void);
>  int perf_pmu__event_source_devices_scnprintf(char *pathname, size_t size=
);
>  int perf_pmu__pathname_scnprintf(char *buf, size_t size,
>                                  const char *pmu_name, const char *filena=
me);
> +int perf_pmu__event_source_devices_fd(void);
> +int perf_pmu__pathname_fd(int dirfd, const char *pmu_name, const char *f=
ilename, int flags);
>  FILE *perf_pmu__open_file(struct perf_pmu *pmu, const char *name);
>
>  void perf_pmu__destroy(void);
> --
> 2.40.0.348.gf938b09366-goog
>
