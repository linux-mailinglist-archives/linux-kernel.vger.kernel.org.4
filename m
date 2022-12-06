Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4308A6447BC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235298AbiLFPNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbiLFPN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:13:26 -0500
Received: from smtp-out-06.comm2000.it (smtp-out-06.comm2000.it [212.97.32.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D2025EB1;
        Tue,  6 Dec 2022 07:09:38 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-06.comm2000.it (Postfix) with ESMTPSA id 036F1561D45;
        Tue,  6 Dec 2022 16:08:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1670339317;
        bh=blplQwq9EdejH0j4HSUbXC84gL4g/wQ7bOQGXQm2ZIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HDqTFZns+v1o07uzn0Tr81LA3IhfJtL5s+LbVA//nNWqe8lfCz/+qpqNqxIpiBLWH
         n6H38VUpBHYApIzgAVRtAkni8olKmTpmEecUbzPKSGxeXYGg5UI4Zc2LQZMAszlUeZ
         JDaaGgB4xiviTghjBdhYK68cKfkRagXUvBFXrYojQwpyYpJ5nDX5RpTJsnhiab+96L
         wLHe+mMBLihLpnXJRi1vfaRWYCupnXOQ4UZyIeBnxwuYMkljnacsLZWTokoRgk4Jx4
         LR9IixSrz0ZHpR8yjxy5ZcJzpiRI3Pvs9594LG2SS5Ej996o8qJr14KUhqfUm+09Sd
         djCQD6Its67SA==
Date:   Tue, 6 Dec 2022 16:08:24 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Sherry Sun <sherry.sun@nxp.com>, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Fabio Estevam <festevam@gmail.com>,
        max.krummenacher@toradex.com
Subject: Re: [PATCH] Revert "serial: fsl_lpuart: Reset prior to registration"
Message-ID: <Y49a6FQfNG55Q47i@francesco-nb.int.toradex.com>
References: <20220929085318.5268-1-sherry.sun@nxp.com>
 <Y49W5DuvGcqh0PFw@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49W5DuvGcqh0PFw@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 03:52:07PM +0100, Francesco Dolcini wrote:
> Hello all,
> 
> On Thu, Sep 29, 2022 at 04:53:18PM +0800, Sherry Sun wrote:
> > This reverts commit 60f361722ad2ae5ee667d0b0545d40c42f754daf.
> > 
> > commit 60f361722ad2 ("serial: fsl_lpuart: Reset prior to registration")
> > causes the lpuart console cannot work any more. Since the console is
> > registered in the uart_add_one_port(), the driver cannot identify the
> > console port before call uart_add_one_port(), which causes all the uart
> > ports including the console port will be global reset.
> > So need to revert this patch to avoid breaking the lpuart console.
> > 
> > Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
> 
> What's the status/plan on this?

whoops, already solved in
76bad3f88750 ("tty: serial: fsl_lpuart: don't break the on-going transfer when global reset")

