Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36E469C18E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjBSRFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjBSRFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:05:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1089753;
        Sun, 19 Feb 2023 09:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=iwh6Ne2U7/xxtTuVCJTOawpxTazKPjYY5WG44WAS924=; b=rN5iAbe11toAgMm3B0r/oHct+u
        xuTzpXWCFp51d7KSr9LMoh8sHgiGHlcPfXgrJKVeyETijwbgEiHwSbIxz28fMAtdWQwRs4UhbXPYg
        gA0wNZI5iTrGoIHws8orbzgu18Mh02tdLfhXe3uUpZTkQMANZDUtnec1X72A4lGdxuJy1jdXKZ4Ns
        5soFwMvoiEucQhyF3pZ8hET6xTyfJt0N7YjUIEMaXJvM+j2iS3BZif4l1CCm/yJPVuCWTKqt9/OO4
        JnM64/gYqtCVH34M2Oi1+p7SVJFywy/MU7G15C2IEm7m0cWrXELmpWMavbuWb6F59bXYljQUJmJHT
        Hdm0SZZw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTn7Z-001zLN-Uv; Sun, 19 Feb 2023 17:05:06 +0000
Message-ID: <863bd5f6-3939-066d-f73f-d2d8453a9425@infradead.org>
Date:   Sun, 19 Feb 2023 09:05:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 1/4] sh: fix -Wmissing-include-dirs warnings for various
 platforms
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
References: <20230219141555.2308306-1-masahiroy@kernel.org>
Content-Language: en-US
In-Reply-To: <20230219141555.2308306-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/19/23 06:15, Masahiro Yamada wrote:
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

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

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

-- 
~Randy
