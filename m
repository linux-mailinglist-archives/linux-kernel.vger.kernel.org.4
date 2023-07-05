Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86D17489DA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjGERIt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 5 Jul 2023 13:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjGERIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:08:47 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73CC9171E;
        Wed,  5 Jul 2023 10:08:46 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qH5zd-003Hst-JW; Wed, 05 Jul 2023 19:08:41 +0200
Received: from p5b13aeb4.dip0.t-ipconnect.de ([91.19.174.180] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qH5zd-000XVr-8K; Wed, 05 Jul 2023 19:08:41 +0200
Message-ID: <113ffbb3872d675a124fdf1ccebbbcf1fac289fb.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/4] sh: fix -Wmissing-include-dirs warnings for various
 platforms
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Date:   Wed, 05 Jul 2023 19:08:40 +0200
In-Reply-To: <20230219141555.2308306-1-masahiroy@kernel.org>
References: <20230219141555.2308306-1-masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.174.180
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-02-19 at 23:15 +0900, Masahiro Yamada wrote:
> The 0day bot reports a lot of warnings (or errors due to CONFIG_WERROR)
> like this:
> 
>   cc1: error: arch/sh/include/mach-hp6xx: No such file or directory [-Werror=missing-include-dirs]
> 
> Indeed, arch/sh/include/mach-hp6xx does not exist.
> 
> -Wmissing-include-dirs is W=1 warning, but it may be annoying
> when CONFIG_BTRFS_FS is enabled because fs/btrfs/Makefile
> unconditionally adds this warning option.
> 
> arch/sh/Makefile defines machdir-y for two purposes:
> 
>  - Build platform code in arch/sh/boards/mach-*/
>  - Add arch/sh/include/mach-*/ to the header search path
> 
> For the latter, some platforms use arch/sh/include/mach-common/ instead
> of having its own arch/sh/include/mach-*/.
> 
> Drop unneeded machdir-y to not include non-existing include directory.
> 
> To build arch/sh/boards/mach-*/, use the standard obj-y syntax in
> arch/sh/boards/Makefile.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202302190641.30VVXnPb-lkp@intel.com/
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  arch/sh/Makefile        | 18 +-----------------
>  arch/sh/boards/Makefile | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/sh/Makefile b/arch/sh/Makefile
> index 5c8776482530..a9cad5137f92 100644
> --- a/arch/sh/Makefile
> +++ b/arch/sh/Makefile
> @@ -116,31 +116,15 @@ export ld-bfd
>  
>  # Mach groups
>  machdir-$(CONFIG_SOLUTION_ENGINE)		+= mach-se
> -machdir-$(CONFIG_SH_HP6XX)			+= mach-hp6xx
>  machdir-$(CONFIG_SH_DREAMCAST)			+= mach-dreamcast
>  machdir-$(CONFIG_SH_SH03)			+= mach-sh03
> -machdir-$(CONFIG_SH_RTS7751R2D)			+= mach-r2d
> -machdir-$(CONFIG_SH_HIGHLANDER)			+= mach-highlander
>  machdir-$(CONFIG_SH_MIGOR)			+= mach-migor
> -machdir-$(CONFIG_SH_AP325RXA)			+= mach-ap325rxa
>  machdir-$(CONFIG_SH_KFR2R09)			+= mach-kfr2r09
>  machdir-$(CONFIG_SH_ECOVEC)			+= mach-ecovec24
> -machdir-$(CONFIG_SH_SDK7780)			+= mach-sdk7780
>  machdir-$(CONFIG_SH_SDK7786)			+= mach-sdk7786
>  machdir-$(CONFIG_SH_X3PROTO)			+= mach-x3proto
> -machdir-$(CONFIG_SH_SH7763RDP)			+= mach-sh7763rdp
> -machdir-$(CONFIG_SH_SH4202_MICRODEV)		+= mach-microdev
>  machdir-$(CONFIG_SH_LANDISK)			+= mach-landisk
> -machdir-$(CONFIG_SH_LBOX_RE2)			+= mach-lboxre2
> -machdir-$(CONFIG_SH_RSK)			+= mach-rsk
> -
> -ifneq ($(machdir-y),)
> -core-y	+= $(addprefix arch/sh/boards/, \
> -	     $(filter-out ., $(patsubst %,%/,$(machdir-y))))
> -endif
> -
> -# Common machine type headers. Not part of the arch/sh/boards/ hierarchy.
> -machdir-y	+= mach-common
> +machdir-y					+= mach-common
>  
>  # Companion chips
>  core-$(CONFIG_HD6446X_SERIES)	+= arch/sh/cchips/hd6446x/
> diff --git a/arch/sh/boards/Makefile b/arch/sh/boards/Makefile
> index 4002a22a7c40..b57219436ace 100644
> --- a/arch/sh/boards/Makefile
> +++ b/arch/sh/boards/Makefile
> @@ -18,3 +18,22 @@ obj-$(CONFIG_SH_APSH4A3A)	+= board-apsh4a3a.o
>  obj-$(CONFIG_SH_APSH4AD0A)	+= board-apsh4ad0a.o
>  
>  obj-$(CONFIG_SH_DEVICE_TREE)	+= of-generic.o
> +
> +obj-$(CONFIG_SOLUTION_ENGINE)	+= mach-se/
> +obj-$(CONFIG_SH_HP6XX)		+= mach-hp6xx/
> +obj-$(CONFIG_SH_DREAMCAST)	+= mach-dreamcast/
> +obj-$(CONFIG_SH_SH03)		+= mach-sh03/
> +obj-$(CONFIG_SH_RTS7751R2D)	+= mach-r2d/
> +obj-$(CONFIG_SH_HIGHLANDER)	+= mach-highlander/
> +obj-$(CONFIG_SH_MIGOR)		+= mach-migor/
> +obj-$(CONFIG_SH_AP325RXA)	+= mach-ap325rxa/
> +obj-$(CONFIG_SH_KFR2R09)	+= mach-kfr2r09/
> +obj-$(CONFIG_SH_ECOVEC)		+= mach-ecovec24/
> +obj-$(CONFIG_SH_SDK7780)	+= mach-sdk7780/
> +obj-$(CONFIG_SH_SDK7786)	+= mach-sdk7786/
> +obj-$(CONFIG_SH_X3PROTO)	+= mach-x3proto/
> +obj-$(CONFIG_SH_SH7763RDP)	+= mach-sh7763rdp/
> +obj-$(CONFIG_SH_SH4202_MICRODEV)+= mach-microdev/
> +obj-$(CONFIG_SH_LANDISK)	+= mach-landisk/
> +obj-$(CONFIG_SH_LBOX_RE2)	+= mach-lboxre2/
> +obj-$(CONFIG_SH_RSK)		+= mach-rsk/

Applied to my for-next tree for 6.5. PR will be sent tomorrow.

Thanks,
Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
