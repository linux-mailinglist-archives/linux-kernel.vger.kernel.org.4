Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7731061E6ED
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 23:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiKFWkY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 17:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiKFWkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 17:40:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A98FCEF
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 14:40:21 -0800 (PST)
Received: from [192.168.2.238] (109-252-117-140.nat.spd-mgts.ru [109.252.117.140])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 83F5E660226C;
        Sun,  6 Nov 2022 22:40:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667774420;
        bh=vGvc+fYcEwH0rnVPheWtDPFDXmkIouczct+CWphMwgM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=i8kh9jqrJlCBWDBeB8KDH0OiMaJonI2OgHb4CHJqVlW+qRnFQrDK22dFC0oaK8ulJ
         tdVcKj2lk/KpJJ9rUTIsoDy+/EPCmRjKGmkNlhRG9dFLapaZIdaF09MsM+m0uR7RN2
         mpmYAzxMxn//a5GxyPvbZ7vc0aWTgN002cHIm+aJRumucLaVdZtilD6vceRq0FL+//
         +8lOjD4GgrGSqq519WvuumfPuwENfa0fUoYYQO0GtkESIi4EVzq/1bbdnG/G8iRavc
         RpLrOrthujsC/gVLbWCxcZDlGyN5cnc6pf8If2MT3bdVBUDCqil3b9OXA1UFJbT7I5
         k+1kF/MsuEYqA==
Message-ID: <a3488b0c-dbc7-0109-8ba7-9f319f018e22@collabora.com>
Date:   Mon, 7 Nov 2022 01:40:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] mfd: axp20x: Do not sleep in the power off handler
Content-Language: en-US
To:     Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai <wens@csie.org>,
        Lee Jones <lee@kernel.org>
Cc:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
References: <20221105212909.6526-1-samuel@sholland.org>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20221105212909.6526-1-samuel@sholland.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/22 00:29, Samuel Holland wrote:
> Since commit 856c288b0039 ("ARM: Use do_kernel_power_off()"), the
> function axp20x_power_off() now runs inside a RCU read-side critical
> section, so it is not allowed to call msleep(). Use mdelay() instead.
> 
> Fixes: 856c288b0039 ("ARM: Use do_kernel_power_off()")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  drivers/mfd/axp20x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
> index 88a212a8168c..880c41fa7021 100644
> --- a/drivers/mfd/axp20x.c
> +++ b/drivers/mfd/axp20x.c
> @@ -842,7 +842,7 @@ static void axp20x_power_off(void)
>  		     AXP20X_OFF);
>  
>  	/* Give capacitors etc. time to drain to avoid kernel panic msg. */
> -	msleep(500);
> +	mdelay(500);
>  }
>  
>  int axp20x_match_device(struct axp20x_dev *axp20x)

ARM was doing local_irq_disable() on power-off before
do_kernel_power_off() was introduced, so this should've been incorrect
for a couple years at least. If I'm not missing anything.

-- 
Best regards,
Dmitry

