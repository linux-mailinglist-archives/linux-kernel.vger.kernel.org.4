Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEEF67D5E6
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjAZUGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjAZUGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:06:12 -0500
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDB312F;
        Thu, 26 Jan 2023 12:06:08 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-16332831ed0so3778783fac.10;
        Thu, 26 Jan 2023 12:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VZC1AGCo1iw/OKKcaY6DIjrVBaw9CD8BZwmjFFL+xHo=;
        b=X5vU4GaXJPB2qwx+vMr/yc/UHmvP/Hd0vOupJATNOpGml2lexhBNdE4M+RpELn5c9a
         4K5lpfyekqdUC6q1RPr2eDpsVNAF8JXnjiwW7IY8tDbP4uCpJAXoS8+Ckq1t8l5QrCEF
         tSOBI1txVx24XP1soQCDIt4VHq9ykolvHstCvAj9uMbNujCzoopqkSeh/w2jEl748q/z
         zQ+CyFBmE2WKuYu9ePfaDilWfFP5gqBrOkLoGtYU4osbEuWyKOth+FErDn7KwjJeRjkY
         63GlJBkbY9hR/JVzSDUPkVEbx4kk7W8jY6POr39HDDfup+sy6+BIVVfNStyH/jR98/Iu
         lSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZC1AGCo1iw/OKKcaY6DIjrVBaw9CD8BZwmjFFL+xHo=;
        b=duFsou+12Z/HLdgkU+dQpM5kui1NR9Pbkq740Mb8+DmSVwOCPtbinegr9qE3jXHb6x
         uDk0LzeYPDBwOekqtbfn4d1rQpBgdoRjZprtGp6X2B/j3nCD8L/yO0bMo5fVhMsQwmKo
         IgbDkEWbj8LwHcAMtWVvw8K3DV0HpxgKgdsE9KebagkfM8fYg2My8xPsc0kZggHhozaJ
         SajV1lIoRuOKXlOs+bdyd+XVZhPahk9iyXQeumNtSk5ybWnaYPQEtInKWf7JlIMV2Npb
         6e6JKr1dOZBCUM8iU/d+pI4EvXcSUt6WhVQbRn0DWiEF6tn+yY41OvbjPtVixoMy4CN5
         jihg==
X-Gm-Message-State: AFqh2krqAxF27WiuffbhUHmLQta0En9P0ypXM8nHtN5z+t1WQGRneW+s
        2JGwrOpPx4Sx/ZrHzwe76Eo=
X-Google-Smtp-Source: AMrXdXtszIHqhqe+4mhgCtIGAy5dqKQXMr4pslFhJZP1eax3dRLbVBtv1sSpkTbg0jWKAZPRBRPajA==
X-Received: by 2002:a05:6870:280a:b0:150:c4e4:4489 with SMTP id gz10-20020a056870280a00b00150c4e44489mr19376533oab.49.1674763567892;
        Thu, 26 Jan 2023 12:06:07 -0800 (PST)
Received: from [127.0.0.1] ([187.19.237.165])
        by smtp.gmail.com with ESMTPSA id x2-20020a4aca82000000b00502189f6bdbsm874248ooq.44.2023.01.26.12.06.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 12:06:07 -0800 (PST)
Date:   Thu, 26 Jan 2023 17:06:01 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf script: Add 'cgroup' field for output
User-Agent: K-9 Mail for Android
In-Reply-To: <20230126194230.3339019-1-namhyung@kernel.org>
References: <20230126194230.3339019-1-namhyung@kernel.org>
Message-ID: <ACACAC8D-3390-4D47-B227-5C3182109847@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On January 26, 2023 4:42:30 PM GMT-03:00, Namhyung Kim <namhyung@kernel=2E=
org> wrote:
>There's no field for the cgroup, let's add one=2E  To do that, users need=
 to
>specify --all-cgroup option for perf record to capture the cgroup info=2E


This information about the new field being only available when --all-cgrou=
p is specified should be in the documentation (man page) and probably in th=
e tool itself, refusing it when the needed command line isn't present=2E

- Arnaldo=20

