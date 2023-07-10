Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D7974DB36
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjGJQgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 12:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjGJQgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 12:36:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59333127;
        Mon, 10 Jul 2023 09:36:44 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 1A72E1FF06;
        Mon, 10 Jul 2023 16:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689007003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=50GMs5nmGpITPWTG7u5Zcxqbmkf0dcUoVQiJpGtLvBg=;
        b=MAkcYfuu2e/AwBYCJ8iEsRGbL7yA8cBwUv3bbYwWUSPqAWWE3+OD7CUwXSDvzwimmPxDm1
        snlvw8+Zbn4vbzubmlOotkSLqVnSnZZloPrWWPbnQLgC3FYXKyueUbjMkHNPEQd9xpbZnd
        rimCb3GOjrBYy3y5WVygqzW/TA9ld7I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689007003;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=50GMs5nmGpITPWTG7u5Zcxqbmkf0dcUoVQiJpGtLvBg=;
        b=h+IckA4+b99FPAeRV10LGOxH9p9DpOwRbzQ2LuIS61mLAFsz2z61ZESsEGm+Evi1q3fXu3
        3LuUg1XOFV1btxDg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E67762C142;
        Mon, 10 Jul 2023 16:36:42 +0000 (UTC)
Date:   Mon, 10 Jul 2023 18:36:41 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Cyril Brulebois <cyril@debamax.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/ofdrm: Update expected device name
Message-ID: <20230710163641.GA9196@kitsune.suse.cz>
References: <20230412095509.2196162-1-cyril@debamax.com>
 <20230412095509.2196162-3-cyril@debamax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230412095509.2196162-3-cyril@debamax.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 11:55:09AM +0200, Cyril Brulebois wrote:
> Since commit 241d2fb56a18 ("of: Make OF framebuffer device names unique"),
> as spotted by Frédéric Bonnard, the historical "of-display" device is
> gone: the updated logic creates "of-display.0" instead, then as many
> "of-display.N" as required.
> 
> This means that offb no longer finds the expected device, which prevents
> the Debian Installer from setting up its interface, at least on ppc64el.
> 
> Given the code similarity it is likely to affect ofdrm in the same way.
> 
> It might be better to iterate on all possible nodes, but updating the
> hardcoded device from "of-display" to "of-display.0" is likely to help
> as a first step.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217328
> Link: https://bugs.debian.org/1033058
> Fixes: 241d2fb56a18 ("of: Make OF framebuffer device names unique")
> Cc: stable@vger.kernel.org # v6.2+
> Signed-off-by: Cyril Brulebois <cyril@debamax.com>
Reviewed-by: Michal Suchánek <msuchanek@suse.de>
> ---
>  drivers/gpu/drm/tiny/ofdrm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tiny/ofdrm.c b/drivers/gpu/drm/tiny/ofdrm.c
> index 6e349ca42485..92df021d71df 100644
> --- a/drivers/gpu/drm/tiny/ofdrm.c
> +++ b/drivers/gpu/drm/tiny/ofdrm.c
> @@ -1390,7 +1390,7 @@ MODULE_DEVICE_TABLE(of, ofdrm_of_match_display);
>  
>  static struct platform_driver ofdrm_platform_driver = {
>  	.driver = {
> -		.name = "of-display",
> +		.name = "of-display.0",
>  		.of_match_table = ofdrm_of_match_display,
>  	},
>  	.probe = ofdrm_probe,
> -- 
> 2.30.2
> 
