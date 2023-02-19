Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1289969C195
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 18:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjBSRFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 12:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjBSRF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 12:05:29 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D9A1350D;
        Sun, 19 Feb 2023 09:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:Subject:From:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=F6JJADHOsWHKA0bshEGXmw0TuflTOHo4/Y/0axH58tc=; b=0bQrdmQXLvQS/CWWCW2JzSwHMQ
        ckfCDify3CmNxAS5OAQShbkf8L5VCNS+tR+r8xSNbifqYZL2GgrvNqPGfxJsAEGCPVwVUuqqBNuZd
        Thnx6KqAdgDfntS2JuY9LfI8zQWTIrIj2UXm4h8aObd8w7b9wylm0TutDqu8EfnnUiHK1V9/6T1Pa
        Opca1+EzlfNrx8i3/TOXKVrgYyMgAnAtluQWC3v+RedrXqA+JnQrzz9yPJAUPbxq7/s/M6QWQc9dK
        R46GBq5JYzKANbkgZwsqk6uAdnpiwQmSzNsmjg37jIqcUfov2oQyhZX8d0bBZQVNEd0AR5c3W8+BL
        XZVxjhFw==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pTn7s-001zOP-S2; Sun, 19 Feb 2023 17:05:24 +0000
Message-ID: <86cc6fec-2d6e-17eb-b9ca-66c1850fca78@infradead.org>
Date:   Sun, 19 Feb 2023 09:05:24 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 4/4] sh: remove compiler flag duplication
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
References: <20230219141555.2308306-1-masahiroy@kernel.org>
 <20230219141555.2308306-4-masahiroy@kernel.org>
Content-Language: en-US
In-Reply-To: <20230219141555.2308306-4-masahiroy@kernel.org>
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
> Every compiler flag added by arch/sh/Makefile is passed to the
> compiler twice.
> 
> $(KBUILD_CPPFLAGS) + $(KBUILD_CFLAGS) is used for compiling *.c
> $(KBUILD_CPPFLAGS) + $(KBUILD_AFLAGS) is used for compiling *.S
> 
> Given the above, adding $(cflags-y) to all of KBUILD_{CPP/C/A}FLAGS
> ends up with duplication.
> 
> Add -I options to $(KBUILD_CPPFLAGS), and the rest of $(cflags-y)
> to KBUILD_{C,A}FLAGS.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
>  arch/sh/Makefile | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/sh/Makefile b/arch/sh/Makefile
> index f1c6aace8acb..cab2f9c011a8 100644
> --- a/arch/sh/Makefile
> +++ b/arch/sh/Makefile
> @@ -145,10 +145,8 @@ cpuincdir-y			+= cpu-common	# Must be last
>  
>  drivers-y			+= arch/sh/drivers/
>  
> -cflags-y	+= $(addprefix -I $(srctree)/arch/sh/include/, $(cpuincdir-y) $(machdir-y))
> -
> +KBUILD_CPPFLAGS		+= $(addprefix -I $(srctree)/arch/sh/include/, $(cpuincdir-y) $(machdir-y))
>  KBUILD_CFLAGS		+= -pipe $(cflags-y)
> -KBUILD_CPPFLAGS		+= $(cflags-y)
>  KBUILD_AFLAGS		+= $(cflags-y)
>  
>  ifeq ($(CONFIG_MCOUNT),y)

-- 
~Randy
