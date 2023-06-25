Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B3473CE3E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 05:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjFYDR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 23:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231506AbjFYDRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 23:17:53 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7476106;
        Sat, 24 Jun 2023 20:17:51 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a0457d6b77so1919706b6e.0;
        Sat, 24 Jun 2023 20:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687663071; x=1690255071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zBilisKOTg9JZolq21bCIv/Br31Fsns6PGz19Vp4DGo=;
        b=YKehVqZOBt54T6vymM835Yhw7wB7mjpYt8PQrAOqdakKDfI5E2cLKdJrCzQi3tHV4R
         aO468GQDPg9PDHBvu6Kv8AY2xT90HDSwOq48vTU0sH1nu/SG7ymZFUwHvs2Mm0G4INtY
         ymgZD5DdbIdnq4ed/lwx7dqVZF98dXw95TSm4Avz9nKwWOH8/g/2rF3wYyRkjJzF6V5V
         0Wg9Djrm07LKZDCbkQnMQzwd5WxIyEU+E1VxhhbcAbW1rSlG6uiDrx98UZvXAK0+6v2y
         DJFnqNeUoTHAYN8zbTKU1f6zxrydOr/vRpATLjbIxCzESg6EJ/kD2rnJobHJjECrw6OQ
         xh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687663071; x=1690255071;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBilisKOTg9JZolq21bCIv/Br31Fsns6PGz19Vp4DGo=;
        b=MPtxcRANOpYP1YaqsUamT8kHXBvDd0cwiRtnnoxvMbIHuT2a+O8+pehfynjrMRe7/C
         pFDvUwp3IbQkxLS4TRUH33QE54kX5payVmrvZigkUgL5w0QTO4uGvZN5bzhGiQwUp9ph
         KwPW6BZA50JplX3OFFWLxBDWAGyd5+hXequH/gDD9EVO34XqC3T0cVWuAt96Y+zH3g60
         FE8DLd5xk9AGLDuDK7zAe32XBhHwKHeWZzUklJH5I3pXabxrNJnNN4ZzSOwTDlqGJ4+P
         Hb3qmy83teBgkHQcYe0U3FbP2RALf08dADaFczMnZeqwLGyfkSq29LIukpFJFEuYCLwE
         aL1w==
X-Gm-Message-State: AC+VfDxBVOqzFai+wrP6x6Z54FXbslKlydlwIe44alK0hnkbQbw6giC2
        lo3wNor/dPdXwH7uxILs9HY=
X-Google-Smtp-Source: ACHHUZ7/Jy5NTcD3WQf00SgbwK/z6pHXBZJrcLxhWoeULa8d+UVF+ZY0WURnPFlyNpd+GdqZxi5Ujg==
X-Received: by 2002:a05:6808:bca:b0:3a0:3587:ff56 with SMTP id o10-20020a0568080bca00b003a03587ff56mr20862227oik.24.1687663071039;
        Sat, 24 Jun 2023 20:17:51 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090a898800b0025eaeaae318sm1897898pjn.7.2023.06.24.20.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 20:17:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 24 Jun 2023 20:17:49 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     Jerrod Frost <jcfrosty@proton.me>, derekjohn.clark@gmail.com,
        jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: (oxp-sensors) Add support for AOKZOE A1 PRO
Message-ID: <a5a5ae9e-a7fe-4d0c-bd86-34d104681dba@roeck-us.net>
References: <20230625012347.121352-2-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230625012347.121352-2-samsagax@gmail.com>
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

On Sat, Jun 24, 2023 at 10:23:44PM -0300, Joaquín Ignacio Aramendía wrote:
> From: Jerrod Frost <jcfrosty@proton.me>
> 
> This device is an iteration over the AOKZOE A1 with the same EC mapping
> and features.
> 
> It also has support for tt_toggle.
> 
> Signed-off-by: Jerrod Frost <jcfrosty@proton.me>
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>

Applied.

Thanks,
Guenter
