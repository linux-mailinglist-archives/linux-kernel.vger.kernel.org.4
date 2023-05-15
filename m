Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD4F7032F7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 18:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242494AbjEOQba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 12:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242716AbjEOQbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 12:31:22 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302A1E78
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 09:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=fxsy5xAAUzv2Oh3VqA6pEv9r2VtHDcvtmHDLXlIrWyA=; b=CeMauip17ebjTwhjUADA9Wxi6H
        nCCp6iZYYwtXTuYEg/9IbbJZG3L4GwFtCqfHG067VbBqe2JkQc1MhrddeTeOm1vemz93Ydwjb9c+M
        JCWuWcgtNyZnmxEn1l+utTvYY3l4jjNLkFqNToo/mhsdLzHXCfkbRXjnNYJ8dv8Nm+5C2Qw0rx8Fm
        3W2YtIB49Ca0TWKen+DhguPsdQhey80zffiRpBU3OV4MAmYHOuRkuTlJZTf4MqpRLzOFIcrz0eWiW
        UqJwx46DWdyRAgphqg3qsovlcwxz2pVnNWVnRJdu6JxBJsgimr5G2rGUW4I3EfwGUggIDp3zR3IT5
        wDoSeBqA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41518)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1pyb6I-00045b-Cr; Mon, 15 May 2023 17:31:06 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1pyb6E-0008Ky-DO; Mon, 15 May 2023 17:31:02 +0100
Date:   Mon, 15 May 2023 17:31:02 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Andrew Davis <afd@ti.com>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] ARM: mach-airoha: Rework support and directory
 structure
Message-ID: <ZGJeRiqylcysFPqu@shell.armlinux.org.uk>
References: <20230515160234.289631-1-afd@ti.com>
 <20230515160234.289631-6-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515160234.289631-6-afd@ti.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 11:02:30AM -0500, Andrew Davis wrote:
> Having a platform need a mach-* directory should be seen as a negative,
> it means the platform needs special non-standard handling. ARM64 support
> does not allow mach-* directories at all. While we may not get to that
> given all the non-standard architectures we support, we should still try
> to get as close as we can and reduce the number of mach directories.
> 
> The mach-airoha/ directory, and files within, provide just one "feature":
> having the kernel print the machine name if the DTB does not also contain
> a "model" string (which they always do). To reduce the number of mach-*
> directories let's do without that feature and remove this directory.

I'm guessing this is copy-n-pasted description. However:
> -static const char * const airoha_board_dt_compat[] = {
> -	"airoha,en7523",
> -	NULL,
> -};
> -
> -DT_MACHINE_START(MEDIATEK_DT, "Airoha Cortex-A53 (Device Tree)")
> -	.dt_compat	= airoha_board_dt_compat,
> -MACHINE_END

If this is actually used, then it will have the effect of providing a
"machine" that has both l2c_aux_mask and l2c_aux_val as zero, whereas
the default one has l2c_aux_mask set to ~0.

This has the effect of _not_ calling l2x0_of_init() - but you don't
mention this. You probably should, and you should probably state why
that is safe (assuming you've even realised you've made this change!)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
