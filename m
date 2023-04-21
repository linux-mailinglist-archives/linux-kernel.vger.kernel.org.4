Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1419E6EB2BC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 22:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233686AbjDUUBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 16:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjDUUB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 16:01:28 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BF82702
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:01:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a6bc48aec8so21070575ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 13:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682107285; x=1684699285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g0kfpaLHk3I9yKQguXu3E4Mv9Mkxg2I0bssImgqVEp8=;
        b=HYRnC+MPjcys9SERzqYral2IFgMkOEA6k4/I7Ru8AnSVwBMlIoQ7c4irBllc7WKLN9
         QiYBXJKHSYH7xZ0n57HcPz5R7RMwfybvtIuJDYfTBAB9c7YUqowzBcaYN9UTXJ3EOwNP
         eULLxzNqt38VFalHQ8g82r4u7M3nguwa5mCNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682107285; x=1684699285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0kfpaLHk3I9yKQguXu3E4Mv9Mkxg2I0bssImgqVEp8=;
        b=helwFO/Q3fsL3eI/5rMiuI5e0zdqBGlXyU3aC5IIZz2p4xXFgrbw4PphjuKctdfFHJ
         5YtfoRAoHYNaRZhYYriLuqPA0PlTv73VjIdhXWb5WNwk9O1LnGmpO8m4/CXhmP3g/yoh
         ipDRY/erUIXnMb5gavQR/3SM96e5j1hRek4KRIOTMGsO87gUxRbiCq3tlubxYvAlSlvq
         Quhj7HbktCrVHQKIWFmsEs8FnGPOzCIkJm7+4Z8JX0Wmny1Ij/NVjiWmm9baGuvNjPhW
         akxVWAOXcyBDZnl4dAMdFHdxO9mz0QUR/zH/UDgum5TdFIwsgTxwTiQmFODZAYwxk44g
         MJ5g==
X-Gm-Message-State: AAQBX9eZK/1eV1JDSeHc/XRvaFE9ceU22HZgu3kpx4OuRpWgg9U1IJIC
        iknMOpMsdYsnmdXFuv+M/qhW4Q==
X-Google-Smtp-Source: AKy350Y6bUULfJjpOmEizOvcmv+AwAqfS1sMB5Dr2zAuVrfNZadkjeqIXtggEk6DCrW9ttuzTDFe4Q==
X-Received: by 2002:a17:903:41ce:b0:1a2:19c1:a974 with SMTP id u14-20020a17090341ce00b001a219c1a974mr7306493ple.68.1682107285207;
        Fri, 21 Apr 2023 13:01:25 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k23-20020a170902761700b001a9581d3ef5sm318744pll.97.2023.04.21.13.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 13:01:24 -0700 (PDT)
Message-ID: <6442eb94.170a0220.25865.0ef6@mx.google.com>
X-Google-Original-Message-ID: <202304211258.@keescook>
Date:   Fri, 21 Apr 2023 13:01:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     paul@paul-moore.com, linux-security-module@vger.kernel.org,
        jmorris@namei.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Subject: Re: [PATCH v9 11/11] LSM: selftests for Linux Security Module
 syscalls
References: <20230421174259.2458-1-casey@schaufler-ca.com>
 <20230421174259.2458-12-casey@schaufler-ca.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230421174259.2458-12-casey@schaufler-ca.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 10:42:59AM -0700, Casey Schaufler wrote:
> Add selftests for the three system calls supporting the LSM
> infrastructure.

Yay tests!

