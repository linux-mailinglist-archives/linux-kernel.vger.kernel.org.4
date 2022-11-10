Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E281862436C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiKJNme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:42:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiKJNmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:42:33 -0500
X-Greylist: delayed 2543 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 05:42:31 PST
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8689D31379
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=CZcNVqk8g0KSBhUkHK8jBepdav+GnxjrdTrEFAD5npc=; b=hjFFxIsGFN79BXqIS1Crj19qI/
        /s46Ipu4kc9GHOn8iSyndnI/QJZvzLmLk9GcEpZyVJUtPwmCiLITMSdQk9cCkfTJDUDgaQV+tAkdr
        5v66hVVTrzJ3stkcqg9+u+g7OiXbRkIlBH22hub2aYlJjdc9uduRXMiLjVRA85U2V/tJwOH545Rw3
        ZIFtBZNuS+EcLCR9xnzK56CejdPpXtLGrOSp+YZ5NwKVXMLGq31alJykB6OFr9n16/gpkWQw2TY5u
        WnvgM/b7WAB0Zqh1v2LNXTkQX/Kow40L/0GoeeYVTPH1AY2FCSAvPP6M/7oSDYb6yA9gA0yFz+Pxb
        yFc/5F+A==;
Received: from [186.214.225.177] (helo=[192.168.15.50])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ot7A0-00FVOM-Nr; Thu, 10 Nov 2022 14:00:01 +0100
Message-ID: <335b511f-ecfd-6e83-ef2e-7a74c8293b00@igalia.com>
Date:   Thu, 10 Nov 2022 11:59:54 -0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2 0/2] Balance mutex_init and mutex_destroy calls
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>,
        Emma Anholt <emma@anholt.net>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>,
        "Juan A . Suarez" <jasuarez@igalia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221108175425.39819-1-mcanal@igalia.com>
From:   Melissa Wen <mwen@igalia.com>
In-Reply-To: <20221108175425.39819-1-mcanal@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/8/22 16:54, Maíra Canal wrote:
> This series introduces some changes to assure the correct resource release on
> the V3D driver, especially the mutex. Currently, the V3D has no mutex_destroy()
> calls, which means that a mutex is being instantiated, but it is not being
> released by the end of its use.
>
> So, use the DRM-managed mutex_init variants when possible to manage the mutex
> release and add mutex_destroy() calls when not possible.
>
> Best Regards,
> - Maíra Canal
>
> v1 -> v2: https://lore.kernel.org/dri-devel/20221107224656.278135-1-mcanal@igalia.com/T/#m3c23e3f21fe6aaae51138c746c74e94b2a7b3bfc
>
> - Move mutex_destroy() to v3d_perfmon_put() (Daniel Vetter).
> - Add mutex_destroy() on error case in v3d_perfmon_create_ioctl() (Daniel Vetter).
> - Add Daniel Vetter's tags.

Applied to drm-misc-next.

Thanks,

Melissa

>
> Maíra Canal (2):
>    drm/v3d: switch to drmm_mutex_init
>    drm/v3d: add missing mutex_destroy
>
>   drivers/gpu/drm/v3d/v3d_gem.c     | 17 +++++++++++++----
>   drivers/gpu/drm/v3d/v3d_perfmon.c |  6 +++++-
>   2 files changed, 18 insertions(+), 5 deletions(-)
>
