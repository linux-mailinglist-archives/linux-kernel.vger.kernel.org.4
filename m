Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F18C6925A4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjBJSqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232748AbjBJSqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:46:31 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F3B7D3C9;
        Fri, 10 Feb 2023 10:46:13 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-16dcb07b805so1273856fac.0;
        Fri, 10 Feb 2023 10:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LoXffCDp9PTA0sP2ahTcQkry4k9jr9rgaxdkmj4hvlk=;
        b=lTRNgfTtuHOm5CRFzJdBeumj5WmqbQ4G9KeJg4HR5Tufw9ZIl9yD9G4o1Sbt8kz3wH
         BGmiwhlt53sE77s36VAwccnysrED2AQWXuMC335nSV8ebrJej4vDJBrVzyFpyoP55KzN
         3ld0E151EBJ4o/HsoxqcZA/UvTLdzxvqEIkUaXrjFb4VmhXmWXlxpn+aY5BCee7LKFkX
         AQTBgJ4qfG7d/hripVswNapaDsv/Tln+5uPCS9HfCpyq0y7agkiCYFjklc39Lq2DzUIQ
         FzqqcuBQOd4kbGP5uQ4VTfil/lct9C6vm1ofy/Xd5HhBb8+OKdChkLszlG5XjnOAsvoF
         SZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoXffCDp9PTA0sP2ahTcQkry4k9jr9rgaxdkmj4hvlk=;
        b=afkuXE+wyQ7MColzbR3LILJMgv2bkDSWbONXWUs3hhFvhIwchNn2xJtwPrW1ib2pq7
         n9mzcyfL4MRB4Hba14EnTw5WdyB3NCeqbuhU37VtGnlR7trHAOmeJOVA4xyBSoqMMtCG
         8AiXwbURqw9yot+y3l2r/Ve0NvE0xgFUu5/OqNDZhax47hk+fqeoFfhI9vQHWO0aKOyN
         OkOKZEOUnwT0bOiI6HmrpTsxVWWCuBMHJA5MtcbStpc8jMjsQUxPA9/EvVz+C+ERzEEG
         yfs22suAQMonQJ4Zu0TYie6Q1IxrG8/de89IlrRJaC0Xx73ymInJUWjTwULd1ZZBUqMs
         J0uA==
X-Gm-Message-State: AO0yUKUJRg93hB05DZI7IKYcS8ZXxjE1dtVOOHSQjGy1CfAOPOk1hgJO
        o1MQVKbN6BYC/60kKPel/i8=
X-Google-Smtp-Source: AK7set9Tchm99xFd/4MiXmF+NcQ4WWJCXt58qiuFCJdZg4kRJEULSODOaqBrG8Vs6SBzvU0+iMsKWQ==
X-Received: by 2002:a05:6871:a688:b0:16d:c113:d3c0 with SMTP id wh8-20020a056871a68800b0016dc113d3c0mr935906oab.10.1676054773120;
        Fri, 10 Feb 2023 10:46:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q14-20020a4a88ce000000b005177c244f31sm2238783ooh.41.2023.02.10.10.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 10:46:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 10 Feb 2023 10:46:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jerry Hoemann <jerry.hoemann@hpe.com>
Cc:     corbet@lwn.net, linux-watchdog@vger.kernel.org,
        wim@linux-watchdog.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation/watchdog/hpwdt: Fix Reference
Message-ID: <20230210184611.GB3670524@roeck-us.net>
References: <20230210184247.221134-1-jerry.hoemann@hpe.com>
 <20230210184247.221134-2-jerry.hoemann@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230210184247.221134-2-jerry.hoemann@hpe.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2023 at 11:42:46AM -0700, Jerry Hoemann wrote:
> The IPMI documentation moved to Documentation/driver-api/ipmi.rst.
> Update reference to reflect new location.
> 
> Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  Documentation/watchdog/hpwdt.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/watchdog/hpwdt.rst b/Documentation/watchdog/hpwdt.rst
> index c824cd7f6e32..c972fc2a3d0b 100644
> --- a/Documentation/watchdog/hpwdt.rst
> +++ b/Documentation/watchdog/hpwdt.rst
> @@ -48,7 +48,7 @@ Last reviewed: 08/20/2018
>   NOTE:
>         More information about watchdog drivers in general, including the ioctl
>         interface to /dev/watchdog can be found in
> -       Documentation/watchdog/watchdog-api.rst and Documentation/IPMI.txt.
> +       Documentation/watchdog/watchdog-api.rst and Documentation/driver-api/ipmi.rst
>  
>   Due to limitations in the iLO hardware, the NMI pretimeout if enabled,
>   can only be set to 9 seconds.  Attempts to set pretimeout to other
> -- 
> 2.39.1
> 
