Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30904641F86
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 21:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbiLDU2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 15:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiLDU2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 15:28:11 -0500
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147039FF2;
        Sun,  4 Dec 2022 12:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20220719; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TyfDaMtztYYPDEYsKXqy11jDzU7U54F8h/OzVMIpyZE=; b=7eoC48YIZb45uRCaZy7TQ5X/cJ
        VMllGdkx3FCzCmYNQtNAQ//E9FpeArRJS1XnH9dHUWgcRMU3kdMfGBUJ/5VaygVaolS3olie8G2+v
        95RrobXhrThMgAYcucx8bMi/Jc907r6Wv1rA82rzmRQIa/mZoMBtqjpuJnxq9+VKEs/ANX77gIhfd
        GE4taFDPbV0Oq4tBW+y7/YKz5nQ9PTKcwwwT30Nm8DKjSEhEUH7X62by8DNAvIb2zxpbAsDJyubJX
        YoAbxHLACQecZKmTtZvM9uq4beZE9p5HIzaOTodi/ZTTiXGXij36b7yhp3IJm6yA7Kei9ZAX/3/GS
        yE9k7cFw==;
Received: from p200300ccff4496001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff44:9600:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1p1vaa-0007YB-JF; Sun, 04 Dec 2022 21:27:52 +0100
Date:   Sun, 4 Dec 2022 21:27:51 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lars@metafoo.de, jiasheng@iscas.ac.cn, paul@crapouillou.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] iio:adc:twl6030: Enable measurements of VUSB, VBAT and
 others
Message-ID: <20221204212751.2de52084@aktux>
In-Reply-To: <20221204154152.5f7948b9@jic23-huawei>
References: <20221201181635.3522962-1-andreas@kemnade.info>
        <20221204154152.5f7948b9@jic23-huawei>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Dec 2022 15:41:52 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu,  1 Dec 2022 19:16:35 +0100
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
> > Some inputs need to be wired up to produce proper measurements,
> > without this change only near zero values are reported.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>  
> 
> Sounds like a fix to me.  If so, Fixes tag?

seems to be there since the beginning, to it would be
Fixes: 1696f36482e70 ("iio: twl6030-gpadc: TWL6030, TWL6032 GPADC driver")

I think it was just not used with the charger (which is not in mainline yet),
so it was probably ignored.

> 
> Anything in here we should be turning off again if the driver is removed 
> or toggling on suspend? If not, other than the space below this looks fine to me.
> 
I would consider that as configuration, comparing with the nearest relative twl4030,
there a similar bit is set in the probe() without disabling it in the remove().

But I think we should set TWL6030_GPADCR in remove() as we do in suspend(),
but that is another fix.

Regards,
Andreas
