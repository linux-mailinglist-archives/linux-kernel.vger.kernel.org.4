Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7307A660451
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 17:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjAFQe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 11:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjAFQe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 11:34:27 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC2576EFF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 08:34:24 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id h192so1480467pgc.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 08:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GLC5QUeUL2afI6fkE2hQgTHlKSoxUZrTGJ/pG2j0kWA=;
        b=w3VSh96pSDfPKxhIYAAO/vefawk9pjXMQGzqCj1VBVod2nSAHd1botoFl8A65MufYq
         6SKlVedRvbrkaU1TSRV26Ku27uPwGEW5R5z6vGEVyIp2IaUiprGgLpteQgkZbXTUoukO
         Oh6UfkIoTM7Pgaui3yR2ulrqvpaU50RoCVDkoXfJCpK1V5Yd8XhoFz2r2Z0DwM709xRz
         7CuezLqYehdDIu33yTk1OGc7dOaVYJ7UOUjT6+/mJ4VfSRdgCU0u/4x3eSL30r4+p346
         v6u+/LgwGvJbWk5C1xUB/5nB98H7F4ycfdPFQNdgNdX4lptWf7czUZ8HtUDohCh+gBKZ
         2GmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLC5QUeUL2afI6fkE2hQgTHlKSoxUZrTGJ/pG2j0kWA=;
        b=TNqCss26NNG0ClujuhI3qjmFRwFKmfw+SWpzICkvQKxyiYpGXQ0WAp0dCd/5BGNx7p
         Mh+TL8jYaw0c2WoXwhqIZC2tq41uCYfxLr2zzd7h9Qz9kmmcNHO6hTYqmzFUWCOPQ4qW
         gIf4K7yeODz/EfqBpeY9030JkUAvc1zGHW/TNF1naKvEhTyU1G4ZaZGjazgNbHYFma4X
         Sba8b9pBuqb3ytLcG/2kE4gerGpWumxFJhyrNwqakzF7RO6Ud8tlGEAq2LrKhhmRO+L1
         ezmPIKjCyOPpc3aNrQ0g81kV4eQi5rRYvZvPzrEchKvdTQm//UxENmpOu+OZ/hhMIhhk
         o3zg==
X-Gm-Message-State: AFqh2krujnQTrG4cLoQt4mc35HBcc2pkIpLX6VwLD6Hpw9zpG1Okc8qG
        8s4BHbma7ZC+fZ+0ek1RiJMQ8Q==
X-Google-Smtp-Source: AMrXdXupbQ23NlCXQq5N5/pRiwBTmYJq6n3/vRFF0HtTT9Bx4yoTaJfrihJF+V5rhcHAnyIj6AYxag==
X-Received: by 2002:a62:1c42:0:b0:582:7d77:7fa2 with SMTP id c63-20020a621c42000000b005827d777fa2mr18705684pfc.11.1673022864134;
        Fri, 06 Jan 2023 08:34:24 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:36e4:cfb6:3705:ebd9])
        by smtp.gmail.com with ESMTPSA id 195-20020a6216cc000000b00580c51341fasm1346020pfw.177.2023.01.06.08.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 08:34:23 -0800 (PST)
Date:   Fri, 6 Jan 2023 09:34:21 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     MD Danish Anwar <danishanwar@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Suman Anna <s-anna@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        "Andrew F . Davis" <afd@ti.com>, nm@ti.com, vigneshr@ti.com,
        srk@ti.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v14 0/6] Introduce PRU remoteproc consumer API
Message-ID: <20230106163421.GA2351214@p14s>
References: <20230106121046.886863-1-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106121046.886863-1-danishanwar@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> MD Danish Anwar (2):
>   remoteproc: pru: Add enum for PRU Core Identifiers.
>   remoteproc: pru: Add APIs to get and put the PRU cores
> 
> Roger Quadros (1):
>   remoteproc: pru: Add pru_rproc_set_ctable() function
> 
> Suman Anna (2):
>   dt-bindings: remoteproc: Add PRU consumer bindings
>   remoteproc: pru: Make sysfs entries read-only for PRU client driven
>     boots
> 
> Tero Kristo (1):
>   remoteproc: pru: Configure firmware based on client setup
> 
>  .../bindings/remoteproc/ti,pru-consumer.yaml  |  60 +++++
>  drivers/remoteproc/pru_rproc.c                | 230 +++++++++++++++++-
>  include/linux/remoteproc/pruss.h              |  83 +++++++
>  3 files changed, 368 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
>  create mode 100644 include/linux/remoteproc/pruss.h
>

I have applied this set.

Thanks,
Mathieu

> -- 
> 2.25.1
> 
