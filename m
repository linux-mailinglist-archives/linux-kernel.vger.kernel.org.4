Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D686C8F68
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 17:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjCYQUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 12:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjCYQUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 12:20:02 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24CAE46B6;
        Sat, 25 Mar 2023 09:20:01 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id DFCCE1C0AB2; Sat, 25 Mar 2023 17:19:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1679761199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YRwPfaYaywOmrK6OfSfiS8RmP4MmRbWuSvlWBa58fnQ=;
        b=jmjiScV6hbfNDIw7nnqPvflBDUvKMRJ2P54KtG57X4ZcC7qauUjo645tI568VgvxLSmfeH
        adH6yfiTHSbNaPwcdQy6EBDmYADimIllnK+o6Q1PDASbHhLhp8nHCSupSwcJuy7ZZAs3u5
        Kajr7eSMnto69No4DkvoumkEx5sY/xU=
Date:   Sat, 25 Mar 2023 17:19:56 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-leds@vger.kernel.org,
        William Zhang <william.zhang@broadcom.com>,
        Rafa?? Mi??ecki <rafal@milecki.pl>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] leds: bcm63138: refer to ARCH_BCMBCA instead of
 ARCH_BCM4908
Message-ID: <20230325161955.GE1820@bug>
References: <20230307082936.16631-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307082936.16631-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-03-07 09:29:36, Lukas Bulwahn wrote:
> Commit dd5c672d7ca9 ("arm64: bcmbca: Merge ARCH_BCM4908 to ARCH_BCMBCA")
> removes config ARCH_BCM4908 as config ARCH_BCMBCA has the same intent.
> 
> Probably due to concurrent development, commit a0ba692072d8 ("leds:
> bcm63138: add support for BCM63138 controller") introduces 'LED Support
> for Broadcom BCM63138 SoC' that depends on ARCH_BCM4908, but this use was
> not visible during the config refactoring from the commit above. Hence,
> these two changes create a reference to a non-existing config symbol.
> 
> Adjust the LEDS_BCM63138 definition to refer to ARCH_BCMBCA instead of
> ARCH_BCM4908 to remove the reference to the non-existing config symbol
> ARCH_BCM4908.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Do we really want this "default Y" on those architectures? I'd understand
it for something critical but LED is not, and if it is not even present on
all such machines...

BR,
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
