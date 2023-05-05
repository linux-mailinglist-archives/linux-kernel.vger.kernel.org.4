Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873EB6F7FD2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjEEJYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjEEJYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:24:00 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D047EF3;
        Fri,  5 May 2023 02:23:57 -0700 (PDT)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 05C59240006;
        Fri,  5 May 2023 09:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1683278636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mWElEqoC0tf6AE16wm3wb4hzf8ICo35KcifM6UnLMzo=;
        b=gAdUn58zRii8F5j9HadQN4CxZRzA5r+uSeedshZX4vU10xEvC3twC47IIhZGAeHGmyI9pF
        cKE/T0V/qJJFYy8MK1yIAFz6k8g1tDAP6ONhv3ehCthYYReSR0N6YS9KaU8j4EjJecS2VG
        Yl9C7rgu1/FzdL578HPrX8NMotO8E+BoGVP6k2dJN4cDbbSu6FhIHLmztuFORS3T1iCVee
        uZACtTPtRvIihqG3JL4yzO4LzF1xnAXMguHdK+pu2nMlNQe7GOBZngFbBgKTnBSzCBVSSm
        OWG/K8tre5GbMqejMgI4zh4rFKT9eng7izNuNpDzg1sNh4PT28JQtLPOwbhP6g==
Date:   Fri, 5 May 2023 11:23:51 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     devicetree@vger.kernel.org, festevam@gmail.com,
        gregkh@linuxfoundation.org, jun.li@nxp.com, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        peter.chen@nxp.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        francesco.dolcini@toradex.com
Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Message-ID: <20230505112351.1c79f6b2@booty>
In-Reply-To: <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
References: <23672d66d229d3be4cc854ddf1462c3507f1c2fc.camel@toradex.com>
        <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
        <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Francesco,

On Thu, 4 May 2023 18:50:14 +0200
Francesco Dolcini <francesco@dolcini.it> wrote:

> Hello Luca,
> I guess your mail to Philippe bounced, let me try to answer since I am aware
> of the issue here.
> 
> On Thu, May 04, 2023 at 06:23:12PM +0200, Luca Ceresoli wrote:
> > I found this thread after several hours spent in debugging why USB host is
> > not detecting new devices on a custom board using the iMX6ULL Colibri
> > SoM.
> > 
> > My best workaround at the moment is:  
> We have the same workaround in our BSP since quite some time, see
> https://git.toradex.com/cgit/meta-toradex-bsp-common.git/tree/recipes-kernel/linux/linux-toradex-mainline-git/0002-drivers-chipidea-disable-runtime-pm-for-imx6ul.patch
> 
> > I haven't found any follow-up patches from you, so I'm wondering whether
> > you have made any progress on this issue.  
> You can find the latest discussion on that regard here
> https://lore.kernel.org/all/Y1vLpaxpc5WBCuGD@francesco-nb.int.toradex.com/

Thanks for this pointer! I have read the discussion and it was a bit
confusing, especially about whether the hardware can work at all.

Are you planning to continue on that work? I would be very glad to test
on product based on the i.MX6ULL Colibri module I am currently working
on.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
