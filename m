Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18C773A96F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231165AbjFVU1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFVU1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:27:43 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 084C31FF0;
        Thu, 22 Jun 2023 13:27:43 -0700 (PDT)
Received: from CPC-beaub-VBQ1L.localdomain (unknown [4.155.48.115])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8598F21C20B1;
        Thu, 22 Jun 2023 13:27:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8598F21C20B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1687465662;
        bh=pah3zAq1lR0LPID6JFpNlFgCCfk77BxPFOsR1HW9+RA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kc4kQe4MoDiB4vQy1Rl5yKzHBFQON2x3ntfCDgUvC7mPEyaIsPYJj4NqZUgl/+VE2
         n0yykpz/A3yl/FT8e+SWOfA1oL/BBaMGz0THXWG6FZITX3EHGcjkvzG7FiZDgouDyh
         0fuDh3ozm+yC2HrDZ/HFO4FVi+gyGy37olclzoDc=
Date:   Thu, 22 Jun 2023 20:27:40 +0000
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     sunliming <sunliming@kylinos.cn>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, kelulanainsley@gmail.com,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] selftests/user_events: Add test cases when event
 is diabled
Message-ID: <ZJSuvC9bfcTQMWvI@CPC-beaub-VBQ1L.localdomain>
References: <20230621063502.154378-1-sunliming@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621063502.154378-1-sunliming@kylinos.cn>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 02:35:02PM +0800, sunliming wrote:
> When user_events are disabled, it's write operation should return zero.
> Add this test cases.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>

I don't have a problem with the chagne to the test, however, the patch
title has a typo in it for "disabled" that should be corrected. I've
ACK'd the other 2 patches, so you only need to resubmit this one with a
correct title.

Thanks,
-Beau

> ---
>  tools/testing/selftests/user_events/ftrace_test.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
> index d33bd31425db..7968d69c3a5c 100644
> --- a/tools/testing/selftests/user_events/ftrace_test.c
> +++ b/tools/testing/selftests/user_events/ftrace_test.c
> @@ -297,6 +297,9 @@ TEST_F(user, write_events) {
>  	io[0].iov_base = &reg.write_index;
>  	io[0].iov_len = sizeof(reg.write_index);
>  
> +	/* Write should return zero when event is not enabled */
> +	ASSERT_EQ(0, writev(self->data_fd, (const struct iovec *)io, 3));
> +
>  	/* Enable event */
>  	self->enable_fd = open(enable_file, O_RDWR);
>  	ASSERT_NE(-1, write(self->enable_fd, "1", sizeof("1")))
> -- 
> 2.25.1
