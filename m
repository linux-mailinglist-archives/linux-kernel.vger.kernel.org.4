Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462FB6FA9DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 12:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbjEHK4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 06:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbjEHK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 06:56:11 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE116A5E5;
        Mon,  8 May 2023 03:55:01 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pvyWA-0001oP-3H; Mon, 08 May 2023 12:54:58 +0200
Message-ID: <51cff63a-3a04-acf5-8264-bb19b0bee8a3@leemhuis.info>
Date:   Mon, 8 May 2023 12:54:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: mainline build failure due to cf21f328fcaf ("media: nxp: Add
 i.MX8 ISI driver")
Content-Language: en-US, de-DE
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
References: <ZElaVmxDsOkZj2DK@debian>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZElaVmxDsOkZj2DK@debian>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1683543301;d41b0eb5;
X-HE-SMSGID: 1pvyWA-0001oP-3H
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.04.23 19:07, Sudip Mukherjee (Codethink) wrote:
>
> The latest mainline kernel branch fails to build xtensa, mips, arm allmodconfig
> with the error:
> 
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c: In function 'mxc_isi_channel_set_inbuf':
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:33:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
>    33 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c: In function 'mxc_isi_channel_set_outbuf':
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:51:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
>    51 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/media/platform/nxp/imx8-isi/imx8-isi-hw.c:66:5: error: "CONFIG_ARCH_DMA_ADDR_T_64BIT" is not defined, evaluates to 0 [-Werror=undef]
>    66 | #if CONFIG_ARCH_DMA_ADDR_T_64BIT
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> git bisect pointed to cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")

Thanks for the report. The fixes (see the mail from Laurent) apparently
are still not mainlined (or am I missing something?), so let me add this
report to the tracking to ensure this is not forgotten:

#regzbot ^introduced cf21f328fcaf
#regzbot fix: media: nxp: ignore unused suspend operations
#regzbot ignore-activity

(I simply picked the latter of the two fixes, that should do the trick)

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.
