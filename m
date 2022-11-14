Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9BA628B2E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 22:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbiKNVOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 16:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236238AbiKNVO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 16:14:29 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E1911C1D;
        Mon, 14 Nov 2022 13:14:19 -0800 (PST)
Received: from leknes.fjasle.eu ([46.142.49.81]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MRSZX-1oa97c0yxR-00NQau; Mon, 14 Nov 2022 22:13:45 +0100
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 668E93C09F; Mon, 14 Nov 2022 22:13:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1668460423; bh=h8McHJ//b172V6G96l5Bvxz5c6Cfg6nz4Zj9xXVDgug=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RZYktjSsNR4kkzWdGKroQIkPeeb5YsGq8IjM4Y2/KJ7A2cgua4K4cDRAAFqSMw2dA
         3qZDjxGH3s9ZSY4EwR3iWWVM1uNyE/SMFn3gGq1B+EUgF4OU7j7sr4LVjO/d3V/Ag/
         9tCf8vceWGTBPfiuG77HL7UEkCqUkdlbrrRG1qMc=
Date:   Mon, 14 Nov 2022 22:13:40 +0100
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: revive parallel execution for .tmp_initcalls.lds
 rule
Message-ID: <Y3KvhNpfpyfDwUr2@fjasle.eu>
References: <20221114174617.211980-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221114174617.211980-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:MuEObhEAJrXc2dJwO+e999Q7Kq8mBFe/DergvyjgVMhfy7qmucH
 FwqVM6wbzGRfcFJcdfJbSHtfUo6ppqA64CVLULG/iU3jjqmJQJJ72ZkznVlePJQrcSHM8+Z
 jEIxbagULBW6c3SUQ1/SVk4xQgmReBQwMNkMAWSbkt1trM1dqcwuKVwpmGFSX/91bvwERpE
 DWiyktZg2qidmQ+5Y2nRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jKixNAjDpAo=:mbSzh132VODC13cuy5H/rk
 K49Dnt+V6Brj6vnFzDf1gh5t+q7FYZVpDOEkkU0TYcNA0k5IZF52z4pkHKaX/ZktOUd4bp0dv
 3ZXKNOeSros2nbcthNn+XnBpMWPg4Mh18+K5/SBkxmpHUUwMvrAB4iuqwUUZCk0cjwTAyMrhK
 2X20ppOycJFJY5yatNsF0roD1lFkXQtQCchCKsFe3ZtFbHnzSz1uc+FQthpNrOaJnDRLZWdFm
 kQKZM/yeWEiZ2ImexZdIhUCKNYd6ISFiGwTrrVwqQBkK3ZfDUe38HmPSnMRESF2bnE983C2FA
 qW21CTtDOBTPc6SF1AbE5xh6oPkq4weZ40TNh8M+S/23a+294xtjmJypzuxp7skB0CY33Fh+U
 MTsCdNeY1+UVKDLN7yD5BK/ApX3JO7Mn8ldWdB99Jzj5jlQ2EjN/A3pF1svAfGSnqsehXy1c3
 01gt1kvosfPISJlV78z6T9C2mQDH1tIpd+4y6ymb3uOuiN4ZVuDCfTSJ9TBbbz4JEC32TomNH
 W3BOZ2p6vYSN0SVJJq+Pgi+YOky35kwORi7nCjhJnHFLjsPlN6YApCcZlyOnZIycvl4MKpVmg
 jahAKJ3duXKlLZrDr93NbnJ3RK4uPt4QfA+WWUW1vYdV3qIcmQbknFHXb7sDGlagrbsjPWsPE
 evGpdFRTZbCkLZsDbVrCXwIlL6jbK/YNcC6FXOuvQX6ZzdyIwQe5X4Zn3/mOX5syoxlCvQyuU
 +UsQmo81M+/hsAMCqODvkWM0u8Gigbp7rM5Puj4aJEHuBlfzAQQ4e6myFazai/UVc10pzAKT0
 P1UaONq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 02:46:17AM +0900, Masahiro Yamada wrote:
> Prior to commit 5d45950dfbb1 ("kbuild: move vmlinux.o link to
> scripts/Makefile.vmlinux_o"), jobserver-exec was invoked from the shell
> script, link-vmlinux.sh. It can get access to the jobserver because
> Makefile adds '+' prefix, as in:
> 
>     +$(call if_changed_dep,link_vmlinux)
> 
> Since 5d45950dfbb1, jobserver-exec is invoked from Makefile, but the
> '+' prefix is missing, hence jobserver-exec has no access to the
> jobserver.
> 
> Fixes: 5d45950dfbb1 ("kbuild: move vmlinux.o link to scripts/Makefile.vmlinux_o")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

> 
>  scripts/Makefile.vmlinux_o | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
> index 0edfdb40364b..ae52d3b3f063 100644
> --- a/scripts/Makefile.vmlinux_o
> +++ b/scripts/Makefile.vmlinux_o
> @@ -19,7 +19,7 @@ quiet_cmd_gen_initcalls_lds = GEN     $@
>  
>  .tmp_initcalls.lds: $(srctree)/scripts/generate_initcall_order.pl \
>  		vmlinux.a $(KBUILD_VMLINUX_LIBS) FORCE
> -	$(call if_changed,gen_initcalls_lds)
> +	+$(call if_changed,gen_initcalls_lds)
>  
>  targets := .tmp_initcalls.lds
>  
> -- 
> 2.34.1

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
