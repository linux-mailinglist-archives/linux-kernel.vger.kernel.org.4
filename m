Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696D36A2486
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 23:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjBXWyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 17:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBXWyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 17:54:15 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9AD199CA;
        Fri, 24 Feb 2023 14:54:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1677279238; i=spasswolf@web.de;
        bh=X6ItjyP9MG8dDWKw11pNbMR3SzEiZVzlKGxqAAkRWYI=;
        h=X-UI-Sender-Class:Subject:From:To:Date:In-Reply-To:References;
        b=NKCbIH6KKXLhDvc8/S3a/PxC+lQ2U1MCHMpK3FGV59SkRvvvJIeGxS8veFDl5BCsO
         DBdkKgH0+zfXy+171G0qZkq56jQiIehA9YphfhSkEDLzj4xQPn1XP7whMuAb3ool80
         YYFokR1o/auBLJQSLJHJE8TtiddCnuAE7qWgVR4wAG0S9dd8BaEapcKyZOww9kNhcD
         2LJ1fjsS4SpQ8CJfvZlivdctVv1PMV9avAGs9PPBsbHqlMnealXz3Vh12y8IAz1KjO
         fZJsfPDBtoxk6yZvCPpFhO6TWIwZoWgH0RVJQ0iIE3OOqncMU2Nn1pQKO+wtenBU7H
         2GDIKDN+I8qKA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsJP4-1odKFI11S6-00tkRn; Fri, 24
 Feb 2023 23:53:58 +0100
Message-ID: <e016ae5f47876156225c5627a0e11a9cb6d4cd4e.camel@web.de>
Subject: Re: [PATCH] mm/mprotect: Fix successful vma_merge() of next in
 do_mprotect_pkey()
From:   Bert Karwatzki <spasswolf@web.de>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-next@vger.kernel.org
Date:   Fri, 24 Feb 2023 23:53:57 +0100
In-Reply-To: <20230224212055.1786100-1-Liam.Howlett@oracle.com>
References: <20230224212055.1786100-1-Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:vx1apuPUecev5jKqtZwdxbuUpxxnQMn3OSG8CsWn48OtHiPbUGR
 cW2IHwwIrqP9woxP3DN3yVLhI/w0brd83zFJUv4+p0p3zzx1+rbQeGQhnFDfv0qJ8SzQaWs
 TMINqdZRdgs/08SKADWHSJFJJBTaACDZAANQVhdc3+mlrGvaUB+nA3unwfeJvqJVHq4gegS
 3MKPsEqqt/tHLzA1j2WAg==
UI-OutboundReport: notjunk:1;M01:P0:/D7syJBMguA=;Ygdz90o5sVO60fd2WvwmkXegi0X
 G63TDnzo8Z6Hk6Z9QqGJw6blXI3UgS81uYluBF2YR8lNg9ebMNLmTsLBX9x7Xdjbz/RcmlhC4
 0+AC1YYIln8TGaIuLaRiApB3lFbQc3RNJNEEDQL8rehHEuLqEOgQE1lv+PvQLq0aSgHI0JHl/
 t2OgyywYoBgFAE0oy0uRkQJYLW+PJj/DVF/x5688oUkwXNnMkuaX36Xw3HSMYKS4EFnVf2KFM
 5WEEo8x5Ed3Isek2V45vQ4met8+SL/wwO9BRyLM4AXzIZV/nRMN+eCOAaLLcW2vHQCtzpfnEr
 5AUqk+F0V0AD52PsTOpPz71vktE62RR80JN4iq4jrrJ+wMQjPz/N9ug0lgLwvyAnsSvCu+n+k
 k5HnRjvb99EqogUNC4bEMe8Nr1oiW9VkPdegSIC28GZTxea5JnZJfLHSP3FonleKLpoZ9Z9ok
 WtmyX9YESLZuZfELUiQ8lSlDv6qnliW8ihMpTUsC2Ry+M0Tc/yNJRgp9y2aqL5rKlKCWWtTFn
 9N3J2W1IMo4Otue+4oUO3k4h/DGjNj/WVMUtTAIwRzTosahIrR0PFr20AZPqTwLh1W5dP8jfh
 SRWyeNTbW7z+uOPDzdCD3itpNPnA4WQkx8gGHoPtwK2m2bf2hPwbIPzB1AWIdglRqnsEM6mxJ
 vG13j576zpO8hQCr+xCCt6lgqdxJHPWxGJDBmIspgY7jpeFfpMY0yzT7xJpe6PTptOtmFfX6Y
 kjIxVIbM0jjt9/+90dXjLUF+/nOsdHgarqy0SbUc9GqI+saG8LYesqQ+Q+Ou+GbilXWG8d2MH
 f4o3qcIttzmvzUzWIfVT3qfLdcrN41u8aYmtMcldoMtLI+w3nQbdrGCJQg5G1BcUl5g1fAiIy
 uTtM02uxNcMKvVPrNQZOg0QAQ1zzBH/x+9elv866kjIOLw83MTCSHZzUBg3fMv6kb2NF2e7xG
 NSY7rqwptzXVNC2p3ATFptqn4qE=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, dem 24.02.2023 um 16:20 -0500 schrieb Liam R. Howlett:
> If mprotect_fixup() successfully calls vma_merge() and replaces vma
> and
> the next vma, then the tmp variable in the do_mprotect_pkey() is not
> updated to point to the new vma end.=C2=A0 This results in the loop
> detecting
> a gap between VMAs that does not exist.=C2=A0 Fix the faulty value of tmp
> by
> setting it to the end location of the vma iterator at the end of the
> loop.
>=20
> Reported-by: Bert Karwatzki <spasswolf@web.de>
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=3D217061
> Fixes: 2286a6914c77 ("mm: change mprotect_fixup to vma iterator")
> Link:
> https://lore.kernel.org/linux-mm/20230223120407.729110a6ecd1416ac59d9cb0@=
linux-foundation.org/
> Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> ---
> =C2=A0mm/mprotect.c | 1 +
> =C2=A01 file changed, 1 insertion(+)
>=20
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 1d4843c97c2a..231929f119d9 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -832,6 +832,7 @@ static int do_mprotect_pkey(unsigned long start,
> size_t len,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (error)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bre=
ak;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0tmp =3D vma_iter_end(&vmi);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0nstart =3D tmp;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0prot =3D reqprot;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
I tested this in linux-next-20230224 by starting stellaris from steam
(which is the only way I managed to trigger the bug) and it fixes the
issue for me.
Bert Karwatzki
