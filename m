Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E131967407F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 19:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjASSFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 13:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjASSFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 13:05:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401B78B322
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 10:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674151455;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+FQBlawSFh7WnrThFuQouGCxy+5V47LRQD3cnPHmpSo=;
        b=Xe9mi6mlbU6xrKsuAHgtM6gBulxrzcU913vin+amKRxkUUo/eOq5mImF++ECeAFPmlmzkF
        uNoNWKtspmWU5+Gz4As4VP6zHVGhSUOUHC+KDqIzPKQ1D4yDJVRbhWFO6FauTx9kHJaY4U
        3kkSoYERAikSVDPgf/Ws/q6mA8R9/T0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-490-bIs-pnYmOXanveZi3y7GGA-1; Thu, 19 Jan 2023 13:04:12 -0500
X-MC-Unique: bIs-pnYmOXanveZi3y7GGA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 285CA3C2274D;
        Thu, 19 Jan 2023 18:04:06 +0000 (UTC)
Received: from localhost (unknown [10.39.195.23])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BFA88492B14;
        Thu, 19 Jan 2023 18:04:05 +0000 (UTC)
From:   Giuseppe Scrivano <gscrivan@redhat.com>
To:     Brian Masney <bmasney@redhat.com>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        bristot@redhat.com, ebiederm@xmission.com, brauner@kernel.org,
        cyphar@cyphar.com, viro@zeniv.linux.org.uk, alexl@redhat.com,
        peterz@infradead.org
Subject: Re: [PATCH v2 2/2] selftests: add tests for prctl(SET_HIDE_SELF_EXE)
In-Reply-To: <Y8mBZ5I8Yx4TARjb@x1> (Brian Masney's message of "Thu, 19 Jan
        2023 12:44:07 -0500")
References: <20230119170718.3129938-1-gscrivan@redhat.com>
        <20230119170718.3129938-2-gscrivan@redhat.com> <Y8mBZ5I8Yx4TARjb@x1>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
Date:   Thu, 19 Jan 2023 19:04:03 +0100
Message-ID: <87o7quflkc.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Masney <bmasney@redhat.com> writes:

> On Thu, Jan 19, 2023 at 06:07:18PM +0100, Giuseppe Scrivano wrote:
>> Signed-off-by: Giuseppe Scrivano <gscrivan@redhat.com>
>> ---
>>  tools/testing/selftests/prctl/Makefile        |   2 +-
>>  tools/testing/selftests/prctl/hide-self-exe.c | 101 ++++++++++++++++++
>>  2 files changed, 102 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/prctl/hide-self-exe.c
>> 
>> diff --git a/tools/testing/selftests/prctl/Makefile b/tools/testing/selftests/prctl/Makefile
>> index c7923b205222..024e107b26ec 100644
>> --- a/tools/testing/selftests/prctl/Makefile
>> +++ b/tools/testing/selftests/prctl/Makefile
>> @@ -5,7 +5,7 @@ ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>>  
>>  ifeq ($(ARCH),x86)
>>  TEST_PROGS := disable-tsc-ctxt-sw-stress-test disable-tsc-on-off-stress-test \
>> -		disable-tsc-test
>> +		disable-tsc-test hide-self-exe
>>  all: $(TEST_PROGS)
>>  
>>  include ../lib.mk
>> diff --git a/tools/testing/selftests/prctl/hide-self-exe.c b/tools/testing/selftests/prctl/hide-self-exe.c
>> new file mode 100644
>> index 000000000000..f86cef8e061c
>> --- /dev/null
>> +++ b/tools/testing/selftests/prctl/hide-self-exe.c
>> @@ -0,0 +1,101 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Tests for prctl(PR_GET_HIDE_SELF_EXE, ...) / prctl(PR_SET_HIDE_SELF_EXE, ...)
>> + *
>> + */
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <unistd.h>
>> +#include <signal.h>
>> +#include <inttypes.h>
>> +#include <errno.h>
>> +#include <fcntl.h>
>> +#include <sys/wait.h>
>> +
>> +#include <sys/prctl.h>
>> +#include <linux/prctl.h>
>> +
>> +#ifndef PR_SET_HIDE_SELF_EXE
>> +# define PR_SET_HIDE_SELF_EXE		65
>> +# define PR_GET_HIDE_SELF_EXE		66
>> +#endif
>> +
>> +int main(void)
>> +{
>> +	int status;
>> +	pid_t pid;
>> +	int ret;
>> +
>> +	ret = open("/proc/self/exe", O_RDONLY);
>> +	if (ret < 0) {
>> +		perror("open /proc/self/exe");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +	close(ret);
>> +
>> +	ret = prctl(PR_GET_HIDE_SELF_EXE, 0, 0, 0, 0);
>> +	if (ret != 0) {
>> +		perror("prctl(PR_GET_HIDE_SELF_EXE)");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	ret = prctl(PR_SET_HIDE_SELF_EXE, 1, 0, 0, 0);
>> +	if (ret != 0) {
>> +		perror("prctl(PR_SET_HIDE_SELF_EXE)");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	/* check it doesn't fail a second time.  */
>> +	ret = prctl(PR_SET_HIDE_SELF_EXE, 1, 0, 0, 0);
>> +	if (ret != 0) {
>> +		perror("prctl(PR_SET_HIDE_SELF_EXE)");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	ret = prctl(PR_GET_HIDE_SELF_EXE, 0, 0, 0, 0);
>> +	if (ret != 1) {
>> +		perror("prctl(PR_GET_HIDE_SELF_EXE)");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	ret = open("/proc/self/exe", O_RDONLY);
>> +	if (ret >= 0 || errno != ENOENT) {
>> +		perror("open /proc/self/exe succeeded");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +
>> +	pid = fork();
>> +	if (pid < 0) {
>> +		perror("fork");
>> +		exit(EXIT_FAILURE);
>> +	}
>> +	if (pid == 0) {
>> +		/* Verify that it is still unreachable after fork().  */
>> +		ret = open("/proc/self/exe", O_RDONLY);
>> +		if (ret >= 0 || errno != ENOENT)
>> +			exit(EXIT_FAILURE);
>> +		close(ret);
>> +
>> +		/* And that it cannot be unset.  */
>> +		ret = prctl(PR_GET_HIDE_SELF_EXE, 0, 0, 0, 0);
>
> Should this be PR_SET_HIDE_SELF_EXE?

you are right, thanks for spotting it!  I should test
PR_SET_HIDE_SELF_EXE not the getter.