>
>  $ perf record --all-cgroups -- true
>
>  $ perf script -F comm,pid,cgroup
>            true 337112  /user=2Eslice/user-657345=2Eslice/user@657345=2E=
service/=2E=2E=2E
>            true 337112  /user=2Eslice/user-657345=2Eslice/user@657345=2E=
service/=2E=2E=2E
>            true 337112  /user=2Eslice/user-657345=2Eslice/user@657345=2E=
service/=2E=2E=2E
>            true 337112  /user=2Eslice/user-657345=2Eslice/user@657345=2E=
service/=2E=2E=2E
>
>Signed-off-by: Namhyung Kim <namhyung@kernel=2Eorg>
>---
> tools/perf/Documentation/perf-script=2Etxt |  2 +-
> tools/perf/builtin-script=2Ec              | 16 +++++++++++++++-
> 2 files changed, 16 insertions(+), 2 deletions(-)
>
>diff --git a/tools/perf/Documentation/perf-script=2Etxt b/tools/perf/Docu=
mentation/perf-script=2Etxt
>index 8d77182fbf31=2E=2E82c4dcb9c42e 100644
>--- a/tools/perf/Documentation/perf-script=2Etxt
>+++ b/tools/perf/Documentation/perf-script=2Etxt
>@@ -134,7 +134,7 @@ OPTIONS
>         srcline, period, iregs, uregs, brstack, brstacksym, flags, bpf-o=
utput,
>         brstackinsn, brstackinsnlen, brstackoff, callindent, insn, insnl=
en, synth,
>         phys_addr, metric, misc, srccode, ipc, data_page_size, code_page=
_size, ins_lat,
>-        machine_pid, vcpu=2E
>+        machine_pid, vcpu, cgroup=2E
>         Field list can be prepended with the type, trace, sw or hw,
>         to indicate to which event type the field list applies=2E
>         e=2Eg=2E, -F sw:comm,tid,time,ip,sym  and -F trace:time,cpu,trac=
e
>diff --git a/tools/perf/builtin-script=2Ec b/tools/perf/builtin-script=2E=
c
>index 69394ac0a20d=2E=2E79976dde99b3 100644
>--- a/tools/perf/builtin-script=2Ec
>+++ b/tools/perf/builtin-script=2Ec
>@@ -59,6 +59,7 @@
> #include "util/dlfilter=2Eh"
> #include "util/record=2Eh"
> #include "util/util=2Eh"
>+#include "util/cgroup=2Eh"
> #include "perf=2Eh"
>=20
> #include <linux/ctype=2Eh>
>@@ -130,6 +131,7 @@ enum perf_output_field {
> 	PERF_OUTPUT_BRSTACKINSNLEN  =3D 1ULL << 36,
> 	PERF_OUTPUT_MACHINE_PID     =3D 1ULL << 37,
> 	PERF_OUTPUT_VCPU            =3D 1ULL << 38,
>+	PERF_OUTPUT_CGROUP          =3D 1ULL << 39,
> };
>=20
> struct perf_script {
>@@ -200,6 +202,7 @@ struct output_option {
> 	{=2Estr =3D "brstackinsnlen", =2Efield =3D PERF_OUTPUT_BRSTACKINSNLEN},
> 	{=2Estr =3D "machine_pid", =2Efield =3D PERF_OUTPUT_MACHINE_PID},
> 	{=2Estr =3D "vcpu", =2Efield =3D PERF_OUTPUT_VCPU},
>+	{=2Estr =3D "cgroup", =2Efield =3D PERF_OUTPUT_CGROUP},
> };
>=20
> enum {
>@@ -2220,6 +2223,17 @@ static void process_event(struct perf_script *scri=
pt,
> 	if (PRINT_FIELD(CODE_PAGE_SIZE))
> 		fprintf(fp, " %s", get_page_size_name(sample->code_page_size, str));
>=20
>+	if (PRINT_FIELD(CGROUP)) {
>+		const char *cgrp_name;
>+		struct cgroup *cgrp =3D cgroup__find(machine->env,
>+						   sample->cgroup);
>+		if (cgrp !=3D NULL)
>+			cgrp_name =3D cgrp->name;
>+		else
>+			cgrp_name =3D "unknown";
>+		fprintf(fp, " %s", cgrp_name);
>+	}
>+
> 	perf_sample__fprintf_ipc(sample, attr, fp);
>=20
> 	fprintf(fp, "\n");
>@@ -3856,7 +3870,7 @@ int cmd_script(int argc, const char **argv)
> 		     "brstacksym,flags,data_src,weight,bpf-output,brstackinsn,"
> 		     "brstackinsnlen,brstackoff,callindent,insn,insnlen,synth,"
> 		     "phys_addr,metric,misc,srccode,ipc,tod,data_page_size,"
>-		     "code_page_size,ins_lat",
>+		     "code_page_size,ins_lat,machine_pid,vcpu,cgroup",
> 		     parse_output_fields),
> 	OPT_BOOLEAN('a', "all-cpus", &system_wide,
> 		    "system-wide collection from all CPUs"),
