Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B426D7891
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbjDEJjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237250AbjDEJje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:39:34 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3476B4C25;
        Wed,  5 Apr 2023 02:39:31 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id bl22so12215261oib.11;
        Wed, 05 Apr 2023 02:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680687570;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4wIC1CpZVOaE4w0vpqchy3vQi+52X2p+A7NNpUhaHjs=;
        b=f9pIAWwvJ1/ZkSjsLBZOYKNN/SvlUJHhIWEYf5hHOmqMKyYatIzDxQ3wF8pmu91t9V
         KufMBg9Ia2jbxgfRuwcybi2grHwm718EOdRg+4uuSCv6RKoVflaU/Y1VW/N1BVFKV3IJ
         5X3x7yBuNkEc99R9L/xY8zpvpx8AZ7b5d0yHJ6pob4J2MAck2mefPm/EfWR62r8Y2LeJ
         enNQ6K0TAW9V/BZIgAfqfdkKNTTxamM4rUi96e3ugY9/wcX3JNNqM7p3LogtCz8FeQQg
         J5/FrQJXXf21MNKcExwuTMz3E16S3BAzdnZlAMryofKJ6GAY6k1K7dMVUAy6D1uBc3we
         kZXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680687570;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wIC1CpZVOaE4w0vpqchy3vQi+52X2p+A7NNpUhaHjs=;
        b=V8kZhMuZnc7/KxirIZ/HyQo23EFwusrc9xauD7SZJYYeyn9nzkUA9uHdP9hZ25yAkO
         wSXj9AMJFAZwMcrNgKOrWzo3QVjTn5q/F/yDmgOodQ3rQYJ5hGeZz0Ak/MgVHGO5NCtK
         Vjzk9D/xbS1jDYFllSeJ2WcCibIxnHyjlTHsNIhvSjRZq4zg1/KcHgng/VuHwPmpkuf7
         M1WRGLhURV7Hi4fo9nZhEhZE8yq5FEGliP2z0XYgUznPXUJ/MGgnTDd1GuvFTObabfw0
         jPOIW46uRjeUiHGPJEnf1XsTHmVq/ccErP1ClALc7gRaHxjzM5PJ+SdOBC4apZkmctKw
         nj0w==
X-Gm-Message-State: AAQBX9fieMDT0jH+hJGTuMq56M6tHama3Btj/FJ4L+Kzm70yqQ4y89lt
        Lgfhgp0mcM9HkyZgNV4PFIs=
X-Google-Smtp-Source: AKy350YqOjXrLkIwek0UaobV9xTERoDvJ14GktHnbC9wXPlhyohk7kyGIyCXP1MGYDBJyDpo2659HQ==
X-Received: by 2002:aca:1206:0:b0:386:ed63:c511 with SMTP id 6-20020aca1206000000b00386ed63c511mr2416172ois.24.1680687570365;
        Wed, 05 Apr 2023 02:39:30 -0700 (PDT)
Received: from [127.0.0.1] ([187.19.238.117])
        by smtp.gmail.com with ESMTPSA id p188-20020acaf1c5000000b0038b2f07dd50sm3348114oih.7.2023.04.05.02.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 02:39:28 -0700 (PDT)
Date:   Wed, 05 Apr 2023 06:39:22 -0300
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
To:     Jiri Olsa <olsajiri@gmail.com>, Ian Rogers <irogers@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Rob Herring <robh@kernel.org>, Leo Yan <leo.yan@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        Gaosheng Cui <cuigaosheng1@huawei.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf pmu: Make parser reentrant
User-Agent: K-9 Mail for Android
In-Reply-To: <ZC0iXid4NraoXSCU@krava>
References: <20230404133630.1985739-1-irogers@google.com> <ZC0iXid4NraoXSCU@krava>
Message-ID: <A34997A8-302E-4577-82B0-F53AD954BC0A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On April 5, 2023 4:25:18 AM GMT-03:00, Jiri Olsa <olsajiri@gmail=2Ecom> wr=
ote:
>On Tue, Apr 04, 2023 at 06:36:30AM -0700, Ian Rogers wrote:
>> By default bison uses global state for compatibility with yacc=2E Make
>> the parser reentrant so that it may be used in asynchronous and
>> multithreaded situations=2E
>>=20
>> Signed-off-by: Ian Rogers <irogers@google=2Ecom>
>
>hum I can't apply this version on Arnaldo's perf/core:

