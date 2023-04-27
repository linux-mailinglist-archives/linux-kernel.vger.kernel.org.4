Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26EE6F0CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344187AbjD0UNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 16:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343704AbjD0UNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 16:13:06 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C15535AD;
        Thu, 27 Apr 2023 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LmOazWNjaaUirDK7f0+UUssGhdwbYYxW6pA0G+w5Wtc=; b=fl7QifYhwiQwrJHfZFAKxi8+VC
        Ek8wl+4yjLOUjcl4OtnLwgiYHMyHqtvCOo6GqIOD7mYc3Kjg1AQS0G7VZCJJYlIjq7My0hundS3qJ
        ODQ9VsWRZR4sLt0vL1ONC8rw0xjKj/DnWDLfyBoaXYHCXpoGtS1k6U+NfyvDw4LwRl+A=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:60862 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1ps7yc-0002xa-T9; Thu, 27 Apr 2023 16:12:27 -0400
Date:   Thu, 27 Apr 2023 16:12:26 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Message-Id: <20230427161226.9c971530c6b848aa813c92b3@hugovil.com>
In-Reply-To: <CAOMZO5BNbRV1fLpwDZWgj9+gihHJBBGeZCvkF1tgm5GhwSn8LQ@mail.gmail.com>
References: <20230427195538.2718661-1-hugo@hugovil.com>
        <CAOMZO5CQeeme6uhb8NCzR2QADjkBM-mRC9-GUnmhLWSGo5MMoQ@mail.gmail.com>
        <20230427160608.f051241d750404939296f60d@hugovil.com>
        <CAOMZO5BNbRV1fLpwDZWgj9+gihHJBBGeZCvkF1tgm5GhwSn8LQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Subject: Re: [PATCH] imx8mn-var-som: dts: fix PHY detection bug by adding
 deassert delay
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Apr 2023 17:07:59 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> On Thu, Apr 27, 2023 at 5:06 PM Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > Hi Fabio,
> > it uses a ADIN1300 PHY.
> >
> > The datasheet indicate that the "Management interface active (t4)" state is reached at most 5ms after the reset signal is deasserted.
> 
> Please add this information to the commit log and please add a Fixes: tag.

Good idea, will do.

Hugo.


-- 
Hugo Villeneuve <hugo@hugovil.com>
