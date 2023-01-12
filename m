Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB35667E49
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240214AbjALSku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240252AbjALSkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:40:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE6F69B2A
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673547167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/kFle39ydkxIvTqDbjiQ26mYZY/ipPx5AO1Q9J7N87Q=;
        b=YxBFfiiquVmKpjTSrQQxGOYPy9ilwpRaOe+NW76CuRM7j2fcWhSvTzDtOjO2BhiMMJYZ61
        vgv8p9i59zlsaCXPt7jiQKYNFQ93bwTs71rkzvyEwpC+INzuvJwP2Q0cuP+sAoqjn8rcmZ
        O4mSvh/qeETr5W4dtziByss5CmK+JPY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-422-fWnjr7-mMKquoXI43X69wQ-1; Thu, 12 Jan 2023 13:12:45 -0500
X-MC-Unique: fWnjr7-mMKquoXI43X69wQ-1
Received: by mail-ed1-f70.google.com with SMTP id r14-20020a05640251ce00b0047d67ab2019so12794004edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:12:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/kFle39ydkxIvTqDbjiQ26mYZY/ipPx5AO1Q9J7N87Q=;
        b=JdFIC2fSLqBQUnd53v/+PMKIZfvlRk+xF87yLsMFQ1bHWrUZ3BNIA2FiJmWjZn+6Dk
         sbr3DbSgdicaehPS+2Xye6aQd6wF7mcsuktF9uu8SA92ypq9OKputQ+/+65qLru6DR9X
         4hudEXdfXbHEGdKTpVuS9dWucsyY+KhrWu377lUannzPMnleaaB0x+bpAff3/QsWUoKV
         vErvvBSImatu8D8rRFnJQsWOpJOa8wxLon3PceORaXg1O3TY+3o1bFtXt1JG4RIGmqYJ
         x2CIexFh8lt1thSQ5ZDrcbUGm/pP/sSDZljtaNTmGzvj1yzRLMTWZAJvSyOFAXe6j/b0
         vHGw==
X-Gm-Message-State: AFqh2krmbO7XBf9G473vkh+iids/3YhuC5oWggVDQ8t8uaL7IiffNHzF
        rftk+pHIbffUgth59MbAjcPQAdiY6+0l1LMMtcMv+E4N7TeaP0Hg9ek3N7gW3yLhnysUF9IQX2D
        BMHffkW60U/jIA5BBH9jsvTWD
X-Received: by 2002:a50:a401:0:b0:46d:53d7:d21e with SMTP id u1-20020a50a401000000b0046d53d7d21emr70239818edb.27.1673547164859;
        Thu, 12 Jan 2023 10:12:44 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuocr0pZgktu2TVwsiNIJg76I42JC16Cs3Nyl/sxnH2yKH0FUdToUA61TD+NVTw1OYVtpCUWA==
X-Received: by 2002:a50:a401:0:b0:46d:53d7:d21e with SMTP id u1-20020a50a401000000b0046d53d7d21emr70239806edb.27.1673547164684;
        Thu, 12 Jan 2023 10:12:44 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u9-20020aa7d889000000b00457b5ba968csm7424462edq.27.2023.01.12.10.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 10:12:44 -0800 (PST)
Message-ID: <8aa95d69-7231-0a9a-93aa-dbb5286a4731@redhat.com>
Date:   Thu, 12 Jan 2023 19:12:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] platform/surface: aggregator: Add missing call to
 ssam_request_sync_free()
Content-Language: en-US, nl
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221220175608.1436273-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221220175608.1436273-1-luzmaximilian@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/20/22 18:56, Maximilian Luz wrote:
> Although rare, ssam_request_sync_init() can fail. In that case, the
> request should be freed via ssam_request_sync_free(). Currently it is
> leaked instead. Fix this.
> 
> Fixes: c167b9c7e3d6 ("platform/surface: Add Surface Aggregator subsystem")
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans

> ---
>  drivers/platform/surface/aggregator/controller.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/aggregator/controller.c b/drivers/platform/surface/aggregator/controller.c
> index 43e765199137..c6537a1b3a2e 100644
> --- a/drivers/platform/surface/aggregator/controller.c
> +++ b/drivers/platform/surface/aggregator/controller.c
> @@ -1700,8 +1700,10 @@ int ssam_request_sync(struct ssam_controller *ctrl,
>  		return status;
>  
>  	status = ssam_request_sync_init(rqst, spec->flags);
> -	if (status)
> +	if (status) {
> +		ssam_request_sync_free(rqst);
>  		return status;
> +	}
>  
>  	ssam_request_sync_set_resp(rqst, rsp);
>  

