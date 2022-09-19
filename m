Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B135BCFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 16:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiISOvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 10:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiISOvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 10:51:08 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9361BC1E;
        Mon, 19 Sep 2022 07:51:02 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oaI6u-0005ft-06; Mon, 19 Sep 2022 16:51:00 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 0F591C12F2; Mon, 19 Sep 2022 16:50:11 +0200 (CEST)
Date:   Mon, 19 Sep 2022 16:50:11 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        John Crispin <john@phrozen.org>, linux-mips@vger.kernel.org
Subject: Re: [PATCH] MIPS: lantiq: export clk_get_io() for lantiq_wdt.ko
Message-ID: <20220919145010.GF7674@alpha.franken.de>
References: <20220917232540.25436-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917232540.25436-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 17, 2022 at 04:25:40PM -0700, Randy Dunlap wrote:
> The lantiq WDT driver uses clk_get_io(), which is not exported,
> so export it to fix a build error:
> 
> ERROR: modpost: "clk_get_io" [drivers/watchdog/lantiq_wdt.ko] undefined!
> 
> Fixes: 287e3f3f4e68 ("MIPS: lantiq: implement support for clkdev api")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: John Crispin <john@phrozen.org>
> Cc: linux-mips@vger.kernel.org
> ---
>  arch/mips/lantiq/clk.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/arch/mips/lantiq/clk.c
> +++ b/arch/mips/lantiq/clk.c
> @@ -50,6 +50,7 @@ struct clk *clk_get_io(void)
>  {
>  	return &cpu_clk_generic[2];
>  }
> +EXPORT_SYMBOL_GPL(clk_get_io);
>  
>  struct clk *clk_get_ppe(void)
>  {

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
