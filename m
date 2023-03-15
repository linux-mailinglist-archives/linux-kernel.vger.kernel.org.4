Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624C16BAB75
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjCOJDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbjCOJDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:03:01 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FD9738BC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:02:40 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id y14so3914570wrq.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678870958;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTpZF54k+xhywB6mdq1sWhw9d24/H6HoiMghTWdRi8M=;
        b=b7TMtw6j9VNG4+HGhgrsPVgdvOVXTtN7rwuY8+AwPOrzAA++UurS+LCh4uu14Z5VJP
         Xwo2i7nKfSP0+WS7YYT1Gh/BmlW4osTAU3lNe8u/SU1KMLUYzk9Rv8srKHcglfPSU0B6
         /7sdwLW09wxIb8b7hgp2lkDJnGTxupLHFZUdo7+9qkN4oRD96ACbV+oqqUsi4YMStyzi
         ruptsZ7vobD2jSoaN4FCPyZKhNPZd3JOxkQbUgEFyXXcQSbqvqhDrsIfQg/imEgZ2GmC
         +ER1nclVaC8ZvE1u0DAjkwuccwI0tEV6S03q0q6VPRrz2HQWxq+vJR+qPMk4A2Nobov2
         UOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678870958;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTpZF54k+xhywB6mdq1sWhw9d24/H6HoiMghTWdRi8M=;
        b=m6npt1YV5ntsNKevU3Y2weX0ezHcFDvoUd5HC4WCQlsjU45BG74BJo3yrR7E74XhxN
         lSiQaEugp8VkaU/n+vEwLzlGcrD1eQbwHljFbHiNHp5we6qTiHqfwqfMIhP8aL1WDjVv
         gh91zsHLjDhF3YRcbwrUbUdhcQdN9Ol9JOQFwr10fTvqJZ5zXaZTvPDdcAio+x1DLwwf
         O2lcW7AuUslingehZGi7jWnNIj55mqmzhk5H8KwobwkZ2CjirKQr6DvKPVcT7YpKTBJl
         7bxkb9HoKhfjk+mplZdWIO15bJKdmPrLNjDHN27TEdatNBWHWGrlAU595VlvMEo3xClv
         PBzA==
X-Gm-Message-State: AO0yUKWNdfC/dXkv7aLl0v8oRRQx13evdSq0BU18q1Onas+0TV87l/uz
        PXz0U0Vu/QvEKD0Du3nral2rHA==
X-Google-Smtp-Source: AK7set+3V/awLn5LeF8ya6otksI0/6+P1J1OzThA1KAIoKIixtHnkD3dfPQqu7lSmnj98Pv88QlytA==
X-Received: by 2002:adf:dfc6:0:b0:2ce:a8f4:2b01 with SMTP id q6-20020adfdfc6000000b002cea8f42b01mr1216119wrn.32.1678870958383;
        Wed, 15 Mar 2023 02:02:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id f2-20020a0560001b0200b002c57384dfe0sm4113750wrz.113.2023.03.15.02.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 02:02:38 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Liu Ying <victor.liu@nxp.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, andrzej.hajda@intel.com, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@gmail.com, daniel@ffwll.ch
In-Reply-To: <20230313055951.2997299-1-victor.liu@nxp.com>
References: <20230313055951.2997299-1-victor.liu@nxp.com>
Subject: Re: [PATCH] MAINTAINERS: Add include/drm/drm_bridge.h to DRM
 DRIVERS FOR BRIDGE CHIPS
Message-Id: <167887095753.2129381.13470724371681580958.b4-ty@linaro.org>
Date:   Wed, 15 Mar 2023 10:02:37 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Mar 2023 13:59:51 +0800, Liu Ying wrote:
> Appropriate maintainers should be suggested for changes to the
> include/drm/drm_bridge.h header file, so add the header file to the
> 'DRM DRIVERS FOR BRIDGE CHIPS' section.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next-fixes)

[1/1] MAINTAINERS: Add include/drm/drm_bridge.h to DRM DRIVERS FOR BRIDGE CHIPS
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=b28ee4476219b47604b860bd579bd9ce3979a67e

-- 
Neil

