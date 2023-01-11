Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED96666267
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjAKSDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbjAKSDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:03:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC41FCE4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673460136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pY9wjzOlET6NgpsLk7OxHRJG44T8VHI0VhpQAw4fLs8=;
        b=MW0y4uEnfz+f16PvnNckXW3xhh7HGloEMLkTLfYQiaEU5toFP54g2MuLfXGXvlBfPnky13
        TzVUTZGpcSCExwQHkY4+deW9QBnz5WyDq1bDhZcwPVTW7Wa0FWr7RkKrO9dvUWUG6shU3S
        s1JtAaJw6BiUYR/UTy4J0rihMY29KKI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-612-EMgXHVSKPdCahUkFNMuvNw-1; Wed, 11 Jan 2023 13:02:15 -0500
X-MC-Unique: EMgXHVSKPdCahUkFNMuvNw-1
Received: by mail-wr1-f69.google.com with SMTP id u4-20020adfc644000000b002ad64393461so2951093wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pY9wjzOlET6NgpsLk7OxHRJG44T8VHI0VhpQAw4fLs8=;
        b=st1M99fiJdjn5KRPZaaxVf9jeMdIi1GSAANcwdMSh+aT0CHD7qKWpUCCGbIuCnzbti
         n4RrBjlOyG9XEJC4MveVeF8VYzprYtI15kDnDwHVU0GfjVbRfel+Cowwg2W/0Q1y3Loi
         mA+e/vZNT1RIRi/wrpH8E2bJdPttl082EXClNrCsJfkLbdt1KjW9MOJdyorXcSOXS/RU
         D/+2wvz6ibCCZND548OfD4FB9k+e25QeLtXogAf/EGAfT7GDbwJPD5fJq5ZlKh7p9D6L
         I6aheyDvnTtPhBrp3+0M2mcntSACN+ia8gj/UOpx0Qf6XzGk/IspnkXgS+78GOSyOeqF
         ILcA==
X-Gm-Message-State: AFqh2kq6L69T3eArjsE+1xnXERkzYwfeZkG1ghxq3txqCoC7oB3GVsuT
        73aR1a2mC3OohZpoTJzn6cYQ54xLJdP6liX1RiXpBHduywAwifVLDhb6yEb5HbRJ4wUoYbSbIpX
        SUhcdVX19vsOGeqaZY8HOyfxzJoUtZr1Fp4al/2I+IpZTAo35bairbggbXmFuJx3y9qAC3eSBtS
        g=
X-Received: by 2002:a5d:534e:0:b0:2bb:6d44:5d1 with SMTP id t14-20020a5d534e000000b002bb6d4405d1mr10835410wrv.28.1673460133609;
        Wed, 11 Jan 2023 10:02:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvEAnBAgxxVJFKjZj6KyuVimR0Aghe3ogMbbBk5im+gWTyBWJFPn6ki5yeX9EmsP5c4UpCvmg==
X-Received: by 2002:a5d:534e:0:b0:2bb:6d44:5d1 with SMTP id t14-20020a5d534e000000b002bb6d4405d1mr10835388wrv.28.1673460133362;
        Wed, 11 Jan 2023 10:02:13 -0800 (PST)
Received: from [192.168.1.130] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m13-20020adfe94d000000b002714b3d2348sm14400789wrn.25.2023.01.11.10.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 10:02:13 -0800 (PST)
Message-ID: <75725b53-2df4-1cbf-5a78-60e491757d9f@redhat.com>
Date:   Wed, 11 Jan 2023 19:02:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 00/13] drm/panel: Make panel drivers use existing DSI
 write macros
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        =?UTF-8?Q?Guido_G=c3=bcnther?= <agx@sigxcpu.org>,
        Ondrej Jirman <megous@megous.com>,
        Purism Kernel Team <kernel@puri.sm>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20230107191822.3787147-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20230107191822.3787147-1-javierm@redhat.com>
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

On 1/7/23 20:18, Javier Martinez Canillas wrote:
> Hello,
> 
> This series contains cleanups for DRM panel drivers that define their own
> DSI write macros instead of using what's already in <drm/drm_mipi_dsi.h>.
> 
> This is a v2 that addresses issues pointed out by Sam Ravnborg in the v1:
> 
> https://lore.kernel.org/lkml/20221228014757.3170486-1-javierm@redhat.com/
> 
> The changes are quite trivial but I've only tested this with allmodconfig
> and `make M=drivers/gpu/drm/panel/` so please review and testing would be
> highly appreciated.
> 

Pushed this to drm-misc (drm-misc-next). Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

