Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E865B6118BF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiJ1REj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiJ1REJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:04:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513537961E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3439629A9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 17:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A243C43470;
        Fri, 28 Oct 2022 17:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666976605;
        bh=AESbGu2O9nYA4AXjyXIcYcJonR0BCyEzgYXDLmNxIps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EBd7GTG/T+ApefryC1LXKWunIBdq6MOYwUDQzzRntsz16ikxQ/8PPTJ4kNV/Sjh/N
         dGdJwK6Fdsi3prf3uX9ShXTKBvywxbZ5Cp3h4lkh///D369bK1Un4bpcDNDU3dpSV2
         yGJ9hwbKOxDaeQFuvY/h8e82yKaUnL+tSl8QWUm4jguglIYwAoZ6rjt5YD59oIoLqk
         hWsiykenAXk8fJ4APkKhdE51Qz9hjNQh7ShdRT1mV9WMUvmhB2cJjB1LycYGCJnAiX
         KJ7Gv9UdPTJfkDoWTuCB7Pq2XSxhyQL0/9FfT5tQb37PqXJeavRbQ6WJduukyq36Kv
         s8bqiHnLZmsZQ==
Date:   Fri, 28 Oct 2022 18:03:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Joey Gouly <joey.gouly@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Topi Miettinen <toiwoton@gmail.com>, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-abi-devel@lists.sourceforge.net, nd@arm.com, shuah@kernel.org
Subject: Re: [PATCH v1 2/2] kselftest: vm: add tests for
 memory-deny-write-execute
Message-ID: <Y1wLVsg8VN26xI7j@sirena.org.uk>
References: <20221026150457.36957-1-joey.gouly@arm.com>
 <20221026150457.36957-3-joey.gouly@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="47yTjnBUJpUNKiR4"
Content-Disposition: inline
In-Reply-To: <20221026150457.36957-3-joey.gouly@arm.com>
X-Cookie: Life -- Love It or Leave It.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--47yTjnBUJpUNKiR4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 26, 2022 at 04:04:57PM +0100, Joey Gouly wrote:

> Add some tests to cover the new PR_SET_MDWE prctl.

Some comments below but they're all stylistic and let's not make perfect
be the enemy of the good here so

Reviewed-by: Mark Brown <broonie@kernel.org>

and we can iterate later rather than blocking anything on the testcase.

> +#ifdef __aarch64__
> +#define PROT_BTI      0x10            /* BTI guarded page */
> +#endif

We should get this from the kernel headers shouldn't we?  We generally
rely on things getting pulled in from there rather than locally
defining.

> +#define TEST1 "mmap(PROT_WRITE | PROT_EXEC)\n"
> +#define TEST2 "mmap(PROT_WRITE); mprotect(PROT_EXEC)\n"
> +#define TEST3 "mmap(PROT_EXEC); mprotect(PROT_EXEC | PROT_READ)\n"
> +#define TEST4 "mmap(PROT_EXEC); mprotect(PROT_EXEC | PROT_BTI)\n"

> +int test1(int mdwe_enabled)
> +{

It feels like we could usefully make an array of

	struct test {
		int (*run)(bool mdwe_enabled);
		char *name;
	}

then we'd need fewer ifdefs, things could be more usefully named and
it'd be a bit easier to add new cases.

> +#ifdef __aarch64__
> +	ksft_set_plan(12);
> +#else
> +	ksft_set_plan(9);
> +#endif

That'd just be ksft_test_plan(3 * ARRAY_SIZE(tests).

> +	// First run the tests without MDWE
> +	test_result(test1(0), TEST1);
> +	test_result(test2(0), TEST2);
> +	test_result(test3(0), TEST3);
> +#ifdef __aarch64__
> +	test_result(test4(0), TEST4);
> +#endif

and these calls to the tests would all be iterating over the array.

--47yTjnBUJpUNKiR4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNcC1UACgkQJNaLcl1U
h9C19Af/eppp5itiJzGKSzYvLeXnNUreLYh2Rqu3UnGDus4O3osH56VEL/v7GS3S
ZXS7XLRRMCvqQLOdyfYMl/D0NZ81bZC4/ieqdBvCIpkl2+NQp/msNrd1Yw4zXcwM
L4QjgI5rsbWq7WXkfwI8RpQqpjI0HuVZWfuGXjfPS7WBf491CheGDpw6UjKGtkKV
G6moVtc6nwANL1zyshVc/HbgiwQYlmtV66UrInc9kcOWlBQXWaAGLzNqNMKhwYeo
nFHG7tCGbCRhs+77IZE+XdhYyDXsf6Kwv9vgir3tUFj/4Z6lUYF+fpHIOKNp8d76
0xbl/MwaAfiZNa7VxJ2lgGgRsr+XPQ==
=H3Al
-----END PGP SIGNATURE-----

--47yTjnBUJpUNKiR4--
