Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E3B74F7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjGKSQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 14:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGKSQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 14:16:36 -0400
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A35E170A;
        Tue, 11 Jul 2023 11:16:32 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4R0pwZ5XL7zMqFlN;
        Tue, 11 Jul 2023 18:16:30 +0000 (UTC)
Received: from unknown by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4R0pwX3cbzzMpr0h;
        Tue, 11 Jul 2023 20:16:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1689099390;
        bh=m8FfbDFpM+kGVy8FFUoZIpFpOZX5MFKGM3U3UZCg094=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kF7ZQX5hK6ApcdfdK22M4s0UWVbsuUGXka2vfcwtc3Hu5vekUVqCEdnlVOcCnPSCn
         AtXY9/ycs801En8GTtizwHmTw9c0PyXGzTB7fViNw9TyR3eKbvm1VmwuhiMX9oBL5H
         6p2Ui2Sjh5qe+63GtQhdDnZVoi7WsGdJDDTGeC9k=
Message-ID: <e9e8f6fa-6319-edbf-b1ea-581b0dbf6bf5@digikod.net>
Date:   Tue, 11 Jul 2023 20:16:27 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH v12 11/11] LSM: selftests for Linux Security Module
 syscalls
Content-Language: en-US
To:     Casey Schaufler <casey@schaufler-ca.com>, paul@paul-moore.com,
        linux-security-module@vger.kernel.org
Cc:     jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20230629195535.2590-1-casey@schaufler-ca.com>
 <20230629195535.2590-12-casey@schaufler-ca.com>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <20230629195535.2590-12-casey@schaufler-ca.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's nice to have such tests!

On 29/06/2023 21:55, Casey Schaufler wrote:
> Add selftests for the three system calls supporting the LSM
> infrastructure.
> 
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>   tools/testing/selftests/Makefile              |   1 +
>   tools/testing/selftests/lsm/Makefile          |  12 +
>   tools/testing/selftests/lsm/config            |   2 +
>   .../selftests/lsm/lsm_get_self_attr_test.c    | 270 ++++++++++++++++++
>   .../selftests/lsm/lsm_list_modules_test.c     | 153 ++++++++++
>   .../selftests/lsm/lsm_set_self_attr_test.c    |  70 +++++
>   6 files changed, 508 insertions(+)
>   create mode 100644 tools/testing/selftests/lsm/Makefile
>   create mode 100644 tools/testing/selftests/lsm/config
>   create mode 100644 tools/testing/selftests/lsm/lsm_get_self_attr_test.c
>   create mode 100644 tools/testing/selftests/lsm/lsm_list_modules_test.c
>   create mode 100644 tools/testing/selftests/lsm/lsm_set_self_attr_test.c
> 
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 90a62cf75008..2b91df264ada 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -38,6 +38,7 @@ TARGETS += landlock
>   TARGETS += lib
>   TARGETS += livepatch
>   TARGETS += lkdtm
> +TARGETS += lsm
>   TARGETS += membarrier
>   TARGETS += memfd
>   TARGETS += memory-hotplug
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
> index 000000000000..a62524b17bf7
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/lsm_get_self_attr_test.c
> @@ -0,0 +1,270 @@
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

I don't think __kernel_size_t is required anywhere in this patch, size_t 
should be fine.


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
> +	errno = 0;
> +	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
> +			      NULL, 0));

It would be cleaner to use static functions instead of calling syscall() 
each time.


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

This assert fails.


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
> +	errno = 0;
> +	ASSERT_EQ(-1, syscall(__NR_lsm_get_self_attr, LSM_ATTR_CURRENT, ctx,
> +			      &size, 0));
> +	ASSERT_EQ(E2BIG, errno);

This assert fails because errno == EOPNOTSUPP.


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
> +	errno = 0;
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
> +	errno = 0;
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
> index 000000000000..871d516a7d7d
> --- /dev/null
> +++ b/tools/testing/selftests/lsm/lsm_list_modules_test.c
> @@ -0,0 +1,153 @@
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

This requires a kernel config not listed in the config file.


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
> +	errno = 0;
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
> +	errno = 0;
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
> +	errno = 0;
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
> +	errno = 0;
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

There is no test that actually set an attribute. Would it be possible to 
load a simple dummy policy to be able to test that with at least one LSM?

Ditto for reading attribute, there are only tests that check for errors 
but not to get attribute contents (only names with basic_lsm_get_self_attr).


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

This only works if there is at least on LSM enabled. You should probably 
list the three that use these syscalls in the config file (if they are 
stackable).

Also, all the get and list tests fail if there is no LSM enabled.



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
