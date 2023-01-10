Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446BC663DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 11:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbjAJKOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 05:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjAJKMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 05:12:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E49D10E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673345485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ksSvI6tffvqfkT2KgiYhPjAggw+4IOeouLwXWNniZWo=;
        b=Rb5ETm6z2kQvNLUB17H/sHZYaQUXf+ahoqnZw44yxTli6u0cNlSQbjIC8Fbx1XdeQYaZ7B
        WtZOXbIq0Yrpu2673f7IM1ADvsHhHqdjGdHugZE5W1u9PghzirL6QBF4ost0NXDki1cY8Y
        5dJAoZ2V2Si0n9SGGM0HXmg183I/fSg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-496-t0PbRBkGOOaoNIl-cATUYg-1; Tue, 10 Jan 2023 05:11:23 -0500
X-MC-Unique: t0PbRBkGOOaoNIl-cATUYg-1
Received: by mail-wm1-f69.google.com with SMTP id i7-20020a05600c354700b003d62131fe46so8790520wmq.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 02:11:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ksSvI6tffvqfkT2KgiYhPjAggw+4IOeouLwXWNniZWo=;
        b=UvQio9Ky0YiHx5hmtfSe3H5rCufxBRN5hJsMXY6Dc0DvuNtLaEkuE/rxizquhBCvcs
         qhGx+FjEpDW7oHpD9clMO2cAG9qjKlsQpA5Jf8NNPIQa98yq+tHy+u0UPkC+lshQxeTJ
         2gn+Ecayj4POIgqK6BNh2ZUNgGYR1VW9+3gIRrD5jJi8b8OHJkmGj3riNA09/K3W152z
         YcnUrpFhX5GLfFnjyHxHn5lCjEo8ynl+MDS/cbin8kdT7zIfTMPveM8/IhX5hKA9quG4
         YlWABDLuFskrGO6awMWMiaP3TjCoWU4he+Nb1uguVCE8FUmHr6skZdxiglDXxjfyhXEy
         3aug==
X-Gm-Message-State: AFqh2kr8AwRPu54SQ7Hh27kSVvwhAOaQ6PbJ3j+o2B/LRD+RzfTP0i/H
        IBsOSvQCfCX7yBF7OpN25yNShOnQTWR3gjS9/u5R7WQsgMMmOgaRXryu76vsqj864EdoRaVaqEQ
        vSLgaDZ+UaNSp1KRip5Gej+up
X-Received: by 2002:a05:600c:1e18:b0:3d2:5e4e:701 with SMTP id ay24-20020a05600c1e1800b003d25e4e0701mr48749923wmb.31.1673345482605;
        Tue, 10 Jan 2023 02:11:22 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtwdRe0FzupWB3fiAxpuXEJ0H5IbmAGHCSf95dKcrh3YBxCSYr7tLCXwN6KMl3SEALYVsCSjw==
X-Received: by 2002:a05:600c:1e18:b0:3d2:5e4e:701 with SMTP id ay24-20020a05600c1e1800b003d25e4e0701mr48749904wmb.31.1673345482430;
        Tue, 10 Jan 2023 02:11:22 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z25-20020a1c4c19000000b003d1e1f421bfsm18584114wmf.10.2023.01.10.02.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 02:11:22 -0800 (PST)
Message-ID: <d2315ac5-2129-feed-d7c5-8dec5c5da4e2@redhat.com>
Date:   Tue, 10 Jan 2023 11:11:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 040/606] drm/i2c/tda9950: Convert to i2c's .probe_new()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Peter Senna Tschudin <peter.senna@gmail.com>,
        Luca Ceresoli <luca.ceresoli@bootlin.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-i2c@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-41-uwe@kleine-koenig.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20221118224540.619276-41-uwe@kleine-koenig.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/18/22 23:36, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> 
> The probe function doesn't make use of the i2c_device_id * parameter so it
> can be trivially converted.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> --
I've pushed this to drm-misc (dri-misc-next) now. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

