Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771575BB761
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 11:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIQJBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 05:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIQJBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 05:01:42 -0400
Received: from tulikuusama2.dnainternet.net (tulikuusama2.dnainternet.net [83.102.40.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461692BB2F;
        Sat, 17 Sep 2022 02:01:41 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by tulikuusama2.dnainternet.net (Postfix) with ESMTP id ABA4F28904;
        Sat, 17 Sep 2022 11:54:51 +0300 (EEST)
X-Virus-Scanned: DNA Internet at dnainternet.net
X-Spam-Score: 2.975
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
Received: from tulikuusama2.dnainternet.net ([83.102.40.151])
        by localhost (tulikuusama2.dnainternet.net [127.0.0.1]) (DNA Internet, port 10041)
        with ESMTP id opv80w7qov8h; Sat, 17 Sep 2022 11:54:51 +0300 (EEST)
Received: from kirsikkapuu2.dnainternet.net (kirsikkapuu2.dnainternet.net [83.102.40.52])
        by tulikuusama2.dnainternet.net (Postfix) with ESMTP id 846D220B65;
        Sat, 17 Sep 2022 11:54:51 +0300 (EEST)
Received: from localhost (87-95-96-237.bb.dnainternet.fi [87.95.96.237])
        by kirsikkapuu2.dnainternet.net (Postfix) with ESMTP id 07FC67B;
        Sat, 17 Sep 2022 11:54:44 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Sat, 17 Sep 2022 11:54:44 +0300
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org, p.zabel@pengutronix.de,
        horatiu.vultur@microchip.com
Subject: Re: [PATCH -next v2 1/2] pinctrl: ocelot: add missing
 destroy_workqueue() in error path in ocelot_pinctrl_probe()
Message-ID: <YyWLVF6OAyerJKvR@surfacebook>
References: <20220917024634.1021861-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917024634.1021861-1-yangyingliang@huawei.com>
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Sep 17, 2022 at 10:46:33AM +0800, Yang Yingliang kirjoitti:
> Add the missing destroy_workqueue() before return from ocelot_pinctrl_probe()
> in error path.
> 
> Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
> v2:
>   move alloc_ordered_workqueue() after ocelot_pinctrl_register().

Why? What will happen if user space start using pins before workqueue is allocated?

If you really want to have it correct, you need either drop all devm_ calls
after allocating workqueue, or wrap destroying into devm.

-- 
With Best Regards,
Andy Shevchenko


