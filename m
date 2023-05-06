Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E416F9247
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 15:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjEFNnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 09:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjEFNne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 09:43:34 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9860E23A05;
        Sat,  6 May 2023 06:43:33 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so2510705a12.1;
        Sat, 06 May 2023 06:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683380613; x=1685972613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66Oa0Tt4V09m3CKz7RlcxzCofTUAwWazL0ZtiHsb8NA=;
        b=JM9FmwxcFQ5R9hdtlqj7wHQZVTqEMBKCRk+AsKrBCZvXVs3SONqurZDsoIySHmtgzg
         ghjbH8xzcrD/IY+rRV3m5f0KxJkGMDMAMaBWhMov5tC9wt4zl8UKtkFLp2IYOwT912af
         qgLpMDX3bULFCjzVtIRRhfm38XoAq/rwVfuiFaGWNzM7TjgBYmBNzE8+hVbubDHON5og
         kYR1Or6RemAeqHWDxHZVB01e+b0wwAO6wvfZbuXHOPYomc8eLV8giKSdbiPYQQP9TvBZ
         EEF718b9MosOiOZds2uNUVGqAk3vyRtIa2vAUy7V4QldWQLEohKAb5uSRXCk6fqQcjOf
         Q0sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683380613; x=1685972613;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66Oa0Tt4V09m3CKz7RlcxzCofTUAwWazL0ZtiHsb8NA=;
        b=jmc44Nllcc/x7dym97rzI0lNr8PJgWDrleW4nmwxuakakiszw0rGYXMGBEnYsnBCDb
         mSqMxpQ0z3dYEDJNgqu8WYgyTLnjdVO+w4Dj4RXvMyVlbAp0wuFdQQAXSt1ZlzuGvd7j
         OXrjpFrmnLl3XM+8ZU9hnjvrTDeReKGkIyJ1AHiHDa1gwkEYHPmWTJAsHXN4s1bsDxEe
         HTOwLrQ21nZyi9W8Dbuwv7npEAiHCEfOw+qltWbT0pQQzEh/id0DEIA2T6KVIT6CQzxv
         SGqyuFiVG7ublWx0YTZMpvE96nGQd+JCDtA3Cvbe//hgGBkEant935YklEhdKL+2aUSN
         yb4g==
X-Gm-Message-State: AC+VfDyZYDZ41w5xqQJqFj7PAYS1PmsKf1bCmh+nOGT23K1vA7vOX1iU
        pwIXii2a4qAF0jHgmFv9m84=
X-Google-Smtp-Source: ACHHUZ7vb5/rSDcNye9osPpI2TAmN+0Ho3gyng9zOi/F8J0qlCjnLb/SV+kQfkdLFiCfBtqmJnQ5nw==
X-Received: by 2002:a17:90a:a785:b0:250:31b2:9677 with SMTP id f5-20020a17090aa78500b0025031b29677mr4541598pjq.22.1683380613033;
        Sat, 06 May 2023 06:43:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n11-20020a17090a9f0b00b0025023726fc4sm3341188pjp.26.2023.05.06.06.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 06:43:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 6 May 2023 06:43:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     James Seo <james@equiv.tech>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 01/11] Documentation/hwmon: Move misplaced entry in hwmon
 docs index
Message-ID: <89848a16-ccb3-4124-8546-90049e4ca948@roeck-us.net>
References: <20230504075752.1320967-1-james@equiv.tech>
 <20230504075752.1320967-2-james@equiv.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504075752.1320967-2-james@equiv.tech>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 12:57:42AM -0700, James Seo wrote:
> Move the entry for the inspur-ipsps1 driver so that it no
> longer appears in the hwmon docs TOC as a document relating
> to the hwmon subsystem itself.
> 
> Signed-off-by: James Seo <james@equiv.tech>
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

Applied to hwmon-next.

Guenter

> ---
>  Documentation/hwmon/index.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index fa1208c62855..03b30a94a9e6 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -9,7 +9,6 @@ Hardware Monitoring
>  
>     hwmon-kernel-api
>     pmbus-core
> -   inspur-ipsps1
>     submitting-patches
>     sysfs-interface
>     userspace-tools
> @@ -85,6 +84,7 @@ Hardware Monitoring Kernel Drivers
>     ina2xx
>     ina238
>     ina3221
> +   inspur-ipsps1
>     intel-m10-bmc-hwmon
>     ir35221
>     ir38064
