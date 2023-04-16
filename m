Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2236E3A3A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 18:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjDPQPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 12:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjDPQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 12:15:28 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B25A6;
        Sun, 16 Apr 2023 09:15:27 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7606d6bb669so36797939f.2;
        Sun, 16 Apr 2023 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681661726; x=1684253726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F23Msg9ijNGcjTb8eXel32GczcrBjfIv4/2kfrp1/10=;
        b=sbb/0wwQNzXJY+DfJJa2MVtp6TdnUTBfq31ROyRdXpYiFDYGA1yqQcXNcW0/3Jc1R5
         Rb41GyI8lG3CccJTo6s/iOL7cOrjhCfKVOuTjJviAlI2o5iY5oiPxdYnI5Hi+e9E6EgG
         wraTkMOLAAEzG2kb+Mtj/rClJxawZMQvFJCpiI0m8PvrikO9OXvljQ9uWCp/G6zedBJq
         23DFsYItj/kSbPDgkUAtfwirFem+KxfIxxok3/HnC34GXehmZK59yFBApPYwyB5qEDLm
         MfkqWr3ujQcBbGkeyCgsvC3AnYXwXpk2YKqJ5o2LtVg6NOHJlI/EOKx5Nqc/ASrl+fKo
         tvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681661726; x=1684253726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F23Msg9ijNGcjTb8eXel32GczcrBjfIv4/2kfrp1/10=;
        b=cwSBJt97Z26jqdS/irFE3F98HC3EVpc1Fk540vV7KtV8ZV6e4OJZWIwlMBG7Gqw+Ls
         oSIp9OncnQoyoqmus95o9H793yMOUcOHDE39Wy0qcMzNeLpKkJlXSOrk1mWTzj41bf9k
         B0kwbx8ps18EtG50GVZPrKfXIaeZcf/XAWswjlrW7lcK9Sx6VyUeHMUmHTwvrGB4PRzB
         DypetP1s1HU7ju3cE5Ry8qpB9VVHtdINqmF5rzwxK0WH4yUbHDAl9fgGCA1RXWP/FFrn
         cHLCw+QIigt5nb69JnA/GzCn7Kc7fOqUr17TX6Cx05cHO4xBvee4B8WGHW0+YDNTy4cE
         Z4vw==
X-Gm-Message-State: AAQBX9dM7dy1tfBenUiIiF3her9wx/4ZXnvnBm4hKZIesEy3LSZAqIjT
        0SmLXAGlH7YghmUp2H/f26nIpTrrphM=
X-Google-Smtp-Source: AKy350ZK+vO65OU4McXqAR2Ng1tEXby6L8U8yz+HIrtKOxs2rqKxzzBeLyagSZ1a5uMqri9Kaakn5A==
X-Received: by 2002:a92:da4f:0:b0:329:719d:10d0 with SMTP id p15-20020a92da4f000000b00329719d10d0mr8705540ilq.19.1681661726711;
        Sun, 16 Apr 2023 09:15:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f2-20020a056e0212a200b00325df6679a7sm1755438ilr.26.2023.04.16.09.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 09:15:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 16 Apr 2023 09:15:25 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Srinivas Neeli <srinivas.neeli@amd.com>
Cc:     shubhrajyoti.datta@amd.com, michal.simek@amd.com,
        srinivas.goud@amd.com, wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@amd.com, git@xilinx.com,
        neelisrinivas18@gmail.com
Subject: Re: [PATCH V3 1/4] MAINTAINERS: Add fragment for Xilinx watchdog
 driver
Message-ID: <23d65122-8609-4337-8699-7380a3378eee@roeck-us.net>
References: <20230331074117.356339-1-srinivas.neeli@amd.com>
 <20230331074117.356339-2-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331074117.356339-2-srinivas.neeli@amd.com>
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

On Fri, Mar 31, 2023 at 01:11:14PM +0530, Srinivas Neeli wrote:
> Added entry for Xilinx xps-timebase watchdog driver.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in V3:
> -None
> ---
>  MAINTAINERS | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d8287eb2ab4a..4ed139d56913 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23071,6 +23071,14 @@ F:	Documentation/devicetree/bindings/media/xilinx/
>  F:	drivers/media/platform/xilinx/
>  F:	include/uapi/linux/xilinx-v4l2-controls.h
>  
> +XILINX WATCHDOG DRIVER
> +M:	Srinivas Neeli <srinivas.neeli@amd.com>
> +R:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
> +R:	Michal Simek <michal.simek@amd.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
> +F:	drivers/watchdog/of_xilinx_wdt.c
> +
>  XILINX XDMA DRIVER
>  M:	Lizhi Hou <lizhi.hou@amd.com>
>  M:	Brian Xu <brian.xu@amd.com>
