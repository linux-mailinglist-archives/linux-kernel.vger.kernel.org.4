Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035FF746901
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 07:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjGDFdA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 01:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGDFc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 01:32:59 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C560E6;
        Mon,  3 Jul 2023 22:32:58 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qGYem-000LQF-IS; Tue, 04 Jul 2023 07:32:56 +0200
Received: from p57bd997f.dip0.t-ipconnect.de ([87.189.153.127] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qGYem-000djq-7u; Tue, 04 Jul 2023 07:32:56 +0200
Message-ID: <bca228079ae6e3063465fdd78054910460426bb2.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 4/4] sh: remove compiler flag duplication
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Date:   Tue, 04 Jul 2023 07:32:55 +0200
In-Reply-To: <20230219141555.2308306-4-masahiroy@kernel.org>
References: <20230219141555.2308306-1-masahiroy@kernel.org>
         <20230219141555.2308306-4-masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.3 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.153.127
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

Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
