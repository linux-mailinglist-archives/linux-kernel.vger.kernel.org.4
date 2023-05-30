Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B627155A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjE3Gpw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjE3Gpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:45:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D218B2;
        Mon, 29 May 2023 23:45:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QVjZv55tCz4whk;
        Tue, 30 May 2023 16:45:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1685429145;
        bh=o7BSq9ytklugFOyDmLNWraah9D1SBaiKnYWrg8YWVzY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CClFspLelMasiQojGDSV8rakiv9SxUusKUuLe2+tTNTreFEwgNqa20yYFu/PgZ+R7
         r0cl9Vho5EdCDiXCqVIqaNXoTk21GJgPMBObVdcOdZmiaA/Sdrs+TRyxB014BcbM/b
         7wufiYNWGRITdYJ2jUQCpLtFH2Fb5NhZiAAY2+S1TP4e7CkJk7QuIrFHEMnx5SGD7J
         8tz7dc8QFP9a5BfAud4zEtHDKJmyAkax0KTTk5r++Vc3NSpFmfD/xyw78ypMuZvogC
         9r6pVCyEA0A/MRuMhDZQYGYvPJcvsynuikJt8ah4+ZlUQ9QIhteVoLhbPhxzeM2sxb
         HQ91XEKVPZ/Yg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Maninder Singh <maninder1.s@samsung.com>, bcain@quicinc.com,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        keescook@chromium.org, nathanl@linux.ibm.com, ustavoars@kernel.org,
        alex.gaynor@gmail.com, gary@garyguo.net, ojeda@kernel.org,
        pmladek@suse.com, wedsonaf@google.com
Cc:     linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Maninder Singh <maninder1.s@samsung.com>,
        Onkarnath <onkarnath.1@samsung.com>
Subject: Re: [PATCH 2/2] powerpc/xmon: use KSYM_NAME_LEN in array size
In-Reply-To: <20230529111337.352990-2-maninder1.s@samsung.com>
References: <20230529111337.352990-1-maninder1.s@samsung.com>
 <CGME20230529111404epcas5p2d540d726dcf3e21aae2a6a0958e2eea5@epcas5p2.samsung.com>
 <20230529111337.352990-2-maninder1.s@samsung.com>
Date:   Tue, 30 May 2023 16:45:39 +1000
Message-ID: <874jnutizw.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maninder Singh <maninder1.s@samsung.com> writes:
> kallsyms_lookup which in turn calls for kallsyms_lookup_buildid()
> writes on index "KSYM_NAME_LEN - 1".
>
> Thus array size should be KSYM_NAME_LEN.
>
> for powerpc it was defined as "128" directly.
> and commit '61968dbc2d5d' changed define value to 512,
> So both were missed to update with new size.
>
> Fixes: 61968dbc2d5d ("kallsyms: increase maximum kernel symbol length to 512")

AFAICS that's the wrong sha.

That commit appears in linux-next, but the commit that actually went
into mainline is:

  b8a94bfb3395 ("kallsyms: increase maximum kernel symbol length to 512")

So I'll update the change log to refer to that.

cheers

> Co-developed-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
> Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
> ---
>  arch/powerpc/xmon/xmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 728d3c257e4a..70c4c59a1a8f 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -88,7 +88,7 @@ static unsigned long ndump = 64;
>  static unsigned long nidump = 16;
>  static unsigned long ncsum = 4096;
>  static int termch;
> -static char tmpstr[128];
> +static char tmpstr[KSYM_NAME_LEN];
>  static int tracing_enabled;
>  
>  static long bus_error_jmp[JMP_BUF_LEN];
> -- 
> 2.17.1
