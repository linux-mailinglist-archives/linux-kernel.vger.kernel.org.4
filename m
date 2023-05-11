Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA5D6FEF70
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237740AbjEKJym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237541AbjEKJyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:54:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EC99EC8
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:54:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aaf91ae451so78873105ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683798837; x=1686390837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A2Z3r2g8b5XIWJ7iC4mvIlxM6ZNZqyv7oNs9flkcp2s=;
        b=q85weGVVpTU4s4bdmat37cNQ3JCmN+m5umPY8yBHQWH8N1qaJ0zsAdHIpgNv0TRri+
         QMNEWH2S0BepQsYZRye0tCGaamjeDev93qLqlM0ixolYxqfZANfn6sCuKCK1J8IH6ILO
         a7odvS+PSNZzp4LuQ4ITjPCxTVI+qW9TpPI3JeTNyyL2xaap6b4cQNiOAP7ukmko/gQa
         BUJKmOEFmvMdTVCI4G0iUp6yG2djLKziWzl2uCW+F/Z0Sy5NjwadSBUQTkq0riiL1lcE
         VPGTyjNyeNI7EfwcX0XuOVpAneFNlMn1N5GET5aHC0hLSb/wUa6WwhVynHH5drO0gzc5
         6LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798837; x=1686390837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A2Z3r2g8b5XIWJ7iC4mvIlxM6ZNZqyv7oNs9flkcp2s=;
        b=LsZapwh6xuwUAQ2IQDQcjkia90l/T8DCOQ2+g3/RDy0qiKrLJh0DwpttGjdIZH41gR
         UiSA0/ejIE+Ljq1xq8vp24xA6AQK+S8ldSfduWsSxQYjZhbcMYd1aet7WTzQgJpVrdmS
         shPkSf/ocDWSY5HYA5saNPvNPeNkaLrhlOQSgrtwn46xM/KXjTBisdQZAVOsjFBlCo7p
         qedLKi7kmuuqLBeiJQDzSVhcUUvggFuea2o0t+KgE7/g1nGLG1AExg8TBsQkHSYYoRrK
         jxNrHG6x4mWre5lZ/42EodeqRoAuCyUyUAJNOhwh0La4G6Q1kaSGmCdH2Nvh3dSZlKdg
         hfjg==
X-Gm-Message-State: AC+VfDwVvLfw41yv0yRM/wPEWcXzBcBxqISJ0eOAIFxSVob6CZj9EQti
        CxZN48HKZ/ckH9x+vytW/gzBDg==
X-Google-Smtp-Source: ACHHUZ4e/XCl1Gfjm8w3elwBPAkx2w1prOIEqvsTyv6K9pIKaF19oHaqkgRsxr97pvfUwbbGRBnj0w==
X-Received: by 2002:a17:903:2307:b0:1ac:a61c:7a14 with SMTP id d7-20020a170903230700b001aca61c7a14mr8875799plh.62.1683798837739;
        Thu, 11 May 2023 02:53:57 -0700 (PDT)
Received: from localhost ([122.172.82.60])
        by smtp.gmail.com with ESMTPSA id c2-20020a170902d90200b001a9bfd4c5dfsm5441912plz.147.2023.05.11.02.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 02:53:56 -0700 (PDT)
Date:   Thu, 11 May 2023 15:23:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:CPU FREQUENCY SCALING FRAMEWORK" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cpufreq: imx6q: Disable only available frequencies
Message-ID: <20230511095355.5t7ldsyg5eglrrtv@vireshk-i7>
References: <20230511092334.3017-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511092334.3017-1-cniedermaier@dh-electronics.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-23, 11:23, Christoph Niedermaier wrote:
> @@ -254,16 +269,16 @@ static int imx6q_opp_check_speed_grading(struct device *dev)
>  	val &= 0x3;
>  
>  	if (val < OCOTP_CFG3_SPEED_996MHZ)
> -		if (dev_pm_opp_disable(dev, 996000000))
> +		if (disable_freq_if_available(dev, 996000000))
>  			dev_warn(dev, "failed to disable 996MHz OPP\n");

Ahh, these warnings.

What about printing the warning only when returned error != -ENODEV ?
Or just marking them dev_dbg() ?

-- 
viresh
