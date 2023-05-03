Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 497796F5715
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjECLU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjECLU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:20:58 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E121FCF
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 04:20:57 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-2fc3f1d6f8cso3090026f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 04:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683112856; x=1685704856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aJlibTx8TK7p5Pjke+lVcNzDYTvxet8ibw1NJMa5wZM=;
        b=FHtm5x0ckmS28FmXCTxXR5WMeSX0le5DilqQ0gNxeA5Hc4Op0A6tUfJBGxym5jh78Y
         iStp9o22yDPetjXAS438tCfbzHw6agB6jfy5skhbJK7WmPKMcGu/v9xgobFFryezbjl8
         a9SVLjJrehlCCTusDOdmiSPe67gmcwj9sp+5kzQWhe1d9H+IAMMfU6M6joHiZlpOkkAX
         Zmx7bBLUpZOYdZbxRXKgeOfR9knSWXqq2aGrJcGpK0j5Qtf1RuJOL6mcR+g9Tc7AO9Oh
         0VVRpOe/W5sSXDflEHnaVpYeEJat8+tky1jIC3ruZ0PN9ApbHt5daLcMPOewOG1z1e6U
         2L0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683112856; x=1685704856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJlibTx8TK7p5Pjke+lVcNzDYTvxet8ibw1NJMa5wZM=;
        b=kPpPyFSRB55y1oqqINvmyTkX8AEF0+gfHZFQsfZcRoY89+QilnPunj1JfoppLZOlFi
         +oLpq03kW4xOsBApq1TUd7HrM2PEL2BGIyunb22+0SDNiVknZxo38+N/eL696NJAgxYb
         AuhXEqcehPssn0LXv7KOfenXodKZYHswaLShkZd3t24o1+kFBBK/Lvdnl5OW3JkmB6cI
         SzhgU+HJxNyrqEmTjD65uYwka17bc+NFw/5qeNGETmhLd2q69aCUcCv3YDTgI8qnnHvh
         IHcExfiJ5z4rqJaEZyMlzM+Qd6MQk9QfB3eXzyrms6+mqgV1z7BPMgMlVdGBilCU/P88
         6ruw==
X-Gm-Message-State: AC+VfDz/2zbmp1vsOvtLnskEhWoTDWpFRxGC3SlwpZ1U4Ae9jyWjcyMR
        J0RwK2IvSUYcGYoItCSiPlX26w==
X-Google-Smtp-Source: ACHHUZ5Hhp9kVQi8FJhj11p5+rQBMBVgoYd2qOZc+s77icf4hUmkxo3GJMxFW8h7/MTiWdRxS6KnIw==
X-Received: by 2002:a5d:5968:0:b0:2ef:bada:2f25 with SMTP id e40-20020a5d5968000000b002efbada2f25mr13980541wri.67.1683112855882;
        Wed, 03 May 2023 04:20:55 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id b9-20020adfee89000000b002f777345d21sm33424777wro.95.2023.05.03.04.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 04:20:54 -0700 (PDT)
Date:   Wed, 3 May 2023 12:20:52 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] backlight: corgi_lcd: fix missing prototype
Message-ID: <20230503112052.GA109942@aspen.lan>
References: <20230417210213.2385912-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417210213.2385912-1-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:02:13PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> The corgi_lcd_limit_intensity() function is called from platform
> and defined in a driver, but the driver does not see the declaration:
>
> drivers/video/backlight/corgi_lcd.c:434:6: error: no previous prototype for 'corgi_lcd_limit_intensity' [-Werror=missing-prototypes]
>   434 | void corgi_lcd_limit_intensity(int limit)
>
> Move the prototype into a header that can be included from both
> sides to shut up the warning.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
