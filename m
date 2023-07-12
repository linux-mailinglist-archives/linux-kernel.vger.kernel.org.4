Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F017509FE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjGLNuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbjGLNur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:50:47 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366BD10EA
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:50:41 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fba8e2aa52so75233865e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689169839; x=1691761839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FXHjXkHkEcT/VKHvP9dVmE2MnxLlBstOmDhD8pe0p0s=;
        b=yIHNIqB8dMyExE+wWlnBK45PTX7y0IlHmgmhJnStPz1lo13JfO/6NqBhwL+Y7txn7O
         3BpLZmPXi/JTuC5KSGTnYx6M7gu6UflT/dWElMFjvLOMNEUJzDmkYV6enmGFYKvPIo9s
         WySsxqtRHBDW9ZTruNE5HgEUi/frjLFC8aOG/lBfpQLVXM/QtHbBLV38vWKg7l/rBJe6
         IBeG3/vhaodu89L6JZHa5KJxMV8aLFRcKJekAe3nXh3SZb4jmA4eCpkDCeJJNYEk8C5b
         aL6a4tf6QWsBUWF3sPykivmKq4//ovVEedkoEGt4gXlWPh4Ee2iRa+8WOAfStb6bhgJ+
         bn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689169839; x=1691761839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXHjXkHkEcT/VKHvP9dVmE2MnxLlBstOmDhD8pe0p0s=;
        b=eeeyj/KosA4WjbYcQmw+k4mSvjSuO4MYV1/8BszuNWvfA8TgvfEsMH2Gk9+7MASIaE
         al3GJHxkLB1Qp/F9X9taTkLxfA3eHOYLu0uNvle0Qpoc72UL/LRlPvSSNniTHcxgTlCY
         uimpWAGZ2X2GKRYMi11StpfGJNlb43WlW514jNaNvqovDzLqQY8zReO3w1q5mAxvcO2E
         zUNmJ6E4dP0gi1f3xoyhIhiEeS0GlIN9fw6OX3hmh2maJ0G7fzs2ByGJF1PZlNvEeVFZ
         c4ZN2bvBywL5i7dHAqcMiWcY0rSJqKv2716UidFCClsgqyF2wXqLiASoLiY8Z4wZu13W
         D+9w==
X-Gm-Message-State: ABy/qLa3khbeFTYrvtX2sCoLsjLQ95x1hejAtPBwVoTNzUiUFXLE9R9z
        0ziGYdwM7k3ohD/n+OZax8hIvA==
X-Google-Smtp-Source: APBJJlHmbyD59xTuaLC4sV1zWfo4r2j857GkZpqlDnKRLGDlYNCSRpenzmqG/cIAd/KXGqcKlOMoPA==
X-Received: by 2002:a05:600c:2251:b0:3f9:c82e:9d87 with SMTP id a17-20020a05600c225100b003f9c82e9d87mr18329639wmm.13.1689169839127;
        Wed, 12 Jul 2023 06:50:39 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id n12-20020adff08c000000b0030ada01ca78sm5181562wro.10.2023.07.12.06.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:50:37 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:50:34 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Wang Ming <machel@vivo.com>
Cc:     Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Dan Carpenter <error27@gmail.com>,
        Jiasheng Jiang <jiasheng@iscas.ac.cn>, ntb@lists.linux.dev,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: Re: [PATCH v2] ntb:Fix an NULL vs IS_ERR() bug for
 debugfs_create_dir() in tool_setup_dbgfs()
Message-ID: <138ab604-27de-4ac6-88fb-0886ee8f6b6d@kadam.mountain>
References: <20230712124035.7981-1-machel@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712124035.7981-1-machel@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:39:59PM +0800, Wang Ming wrote:
> The debugfs_create_dir() function returns error pointers.
> It never returns NULL. Most incorrect error checks were fixed,
> but the one in tool_setup_dbgfs() was forgotten.
> 
> Fix the remaining error check.
> 
> Signed-off-by: Wang Ming <machel@vivo.com>
> ---
>  drivers/ntb/test/ntb_tool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index eeeb4b1c97d2..4fa69ea4331d 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -1495,7 +1495,7 @@ static void tool_setup_dbgfs(struct tool_ctx *tc)
>  
>  	tc->dbgfs_dir = debugfs_create_dir(dev_name(&tc->ntb->dev),
>  					   tool_dbgfs_topdir);
> -	if (!tc->dbgfs_dir)
> +	if (IS_ERR(tc->dbgfs_dir))

No, this will break the driver if debugfs is disabled in the .config.

(I haven't checked, it's possible that this code is #ifdeffed out when
CONFIG_DEBUGFS is disabled so possibly this change is harmless.  But
either way, this change is wrong).

Normally this would be the correct change, but debugfs is weird.  It's
not supposed to be checked for errors in the normal case.  If the
driver pokes around in the debugfs internals then you might need to
check but you should avoid doing that and it doesn't apply here.

As I was saying, this change would normally be the correct thing, and it
used to work.  But we changed it so that now it's impossible to check
for errors.  Making it impossible to check for errors helps people feel
better about deleting error checking.

The correct change is to delete this dead code, but it's a headache
to convince people to it.  It would be better to do it as a mass delete
so everyone can see the thread.  Trying to convince people one by one
does not work.

regards,
dan carpenter

