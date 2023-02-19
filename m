Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4011969C192
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjBSRF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbjBSRFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:05:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4429D13508;
        Sun, 19 Feb 2023 09:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=AbdG81pFpbsO+dVFtFherENtA24BLCHQkVk1QLBAUQg=; b=imuAoLkn54jT9uMghiJB/sm0T7
        WZrXljlAZ06HW/pLa1jZ+G9WbJGYqPxdrnFXOSgCRnqrFeLrWqjZ+4hu9Dnk67zGTxznEoca6CTz+
        SUvofh/FHFeH/Qzn5Ai/jkWt2Ce1kVXjBz700B75inlnLXe4f10jv2+j3blIwgX3sXX+FMJaroOcc
        w4ymlCTbveIGEwnvjsKyULfRV88dSb8JeAkxzbk8MzVWzIXkmTWA4Vz9sn6JuxIVvb08Cz2MwDLAs
        F4WjRyNyEuo7opBDl/Zt5FsrHfRGr1YorejyC0JhwW6DL1yOegPeZqeipvYBAd0CKcsvnKShFNElA
        15A8LBaw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTn7o-001zNJ-Rt; Sun, 19 Feb 2023 17:05:20 +0000
Message-ID: <523d51c0-b68e-a4dc-d6aa-a84725f7cb56@infradead.org>
Date:   Sun, 19 Feb 2023 09:05:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 3/4] sh: refactor header include path addition
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
References: <20230219141555.2308306-1-masahiroy@kernel.org>
 <20230219141555.2308306-3-masahiroy@kernel.org>
Content-Language: en-US
In-Reply-To: <20230219141555.2308306-3-masahiroy@kernel.org>
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
> Shorten the code. No functional change intended.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
>  arch/sh/Makefile | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/sh/Makefile b/arch/sh/Makefile
> index 0625796cfe7f..f1c6aace8acb 100644
> --- a/arch/sh/Makefile
> +++ b/arch/sh/Makefile
> @@ -145,8 +145,7 @@ cpuincdir-y			+= cpu-common	# Must be last
>  
>  drivers-y			+= arch/sh/drivers/
>  
> -cflags-y	+= $(foreach d, $(cpuincdir-y), -I $(srctree)/arch/sh/include/$(d)) \
> -		   $(foreach d, $(machdir-y), -I $(srctree)/arch/sh/include/$(d))
> +cflags-y	+= $(addprefix -I $(srctree)/arch/sh/include/, $(cpuincdir-y) $(machdir-y))
>  
>  KBUILD_CFLAGS		+= -pipe $(cflags-y)
>  KBUILD_CPPFLAGS		+= $(cflags-y)

-- 
~Randy
