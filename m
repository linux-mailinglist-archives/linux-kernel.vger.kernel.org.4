Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D42716755
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjE3PmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjE3PmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:42:08 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F82E8;
        Tue, 30 May 2023 08:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=VbQOqV0XO5ZW9VCHB3kU+B3iNrKth4njPt4pnZnKjaU=; b=xPO3dQxdKCjghLReaH3potgFlw
        Zh0uYhuuX15w6YCNiQTlitVMZ3K/+D9ulFyXwJFiC6ip9SWAlcUyDfq05KUlKIdzMH2y8kugWFhBh
        ai9LHihHKzGOHfOu8otz66JQ7P4zEw9Utl6BhrRPW1zi3tbImoduRlFdyZZyVaN+GGko=;
Received: from modemcable061.19-161-184.mc.videotron.ca ([184.161.19.61]:33086 helo=debian-acer)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q41Tz-0006z5-Lf; Tue, 30 May 2023 11:42:00 -0400
Date:   Tue, 30 May 2023 11:41:58 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     andy.shevchenko@gmail.com
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        l.perczak@camlintechnologies.com, tomasz.mon@camlingroup.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Message-Id: <20230530114158.f74f014234fbffb1026f06e1@hugovil.com>
In-Reply-To: <ZHXa23WFb9vNG-T2@surfacebook>
References: <20230529140711.896830-1-hugo@hugovil.com>
        <ZHUnwNNcU_EnS4bo@surfacebook>
        <20230529220708.66f7825fed9ee36b181128cf@hugovil.com>
        <ZHXa23WFb9vNG-T2@surfacebook>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 184.161.19.61
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH v4 0/9] serial: sc16is7xx: fix GPIO regression and rs485
 improvements
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 May 2023 14:15:39 +0300
andy.shevchenko@gmail.com wrote:

> Mon, May 29, 2023 at 10:07:08PM -0400, Hugo Villeneuve kirjoitti:
> > On Tue, 30 May 2023 01:31:28 +0300
> > andy.shevchenko@gmail.com wrote:
> > > Mon, May 29, 2023 at 10:07:02AM -0400, Hugo Villeneuve kirjoitti:
> > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > 
> > > > Hello,
> > > > this patch series mainly fixes a GPIO regression and improve RS485 flags and
> > > > properties detection from DT.
> > > > 
> > > > It now also includes various small fixes and improvements that were previously
> > > > sent as separate patches, but that made testing everything difficult.
> > > > 
> > > > Patch 1 fixes an issue when debugging IOcontrol register. After testing the GPIO
> > > > regression patches (patches 6 and 7, tests done by Lech Perczak), it appers that
> > > > this patch is also necessary for having the correct IOcontrol register values.
> > > > 
> > > > Patch 2 introduces a delay after a reset operation to respect datasheet
> > > > timing recommandations.
> > > 
> > > These two patches are w/o Fixes tag, they should be moved in the series further
> > > as I explained before.
> > 
> > Your explanation was not clear.
> 
> Sorry if it feels like this. The documentation should have more clarity
> on the matter.
> 
> > Anyway, I moved them in position 7 and 8.
> 
> Thank you, but take also what Greg KH replied to you into consideration.
> He is the maintainer and seems other patches needs some additional work
> in the scope of Fixes / backport (see stable kernel patches flow in the
> kernel documentation, which I also mentioned earlier).

Hi,
will do.

Thank you,.
Hugo.
