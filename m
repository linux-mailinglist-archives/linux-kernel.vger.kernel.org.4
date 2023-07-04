Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251D27478D9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 21:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjGDTy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 15:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjGDTy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 15:54:57 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FB910DA;
        Tue,  4 Jul 2023 12:54:54 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 608EF100068;
        Tue,  4 Jul 2023 22:54:52 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 608EF100068
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1688500492;
        bh=7UatRpUi2b+sNemwwASvEN5x1J17ZMyIDvEn3PmXvSU=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:From;
        b=VWGWD5xVIBAAfsJ/vc5d3WIvXwNeo58tlDdaIlHlgzNsx87/kiONy8JgBomQeUDmz
         FUqbq+UkB+jSOiDpHqJmROrULliBtNRyunsA1LHujLqJYf0zZ+qXmGz5K2e7y6pS0f
         fon8weAnuyCJTCLZA3MXvWdP4PJEdpyo5mOWUAdms+p2TtlrjS0THh236N2FgayXaV
         OuFr+k4ZctdHUB9ttoTXQYakiFPg3wza0Tv/Nf/YYFc+JUyYvyQcMxhgCyFc3SFMAU
         4/gfjm3Ur9yAej3pwfbzNppFm9Qi0TbwSssd+7HdSXTYJuDpnhUJz07YTydkn1ihVH
         ZHtA7Sfze0K6w==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Tue,  4 Jul 2023 22:54:52 +0300 (MSK)
Received: from localhost (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 4 Jul
 2023 22:54:39 +0300
Date:   Tue, 4 Jul 2023 22:54:51 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jerome Brunet <jbrunet@baylibre.com>
CC:     <neil.armstrong@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <khilman@baylibre.com>,
        <martin.blumenstingl@googlemail.com>, <jian.hu@amlogic.com>,
        <kernel@sberdevices.ru>, <rockosov@gmail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jan Dakinevich <yvdakinevich@sberdevices.ru>
Subject: Re: [PATCH v1] clk: meson: change usleep_range() to udelay() for
 atomic context
Message-ID: <20230704195451.7gklbmyautuajqtq@CAB-WSD-L081021>
References: <20230703200404.20361-1-ddrokosov@sberdevices.ru>
 <1j352378zh.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1j352378zh.fsf@starbuckisacylon.baylibre.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178432 [Jul 04 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: DDRokosov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 520 520 ccb018a655251011855942a2571029252d3d69a2, {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:7.1.1,5.0.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/04 05:54:00 #21559896
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jerome,

Thank you for the review!

On Tue, Jul 04, 2023 at 09:43:41PM +0200, Jerome Brunet wrote:
> 
> On Mon 03 Jul 2023 at 23:04, Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> 
> > The function meson_clk_pll_enable() can be invoked under the enable_lock
> > spinlock from the clk core logic
> 
> ---
> > (please refer to
> > drivers/clk/clk.c:clk_core_enable_lock()), which risks a kernel panic
> > during the usleep_range() call:
> >
> 
> This part of the comment is not very useful - please drop it
> 

Do you mean a stack trace or reference to clk_core_enable_lock()?

> >    BUG: scheduling while atomic: kworker/u4:2/36/0x00000002
> >    Modules linked in: g_ffs usb_f_fs libcomposite
> >    CPU: 1 PID: 36 Comm: kworker/u4:2 Not tainted 6.4.0-rc5 #273
> >    Workqueue: events_unbound async_run_entry_fn
> >    Call trace:
> >     dump_backtrace+0x9c/0x128
> >     show_stack+0x20/0x38
> >     dump_stack_lvl+0x48/0x60
> >     dump_stack+0x18/0x28
> >     __schedule_bug+0x58/0x78
> >     __schedule+0x828/0xa88
> >     schedule+0x64/0xd8
> >     schedule_hrtimeout_range_clock+0xd0/0x208
> >     schedule_hrtimeout_range+0x1c/0x30
> >     usleep_range_state+0x6c/0xa8
> >     meson_clk_pll_enable+0x1f4/0x310
> >     clk_core_enable+0x78/0x200
> >     clk_core_enable+0x58/0x200
> >     clk_core_enable+0x58/0x200
> >     clk_core_enable+0x58/0x200
> >     clk_enable+0x34/0x60
> >
> > Considering that this code is expected to be used in an atomic context,
> > it is required to use the udelay() function instead of usleep_range()
> > for the atomic context safety.
> 
> Please use an imperative form, instructing the code to change 
> 

Ack

> >
> > Fixes: b6ec400aa153 ("clk: meson: introduce new pll power-on sequence for A1 SoC family")
> > Reported-by: Jan Dakinevich <yvdakinevich@sberdevices.ru>
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > Signed-off-by: Jan Dakinevich <yvdakinevich@sberdevices.ru>
> 
> The tags are confusing here
> I suppose a 2 lines change has not be been written with 4 hands ;)
> 
> If Jan just reported and you made the change then drop his signed-off
> If he did the job, then drop the reported-by and change the author
> 

No problem :) Sometimes 2 lines change is produced during 4 hands
debugging :)

> > ---
> >  drivers/clk/meson/clk-pll.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> > index 56ec2210f1ad..eef6f37c8d8d 100644
> > --- a/drivers/clk/meson/clk-pll.c
> > +++ b/drivers/clk/meson/clk-pll.c
> > @@ -367,9 +367,9 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
> >  	 * 3. enable the lock detect module
> >  	 */
> >  	if (MESON_PARM_APPLICABLE(&pll->current_en)) {
> > -		usleep_range(10, 20);
> > +		udelay(10);
> >  		meson_parm_write(clk->map, &pll->current_en, 1);
> > -		usleep_range(40, 50);
> > +		udelay(40);
> >  	};
> >  
> >  	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
> 

-- 
Thank you,
Dmitry
