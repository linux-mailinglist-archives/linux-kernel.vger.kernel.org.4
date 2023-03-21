Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3826D6C3DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjCUW1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjCUW1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:27:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCFF574C1;
        Tue, 21 Mar 2023 15:27:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CDECEB81A62;
        Tue, 21 Mar 2023 22:27:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C30DC433D2;
        Tue, 21 Mar 2023 22:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679437657;
        bh=XsHij0+BjfqI4rqTScfDv0AssQdKZ+pcm9X+ZsVj9qI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g0JEjCuWMLIE3T9sI7o71hYI6RGYvLIpfxbioYeLQa5FAz7EBzPRutNmbfUXBLsx6
         8+wR0LZaqO1dWzFiQILDai586zNGXaZQuyjAcik1/hsTUCEuroUjX/cs+I7294n6Gq
         UW852zdZvttEm9n+oqI8SGorf3kiNAKXgWBM1SN6fNUbl8qdHQ/lXL8+1M/7lYL3Rc
         vhn9L0rhYDZmywiB+VcqcdZ/ndJB9zupIPNzf487Sn5I44opvVNG2/Bd+8CZ/8qEXy
         l50E4Snc4j7AeJLCfjaRYs0RWd6TDSWbMH4Z+jTGLxkmunarRgTJ2lgeh0Jes9vgTD
         QMuG5xfGhRqEA==
Date:   Tue, 21 Mar 2023 22:27:30 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de,
        dave.hansen@linux.intel.com, x86@kernel.org, mingo@redhat.com,
        peterz@infradead.org, xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] function_graph: Support recording and printing
 the return value of function
Message-ID: <89607a60-d3a7-4f89-84ae-bf3e65efb487@spud>
References: <20230321084650.769212-1-pengdonglin@sangfor.com.cn>
 <20230321084650.769212-2-pengdonglin@sangfor.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zJIfbxas1xSJly7d"
Content-Disposition: inline
In-Reply-To: <20230321084650.769212-2-pengdonglin@sangfor.com.cn>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zJIfbxas1xSJly7d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 21, 2023 at 01:46:49AM -0700, Donglin Peng wrote:
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index c5e42cc37604..3efa4f645a39 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -139,6 +139,7 @@ config RISCV
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>  	select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>  	select HAVE_FUNCTION_GRAPH_TRACER
> +	select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>  	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION

BTW, and this is such a minor nit, but if you end up having to do a respin
of this for some other reason, would you mind adding the new option in
alphabetical order?

Thanks,
Conor.

--zJIfbxas1xSJly7d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZBovUgAKCRB4tDGHoIJi
0pH1AP9ab3KXHhTA2YhZs4WtiizIGeRBhjdfsR9sovX0Iy+53AD/XUWT/IDFWMgh
lK/ZPBfSfjgOJ90dNrP/Yemt9EuGRQc=
=zBK+
-----END PGP SIGNATURE-----

--zJIfbxas1xSJly7d--
