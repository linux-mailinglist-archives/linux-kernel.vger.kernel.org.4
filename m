Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62EF5EC5D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 16:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbiI0OUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 10:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiI0OUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 10:20:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191DFA74C5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664288383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mx4jE3ECEvBhJZF2XERwRargEjDaO4M7Q9H1iSbdaLI=;
        b=HL0NlU1HrgJ54mjn0BE/aP1SyAB+FEi+o7upr3PxJ+ZA+xvUoPleRFmO4+7PzSUviW1ksL
        bFxlrXZxJcbikIWF9ANFNf0AVygtIwa4COkfteQAkbuGw2+jctFVw847L4t0Bdmh9PLlye
        /3txAtRI2frVw0lC2pq+Ztiel6PlKTs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-475-vK8qOWw9M3SEVfqAvBnKpA-1; Tue, 27 Sep 2022 10:19:42 -0400
X-MC-Unique: vK8qOWw9M3SEVfqAvBnKpA-1
Received: by mail-ed1-f69.google.com with SMTP id c6-20020a05640227c600b004521382116dso8047835ede.22
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 07:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Mx4jE3ECEvBhJZF2XERwRargEjDaO4M7Q9H1iSbdaLI=;
        b=C8U9uyretvJdLCrZQm4zM9P4HBcix4LhVVbTh0cstQ2Buw59Hi3TAOwqJbtNnk9nPP
         JUl+QJO3DX/twu4SnoTvUHYRMV4nF6n5dOS0+301aAs/y8+x8BSsLfnY2TsEhZkg//W+
         xFAEZZGHa66Gnn1vZWWIjujgu/3D+hnr2Qref8nz/4LZ6JWwN6Tw8nnhCzjm/zvRrh+M
         9bmU663tcRVC6MGNh7LQqeJfgXChmNCH52CDzDp/MDzSsuUHyN0IhYv6O1JBlH41bqxg
         Qmds3b+nRYwOx5ELcdjfJrWYsyzKt6atatV37Tt67gRUCAHNWohiUfgvOT2yc3/cUhji
         5CPg==
X-Gm-Message-State: ACrzQf16HNm230YuUPs2R4odP6ZkdYpF1ZulToUo4tLEOJMhoDLUemFM
        Ky7WSzaDT7TCMgkOlTh8dciSa1vCz3rsMcyOplw5di0MC5mnD812XIg1wKaS+4Uuaf0b4S0BMXP
        sl5baMk7V9JCZLeERwzUEE1ig
X-Received: by 2002:a05:6402:4311:b0:451:c437:a5a9 with SMTP id m17-20020a056402431100b00451c437a5a9mr26869836edc.272.1664288381543;
        Tue, 27 Sep 2022 07:19:41 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM60r0gclTxsXcEWNa8UNAxfSRZTWGhw5XYosntx/1KSv1YrYaDD9LndA5ig8hu4BYvKJ6Gw7Q==
X-Received: by 2002:a05:6402:4311:b0:451:c437:a5a9 with SMTP id m17-20020a056402431100b00451c437a5a9mr26869819edc.272.1664288381331;
        Tue, 27 Sep 2022 07:19:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id q18-20020a17090676d200b0077f324979absm873812ejn.67.2022.09.27.07.19.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 07:19:40 -0700 (PDT)
Message-ID: <9036da27-32aa-8ae3-9221-45b988d37266@redhat.com>
Date:   Tue, 27 Sep 2022 16:19:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] acerhdf: remove unneeded semicolon
Content-Language: en-US
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, peter@piie.net
Cc:     markgross@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
References: <20220926033311.84765-1-jiapeng.chong@linux.alibaba.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220926033311.84765-1-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/26/22 05:33, Jiapeng Chong wrote:
> ./drivers/platform/x86/acerhdf.c:344:2-3: Unneeded semicolon.
> 
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=2271
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/platform/x86/acerhdf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/acerhdf.c b/drivers/platform/x86/acerhdf.c
> index a7407aa032ba..b48c6c5da147 100644
> --- a/drivers/platform/x86/acerhdf.c
> +++ b/drivers/platform/x86/acerhdf.c
> @@ -341,7 +341,7 @@ static void acerhdf_check_param(struct thermal_zone_device *thermal)
>  		pr_err("fanoff temperature (%d) is above fanon temperature (%d), clamping to %d\n",
>  		       fanoff, fanon, fanon);
>  		fanoff = fanon;
> -	};
> +	}
>  
>  	trips[0].temperature = fanon;
>  	trips[0].hysteresis  = fanon - fanoff;


This patch does not apply on my current for-next branch:

https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=for-next

I guess that this might be based on the thermal-zone changes which are going upstream
for 6.1 through another tree.

Please rebase + resend this once 6.1-rc1 is out.

Regards,

Hans

