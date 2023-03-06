Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37916AB960
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjCFJKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjCFJJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:09:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFF64EF9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 01:09:43 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6qV-0006Z0-Ai; Mon, 06 Mar 2023 10:09:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6qR-002D7W-QZ; Mon, 06 Mar 2023 10:09:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1pZ6qR-002coG-5Y; Mon, 06 Mar 2023 10:09:23 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 0/3] watchdog: s3c2410_wdt: Simplify using dev_err_probe()
Date:   Mon,  6 Mar 2023 10:09:16 +0100
Message-Id: <20230306090919.2206871-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <891023d7-9510-445e-9053-ad5c0398d350@roeck-us.net>
References: <891023d7-9510-445e-9053-ad5c0398d350@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4134; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=dbOnuKo6PAvTY72AG+BV5c/SL7l2SajkGuyceprD1LY=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBkBa2viWCqV5t+UroQTcp7HhFtUP28LNcAXyyhx wa2CaN4jq+JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCZAWtrwAKCRDB/BR4rcrs CUpTB/9qB6PfHLNjPnGdZajL8QSJuFMGNV9X1m15eEDJGlTuaCuPb/dvzC9HNyWqodYQV0q1aJk 31wGYV1yZ9h6Le+C7HEr0F1xBbQgce05MyfmDYjJ6t3Q4Gj6LRXWmZ7ABoR0UwJ9Ya46Mwhz7Ay 2ZynYidbKjdql0paRK6TbUkUanbJp4fs45dn4DHUpXIX7xtQzS6jP6Sp+20hHmVEO1HQYo1fK9M ET6eWXgY9B0XrLVnZlm+IQmL55hOGouo1IpIYfR/DCe+pJSsSLsW2ItkZ+OnoAY9JBL+XS+lm77 sHM8nxgxMtOCoVVzatR6x0QOgdpcaeLg3LeG5r5TkQ7Hxi87
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Mar 05, 2023 at 06:31:08AM -0800, Guenter Roeck wrote:
> On Sun, Mar 05, 2023 at 12:15:00PM +0100, Uwe Kleine-König wrote:
> > On Sat, Mar 04, 2023 at 02:10:47PM -0800, Guenter Roeck wrote:
> > > The primary reason to call dev_err_probe() is that the error may be
> > > -EPROBE_DEFER, in which case the error message is suppressed.
> > > That is not the case for those two functions; they never return
> > > -EPROBE_DEFER. Calling dev_err_probe() would give the false impression
> > > that the functions _might_ return -EPROBE_DEFER.
> > 
> > That is subjective. In my book dev_err_probe() handling -EPROBE_DEFER is
> > only one aspect. Another is that using it allows to have return and error
> > message in a single line and also that if already other exit paths use
> > it to get a consistent style for the emitted messages. Having said that
> > *I* wouldn't assume that the previous call might return -EPROBE_DEFER
> > just because dev_err_probe() is used.
> > 
> > Having said that, I also don't think there is much harm if someone
> > thinks that a given function (here devm_request_irq()) might return
> > -EPROBE_DEFER.
> > 
> 
> I guess we'll have to agree to disagree.

I don't agree to disagree. In my eyes you weight the corresponding facts
in an irrational way. To have some code changes to talk about, I created
this series (on top of Guenter's patches to this driver from Saturday
[1]).

Patch 1 is necessary to effectively make use of dev_err_probe(). I admit
this annoys me a bit as it shows that dev_err_probe() isn't a plug-in
replacement, but given that it reduces the binary size a bit, it has at
least positive usefulness. (But maybe this is subjective? *shrug*)

Patch 2 unifies the format of the error messages between the error paths
that make use of dev_err_probe() and those that (only) use dev_err().
IMHO this has mixed value, but still positive in sum. While having a
consistent error log style is nice, having to manually use
dev_err_probe()'s style is a bit ugly. Together with a) the messages get
more useful mentioning the error code and b) the downside is removed by
patch 3, I still like it. (And if you don't because of b), please
consider squashing patches 2 and 3 together. In fact I only created
patch 2 to make the upsides for patch 3 more obvious and I don't mind a
squash.)

Patch 3 does the actual conversion to dev_err_probe() for all error
paths in .probe(). The (unarguable?) upsides are:

 - Reduced line count
 - Reduced binary size (and the reduction mentioned in the commit log
   doesn't even account for the shorter format strings!)

The fact where Guenter doesn't agree to me (and Krzysztof) is:

 - You cannot any more defer from the usage of dev_err_probe() vs.
   dev_err() if the function that failed before might return
   -EPROBE_DEFER.

In my eyes this is irrelevant because there is no objective reason to
have to know that. If the function might return -EPROBE_DEFER or not
shouldn't (and doesn't!) have an influence on how the driver should
behave in the error case. Also the ability to defer that property is
very unreliable. It's not even reliable in drivers/watchdog, look at how
imx2_wdt handles devm_clk_get() or keembay_wdt handles clk_get_rate()
returning zero.

So using dev_err_probe() has two big benefits in contrast to a dubious
and unreliable connection between -EPROBE_DEFER and dev_err_probe().

Best regards
Uwe

[1] https://lore.kernel.org/linux-watchdog/20230304165653.2179835-1-linux@roeck-us.net

Uwe Kleine-König (3):
  watchdog: s3c2410_wdt: Fold s3c2410_get_wdt_drv_data() into only
    caller
  watchdog: s3c2410_wdt: Unify error logging format in probe function
  watchdog: s3c2410_wdt: Simplify using dev_err_probe()

 drivers/watchdog/s3c2410_wdt.c | 93 ++++++++++++++--------------------
 1 file changed, 37 insertions(+), 56 deletions(-)


base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
prerequisite-patch-id: 775bdd863307268e1ef16250bf2f40862637b453
prerequisite-patch-id: 924ddfbe583e97e7c9a46c2460ecbc88c29ee319
-- 
2.39.1

