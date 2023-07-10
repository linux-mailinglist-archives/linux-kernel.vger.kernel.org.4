Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393C274DCBA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 19:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbjGJRrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 13:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGJRq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 13:46:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1417EDD;
        Mon, 10 Jul 2023 10:46:57 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C2E36200AE;
        Mon, 10 Jul 2023 17:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689011215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bgYYUfNlXqRAulFmwC4oTIUnr7Hav2E8ZDZIyQ3RRg=;
        b=wDVhrPr7JqE9PofEW+tSQEob8PLlqvfUrfLl1RBWkXpnE0jo5piaIbonRTSI56C0D2kF7c
        30uJOvj0PwYPDINZIZXSfzGWPa1c2VSQd2WwVgxed3+DEa9HxpU+19lYwVAfF313uWsrvG
        0LBx+NgEfm58kIKXo0qDl4b6dN9bBzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689011215;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2bgYYUfNlXqRAulFmwC4oTIUnr7Hav2E8ZDZIyQ3RRg=;
        b=IU4VrQXDE+tAy2TP6HlHbeZmloMIyXZ/HWL2wEx0gHPMglSYUGDwcX99PTTGqfiNOeQnFo
        RIHVVtJLHabJLVAw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8ADD12C142;
        Mon, 10 Jul 2023 17:46:55 +0000 (UTC)
Date:   Mon, 10 Jul 2023 19:46:54 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        stable@vger.kernel.org, Cyril Brulebois <cyril@debamax.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] of: Preserve "of-display" device name for compatibility
Message-ID: <20230710174654.GB9196@kitsune.suse.cz>
References: <20230710174007.2291013-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230710174007.2291013-1-robh@kernel.org>
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

On Mon, Jul 10, 2023 at 11:40:07AM -0600, Rob Herring wrote:
> Since commit 241d2fb56a18 ("of: Make OF framebuffer device names unique"),
> as spotted by Frédéric Bonnard, the historical "of-display" device is
> gone: the updated logic creates "of-display.0" instead, then as many
> "of-display.N" as required.
> 
> This means that offb no longer finds the expected device, which prevents
> the Debian Installer from setting up its interface, at least on ppc64el.
> 
> Fix this by keeping "of-display" for the first device and "of-display.N"
> for subsequent devices.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217328
> Link: https://bugs.debian.org/1033058
> Fixes: 241d2fb56a18 ("of: Make OF framebuffer device names unique")
> Cc: stable@vger.kernel.org
> Cc: Cyril Brulebois <cyril@debamax.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Helge Deller <deller@gmx.de>
> Signed-off-by: Rob Herring <robh@kernel.org>

This is exclusive with the other patchset that updates the other side:
https://lore.kernel.org/lkml/20230412095509.2196162-1-cyril@debamax.com/

Reviewed-by: Michal Suchánek <msuchanek@suse.de>

Thanks

Michal

> ---
>  drivers/of/platform.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 051e29b7ad2b..0c3475e7d2ff 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -552,7 +552,7 @@ static int __init of_platform_default_populate_init(void)
>  			if (!of_get_property(node, "linux,opened", NULL) ||
>  			    !of_get_property(node, "linux,boot-display", NULL))
>  				continue;
> -			dev = of_platform_device_create(node, "of-display.0", NULL);
> +			dev = of_platform_device_create(node, "of-display", NULL);
>  			of_node_put(node);
>  			if (WARN_ON(!dev))
>  				return -ENOMEM;
> -- 
> 2.40.1
> 
