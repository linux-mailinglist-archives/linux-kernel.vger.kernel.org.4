Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF4C6A288A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 10:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBYJhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 04:37:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBYJhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 04:37:15 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3FD9CA2F
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 01:37:13 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 31P9b635029945;
        Sat, 25 Feb 2023 10:37:06 +0100
Date:   Sat, 25 Feb 2023 10:37:06 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Vincent Dagonneau <v@vda.io>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] tools/nolibc: add tests for the integer limits in
 stdint.h
Message-ID: <Y/nWwuqLLG8A0xT7@1wt.eu>
References: <20230223010025.11092-1-v@vda.io>
 <20230223010025.11092-5-v@vda.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223010025.11092-5-v@vda.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

I'm currently integrating your patches. I'm having a quick question
below:

On Wed, Feb 22, 2023 at 08:00:25PM -0500, Vincent Dagonneau wrote:
> This commit adds tests for the limits added in a previous commit. The
> limits are defined in decimal in stdint.h and as hexadecimal in the
> tests (e.g. 0x7f = 127 or 0x80 = -128). Hopefully it catches some of the
> most egregious mistakes.
> 
> As we rely on the compiler to provide __SIZEOF_LONG__, we also test
> whether it is defined.
> 
> Signed-off-by: Vincent Dagonneau <v@vda.io>
> Signed-off-by: Willy Tarreau <w@1wt.eu>
> ---
>  tools/testing/selftests/nolibc/nolibc-test.c | 53 ++++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 882140508d56..d6886f900e79 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -561,6 +561,59 @@ int run_syscall(int min, int max)
>  		CASE_TEST(waitpid_child);     EXPECT_SYSER(1, waitpid(getpid(), &tmp, WNOHANG), -1, ECHILD); break;
>  		CASE_TEST(write_badf);        EXPECT_SYSER(1, write(-1, &tmp, 1), -1, EBADF); break;
>  		CASE_TEST(write_zero);        EXPECT_SYSZR(1, write(1, &tmp, 0)); break;
> +		CASE_TEST(limit_int8_max);          EXPECT_EQ(1, INT8_MAX,         (int8_t)          0x7f); break;
> +		CASE_TEST(limit_int8_min);          EXPECT_EQ(1, INT8_MIN,         (int8_t)          0x80); break;
> +		CASE_TEST(limit_uint8_max);         EXPECT_EQ(1, UINT8_MAX,        (uint8_t)         0xff); break;
(...)

I'm just realizing now that the test was added at the end of the syscalls
tests instead of the stdlib test (e.g. after memcmp()). Are you OK with me
moving it there, given that it has nothing to do with syscalls but rather
with what the nolibc itself provides ?

Thanks!
Willy
