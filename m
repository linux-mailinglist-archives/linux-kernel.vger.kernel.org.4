Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E47969A559
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 06:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbjBQFvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 00:51:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjBQFvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 00:51:36 -0500
Received: from mg.richtek.com (mg.richtek.com [220.130.44.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C79F49899;
        Thu, 16 Feb 2023 21:51:33 -0800 (PST)
X-MailGates: (flag:4,DYNAMIC,BADHELO,RELAY,NOHOST:PASS)(compute_score:DE
        LIVER,40,3)
Received: from 192.168.10.46
        by mg.richtek.com with MailGates ESMTP Server V5.0(23447:0:AUTH_RELAY)
        (envelope-from <cy_huang@richtek.com>); Fri, 17 Feb 2023 13:51:22 +0800 (CST)
Received: from ex4.rt.l (192.168.10.47) by ex3.rt.l (192.168.10.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Fri, 17 Feb
 2023 13:51:22 +0800
Received: from linuxcarl2.richtek.com (192.168.10.154) by ex4.rt.l
 (192.168.10.45) with Microsoft SMTP Server id 15.2.1118.20 via Frontend
 Transport; Fri, 17 Feb 2023 13:51:22 +0800
Date:   Fri, 17 Feb 2023 13:51:22 +0800
From:   ChiYuan Huang <cy_huang@richtek.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     Sebastian Reichel <sre@kernel.org>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] power: supply: rt9467: Fix rt9467_run_aicl()
Message-ID: <20230217055122.GA5502@linuxcarl2.richtek.com>
References: <2ed01020fa8a135c36dbaa871095ded47d926507.1676464968.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2ed01020fa8a135c36dbaa871095ded47d926507.1676464968.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Christophe:
On Wed, Feb 15, 2023 at 01:43:04PM +0100, Christophe JAILLET wrote:
> It is spurious to bail-out on a wait_for_completion_timeout() call that
> does NOT timeout.
> 
> Reverse the logic to return -ETIMEDOUT instead, in case of tiemout.
>
Thanks. It's really our coding issue.

Reviewed-by: ChiYuan Huang <cy_huang@richtek.com>
> Fixes: 6f7f70e3a8dd ("power: supply: rt9467: Add Richtek RT9467 charger driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> 
> This is spurious, because if I'm right, it means that it does not work!
> Testing on a real hardware is really welcomed.
> ---
>  drivers/power/supply/rt9467-charger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/power/supply/rt9467-charger.c b/drivers/power/supply/rt9467-charger.c
> index 96ad0d7d3af4..bb737fd1cca6 100644
> --- a/drivers/power/supply/rt9467-charger.c
> +++ b/drivers/power/supply/rt9467-charger.c
> @@ -598,8 +598,8 @@ static int rt9467_run_aicl(struct rt9467_chg_data *data)
>  
>  	reinit_completion(&data->aicl_done);
>  	ret = wait_for_completion_timeout(&data->aicl_done, msecs_to_jiffies(3500));
> -	if (ret)
> -		return ret;
> +	if (ret == 0)
> +		return -ETIMEDOUT;
>  
>  	ret = rt9467_get_value_from_ranges(data, F_IAICR, RT9467_RANGE_IAICR, &aicr_get);
>  	if (ret) {
> -- 
> 2.34.1
> 
