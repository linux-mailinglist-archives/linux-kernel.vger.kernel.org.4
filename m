Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CE75EBDFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiI0JDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiI0JDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:03:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB336AA3F9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664269374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xy/vZrVEyKAC936wld9SdePzf0CNuc4X8kChnAdBCQk=;
        b=eMnlEZEV5iaKWvOmFmHf/KKYP1Oh5OgyN0dtYBD+n5r4ykYtBBfXQT2Mv1Uf41zZKBDhJB
        sJKKaB+PqmB+udxnLHM7v3VOX5BG49KNlwz7q8pngcpux5YtQEY0iZMRTod0ywIjGU1sJf
        VXmb2XU9uf1LZ/h3KQVJ8D18mJn49Zk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664--yfKl-g2OLO7C8v2JaJjEQ-1; Tue, 27 Sep 2022 05:02:53 -0400
X-MC-Unique: -yfKl-g2OLO7C8v2JaJjEQ-1
Received: by mail-wr1-f69.google.com with SMTP id e2-20020adf9bc2000000b0022ae4ea0afcso1924842wrc.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=xy/vZrVEyKAC936wld9SdePzf0CNuc4X8kChnAdBCQk=;
        b=MFz2m4LU0uQZEgM8pRJCyfqDRXIF3skSCk8qXiCYtja7ozQv6zOjYs0bZCs9PUADgA
         pLwOQxBpD7ryuS1fnDpyb9ziqyBR03QuOTWfVqct2oWBZRhxB+TeBDvR+MMfoNDjTDxz
         BNsPyXGbhRcJwnS7DITrSuvJNAzA+dvpeldi7T+L82mfu172LZXHtgXrW+Qt4hzhVKe5
         fAYmvaGZpygU5ACQcsCBfzXc3NLYOSf/hX7yjCD0GaqageBkTJDHpssODJd0EWXo2olv
         J6g83xEpMQnyffd1+AH2DoJU/8mx8V9/xaVN4fXDhHq1c0Lmsr+8Z/1osJYGcD8PrWVa
         Tkkg==
X-Gm-Message-State: ACrzQf3KmRZqgZ8RVJDla+gLdvdvzeqx8FeutjDOQ9cVn3KybLw3LSeF
        K0DFBB6Y/VcrIiB+uO6lvxQex7+CBL/0RwttwYA4yLBBhyzt+bG6K40A7KrFYRFS3dzWQ8nFsnT
        Tfeb6UGp+UFfYjG9wKA4SGVqf
X-Received: by 2002:adf:dd8f:0:b0:22a:84ab:4be3 with SMTP id x15-20020adfdd8f000000b0022a84ab4be3mr15951099wrl.40.1664269371780;
        Tue, 27 Sep 2022 02:02:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6QQ+AHuQOmKI/6F1QjWVeqDfj9EhoRpgYUwRQU9fWumUC0o5Tf3aS3su5R3i29q/HGgpvQ8w==
X-Received: by 2002:adf:dd8f:0:b0:22a:84ab:4be3 with SMTP id x15-20020adfdd8f000000b0022a84ab4be3mr15951066wrl.40.1664269371478;
        Tue, 27 Sep 2022 02:02:51 -0700 (PDT)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r2-20020a05600c284200b003b2878b9e0dsm1116996wmb.20.2022.09.27.02.02.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 02:02:50 -0700 (PDT)
Message-ID: <2a3b6824-7a76-308c-c7a7-cc7c6001dfcb@redhat.com>
Date:   Tue, 27 Sep 2022 11:02:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [v2] drm/msm: add null checks for drm device to avoid crash
 during probe defer
Content-Language: en-US
To:     Vinod Polimera <vpolimer@qti.qualcomm.com>,
        "dmitry.baryshkov@linaro.org" <dmitry.baryshkov@linaro.org>,
        "Vinod Polimera (QUIC)" <quic_vpolimer@quicinc.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "dianders@chromium.org" <dianders@chromium.org>,
        "vpolimer@quicinc.com" <vpolimer@quicinc.com>,
        Abhinav Kumar <abhinavk@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>,
        "kalyant@quicinc.com" <kalyant@quicinc.com>
References: <1654249343-24959-1-git-send-email-quic_vpolimer@quicinc.com>
 <29ae886c-b2b2-2387-87cb-e4a885080418@linaro.org>
 <f70f9f1b-c835-7baf-974d-87f2bf6e4e53@linaro.org>
 <BN0PR02MB8173E3E88164E52AEF5AB1A1E4559@BN0PR02MB8173.namprd02.prod.outlook.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <BN0PR02MB8173E3E88164E52AEF5AB1A1E4559@BN0PR02MB8173.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vinod and Dmitry,

On 9/27/22 09:31, Vinod Polimera wrote:
>> -----Original Message-----
>> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Sent: Friday, August 26, 2022 2:11 PM
>> To: Vinod Polimera (QUIC) <quic_vpolimer@quicinc.com>; dri-
>> devel@lists.freedesktop.org; linux-arm-msm@vger.kernel.org;
>> freedreno@lists.freedesktop.org; devicetree@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org; robdclark@gmail.com;
>> dianders@chromium.org; vpolimer@quicinc.com; swboyd@chromium.org;
>> kalyant@quicinc.com
>> Subject: Re: [v2] drm/msm: add null checks for drm device to avoid crash
>> during probe defer
>>

[...]

>> Vinod, do we still want to pursue this fix? If so, could you please
>> update it according to the comment.
>>

I don't think this patch is needed anymore, since AFAICT the issue has
been fixed by commit 0a58d2ae572a ("drm/msm: Make .remove and .shutdown
HW shutdown consistent") which is already in the drm/drm-next branch.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

