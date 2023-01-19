Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FDB67403B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjASRpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjASRo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:44:57 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F012728
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674150252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I65fhwzn/L9Fa22JkNDNnGV7+YerXbIr5UxK/3KRDk0=;
        b=EuOfZaf1iik0GCFaRy28h1DZRbHI2IgM7lMj8QM7g8546DssCfApdxmz518riihW3uf9BI
        TNZiC6c4tOMXQTotN43SODS5G9itYUM32BsQi+HWJRAOn21CbSNmCOhH+8HXrYrZeMby7P
        c32iE7D+59AmmErCIqQHsvDpXOW6Yao=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-546-DUEB9hWWPOiYIaQ5TfeyOw-1; Thu, 19 Jan 2023 12:44:11 -0500
X-MC-Unique: DUEB9hWWPOiYIaQ5TfeyOw-1
Received: by mail-il1-f200.google.com with SMTP id n18-20020a056e02101200b0030f2b79c2ffso2074929ilj.20
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:44:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I65fhwzn/L9Fa22JkNDNnGV7+YerXbIr5UxK/3KRDk0=;
        b=MPYK5JUD8Vsvfg8kPb8uxE+a1kFSHZqdNOhRoVNLb3q5v54KqvXNAKAiU/nRvr7bLJ
         /kAUnc6ox4y9dh+70O1rxnaFmRZyDwdi9VNqWiiznV5WYmprLpFuMB0qkdfiWpJj/ccx
         5hNZgGJYsnAWQ/qTjozycO5eu44G4j7aIAzWuX92hcNx6IXvAY0ImaQp+RIW0wrK7IOp
         CCnNsQxl7lkYnJ984TVQiLRIdPGpHN1qxvwHH3yo2UGDR2dGlSkyCfb3787t2gNeYmer
         Jpro/wlRHFbT1p/LehLmcrwgsTobCDvSQkSwhVdOf0J0oqd0UyKFYcNrGkobMlcFa4h2
         T6uw==
X-Gm-Message-State: AFqh2kphxoYEXjhliCkZbE0uxBZ2u0qSq5cd3wGch4Kn2ClX4eC3dYZd
        AEsgTaPVkm4csTWrAvma7g1ISNrrofKTDUKESkZsYYeUIzaFnXb8e/tD6XXMqOJD/KcdIQXj0Zx
        vN5E1TYRSNBIXlgy8tPIkGxRg
X-Received: by 2002:a5d:8190:0:b0:707:6e91:e866 with SMTP id u16-20020a5d8190000000b007076e91e866mr2665091ion.15.1674150250055;
        Thu, 19 Jan 2023 09:44:10 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv1W5GZVuR826/SH+nw+lLMCvbhlb9cYqIkTu+onlo8zN5FdR8m3HX9tdl7EgaFE50l7p0hDw==
X-Received: by 2002:a5d:8190:0:b0:707:6e91:e866 with SMTP id u16-20020a5d8190000000b007076e91e866mr2665074ion.15.1674150249760;
        Thu, 19 Jan 2023 09:44:09 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id o9-20020a6b5a09000000b006c0cb1e1ea8sm12192765iob.12.2023.01.19.09.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 09:44:09 -0800 (PST)
Date:   Thu, 19 Jan 2023 12:44:07 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        bristot@redhat.com, ebiederm@xmission.com, brauner@kernel.org,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk, alexl@redhat.com,
        peterz@infradead.org
Subject: Re: [PATCH v2 2/2] selftests: add tests for prctl(SET_HIDE_SELF_EXE)
Message-ID: <Y8mBZ5I8Yx4TARjb@x1>
References: <20230119170718.3129938-1-gscrivan@redhat.com>
 <20230119170718.3129938-2-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119170718.3129938-2-gscrivan@redhat.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 06:07:18PM +0100, Giuseppe Scrivano wrote:
> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
> ---
>  tools/testing/selftests/prctl/Makefile        |   2 +-
>  tools/testing/selftests/prctl/hide-self-exe.c | 101 ++++++++++++++++++
>  2 files changed, 102 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/prctl/hide-self-exe.c
> 
> diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
> index c7923b205222..024e107b26ec 100644
> --- a/tools/testing/selftests/prctl/Makefile
> +++ b/tools/testing/selftests/prctl/Makefile
> @@ -5,7 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>  
>  ifeq ($(ARCH),x86)
>  TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
> -		disable-tsc-test
> +		disable-tsc-test hide-self-exe
>  all: $(TEST_PROGS)
>  
>  include ../lib.mk
> diff --git a/tools/testing/selftests/prctl/hide-self-exe.c b/tools/testing/selftests/prctl/hide-self-exe.c
> new file mode 100644
> index 000000000000..f86cef8e061c
> --- /dev/null
> +++ b/tools/testing/selftests/prctl/hide-self-exe.c
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Tests for prctl(PR_GET_HIDE_SELF_EXE, ...) / prctl(PR_SET_HIDE_SELF_EXE, ...)
> + *
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <unistd.h>
> +#include <signal.h>
> +#include <inttypes.h>
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <sys/wait.h>
> +
> +#include <sys/prctl.h>
> +#include <linux/prctl.h>
> +
> +#ifndef PR_SET_HIDE_SELF_EXE
> +# define PR_SET_HIDE_SELF_EXE		65
> +# define PR_GET_HIDE_SELF_EXE		66
> +#endif
> +
> +int main(void)
> +{
> +	int status;
> +	pid_t pid;
> +	int ret;
> +
> +	ret = open("/proc/self/exe", O_RDONLY);
> +	if (ret < 0) {
> +		perror("open /proc/self/exe");
> +		exit(EXIT_FAILURE);
> +	}
> +	close(ret);
> +
> +	ret = prctl(PR_GET_HIDE_SELF_EXE, 0, 0, 0, 0);
> +	if (ret != 0) {
> +		perror("prctl(PR_GET_HIDE_SELF_EXE)");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	ret = prctl(PR_SET_HIDE_SELF_EXE, 1, 0, 0, 0);
> +	if (ret != 0) {
> +		perror("prctl(PR_SET_HIDE_SELF_EXE)");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	/* check it doesn't fail a second time.  */
> +	ret = prctl(PR_SET_HIDE_SELF_EXE, 1, 0, 0, 0);
> +	if (ret != 0) {
> +		perror("prctl(PR_SET_HIDE_SELF_EXE)");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	ret = prctl(PR_GET_HIDE_SELF_EXE, 0, 0, 0, 0);
> +	if (ret != 1) {
> +		perror("prctl(PR_GET_HIDE_SELF_EXE)");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	ret = open("/proc/self/exe", O_RDONLY);
> +	if (ret >= 0 || errno != ENOENT) {
> +		perror("open /proc/self/exe succeeded");
> +		exit(EXIT_FAILURE);
> +	}
> +
> +	pid = fork();
> +	if (pid < 0) {
> +		perror("fork");
> +		exit(EXIT_FAILURE);
> +	}
> +	if (pid == 0) {
> +		/* Verify that it is still unreachable after fork().  */
> +		ret = open("/proc/self/exe", O_RDONLY);
> +		if (ret >= 0 || errno != ENOENT)
> +			exit(EXIT_FAILURE);
> +		close(ret);
> +
> +		/* And that it cannot be unset.  */
> +		ret = prctl(PR_GET_HIDE_SELF_EXE, 0, 0, 0, 0);

Should this be PR_SET_HIDE_SELF_EXE?

Brian