Try on tmp=2Eperf-tools-next

>
>patching file tools/perf/util/pmu=2Ec
>Hunk #2 succeeded at 59 with fuzz 1=2E
>Hunk #3 FAILED at 80=2E
>Hunk #4 FAILED at 90=2E
>2 out of 4 hunks FAILED -- saving rejects to file tools/perf/util/pmu=2Ec=
=2Erej
>patching file tools/perf/util/pmu=2Eh
>patching file tools/perf/util/pmu=2El
>patching file tools/perf/util/pmu=2Ey
>
>jirka
>
>
>> ---
>>  tools/perf/util/pmu=2Ec | 24 ++++++++++++++++++------
>>  tools/perf/util/pmu=2Eh |  2 +-
>>  tools/perf/util/pmu=2El | 17 ++++++++++++-----
>>  tools/perf/util/pmu=2Ey |  5 ++++-
>>  4 files changed, 35 insertions(+), 13 deletions(-)
>>=20
>> diff --git a/tools/perf/util/pmu=2Ec b/tools/perf/util/pmu=2Ec
>> index 78a407b42ad1=2E=2Ef603cdabf797 100644
>> --- a/tools/perf/util/pmu=2Ec
>> +++ b/tools/perf/util/pmu=2Ec
>> @@ -24,6 +24,8 @@
>>  #include "evsel=2Eh"
>>  #include "pmu=2Eh"
>>  #include "pmus=2Eh"
>> +#include "pmu-bison=2Eh"
>> +#include "pmu-flex=2Eh"
>>  #include "parse-events=2Eh"
>>  #include "print-events=2Eh"
>>  #include "header=2Eh"
>> @@ -57,9 +59,6 @@ struct perf_pmu_format {
>>  	struct list_head list;
>>  };
>> =20
>> -int perf_pmu_parse(struct list_head *list, char *name);
>> -extern FILE *perf_pmu_in;
>> -
>>  static bool hybrid_scanned;
>> =20
>>  static struct perf_pmu *perf_pmu__find2(int dirfd, const char *name);
>> @@ -81,6 +80,8 @@ int perf_pmu__format_parse(int dirfd, struct list_hea=
d *head)
>>  	while (!ret && (evt_ent =3D readdir(format_dir))) {
>>  		char *name =3D evt_ent->d_name;
>>  		int fd;
>> +		void *scanner;
>> +		FILE *file;
>> =20
>>  		if (!strcmp(name, "=2E") || !strcmp(name, "=2E=2E"))
>>  			continue;
>> @@ -91,9 +92,20 @@ int perf_pmu__format_parse(int dirfd, struct list_he=
ad *head)
>>  		if (fd < 0)
>>  			break;
>> =20
>> -		perf_pmu_in =3D fdopen(fd, "r");
>> -		ret =3D perf_pmu_parse(head, name);
>> -		fclose(perf_pmu_in);
>> +		file =3D fdopen(fd, "r");
>> +		if (!file)
>> +			break;
>> +
>> +		ret =3D perf_pmu_lex_init(&scanner);
>> +		if (ret) {
>> +			fclose(file);
>> +			break;
>> +		}
>> +
>> +		perf_pmu_set_in(file, scanner);
>> +		ret =3D perf_pmu_parse(head, name, scanner);
>> +		perf_pmu_lex_destroy(scanner);
>> +		fclose(file);
>>  	}
>> =20
>>  	closedir(format_dir);
>> diff --git a/tools/perf/util/pmu=2Eh b/tools/perf/util/pmu=2Eh
>> index 32c3a75bca0e=2E=2Ed53618c65c92 100644
>> --- a/tools/perf/util/pmu=2Eh
>> +++ b/tools/perf/util/pmu=2Eh
>> @@ -206,7 +206,7 @@ int perf_pmu__check_alias(struct perf_pmu *pmu, str=
uct list_head *head_terms,
>>  			  struct perf_pmu_info *info);
>>  struct list_head *perf_pmu__alias(struct perf_pmu *pmu,
>>  				  struct list_head *head_terms);
>> -void perf_pmu_error(struct list_head *list, char *name, char const *ms=
g);
>> +void perf_pmu_error(struct list_head *list, char *name, void *scanner,=
 char const *msg);