With nits below fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  tools/testing/selftests/Makefile              |   1 +
>  tools/testing/selftests/lsm/Makefile          |  12 +
>  tools/testing/selftests/lsm/config            |   2 +
>  .../selftests/lsm/lsm_get_self_attr_test.c    | 267 ++++++++++++++++++
>  .../selftests/lsm/lsm_list_modules_test.c     | 149 ++++++++++
>  .../selftests/lsm/lsm_set_self_attr_test.c    |  70 +++++
>  6 files changed, 501 insertions(+)
>  create mode 100644 tools/testing/selftests/lsm/Makefile
>  create mode 100644 tools/testing/selftests/lsm/config
>  create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
>  create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
>  create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 13a6837a0c6b..b18d133a1141 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -38,6 +38,7 @@ TARGETS += landlock
>  TARGETS += lib
>  TARGETS += livepatch
>  TARGETS += lkdtm
> +TARGETS += lsm
>  TARGETS += membarrier
>  TARGETS += memfd
>  TARGETS += memory-hotplug
> diff --git a/tools/testing/selftests/lsm/Makefile b/tools/testing/selftests/lsm/Makefile
> new file mode 100644
> index 000000000000..f39a75212b78
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# First run: make -C ../../../.. headers_install
> +
> +CFLAGS += -Wall -O2 $(KHDR_INCLUDES)
> +
> +TEST_GEN_PROGS := lsm_get_self_attr_test lsm_list_modules_test \
> +		  lsm_set_self_attr_test
> +
> +include ../lib.mk
> +
> +$(TEST_GEN_PROGS):
> diff --git a/tools/testing/selftests/lsm/config b/tools/testing/selftests/lsm/config
> new file mode 100644
> index 000000000000..afb887715f64
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/config
> @@ -0,0 +1,2 @@
> +CONFIG_SYSFS=y
> +CONFIG_SECURITY=y
> diff --git a/tools/testing/selftests/lsm/lsm_get_self_attr_test.c b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> new file mode 100644
> index 000000000000..71c2b1a8a44e
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> @@ -0,0 +1,267 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Linux Security Module infrastructure tests
> + * Tests for the lsm_get_self_attr system call
> + *
> + * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright © 2022 Intel Corporation
> + */
> +
> +#define _GNU_SOURCE
> +#include <linux/lsm.h>
> +#include <fcntl.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include "../kselftest_harness.h"
> +
> +#define PROCATTR	"/proc/self/attr/"
> +
> +static int read_proc_attr(const char *attr, char *value, __kernel_size_t size)
> +{
> +	int fd;
> +	int len;
> +	char *path;
> +
> +	len = strlen(PROCATTR) + strlen(attr) + 1;
> +	path = calloc(len, 1);
> +	if (path == NULL)
> +		return -1;
> +	sprintf(path, "%s%s", PROCATTR, attr);
> +
> +	fd = open(path, O_RDONLY);
> +	free(path);
> +
> +	if (fd < 0)
> +		return -1;
> +	len = read(fd, value, size);
> +	if (len <= 0)
> +		return -1;
> +fprintf(stderr, "len=%d\n", len);

Accidentally leftover debugging?

> +	close(fd);
> +
> +	path = strchr(value, '\n');
> +	if (path)
> +		*path = '\0';
> +
> +	return 0;
> +}
> +
> +static struct lsm_ctx *next_ctx(struct lsm_ctx *ctxp)
> +{
> +	void *vp;
> +
> +	vp = (void *)ctxp + sizeof(*ctxp) + ctxp->ctx_len;
> +	return (struct lsm_ctx *)vp;
> +}
> +
> +TEST(size_null_lsm_get_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	char *ctx = calloc(page_size, 1);
> +
> +	ASSERT_NE(NULL, ctx);
> +	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
> +			      NULL, 0));
> +	ASSERT_EQ(EINVAL, errno);
> +
> +	free(ctx);
> +}
> +
> +TEST(ctx_null_lsm_get_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	__kernel_size_t size = page_size;
> +
> +	ASSERT_NE(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, NULL,
> +			      &size, 0));
> +	ASSERT_NE(1, size);
> +}
> +
> +TEST(size_too_small_lsm_get_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	char *ctx = calloc(page_size, 1);
> +	__kernel_size_t size = 1;
> +
> +	ASSERT_NE(NULL, ctx);
> +	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
> +			      &size, 0));
> +	ASSERT_EQ(E2BIG, errno);
> +	ASSERT_NE(1, size);
> +
> +	free(ctx);
> +}
> +
> +TEST(flags_zero_lsm_get_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	char *ctx = calloc(page_size, 1);
> +	__kernel_size_t size = page_size;
> +
> +	ASSERT_NE(NULL, ctx);

I would explicitly set errno to 0 before syscalls, just to sure.

> +	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
> +			      &size, 1));
> +	ASSERT_EQ(EINVAL, errno);
> +	ASSERT_EQ(page_size, size);
> +
> +	free(ctx);
> +}
> +
> +TEST(flags_overset_lsm_get_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	char *ctx = calloc(page_size, 1);
> +	__kernel_size_t size = page_size;
> +
> +	ASSERT_NE(NULL, ctx);

e.g.:
	errno = 0;

but repeated for all syscalls below...

> +	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr,
> +			      LSM_ATTR_CURRENT | LSM_ATTR_PREV, ctx, &size, 0));
> +	ASSERT_EQ(EOPNOTSUPP, errno);
> +
> +	free(ctx);
> +}
> +
> +TEST(basic_lsm_get_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	__kernel_size_t size = page_size;
> +	struct lsm_ctx *ctx = calloc(page_size, 1);
> +	struct lsm_ctx *tctx = NULL;
> +	__u64 *syscall_lsms = calloc(page_size, 1);
> +	char *attr = calloc(page_size, 1);
> +	int cnt_current = 0;
> +	int cnt_exec = 0;
> +	int cnt_fscreate = 0;
> +	int cnt_keycreate = 0;
> +	int cnt_prev = 0;
> +	int cnt_sockcreate = 0;
> +	int lsmcount;
> +	int count;
> +	int i;
> +
> +	ASSERT_NE(NULL, ctx);
> +	ASSERT_NE(NULL, syscall_lsms);
> +
> +	lsmcount = syscall(__NR_lsm_list_modules, syscall_lsms, &size, 0);
> +	ASSERT_LE(1, lsmcount);
> +
> +	for (i = 0; i < lsmcount; i++) {
> +		switch (syscall_lsms[i]) {
> +		case LSM_ID_SELINUX:
> +			cnt_current++;
> +			cnt_exec++;
> +			cnt_fscreate++;
> +			cnt_keycreate++;
> +			cnt_prev++;
> +			cnt_sockcreate++;
> +			break;
> +		case LSM_ID_SMACK:
> +			cnt_current++;
> +			break;
> +		case LSM_ID_APPARMOR:
> +			cnt_current++;
> +			cnt_exec++;
> +			cnt_prev++;
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (cnt_current) {
> +		size = page_size;
> +		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
> +				&size, 0);
> +		ASSERT_EQ(cnt_current, count);
> +		tctx = ctx;
> +		ASSERT_EQ(0, read_proc_attr("current", attr, page_size));
> +		ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
> +		for (i = 1; i < count; i++) {
> +			tctx = next_ctx(tctx);
> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +	}
> +	if (cnt_exec) {
> +		size = page_size;
> +		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_EXEC, ctx,
> +				&size, 0);
> +		ASSERT_GE(cnt_exec, count);
> +		if (count > 0) {
> +			tctx = ctx;
> +			if (read_proc_attr("exec", attr, page_size) == 0)
> +				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +		for (i = 1; i < count; i++) {
> +			tctx = next_ctx(tctx);
> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +	}
> +	if (cnt_fscreate) {
> +		size = page_size;
> +		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_FSCREATE, ctx,
> +				&size, 0);
> +		ASSERT_GE(cnt_fscreate, count);
> +		if (count > 0) {
> +			tctx = ctx;
> +			if (read_proc_attr("fscreate", attr, page_size) == 0)
> +				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +		for (i = 1; i < count; i++) {
> +			tctx = next_ctx(tctx);
> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +	}
> +	if (cnt_keycreate) {
> +		size = page_size;
> +		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_KEYCREATE, ctx,
> +				&size, 0);
> +		ASSERT_GE(cnt_keycreate, count);
> +		if (count > 0) {
> +			tctx = ctx;
> +			if (read_proc_attr("keycreate", attr, page_size) == 0)
> +				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +		for (i = 1; i < count; i++) {
> +			tctx = next_ctx(tctx);
> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +	}
> +	if (cnt_prev) {
> +		size = page_size;
> +		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_PREV, ctx,
> +				&size, 0);
> +		ASSERT_GE(cnt_prev, count);
> +		if (count > 0) {
> +			tctx = ctx;
> +			ASSERT_EQ(0, read_proc_attr("prev", attr, page_size));
> +			ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
> +			for (i = 1; i < count; i++) {
> +				tctx = next_ctx(tctx);
> +				ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
> +			}
> +		}
> +	}
> +	if (cnt_sockcreate) {
> +		size = page_size;
> +		count = syscall(__NR_lsm_get_self_attr, LSM_ATTR_SOCKCREATE,
> +				ctx, &size, 0);
> +		ASSERT_GE(cnt_sockcreate, count);
> +		if (count > 0) {
> +			tctx = ctx;
> +			if (read_proc_attr("sockcreate", attr, page_size) == 0)
> +				ASSERT_EQ(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +		for (i = 1; i < count; i++) {
> +			tctx = next_ctx(tctx);
> +			ASSERT_NE(0, strcmp((char *)tctx->ctx, attr));
> +		}
> +	}
> +
> +	free(ctx);
> +	free(attr);
> +	free(syscall_lsms);
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/lsm/lsm_list_modules_test.c b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> new file mode 100644
> index 000000000000..3ec814002710
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> @@ -0,0 +1,149 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Linux Security Module infrastructure tests
> + * Tests for the lsm_list_modules system call
> + *
> + * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright © 2022 Intel Corporation
> + */
> +
> +#define _GNU_SOURCE
> +#include <linux/lsm.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include "../kselftest_harness.h"
> +
> +static int read_sysfs_lsms(char *lsms, __kernel_size_t size)
> +{
> +	FILE *fp;
> +
> +	fp = fopen("/sys/kernel/security/lsm", "r");
> +	if (fp == NULL)
> +		return -1;
> +	if (fread(lsms, 1, size, fp) <= 0)
> +		return -1;
> +	fclose(fp);
> +	return 0;
> +}
> +
> +TEST(size_null_lsm_list_modules)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	char *syscall_lsms = calloc(page_size, 1);
> +
> +	ASSERT_NE(NULL, syscall_lsms);
> +	ASSERT_EQ(-1, syscall(__NR_lsm_list_modules, syscall_lsms, NULL, 0));
> +	ASSERT_EQ(EFAULT, errno);
> +
> +	free(syscall_lsms);
> +}
> +
> +TEST(ids_null_lsm_list_modules)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	__kernel_size_t size = page_size;
> +
> +	ASSERT_EQ(-1, syscall(__NR_lsm_list_modules, NULL, &size, 0));
> +	ASSERT_EQ(EFAULT, errno);
> +	ASSERT_NE(1, size);
> +}
> +
> +TEST(size_too_small_lsm_list_modules)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	char *syscall_lsms = calloc(page_size, 1);
> +	__kernel_size_t size = 1;
> +
> +	ASSERT_NE(NULL, syscall_lsms);
> +	ASSERT_EQ(-1, syscall(__NR_lsm_list_modules, syscall_lsms, &size, 0));
> +	ASSERT_EQ(E2BIG, errno);
> +	ASSERT_NE(1, size);
> +
> +	free(syscall_lsms);
> +}
> +
> +TEST(flags_set_lsm_list_modules)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	char *syscall_lsms = calloc(page_size, 1);
> +	__kernel_size_t size = page_size;
> +
> +	ASSERT_NE(NULL, syscall_lsms);
> +	ASSERT_EQ(-1, syscall(__NR_lsm_list_modules, syscall_lsms, &size, 7));
> +	ASSERT_EQ(EINVAL, errno);
> +	ASSERT_EQ(page_size, size);
> +
> +	free(syscall_lsms);
> +}
> +
> +TEST(correct_lsm_list_modules)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	__kernel_size_t size = page_size;
> +	__u64 *syscall_lsms = calloc(page_size, 1);
> +	char *sysfs_lsms = calloc(page_size, 1);
> +	char *name;
> +	char *cp;
> +	int count;
> +	int i;
> +
> +	ASSERT_NE(NULL, sysfs_lsms);
> +	ASSERT_NE(NULL, syscall_lsms);
> +	ASSERT_EQ(0, read_sysfs_lsms(sysfs_lsms, page_size));
> +
> +	count = syscall(__NR_lsm_list_modules, syscall_lsms, &size, 0);
> +	ASSERT_LE(1, count);
> +	cp = sysfs_lsms;
> +	for (i = 0; i < count; i++) {
> +		switch (syscall_lsms[i]) {
> +		case LSM_ID_CAPABILITY:
> +			name = "capability";
> +			break;
> +		case LSM_ID_SELINUX:
> +			name = "selinux";
> +			break;
> +		case LSM_ID_SMACK:
> +			name = "smack";
> +			break;
> +		case LSM_ID_TOMOYO:
> +			name = "tomoyo";
> +			break;
> +		case LSM_ID_IMA:
> +			name = "ima";
> +			break;
> +		case LSM_ID_APPARMOR:
> +			name = "apparmor";
> +			break;
> +		case LSM_ID_YAMA:
> +			name = "yama";
> +			break;
> +		case LSM_ID_LOADPIN:
> +			name = "loadpin";
> +			break;
> +		case LSM_ID_SAFESETID:
> +			name = "safesetid";
> +			break;
> +		case LSM_ID_LOCKDOWN:
> +			name = "lockdown";
> +			break;
> +		case LSM_ID_BPF:
> +			name = "bpf";
> +			break;
> +		case LSM_ID_LANDLOCK:
> +			name = "landlock";
> +			break;
> +		default:
> +			name = "INVALID";
> +			break;
> +		}
> +		ASSERT_EQ(0, strncmp(cp, name, strlen(name)));
> +		cp += strlen(name) + 1;
> +	}
> +
> +	free(sysfs_lsms);
> +	free(syscall_lsms);
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/lsm/lsm_set_self_attr_test.c b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> new file mode 100644
> index 000000000000..ca538a703168
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Linux Security Module infrastructure tests
> + * Tests for the lsm_set_self_attr system call
> + *
> + * Copyright © 2022 Casey Schaufler <casey@schaufler-ca.com>
> + * Copyright © 2022 Intel Corporation
> + */
> +
> +#define _GNU_SOURCE
> +#include <linux/lsm.h>
> +#include <string.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/types.h>
> +#include "../kselftest_harness.h"
> +
> +TEST(ctx_null_lsm_set_self_attr)
> +{
> +	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, LSM_ATTR_CURRENT, NULL,
> +			      sizeof(struct lsm_ctx), 0));
> +}
> +
> +TEST(size_too_small_lsm_set_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	struct lsm_ctx *ctx = calloc(page_size, 1);
> +	__kernel_size_t size = page_size;
> +
> +	ASSERT_NE(NULL, ctx);
> +	ASSERT_GE(1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
> +			     &size, 0));
> +	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, LSM_ATTR_CURRENT, ctx, 1,
> +			      0));
> +
> +	free(ctx);
> +}
> +
> +TEST(flags_zero_lsm_set_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	char *ctx = calloc(page_size, 1);
> +	__kernel_size_t size = page_size;
> +
> +	ASSERT_NE(NULL, ctx);
> +	ASSERT_GE(1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
> +			     &size, 0));
> +	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr, LSM_ATTR_CURRENT, ctx,
> +			      size, 1));
> +
> +	free(ctx);
> +}
> +
> +TEST(flags_overset_lsm_set_self_attr)
> +{
> +	const long page_size = sysconf(_SC_PAGESIZE);
> +	char *ctx = calloc(page_size, 1);
> +	__kernel_size_t size = page_size;
> +	struct lsm_ctx *tctx = (struct lsm_ctx *)ctx;
> +
> +	ASSERT_NE(NULL, ctx);
> +	ASSERT_GE(1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, tctx,
> +			     &size, 0));
> +	ASSERT_EQ(-1, syscall(__NR_lsm_set_self_attr,
> +			      LSM_ATTR_CURRENT | LSM_ATTR_PREV, tctx, size, 0));
> +
> +	free(ctx);
> +}
> +
> +TEST_HARNESS_MAIN
> -- 
> 2.39.2
> 

-- 
Kees Cook
