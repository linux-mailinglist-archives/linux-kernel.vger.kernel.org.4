Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7320072EFCE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 01:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbjFMXJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 19:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFMXJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 19:09:30 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1076CE6F;
        Tue, 13 Jun 2023 16:09:21 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-665a18f5643so1745404b3a.0;
        Tue, 13 Jun 2023 16:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686697760; x=1689289760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IatuP/RDnQdoeSej9nA4a4h6poVVsV21jA6QdT0KSvA=;
        b=AlxhtcdUzBSfoWiWYaHoSWjSxVYya0oPVN+K0WQ4WHUWKCvPaWc4+KrPEGoaLMf7Av
         KzUmZlK0GqrsQelDNDiMk5oOsjpOs497Xj0TbHlmBJwJJ4bMmhDqvNyZ5UVsNiPMuFr/
         hTEwTQ3rN08Gja711OBMQZUGmdwVKpqmPLA7IcYzmtLXL73wl7Qpfxo7p8lIf3Gp7lFV
         J4zaDDArTpSpGBxt/JvUQvCAEJsNxMZPh/sHh1DUEU/dEQtU9KW9SpX4uSKfQiMcmVo7
         pXPm3ZpXFGA2eWqvDc1mkpRu+J6nj5pp5bG/on3T5NsdjDZ/sWXlN4p9jKeNfQNjPVW/
         0j/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686697760; x=1689289760;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IatuP/RDnQdoeSej9nA4a4h6poVVsV21jA6QdT0KSvA=;
        b=XCidaLU71+z4cGOTowdMUA4Odrno7056NpXarjdT59Az0FwA4trhXtkuS4jOPpwzEK
         pXifL+LOaAOmLb+QpcrOHp3b0pLYwm5qlvSmyxvaXssIPYOFVm4zAY9hSQaR/fekIsWh
         dmcAwkHi0O3ZJu0wNa2bXpr3aUhmpA+UkHzRE4EkSl3hKlx2ONh3qXFkWqckN1jqvgiD
         dd/1y/tdlY9yM23nK1WSVAUB0EYMqfIJ5m5tWi+1X9K/rOMKvo0JLyQPNEeFiF3hZub7
         tMUItE6Uj8GWH2CLGF50GHQ27B89MRV5W+ceo+rfrqmOuICvslIgDvBxDxSZwunf/CEq
         OKQg==
X-Gm-Message-State: AC+VfDzFjMGkQ/Q7ZyZ5HX6mdOdPM0T5QWjUJtOFWdosxhmQJKqy7FZ9
        LNR8X/HV5rXq5sVEXhulQ8c=
X-Google-Smtp-Source: ACHHUZ7mWOoEGpFP4xKnizuy1KjMJQWYCAifyI5ZnxV2fbP3ZNi0aU9F6ElEOODsXRGwi/24MTwBog==
X-Received: by 2002:a05:6a20:12d2:b0:117:3c00:77ea with SMTP id v18-20020a056a2012d200b001173c0077eamr47033pzg.0.1686697760472;
        Tue, 13 Jun 2023 16:09:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x52-20020a056a000bf400b0065fd8075ba0sm6108588pfu.212.2023.06.13.16.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 16:09:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 13 Jun 2023 16:09:18 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 5.4 00/45] 5.4.247-rc1 review
Message-ID: <5d660acb-e5c5-456a-b4f3-35c93e0d2a10@roeck-us.net>
References: <20230612101654.644983109@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612101654.644983109@linuxfoundation.org>
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

On Mon, Jun 12, 2023 at 12:25:54PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.247 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 

Build results:
	total: 159 pass: 159 fail: 0
Qemu test results:
	total: 455 pass: 455 fail: 0

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter
