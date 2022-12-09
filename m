Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACEB648AD1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 23:42:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbiLIWmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 17:42:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiLIWmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 17:42:46 -0500
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E7BD165B1;
        Fri,  9 Dec 2022 14:42:44 -0800 (PST)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1p3m4f-0005PX-00; Fri, 09 Dec 2022 23:42:33 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 56DCFC248E; Fri,  9 Dec 2022 23:41:40 +0100 (CET)
Date:   Fri, 9 Dec 2022 23:41:40 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maxime Bizon <mbizon@freebox.fr>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH v3] MIPS: BCM63xx: Add check for NULL for clk in
 clk_enable
Message-ID: <20221209224140.GA4928@alpha.franken.de>
References: <20221209100550.30470-1-abelova@astralinux.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209100550.30470-1-abelova@astralinux.ru>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 01:05:50PM +0300, Anastasia Belova wrote:
> Check clk for NULL before calling clk_enable_unlocked where clk
> is dereferenced. There is such check in other implementations
> of clk_enable.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e7300d04bd08 ("MIPS: BCM63xx: Add support for the Broadcom BCM63xx family of SOCs.")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
> v2: Fix errors reported by kernel test robot <lkp@intel.com>.
> v3: Merge several patches into single one.
>  arch/mips/bcm63xx/clk.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
> index 6e6756e8fa0a..86a6e2590866 100644
> --- a/arch/mips/bcm63xx/clk.c
> +++ b/arch/mips/bcm63xx/clk.c
> @@ -361,6 +361,8 @@ static struct clk clk_periph = {
>   */
>  int clk_enable(struct clk *clk)
>  {
> +	if (!clk)
> +		return 0;
>  	mutex_lock(&clocks_mutex);
>  	clk_enable_unlocked(clk);
>  	mutex_unlock(&clocks_mutex);
> -- 
> 2.30.2

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
