Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89F026E0506
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 05:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjDMDE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 23:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbjDMDER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 23:04:17 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4595B7EF6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:04:12 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3ee6c339cceso82915e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 20:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681355050; x=1683947050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NTsVS1OLMuTArKSUysXDm7wLuvPWjjl2ejrbWsOgpAM=;
        b=7QpvhxlRtLqRSQ1tC9pj1NEIf7Qem7NpWJOraiBAkrHREJFw41d3Ezrm9o93AnbRcT
         wLTsV1oHM+kcrk63gl/rJSolqYrA0Lk3DJq5PRdyo30MBfETYWi2BPwTjy42lVWpfHnK
         bnXMhsudvS4+v4bVC4j/J/pm2Omu5x64bgPC9Y425/50q3Ybbof9NDt1FA+zgorOZmr5
         kKtZPCUcQGEAMb600I3Ny8wG9sLiqy6G9e+lY8Nyluc4xil/WEfvkyo8fl7fw7lPlJml
         jHlroKoRuAWbLmQXgm5dVU/ZlykpG/ZhK6yiX/RBcz2UscjbKIoVNAsGbrT0AthvUWOp
         1w9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681355050; x=1683947050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NTsVS1OLMuTArKSUysXDm7wLuvPWjjl2ejrbWsOgpAM=;
        b=mE+Wi7ONAY3r+7pWw0kdo/vzj+UIbnCE07Zr5TS1cIHj5JE1rEF/4AN2HszDpjtCmq
         8y1X8ydxx/3CzlGkk/0uqOToy7MAa68P+8H6LjjZiNHD1vmJxFzjPDq0zTcBpKqigXXS
         4CdBUSEsS06VA7dSipM7TtlaUryVWh+BIs9Da9cGdD6H9H8/Qw/JONz+VGJb5RVGtXTq
         9xPBYapJZsRhD6s3eCDYFbE2L3vdg1PEecnrKyn/g+tHvaSDnfpeV4BRNJOgG9V5dqEU
         K8tDLwDACHpki1FnbYjVF36xBDvc1tnj7BQck7UFIfFS6APrFVI61U2bS1uiItGoqwlg
         iAAw==
X-Gm-Message-State: AAQBX9dmd/CIKW+V+mKm8YqPIxg6vAsJCGAxP+hhQlmJxFAARSUBBcqJ
        9p9fxOk42gHZRRgAdFB9LAy2t+QKVrB9+oXt9F28+g==
X-Google-Smtp-Source: AKy350a0b2oNd7n2AfYF7OlNIIGzKkr9QxfEEjb/mEKBJSAs8YEveRU4hXsxAgIXmsahQRXa1GNu/2dFqxWQV1NrrE4=
X-Received: by 2002:a05:600c:4f4a:b0:3f0:44e8:57f3 with SMTP id
 m10-20020a05600c4f4a00b003f044e857f3mr565505wmq.5.1681355050374; Wed, 12 Apr
 2023 20:04:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230413024125.3082418-1-zenghao@kylinos.cn>
In-Reply-To: <20230413024125.3082418-1-zenghao@kylinos.cn>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 12 Apr 2023 20:03:58 -0700
Message-ID: <CAP-5=fV9TVxHx1xveQgUbZnyrDNUmkW=c3OX+DEErfZb_3G_ow@mail.gmail.com>
Subject: Re: [PATCH] perf pmu: Fix resource leaks in pmu_cpumask()
To:     Hao Zeng <zenghao@kylinos.cn>
Cc:     linux-perf-users@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, james.clark@arm.com,
        suzuki.poulose@arm.com, ravi.bangoria@amd.com, seanjc@google.com,
        linux-kernel@vger.kernel.org
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

On Wed, Apr 12, 2023 at 7:41=E2=80=AFPM Hao Zeng <zenghao@kylinos.cn> wrote=
:
>
> The perf_pmu__open_file() and perf_cpu_map__read()
> are called to process the file,but the file is not closed,
> which may cause a file handle leak.
>
> Signed-off-by: Hao Zeng <zenghao@kylinos.cn>

Thanks, this was already fixed by Namhyung in:
https://lore.kernel.org/all/20230331202949.810326-9-namhyung@kernel.org/
You may want to check for issues like this in Arnaldo's perf-tools-next tre=
e:
https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=3Dper=
f-tools-next
These are the changes planned for Linux 6.4.

Thanks,
Ian

> ---
>  tools/perf/util/pmu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> index c256b29defad..3b4d2f531d83 100644
> --- a/tools/perf/util/pmu.c
> +++ b/tools/perf/util/pmu.c
> @@ -583,6 +583,7 @@ static struct perf_cpu_map *pmu_cpumask(const char *n=
ame)
>                 if (!file)
>                         continue;
>                 cpus =3D perf_cpu_map__read(file);
> +               fclose(file);
>                 if (cpus)
>                         return cpus;
>         }
> --
> 2.37.2
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
