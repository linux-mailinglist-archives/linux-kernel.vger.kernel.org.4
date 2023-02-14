Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4229469672A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjBNOl7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 14 Feb 2023 09:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjBNOl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:41:56 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7739927D4D;
        Tue, 14 Feb 2023 06:41:55 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pRwV0-002cvL-LZ; Tue, 14 Feb 2023 15:41:38 +0100
Received: from p5b13aa49.dip0.t-ipconnect.de ([91.19.170.73] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pRwV0-000316-EM; Tue, 14 Feb 2023 15:41:38 +0100
Message-ID: <c9cc61db21e80b0b9304496567d0ed5feea47e25.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 2/2] sh: initialize max_mapnr
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org
Date:   Tue, 14 Feb 2023 15:41:37 +0100
In-Reply-To: <20230214140729.1649961-3-rppt@kernel.org>
References: <20230214140729.1649961-1-rppt@kernel.org>
         <20230214140729.1649961-3-rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.170.73
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-02-14 at 16:07 +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> sh never initializes max_mapnr which is used by the generic
> implementation of pfn_valid().
> 
> Initialize max_mapnr with set_max_mapnr() in sh::paging_init().
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: e5080a967785 ("mm, arch: add generic implementation of pfn_valid() for FLATMEM")
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>  arch/sh/mm/init.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index 506784702430..bf1b54055316 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -301,6 +301,7 @@ void __init paging_init(void)
>  	 */
>  	max_low_pfn = max_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
>  	min_low_pfn = __MEMORY_START >> PAGE_SHIFT;
> +	set_max_mapnr(max_low_pfn - min_low_pfn);
>  
>  	nodes_clear(node_online_map);
>  

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