>> =20
>>  int perf_pmu__new_format(struct list_head *list, char *name,
>>  			 int config, unsigned long *bits);
>> diff --git a/tools/perf/util/pmu=2El b/tools/perf/util/pmu=2El
>> index 58b4926cfaca=2E=2E67b247be693b 100644
>> --- a/tools/perf/util/pmu=2El
>> +++ b/tools/perf/util/pmu=2El
>> @@ -1,4 +1,6 @@
>>  %option prefix=3D"perf_pmu_"
>> +%option reentrant
>> +%option bison-bridge
>> =20
>>  %{
>>  #include <stdlib=2Eh>
>> @@ -6,16 +8,21 @@
>>  #include "pmu=2Eh"
>>  #include "pmu-bison=2Eh"
>> =20
>> -static int value(int base)
>> +char *perf_pmu_get_text(yyscan_t yyscanner);
>> +YYSTYPE *perf_pmu_get_lval(yyscan_t yyscanner);
>> +
>> +static int value(yyscan_t scanner, int base)
>>  {
>> +	YYSTYPE *yylval =3D perf_pmu_get_lval(scanner);
>> +	char *text =3D perf_pmu_get_text(scanner);
>>  	long num;
>> =20
>>  	errno =3D 0;
>> -	num =3D strtoul(perf_pmu_text, NULL, base);
>> +	num =3D strtoul(text, NULL, base);
>>  	if (errno)
>>  		return PP_ERROR;
>> =20
>> -	perf_pmu_lval=2Enum =3D num;
>> +	yylval->num =3D num;
>>  	return PP_VALUE;
>>  }
>> =20
>> @@ -25,7 +32,7 @@ num_dec         [0-9]+
>> =20
>>  %%
>> =20
>> -{num_dec}	{ return value(10); }
>> +{num_dec}	{ return value(yyscanner, 10); }
>>  config		{ return PP_CONFIG; }
>>  -		{ return '-'; }
>>  :		{ return ':'; }
>> @@ -35,7 +42,7 @@ config		{ return PP_CONFIG; }
>> =20
>>  %%
>> =20
>> -int perf_pmu_wrap(void)
>> +int perf_pmu_wrap(void *scanner __maybe_unused)
>>  {
>>  	return 1;
>>  }
>> diff --git a/tools/perf/util/pmu=2Ey b/tools/perf/util/pmu=2Ey
>> index e675d79a0274=2E=2Edff4e892ac4d 100644
>> --- a/tools/perf/util/pmu=2Ey
>> +++ b/tools/perf/util/pmu=2Ey
>> @@ -1,6 +1,8 @@
>> -
>> +%define api=2Epure full
>>  %parse-param {struct list_head *format}
>>  %parse-param {char *name}
>> +%parse-param {void *scanner}
>> +%lex-param {void* scanner}
>> =20
>>  %{
>> =20
>> @@ -78,6 +80,7 @@ PP_VALUE
>> =20
>>  void perf_pmu_error(struct list_head *list __maybe_unused,
>>  		    char *name __maybe_unused,
>> +		    void *scanner __maybe_unused,
>>  		    char const *msg __maybe_unused)
>>  {
>>  }
>> --=20
>> 2=2E40=2E0=2E348=2Egf938b09366-goog
>>=20
