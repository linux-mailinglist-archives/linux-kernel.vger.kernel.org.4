Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2ED73B894
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 15:16:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjFWNQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 09:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFWNQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 09:16:42 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42AC5BA;
        Fri, 23 Jun 2023 06:16:40 -0700 (PDT)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
        id 1qCgeU-0002sn-00; Fri, 23 Jun 2023 15:16:38 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 72D90C0375; Fri, 23 Jun 2023 15:10:19 +0200 (CEST)
Date:   Fri, 23 Jun 2023 15:10:19 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] MIPS: dec: prom: Address -Warray-bounds warning
Message-ID: <20230623131019.GD11636@alpha.franken.de>
References: <ZJTcvfpvhvF+OLjc@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJTcvfpvhvF+OLjc@work>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 05:43:57PM -0600, Gustavo A. R. Silva wrote:
> Zero-length arrays are deprecated, and we are replacing them with flexible
> array members instead. So, replace zero-length array with flexible-array
> member in struct memmap.
> 
> Address the following warning found after building (with GCC-13) mips64
> with decstation_64_defconfig:
> In function 'rex_setup_memory_region',
>     inlined from 'prom_meminit' at arch/mips/dec/prom/memory.c:91:3:
> arch/mips/dec/prom/memory.c:72:31: error: array subscript i is outside array bounds of 'unsigned char[0]' [-Werror=array-bounds=]
>    72 |                 if (bm->bitmap[i] == 0xff)
>       |                     ~~~~~~~~~~^~~
> In file included from arch/mips/dec/prom/memory.c:16:
> ./arch/mips/include/asm/dec/prom.h: In function 'prom_meminit':
> ./arch/mips/include/asm/dec/prom.h:73:23: note: while referencing 'bitmap'
>    73 |         unsigned char bitmap[0];
> 
> This helps with the ongoing efforts to globally enable -Warray-bounds.
> 
> This results in no differences in binary output.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Link: https://github.com/KSPP/linux/issues/323
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  arch/mips/include/asm/dec/prom.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/dec/prom.h b/arch/mips/include/asm/dec/prom.h
> index 1e1247add1cf..908e96e3a311 100644
> --- a/arch/mips/include/asm/dec/prom.h
> +++ b/arch/mips/include/asm/dec/prom.h
> @@ -70,7 +70,7 @@ static inline bool prom_is_rex(u32 magic)
>   */
>  typedef struct {
>  	int pagesize;
> -	unsigned char bitmap[0];
> +	unsigned char bitmap[];
>  } memmap;
>  
>  
> -- 
> 2.34.1

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
