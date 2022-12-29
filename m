Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4D9658DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbiL2Obt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiL2Obq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:31:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 863A1DF45
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672324259;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iyDuPw9BfhAfsJqj1LLBmM52knl5cpyM0AV0SoAQzf4=;
        b=Xp+DPU+/eaeMzQqPs1pvjfFLeCPIfZNCifInq3hNwae5ka8jHpUeuy6XamzE+iiGV6sEHZ
        KaXOBcT9GmYgK5LsnKQv/Wxi9ZDTCIMRDvWJ2lgdj/STtnwCnba7KgrLA/wicUzZpW9Wix
        uzgORT7Ziyj+6tcehYyWHOaHbL552JI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-489-GeOe5VV2OuSacpE3OO-4SQ-1; Thu, 29 Dec 2022 09:30:58 -0500
X-MC-Unique: GeOe5VV2OuSacpE3OO-4SQ-1
Received: by mail-wm1-f69.google.com with SMTP id bi18-20020a05600c3d9200b003d991844dbcso3234094wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 06:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iyDuPw9BfhAfsJqj1LLBmM52knl5cpyM0AV0SoAQzf4=;
        b=xi6CTt9Wg/X5CmPisjYutOGFqLBJUweb2gdKnakyjsvyJQ/J5gg+d5F0YK/WwGwGVc
         7ovND6D+Qr/uPYFBc8zHPVYnyDO/FJGzZSY/RL5B1a+7KYZRUEeid7QYr9wS2o9TlN5a
         i5GQ3ZEIoQh1fgvffA7TxSU+N522lfxySKQiA6ESOrfDGuohYPEm7swDd+FagyxJWWpO
         7JVL6hrx/qlDrRmIivBgsNLjm48RlXAp5034MFRLs9afL7rj1vVRkRTeZKac+0AKsIxq
         cN+YibpSVcaZqlVR8HuZqbtNm2H4sSkU3ejqx4JApHSikG3ujruBSomlApgwjsLfrEES
         NRcg==
X-Gm-Message-State: AFqh2kp1a8Ave63XJv4prUXUz4VAdYbYEOXLyV0xduNv1PXNlc2pAZ4+
        lBS3JeytJp6ZzYb2VOu+9eFfxPnWIf1RILRyd8qk1lrXzp9C5SaHwBEtJb/nR4eTFyc9t3GfxL8
        mbfSjjdjjnCLl9yIovPsOWTIq
X-Received: by 2002:a05:600c:500a:b0:3d3:5b56:b834 with SMTP id n10-20020a05600c500a00b003d35b56b834mr20258814wmr.5.1672324257052;
        Thu, 29 Dec 2022 06:30:57 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu7jq2MqHRR2Qf7hZNRLxPrxMP+dHZZmm1DOclVneqxdq6tN99CJ+oQPMkRcoN+zvTQ2QD3pg==
X-Received: by 2002:a05:600c:500a:b0:3d3:5b56:b834 with SMTP id n10-20020a05600c500a00b003d35b56b834mr20258803wmr.5.1672324256815;
        Thu, 29 Dec 2022 06:30:56 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id r9-20020a05600c35c900b003d96bdddd3dsm26127449wmq.15.2022.12.29.06.30.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Dec 2022 06:30:55 -0800 (PST)
Message-ID: <7e527370-5c10-e908-c143-d33ebe69a3a0@redhat.com>
Date:   Thu, 29 Dec 2022 15:30:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 03/14] drm/panel-sitronix-st7703: Drop custom DSI write
 macros
Content-Language: en-US
To:     =?UTF-8?Q?Guido_G=c3=bcnther?= <guido.gunther@puri.sm>
Cc:     linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Ondrej Jirman <megous@megous.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20221228014757.3170486-1-javierm@redhat.com>
 <20221228014757.3170486-4-javierm@redhat.com>
 <Y6wwLdvhjUeTYSlQ@qwark.sigxcpu.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Y6wwLdvhjUeTYSlQ@qwark.sigxcpu.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Guido,

On 12/28/22 13:01, Guido Günther wrote:
> Hi Javier,
> Could you please also cc maintainers on the actual macro addition since
> it's hard to review without seeing what the code gets changed to
> (especially when there's multiple revisions). I assume
>

Sure, I will do it if post another revision. Although the changes are quite
trivial and all the drivers define basically the same macro so no functional
changes are expected.
 
>    https://lore.kernel.org/dri-devel/20221228014757.3170486-2-javierm@redhat.com/
> 
> is the right one?

Correct.

> Cheers,
>  -- Guido
> 
-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

