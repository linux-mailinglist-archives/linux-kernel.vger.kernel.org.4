Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8915864490C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbiLFQS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiLFQSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:18:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019E72E6AB
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 08:16:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADE94B81A10
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 16:16:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5658C433C1;
        Tue,  6 Dec 2022 16:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670343360;
        bh=Ke9Es9vSZpyqQkkD0xDtUqrPPPHQ+QXHuO92AWRtX1o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CUXtY072QKTqR8dVGI+9RxyL8a/07FbLRZKpQFkI2akpBJwWtmuuHo/zeS78ST/Qf
         wP2/KK2eINwmdiPfNITsaR9WfOhcSYz6y5s2nm4bmhqoBREpfZbf1B9hxAPsj47EjF
         ZJUBaQdtleCUphhzQsxxXtoWNCJ1pu/pLZ/g5he8AgCtJ+TzSqoKVjhuHFSYhiN9oA
         tZqWfbaK/RrAATh9ob6ayzFEHtCOCvp5TOAS+gijQdU6SKKmQIJc+0kvbBhRw1eQ6g
         zFFOcpW5WnJtDw8agTkOQgjbJhfIrC+hGE1UdG7xj9WalzmiA6wS3uu0itEMVJlJAi
         3lR8mjTR8oeIA==
Date:   Tue, 6 Dec 2022 16:15:56 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Changbin Du <changbin.du@intel.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: stacktrace: Fix missing the first frame
Message-ID: <Y49qvHb3LVas1cvO@spud>
References: <20221205132936.493245-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/esEgmKIgx6lEmfS"
Content-Disposition: inline
In-Reply-To: <20221205132936.493245-1-liushixin2@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/esEgmKIgx6lEmfS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2022 at 09:29:36PM +0800, Liu Shixin wrote:
> When running kfence_test, I found some testcases failed like this:
>=20
>  # test_out_of_bounds_read: EXPECTATION FAILED at mm/kfence/kfence_test.c=
:346
>  Expected report_matches(&expect) to be true, but is false
>  not ok 1 - test_out_of_bounds_read
>=20
> The corresponding call-trace is:
>=20
>  BUG: KFENCE: out-of-bounds read in kunit_try_run_case+0x38/0x84
>=20
>  Out-of-bounds read at 0x(____ptrval____) (32B right of kfence-#10):
>   kunit_try_run_case+0x38/0x84
>   kunit_generic_run_threadfn_adapter+0x12/0x1e
>   kthread+0xc8/0xde
>   ret_from_exception+0x0/0xc
>=20
> The kfence_test using the first frame of call trace to check whether the
> testcase is succeed or not. Patch a7c5c7e8ff78 skip first frame for all
> case, which results the kfence_test failed. Indeed, we only need to skip
> the first frame for case (task=3D=3DNULL || task=3D=3Dcurrent).
>=20
> With this patch, the call-trace will be:
>=20
>  BUG: KFENCE: out-of-bounds read in test_out_of_bounds_read+0x88/0x19e
>=20
>  Out-of-bounds read at 0x(____ptrval____) (1B left of kfence-#7):
>   test_out_of_bounds_read+0x88/0x19e
>   kunit_try_run_case+0x38/0x84
>   kunit_generic_run_threadfn_adapter+0x12/0x1e
>   kthread+0xc8/0xde
>   ret_from_exception+0x0/0xc
>=20
> Fixes: a7c5c7e8ff78 ("riscv: eliminate unreliable __builtin_frame_address=
(1)")

This fixes tag is not right, did checkpatch not warn about it?

The correct fixes tag would be:
Fixes: 6a00ef449370 ("riscv: eliminate unreliable __builtin_frame_address(1=
)")

Maybe consider automating the creation of fixes tags, like so:
git log -1 --format=3D'Fixes: %h (\"%s\")'

Thanks,
Conor.

> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> ---
>  arch/riscv/kernel/stacktrace.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrac=
e.c
> index 08d11a53f39e..5fe2ae4cf135 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -30,6 +30,7 @@ void notrace walk_stackframe(struct task_struct *task, =
struct pt_regs *regs,
>  		fp =3D (unsigned long)__builtin_frame_address(0);
>  		sp =3D current_stack_pointer;
>  		pc =3D (unsigned long)walk_stackframe;
> +		level =3D -1;
>  	} else {
>  		/* task blocked in __switch_to */
>  		fp =3D task->thread.s[0];
> @@ -41,7 +42,7 @@ void notrace walk_stackframe(struct task_struct *task, =
struct pt_regs *regs,
>  		unsigned long low, high;
>  		struct stackframe *frame;
> =20
> -		if (unlikely(!__kernel_text_address(pc) || (level++ >=3D 1 && !fn(arg,=
 pc))))
> +		if (unlikely(!__kernel_text_address(pc) || (level++ >=3D 0 && !fn(arg,=
 pc))))
>  			break;
> =20
>  		/* Validate frame pointer */
> --=20
> 2.25.1
>=20

--/esEgmKIgx6lEmfS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCY49qvAAKCRB4tDGHoIJi
0kI7AP9Wd277d8/BzwLH9y34IUIT/97w2cZ2oh4ldowck5Y9bQD+I+ltzljWIlqI
5d5NHjHdSGLSMbBS/qCnorTUjpi+tgE=
=l4hT
-----END PGP SIGNATURE-----

--/esEgmKIgx6lEmfS--
