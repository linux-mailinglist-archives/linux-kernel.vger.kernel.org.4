Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEC874F962
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjGKUyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjGKUyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:54:44 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99231709;
        Tue, 11 Jul 2023 13:54:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 134251BF203;
        Tue, 11 Jul 2023 20:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689108880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=biIajIQS8usePEbgPL/4UdQnxtkHBuw/MmCRAWoFrB0=;
        b=Gq2ZmwVoHBOYBr9HyfaAHzYNOj8bWniPMkcjRkDuKNCZF4H7u6Ud6xvJRFS65MXplPeLZ3
        sQVXZVA5ak7tnboAubSyeHTIywDWj7X3FLBUhphyBoKTNzS3pHzAzpBMB5pRnR/k9Osv5O
        3Xjen2MRWTDLfkHf4IoyuxwEhZ0LkmlP9cN/4jkiZXZ/2OBvBdvG82gyotpE373dBPK9Bb
        G/uEgUG0PjIs+N+Ik2ySDBBYZUkcPhqb6gYYv5vnaZ57X5p93gMX2xOppp3nJjhbCpT1pY
        dh6hcnhqhgTqrEI+sOpDLr7eZnsQzxRrz+QhTlr9QHSauO4QywECEbjNct6H/g==
Date:   Tue, 11 Jul 2023 22:54:39 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: pcf-8563: Report previously detected low-voltage
 via RTC_VL_BACKUP_LOW
Message-ID: <2023071120543925735a3a@mail.local>
References: <da84b6b1-a9d8-ce46-16a9-e1a2d495240c@siemens.com>
 <20230610083135e40dd2f6@mail.local>
 <1d532c45-ee33-9729-f0ac-b59c2bec8d7d@siemens.com>
 <202306111511569834cac2@mail.local>
 <9ac4b2a5-7cc8-4fce-7ea0-61b26d6ef223@siemens.com>
 <202306112216153a75dfa3@mail.local>
 <c195c196-d99b-9e17-3854-fc147ac2e447@siemens.com>
 <69dd51b9-aab1-a9ec-91c2-b1dc79797f10@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69dd51b9-aab1-a9ec-91c2-b1dc79797f10@siemens.com>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 09:27:14+0200, Jan Kiszka wrote:
> >>> Nope, that could be easily avoided in software. The actual problem is
> >>> that the VL bit is not settable (clear-on-write). And that means we
> >>> can't do anything about losing the low battery information across
> >>> reboots - but that's no difference to the situation with the existing
> >>> driver.
> >>>
> >>> There is no "fix" for userspace as there is no standard framework to
> >>> read-out the status early and retrieve it from there when the user asks
> >>> for it. That's best done in the kernel.
> >>
> >> That's not true, nothing prevents userspace from reading the battery
> >> status before setting the time and destroying the information which is
> >> exactly what you should be doing.
> > 
> > What is your "userspace"? Mine is stock Debian with systemd and
> > timesyncd enabled. But there is no framework to read the status early
> > enough and propagate that after timesyncd did its job. Any concrete
> > suggestion to "fix" userspace?
> > 
> 
> Ping - I still have seen no suggestion to improve this situation otherwise.
> 

You can get systemd or any daemon to read the rtc flag before systemd
decides to use NTP and set the time, destroying the information.

This is a systemd issue, not a kernel issue. I already have to handle
two other issues caused by systemd because they don't want to budge, I
will not take a third one.


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
