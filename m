Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DBC663C6E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 10:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbjAJJLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 04:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjAJJLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 04:11:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFC7C70
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673341850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yWXx46ST0eNXscZuNMexmxZ3GtEyDtW2jwFA0HF6qEQ=;
        b=D57mj4BR6T2lzW8fVSDwyCfSGrfJUTZW+fO0Nlc1iyiZvoeJ1Nc4pxP9+1PNYJDXczbmSc
        vz94ecToE8wwOys1qTwR165tD4GXWVxaYY7Eyz2LODh746QaWlIzVIw144uSzXsXTrRaxL
        4DrZiP0P1mZ2njwDzvRXvZ8udAXwXzM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-450-mhwvRmUzO_uUtoZd1a52EA-1; Tue, 10 Jan 2023 04:10:49 -0500
X-MC-Unique: mhwvRmUzO_uUtoZd1a52EA-1
Received: by mail-wm1-f72.google.com with SMTP id fm25-20020a05600c0c1900b003d9702a11e5so6067664wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 01:10:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWXx46ST0eNXscZuNMexmxZ3GtEyDtW2jwFA0HF6qEQ=;
        b=3wWfpVq/KFALL9yBxqsB/ZJbhfII9NEcBpHRGcPU40fyiFVd+4+G+NuL88HR/3ru9T
         jpuPa5H2AO3+CwfHREEitPVpsiLMIKa/nb7otHU3K0DzK3FAQj/nk+Rx9NTLFJ3o3HKV
         aTk8dR3NAq1HiqiXCDiO3AwD4KQ5HhcwlolZI94wtOK+PyO6uJm5gj4F+luksapPHVrJ
         3Zj97RoOwO29rRQ2QajOjjr+P0VU6Lir9UMaQ1Msl47/syQ/otH8trjt0RczzXVSEEy+
         LSmyaQDvVsa1FK1j4MZKrCDTFZmjGNSjeqp/jCQFy4QRbwEGasRel0+E787Zx49XbhZi
         uI5Q==
X-Gm-Message-State: AFqh2kq+r91jXGJ7nm7q1bwkvkel6UJ3DEHwml2l8NaUdmArHxFBOvBk
        VjMC897aFkQwINzsgVgWJhGKe0A0Q3ZPqhDzwRdd2dwEpG5+f2LqGMaXgdbRDFMQFd948X5VFkV
        pWanwwYCJk9EJc3XxzJLrTOvx
X-Received: by 2002:a05:600c:3d11:b0:3cf:8b22:76b3 with SMTP id bh17-20020a05600c3d1100b003cf8b2276b3mr49160600wmb.0.1673341848287;
        Tue, 10 Jan 2023 01:10:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsxw1W4Slf9AiH0i+Mq5ZqP5Zi07NMRWMijT+CvF5DKIEWYj7uheoX+YrSj17A+rhiHYB0oNA==
X-Received: by 2002:a05:600c:3d11:b0:3cf:8b22:76b3 with SMTP id bh17-20020a05600c3d1100b003cf8b2276b3mr49160582wmb.0.1673341848077;
        Tue, 10 Jan 2023 01:10:48 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q20-20020a7bce94000000b003c6c3fb3cf6sm13902722wmj.18.2023.01.10.01.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 01:10:47 -0800 (PST)
Message-ID: <1b78de44-4bbf-b147-6804-4ce445fc3440@redhat.com>
Date:   Tue, 10 Jan 2023 10:10:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 038/606] drm/i2c/ch7006: Convert to i2c's .probe_new()
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Ajay Gupta <ajayg@nvidia.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-i2c@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-39-uwe@kleine-koenig.org>
 <20230110090654.ghj6rioikxse33e3@pengutronix.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230110090654.ghj6rioikxse33e3@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_FILL_THIS_FORM_SHORT autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Uwe,

On 1/10/23 10:06, Uwe Kleine-König wrote:
> Hello,
> 
> I fatfingered my git tooling and got the author of this patch wrong. My
> intention is that the author is
> 
> 	Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>

That's what I thought but good to have a confirmation from you.
 
> and not my other self with my private email address. Tell me if I should
> resend to simplify patch application.
>

No need, I can amend that locally before pushing. Thanks!
 
> Best regards
> Uwe
> 

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

