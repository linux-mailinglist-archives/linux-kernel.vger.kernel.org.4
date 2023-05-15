Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524F8702827
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 11:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237750AbjEOJUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 05:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240171AbjEOJTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 05:19:50 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775C64696
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:14:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ab0c697c2bso115303645ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 02:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684142081; x=1686734081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhl70D13UPLlD+CJJjNTF5Q84ulLNw8nlegVawSdcsg=;
        b=IaLTLnEr1fHdQAgZzYUOIU4RUWBUHAzbCZomuK87PdvoPDoUg4uyB9Vx1CNzd1dFaN
         cTq/PhPv2cIVoHaboVjlIObQGfQbovfFR+64mjErzXckYMmilnwjcwexhM8pNNg5XzN5
         m25Xsm20gfSdjsakODyQHUwUVUmpvxUTmliRkXKBx8mTmiWyPa/2X+qeUZlhEHWRuRnt
         7kRGSqF+dX93edpGF6R1oCvJxCDioOcA/6UIorHIqdyWE0mk362CWVDR2AnitHQGSyRc
         qbLm+kBP8Vij0Rbpexh5Um0/lfSmTtzgGWBzZcxp8R7gQ1AdPSag1y1CebtpC8y8cCxz
         zOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684142081; x=1686734081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rhl70D13UPLlD+CJJjNTF5Q84ulLNw8nlegVawSdcsg=;
        b=E4oA1S/dSwmCleVyano0GRJCeumgfmiaDEN/DdqIu90J3quMVXcw0Od4XdWnmz7SAz
         16kk/hbuX2rFqIZmVt0nzz1JkBSK5OAuFRAncLgesQXBvem8UOiLMGo5tq2UVDxizQAw
         diwTqc1b/82DZ5/EN7UozY9E/d5Njva/VXKktq5/I+XTGxPMAdGhD5B/iX3Jw8ltPel7
         rp18eFaf/h9Q9HLCmeTWEEB/7qFEZriwPGJum6d07gdEXtV5dGFr44Xbwr2NWc3D324L
         dZTOIE1PLww7rNi7tTEfYXL0N3UgCHjerlbiCm0oietLxTlpQ9pN2nHh/QZiaGZTg6g+
         c6Qw==
X-Gm-Message-State: AC+VfDz6jqbXK3cTnUT4fh+p609Mrma/aOpDBqk3Swhn4UD0kgZ/NRkx
        uMnhjAMPZPKrBts1sJ8kavqJaA==
X-Google-Smtp-Source: ACHHUZ5to8leScyvux6CJtKYH6ulUjsidhowbpHUtx5Cw7pvncvMb9rj6cosZG9pkzjykGMHsn2Ccw==
X-Received: by 2002:a17:903:2112:b0:1ac:8e0b:282e with SMTP id o18-20020a170903211200b001ac8e0b282emr19934850ple.58.1684142080895;
        Mon, 15 May 2023 02:14:40 -0700 (PDT)
Received: from localhost ([122.172.82.60])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c20d00b0019e5fc21663sm12922969pll.218.2023.05.15.02.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 02:14:40 -0700 (PDT)
Date:   Mon, 15 May 2023 14:44:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] cpufreq: imx6q: No warning output when disabling a
 non-existing frequency of the OPP
Message-ID: <20230515091438.llg6gfgmxrhkbecz@vireshk-i7>
References: <20230512150711.106854-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230512150711.106854-1-cniedermaier@dh-electronics.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-05-23, 17:07, Christoph Niedermaier wrote:
> It is confusing if a warning is given for disabling a non-existent
> frequency of the operating performance points (OPP). In this case
> the function dev_pm_opp_disable() returns -ENODEV. Check the return
> value and avoid the output of a warning in this case. Avoid code
> duplication by using a separate function.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>

Applied. Thanks.

-- 
viresh
