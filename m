Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260CF6FEA1E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 05:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjEKDVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 23:21:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjEKDVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 23:21:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8533E63;
        Wed, 10 May 2023 20:21:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QGxy40qx8z4x2c;
        Thu, 11 May 2023 13:21:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1683775292;
        bh=9VphvYDUUTpJa6Y51rDbdnX2+VZhjxsrx/SPIlypOzg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NJNN2mxnfu/5QYe7146XafzWTY72GFa0FBjWrl2NLrxKyugO0NAVfnvefKNqSd6pa
         yQzeAxhIemK5n1/e0B8WFeiOUkigosZGcXEkcK8l8kQ1qQNk/OQ+4+PdoZoVutNUq9
         mFkl2ewnLvfRjTL9efoWJN5c14AkgYpUrfyPElVTvbpr1OCax+7l8CPQkZUET5fBE4
         F488/tp145G5ISsXEhhYnOw7qJ/ZbGXVDqj45X75FmW0Ifq6CcdC0EH4JPwMlatPi1
         COCqhjngty6kkF+aWLnfOykGPX2ig66VE9Wvld7fRyrnldUEGBEihtrS6EaG3QRXWi
         7BQRutfI41uWQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com,
        willy@infradead.org, linux-api@vger.kernel.org,
        kernel-team@meta.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v13 3/3] selftests: Add selftests for cachestat
In-Reply-To: <20230503013608.2431726-4-nphamcs@gmail.com>
References: <20230503013608.2431726-1-nphamcs@gmail.com>
 <20230503013608.2431726-4-nphamcs@gmail.com>
Date:   Thu, 11 May 2023 13:21:28 +1000
Message-ID: <877ctfa6yv.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nhat Pham <nphamcs@gmail.com> writes:
> Test cachestat on a newly created file, /dev/ files, and /proc/ files.
> Also test on a shmem file (which can also be tested with huge pages
> since tmpfs supports huge pages).
>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
...
> diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
> new file mode 100644
> index 000000000000..c3823b809c25
> --- /dev/null
> +++ b/tools/testing/selftests/cachestat/test_cachestat.c
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE
> +
> +#include <stdio.h>
> +#include <stdbool.h>
> +#include <linux/kernel.h>
> +#include <linux/mman.h>
> +#include <sys/mman.h>
> +#include <sys/shm.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +#include <string.h>
> +#include <fcntl.h>
> +#include <errno.h>
> +
> +#include "../kselftest.h"
> +
> +static const char * const dev_files[] = {
> +	"/dev/zero", "/dev/null", "/dev/urandom",
> +	"/proc/version", "/proc"
> +};
> +static const int cachestat_nr = 451;
> +
> +void print_cachestat(struct cachestat *cs)
> +{
> +	ksft_print_msg(
> +	"Using cachestat: Cached: %lu, Dirty: %lu, Writeback: %lu, Evicted: %lu, Recently Evicted: %lu\n",
> +	cs->nr_cache, cs->nr_dirty, cs->nr_writeback,
> +	cs->nr_evicted, cs->nr_recently_evicted);
> +}
> +
> +bool write_exactly(int fd, size_t filesize)
> +{
> +	char data[filesize];

On kernels with 64K pages (powerpc at least), this tries to allocate
64MB on the stack which segfaults.

Allocating data with malloc avoids the problem and allows the test to
pass.

Looks like this commit is still in mm-unstable, so maybe Andrew can
squash the incremental diff below in, if it looks OK to you. The diff is
a bit big because I unindented the body of the function.

cheers


diff --git a/tools/testing/selftests/cachestat/test_cachestat.c b/tools/testing/selftests/cachestat/test_cachestat.c
index 9be2262e5c17..54d09b820ed4 100644
--- a/tools/testing/selftests/cachestat/test_cachestat.c
+++ b/tools/testing/selftests/cachestat/test_cachestat.c
@@ -31,48 +31,59 @@ void print_cachestat(struct cachestat *cs)
 
 bool write_exactly(int fd, size_t filesize)
 {
-	char data[filesize];
-	bool ret = true;
 	int random_fd = open("/dev/urandom", O_RDONLY);
+	char *cursor, *data;
+	int remained;
+	bool ret;
 
 	if (random_fd < 0) {
 		ksft_print_msg("Unable to access urandom.\n");
 		ret = false;
 		goto out;
-	} else {
-		int remained = filesize;
-		char *cursor = data;
+	}
 
-		while (remained) {
-			ssize_t read_len = read(random_fd, cursor, remained);
+	data = malloc(filesize);
+	if (!data) {
+		ksft_print_msg("Unable to allocate data.\n");
+		ret = false;
+		goto close_random_fd;
+	}
 
-			if (read_len <= 0) {
-				ksft_print_msg("Unable to read from urandom.\n");
-				ret = false;
-				goto close_random_fd;
-			}
+	remained = filesize;
+	cursor = data;
 
-			remained -= read_len;
-			cursor += read_len;
+	while (remained) {
+		ssize_t read_len = read(random_fd, cursor, remained);
+
+		if (read_len <= 0) {
+			ksft_print_msg("Unable to read from urandom.\n");
+			ret = false;
+			goto out_free_data;
 		}
 
-		/* write random data to fd */
-		remained = filesize;
-		cursor = data;
-		while (remained) {
-			ssize_t write_len = write(fd, cursor, remained);
+		remained -= read_len;
+		cursor += read_len;
+	}
 
-			if (write_len <= 0) {
-				ksft_print_msg("Unable write random data to file.\n");
-				ret = false;
-				goto close_random_fd;
-			}
+	/* write random data to fd */
+	remained = filesize;
+	cursor = data;
+	while (remained) {
+		ssize_t write_len = write(fd, cursor, remained);
 
-			remained -= write_len;
-			cursor += write_len;
+		if (write_len <= 0) {
+			ksft_print_msg("Unable write random data to file.\n");
+			ret = false;
+			goto out_free_data;
 		}
+
+		remained -= write_len;
+		cursor += write_len;
 	}
 
+	ret = true;
+out_free_data:
+	free(data);
 close_random_fd:
 	close(random_fd);
 out:

