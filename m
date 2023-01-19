Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADAC6733B8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 09:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjASIca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 03:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjASIc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:32:27 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B6466F8A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:32:23 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id b17so1656898pld.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 00:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YbrgVpwF2pbjazG2wPuZ5pGu2SagKg2YK0Fd/r4ygk0=;
        b=vRV7XHB13C1kYJT922Pxl1JpOjHNcpU+NKr8kXE+e/GWqHaNcwLQtz+aRgVPGZsHF7
         eQR499UMHgW5di+bQtOvFmQei8fnN4lfrudarbQJ65JtYqaLP5gPNxPryue2/xxrQe5q
         6Bq+NXjKE+S19ZWfcZ0MqbJZvrO3KX085gZ7WSLBo0LvzguTgR/6WQlrTHIbxYhbWHX7
         NJY+OJiLbnYBOKbyHM+ridT9skrXQFnRZTdzYl8ch9B2nb1AJC5YPHgVvoCrhaWBD2NA
         zE1P2vwTERvwbtNAcM8uK0OfCo60osMLbD06ZoJbFlGDLVGVwZrGEyfcAFMv13qkGNFi
         4vOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbrgVpwF2pbjazG2wPuZ5pGu2SagKg2YK0Fd/r4ygk0=;
        b=Ygyu703dc+B+f4FoB6vN5AREioe5D8KdFmiRy8mqdv2Z4E3l4+149dSd5H+6tX7QVq
         0iuPJvjx+Pw5DPPlImOPK7V+Ufzpo99Obg7dl7luOtXmqYONbIfhDa0jSx0sskHMqzvN
         MBN88EBUAfeqCBFmiQy6zhEo3H+X0XbLUjuwO5RVdkOX2GVMxrbqXCicL7ky80IwZcxu
         P5C+PMqrozaLQDWNRxLrmdQrLd1XfRAtHZZtVXUega+MsPEP8h5+++OAWg0z/rgf3KY4
         IGPYHP1Jlxa4gt1ZcrYuXvgQvRnnxMpcksdUTx9U05YMup8+xvz0dCjzmcUbdIiGJ9YC
         KhCA==
X-Gm-Message-State: AFqh2krA6A+p2Zwjv+O5QqpFCT9cFU8MfrhM4j5P1+LBQqHHmdhEoTIB
        J9nlOM2e54vLKx8YkszfKPIp9g==
X-Google-Smtp-Source: AMrXdXtWrH7mRs6DPboAmuPucX8c0sbCzk8cJln3A/iC+Q9QSLNojZice6XhxmehRZj4zMdIDaawYw==
X-Received: by 2002:a17:90b:1211:b0:229:2964:53ad with SMTP id gl17-20020a17090b121100b00229296453admr24053434pjb.1.1674117143427;
        Thu, 19 Jan 2023 00:32:23 -0800 (PST)
Received: from localhost ([122.172.83.155])
        by smtp.gmail.com with ESMTPSA id x9-20020a17090a294900b00225bc0e5f19sm2640182pjf.1.2023.01.19.00.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 00:32:22 -0800 (PST)
Date:   Thu, 19 Jan 2023 14:02:20 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Vincent Wang <bhuwz@163.com>,
        Vincent Wang <vincentwang3@lenovo.com>, rafael@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: Register with perf domain before
Message-ID: <20230119083220.d7h7xowfml6f4puj@vireshk-i7>
References: <20230118044733.29391-1-bhuwz@163.com>
 <20230118084923.m3ztfn6v3hskpad6@vireshk-i7>
 <529d967f-9dbc-5b35-546a-428cbb191f0f@arm.com>
 <20230119053952.qwh2yrmhddzocnju@vireshk-i7>
 <eee126fc-c93f-9ff1-835a-96d5d70b4eca@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eee126fc-c93f-9ff1-835a-96d5d70b4eca@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-01-23, 07:58, Lukasz Luba wrote:
> Although, I hope one day, maybe at some conference,
> we could discuss those Android-kernel vs. mainline differences.
> IMO the gap isn't shrinking, but I would like to shrink it.
> Especially when we are serious about long term kernel
> support for mobile devices, this gap should be tiny.
> Therefore, I would tackle this scheduler cpufreq governors and API
> for them.

Sure, or if there is something worth pushing to the mainline kernel,
cpufreq specific, then I am up for it.

-- 
viresh
