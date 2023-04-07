Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A126C6DB18B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbjDGRT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjDGRTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:19:44 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA7DCA03;
        Fri,  7 Apr 2023 10:19:23 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4PtQ8Q1TtMzyR8;
        Fri,  7 Apr 2023 20:19:17 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1680887960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sx/v6v02tkhyVSJIxoR5pZtA5d+qnL+HKABd0KsDWkk=;
        b=be7boNoSaCauKSf5nx7KUm+r6UvnLMDwHpf0Qa1a9fuciGNUun+OK1SRSGeD8T5v5fFGw5
        aTLNE1hacjHpkBakgCN+euY2G497WLc7L7SLEE8F9vDdpu7AwIRmn8RhaFpRcQER5UliSe
        ijDS2ZLYe2MH/Z+EjJu5J2Du+MqFot8=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1680887960; a=rsa-sha256; cv=none;
        b=T/CuPIfgtU/10f0gPBOap2JMhmhN1T1u/2qju0MziBT/3Vr4nrzcG8p2NEmQJXH1mNglmb
        l+cDsGWgIGEVeXP0xI/hnT/jC/w3SxRxQnjqApJmrXbLr88PHNmlIBa65KfWgIeGVLPvN+
        YWCR/PhsGIdLlCcIdbUQNUpXog/96QI=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1680887960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sx/v6v02tkhyVSJIxoR5pZtA5d+qnL+HKABd0KsDWkk=;
        b=TjfAYh/Fj8WFUjFOKnXU8hsAdoOF0mZs31+RQteSR9hvHGQ5zwPGmuZVTNzFsV0e4pmRa8
        hdxXGyn2O/tXhz6Dt6g9ytC0xBluqypq9KOIOlrlY22uMfRuNhhXonGd5dgkRgqifIKvY0
        sE0oX5FaJ5LSrXBQlXSjeEGVAkukOnI=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id B46D1634C91;
        Fri,  7 Apr 2023 20:16:30 +0300 (EEST)
Date:   Fri, 7 Apr 2023 20:16:30 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Matt Ranostay <matt.ranostay@konsulko.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] media: i2c: video: constify pointers to
 hwmon_channel_info
Message-ID: <ZDBP7vG498h2FQ7N@valkosipuli.retiisi.eu>
References: <20230407150015.79715-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407150015.79715-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Fri, Apr 07, 2023 at 05:00:15PM +0200, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This depends on hwmon core patch:
> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> 
> Therefore I propose this should also go via hwmon tree.

Works for me. Please add:

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thanks!

-- 
Kind regards,

Sakari Ailus
