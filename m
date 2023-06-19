Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA36735EF1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 23:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjFSVVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 17:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjFSVUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 17:20:38 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594AD10E
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 14:20:36 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id 3AEBE201E6;
        Mon, 19 Jun 2023 23:20:33 +0200 (CEST)
Date:   Mon, 19 Jun 2023 23:20:28 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <kristo@kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Wadim Egorov <w.egorov@phytec.de>, vigneshr@ti.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        d-gole@ti.com
Subject: Re: [PATCH] firmware: ti_sci: Use system_state to determine polling
Message-ID: <ZJDGnM7X/n4WkIFS@francesco-nb.int.toradex.com>
References: <20230619131236.3285069-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619131236.3285069-1-nm@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2023 at 08:12:36AM -0500, Nishanth Menon wrote:
> Commit b9e8a7d950ff ("firmware: ti_sci: Switch transport to polled
> mode during system suspend") aims to resolve issues with tisci
> operations during system suspend operation. However, the system may
> enter a no_irq stage in various other usage modes, including power-off
> and restart. To determine if polling mode is appropriate, use the
> system_state instead.
> 
> While at this, drop the unused is_suspending state variable and
> related helpers.
> 
> Reported-by: Francesco Dolcini <francesco@dolcini.it>
> Reported-by: Wadim Egorov <w.egorov@phytec.de>
> Link: https://lore.kernel.org/all/ZGeHMjlnob2GFyHF@francesco-nb.int.toradex.com/
> Signed-off-by: Nishanth Menon <nm@ti.com>

s/Link/Closes/

Fixes: b9e8a7d950ff ("firmware: ti_sci: Switch transport to polled mode during system suspend")

>  drivers/firmware/ti_sci.c | 35 ++---------------------------------
>  1 file changed, 2 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
> index 039d92a595ec..dc7906e38f09 100644
> --- a/drivers/firmware/ti_sci.c
> +++ b/drivers/firmware/ti_sci.c
...
> -static DEFINE_SIMPLE_DEV_PM_OPS(ti_sci_pm_ops, ti_sci_suspend, ti_sci_resume);

You need to stop using ti_sci_pm_ops in ti_sci_driver, without this
change it does not build.

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index dc7906e38f09..91aaa0ca9bde 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -3485,7 +3485,6 @@ static struct platform_driver ti_sci_driver = {
        .driver = {
                   .name = "ti-sci",
                   .of_match_table = of_match_ptr(ti_sci_of_match),
-                  .pm = &ti_sci_pm_ops,
        },
 };


With that change I was able to do a quick test on a patched v6.4-rc7 and
it seems to solve the issue.

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Toradex Verdin AM62

Francesco

