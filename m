Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3ED6FFFB5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 06:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239882AbjELEls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 00:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239826AbjELElq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 00:41:46 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE5310D0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:41:44 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24de9c66559so6635422a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 21:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683866504; x=1686458504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0eAzz1APWLPmtP5qjDMq+U37VYIUnO9rDXLCNCtOeis=;
        b=jQQpkAVdXvoEeLX+uBb+I+JanD8GzdD0r5htTuvVRuLj8vNjcTuU26PRLZYTtavnta
         5dl0qgBCCDCphh6zEEvMgpoTNHq5dNDpDrh22Ir8robr1KAVINJEWyhm8CHSbr0EjukY
         bcGG9mEdfQ4oTQpNsGWFJnv7zVDHqa/8/8J9qOa/V+4SDl0YhUqUiv8+U+h5ufhThaCN
         Ej3gXDI9FsPht9l9CO88tVjw4yBbkZfEwnJdEses8xZH6XsW6wAN36Zqm2viFt27kJer
         kHMou3jn3pMk90jjkAAcdXREeIJw5eesq+PDfNBxK3gtTPSmg1/XKKLTzUGJO6LyCymC
         oAbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683866504; x=1686458504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eAzz1APWLPmtP5qjDMq+U37VYIUnO9rDXLCNCtOeis=;
        b=FanCpoDy8VNPQLlrwWBjW/1+tfP9I2vx/puv+KXi3k0GNgsvQeDXcXrnNmunh8WQbg
         G/ysUVqmLDY5cuLkllHarxG0xa/QUaE89S7iI9/6M76qqXExbpJ+zDWNkcsvP+fstlGr
         +EEDI4JkXIZ3enW5Di7xSQkHD+dhbVcXgbFe1JrQQ8/Z1SV6Om0K0sk9TqNnvyGHa+Zt
         jXbUfy69ZRYREYNPQsv3lrnDKBQ28qeqjwVhe9USiYmYJ0Rtw2okzJNJv99op/B+YXAk
         JSqxxRoJ38PN1IVx2khz86TC8N1Ibij4SatZCVLtolyOkY70J8OpPwkCFYbg3wJ4q0Wp
         ROow==
X-Gm-Message-State: AC+VfDxr5qPoFZbvfv7jh74ZsxW8HvCVj3QKZ+cYiAC0cdzAsP+HH3KW
        MiIE8DE0qMfkTsDdkmE2JNnU0Q==
X-Google-Smtp-Source: ACHHUZ5IsgJoRV2rBIah4jhVE0LM8uR82bgwDWm8maN2mG3FiDkEXQG4PwuxnWO+qFy4oyTDs5fndQ==
X-Received: by 2002:a17:90b:1e0c:b0:24d:e4fd:f487 with SMTP id pg12-20020a17090b1e0c00b0024de4fdf487mr22487972pjb.14.1683866503875;
        Thu, 11 May 2023 21:41:43 -0700 (PDT)
Received: from localhost ([122.172.82.60])
        by smtp.gmail.com with ESMTPSA id dt20-20020a17090afa5400b00247601ce2aesm16145265pjb.20.2023.05.11.21.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 21:41:43 -0700 (PDT)
Date:   Fri, 12 May 2023 10:11:41 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: imx6q: Disable only available frequencies
Message-ID: <20230512044141.n3l6l75cfal7i26d@vireshk-i7>
References: <20230511092334.3017-1-cniedermaier@dh-electronics.com>
 <20230511095355.5t7ldsyg5eglrrtv@vireshk-i7>
 <a7bfc85a9b664daf84e90adf520c0a56@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7bfc85a9b664daf84e90adf520c0a56@dh-electronics.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-23, 14:38, Christoph Niedermaier wrote:
> -	if (val < OCOTP_CFG3_SPEED_996MHZ)
> -		if (dev_pm_opp_disable(dev, 996000000))
> +	if (val < OCOTP_CFG3_SPEED_996MHZ) {
> +		ret_opp = dev_pm_opp_disable(dev, 996000000);
> +		if (ret_opp < 0 && ret_opp != -ENODEV)
>  			dev_warn(dev, "failed to disable 996MHz OPP\n");
> +	}
> 
> If that's OK, I can do a version 2 with it.

Looks okay to me.

-- 
viresh
