Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0997715EB5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 14:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjE3MPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 08:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbjE3MPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 08:15:13 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DA8C10E;
        Tue, 30 May 2023 05:15:06 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1b01d912924so34326045ad.1;
        Tue, 30 May 2023 05:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685448906; x=1688040906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSonn1Wj9WYlO2/wi9meZ0Hj4Mrbv3g+ANp9gt9DWKc=;
        b=D2y1iirxlOA1whLuxkn4Cvr4N0dbHeYrsvnX/+ROgnj6TcH3fOAkZ+A+lXHhJ8pZSr
         aJQBSHpFiFZtfVwS8ouikmfLrxNuteaojzMBzDMNU0YEdTkl5K26GOpI6p1i001x016y
         WQP+6qaXhJT+lRPehyDteIoJ+iHVPiPb9sjqfkSM79IMpZxMybLyiSEx3XnodtIaB6AN
         pZbPr88yxZA1WoSS9odSqdmVYY4ZlPS6kqiEl6wVa8yApoMF1SH1N8FAcwkY9Nrq3ipU
         vD0awE1EqlVYbQvyvPCw8bd4q8OPkEVa+YlouEdhpt7XrYdWzOKjjoOvucgLx67xIKIf
         qLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685448906; x=1688040906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TSonn1Wj9WYlO2/wi9meZ0Hj4Mrbv3g+ANp9gt9DWKc=;
        b=AuGKE4ooF+GWHKdSkG+cZCEasEsixsuCfOMEK9HP3meAH507r0d+fylg6RN+2Po7Ow
         Ft/rkR/5QIf1jvZCSAzEKCjmJouKe0jttUulqJCgUpcGJxiXkx7LLoVnAYQx1wZABvOr
         1TZjgb/P8eNo4ELEzSLaNfCYvFjeBgqCjVxllZ58z4c7Ik5P/Hq1isbk1M/m3D0ucsJM
         g4SPCWsYw7SHnSsC/Q+vlKY+L+K9p25hz1Ud1P65URd/R9oKcolF7iOfUA+lMVgACKAY
         t8rsaVJsWe8bSSE3F5+m+zHwF29qxeEH1GWtqRr6sfn29HZUB4/kpdwQTzMyZgY87RD3
         nKrw==
X-Gm-Message-State: AC+VfDwskGk8Fp0XveyAWxoowFgD+opX/99Wr6V+6izamH/cL92L01pk
        UG4tX8eknQ2u9em6m1wbpHk=
X-Google-Smtp-Source: ACHHUZ5y59N4Y6nAkf/RppC21TtkyrkJVUslucsvcKbF1weMf1kjkHnotOIfvHjNLnzJYMpVuxbWlw==
X-Received: by 2002:a17:902:bd8b:b0:1ab:1b8:8a5f with SMTP id q11-20020a170902bd8b00b001ab01b88a5fmr2011127pls.33.1685448905794;
        Tue, 30 May 2023 05:15:05 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jc12-20020a17090325cc00b001aaef9d0102sm5382021plb.197.2023.05.30.05.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 05:15:05 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 30 May 2023 05:15:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Srinivas Neeli <srinivas.neeli@amd.com>
Cc:     shubhrajyoti.datta@amd.com, michal.simek@amd.com,
        srinivas.goud@amd.com, wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, git@amd.com, git@xilinx.com,
        neelisrinivas18@gmail.com
Subject: Re: [PATCH V4 4/4] MAINTAINERS: Add support for Xilinx versal
 watchdog
Message-ID: <70f3a218-c4ac-4614-afb8-09e68a4d1e4f@roeck-us.net>
References: <20230420104231.2243079-1-srinivas.neeli@amd.com>
 <20230420104231.2243079-5-srinivas.neeli@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420104231.2243079-5-srinivas.neeli@amd.com>
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

On Thu, Apr 20, 2023 at 04:12:31PM +0530, Srinivas Neeli wrote:
> Added entry for Xilinx versal watchdog driver.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Changes in V4:
> -None
> Changes in V3:
> -None
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 327901c9f1d1..388305608418 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -23148,8 +23148,10 @@ M:	Srinivas Neeli <srinivas.neeli@amd.com>
>  R:	Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>
>  R:	Michal Simek <michal.simek@amd.com>
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
>  F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
>  F:	drivers/watchdog/of_xilinx_wdt.c
> +F:	drivers/watchdog/xilinx_wwdt.c
>  
>  XILINX XDMA DRIVER
>  M:	Lizhi Hou <lizhi.hou@amd.com>
> -- 
> 2.25.1
> 
