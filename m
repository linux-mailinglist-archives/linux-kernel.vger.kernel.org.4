Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29C85B7CE3
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiIMWPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiIMWPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EE71209B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663107302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QkRwvxkxuZTjDo6IP2NnlgO32UW0G4L0LhzpMPjt8ng=;
        b=eDuwHMAHvWmPE0QfkV633Ix2WDTo2CshWccGCgBF35x4CiR/xjfLkOJjmB29iTv6IzkGgC
        cTUrDZguR0KpCjLm7RuYs7EqFjTM0HTgayOdRn58Yqff3oHLgT6kM22gMaI16ib/cZQ44G
        01pbFMauREXcuyMyz7qQpeWvH7F72Pg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-_O2XO5okP2Gb8CPNc2BjBA-1; Tue, 13 Sep 2022 18:15:01 -0400
X-MC-Unique: _O2XO5okP2Gb8CPNc2BjBA-1
Received: by mail-ej1-f72.google.com with SMTP id hr12-20020a1709073f8c00b0077e8371f847so3018823ejc.20
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QkRwvxkxuZTjDo6IP2NnlgO32UW0G4L0LhzpMPjt8ng=;
        b=CcgEao91Z4tIx3hL36fjWNpzt30VE4VQlz8LIniwylxbIAKhJMFPysIZ+7RzLO63Rt
         ZntqfCRocjiW5e4RCJEZwwCGWUwNYh6QoTkWS/HVTNhzgY2x7Q6fj0ipmjPIn78hsMOp
         WeLLRGJLdwf84Kq2SrhKVdJY15AGpddrQlR/XxAftIMs5JkQlVMo902Sio6spYpDYIAa
         y4ux+WLYinnHa2EyAey+Xr4KYJtgsgC0dhOuimQsjwsjv2wZIugDB6NlbE3VZwW/vl+Z
         8hTgbI/lcn5/wkFP4YGpeGtxRU6JfQnU2QTfgnkIbd8Amrj9VSWSsTz/Sh27RHtHwfyJ
         HVWQ==
X-Gm-Message-State: ACgBeo1LmwR5nwSi3NYdZt7Rrg+xFQlIpFYaDK/ZKlla5Qa/p3NNNdbP
        Oqp99Hg+R1bfgrwr10ly2RkzK9c3AG4N6FrVD9TdCRiasiXhT2Q9luj0nO7yvLo/JCyVlv2IG9t
        2/GNjTytqrqkfpeYSbHbtUoo3
X-Received: by 2002:a17:906:974d:b0:780:2c07:7617 with SMTP id o13-20020a170906974d00b007802c077617mr567154ejy.707.1663107300116;
        Tue, 13 Sep 2022 15:15:00 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5jydPgHVu9oBy62e7em4JC2Tq4/WiNSDgZNWnV9jpoLtxkk4Svofq01XCc7D1WMANcOytpmw==
X-Received: by 2002:a17:906:974d:b0:780:2c07:7617 with SMTP id o13-20020a170906974d00b007802c077617mr567144ejy.707.1663107299961;
        Tue, 13 Sep 2022 15:14:59 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id ep19-20020a1709069b5300b0073093eaf53esm6615666ejc.131.2022.09.13.15.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 15:14:59 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v2 0/6] drm/arm/hdlcd: use drm managed resources
Date:   Wed, 14 Sep 2022 00:14:50 +0200
Message-Id: <20220913221456.147937-1-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series converts the driver to use drm managed resources to prevent
potential use-after-free issues on driver unbind/rebind and to get rid of the
usage of deprecated APIs.

Changes in v2:
  - drop patch "drm/arm/hdlcd: crtc: use drmm_crtc_init_with_planes()"

Danilo Krummrich (6):
  drm/arm/hdlcd: use drmm_* to allocate driver structures
  drm/arm/hdlcd: replace drm->dev_private with drm_to_hdlcd_priv()
  drm/arm/hdlcd: plane: use drm managed resources
  drm/arm/hdlcd: use drm_dev_unplug()
  drm/arm/hdlcd: crtc: protect device resources after removal
  drm/arm/hdlcd: debugfs: protect device resources after removal

 drivers/gpu/drm/arm/hdlcd_crtc.c | 76 ++++++++++++++++++++++++--------
 drivers/gpu/drm/arm/hdlcd_drv.c  | 36 ++++++++-------
 drivers/gpu/drm/arm/hdlcd_drv.h  |  2 +
 3 files changed, 79 insertions(+), 35 deletions(-)


base-commit: 75cebd664d57a78af3e46c14bd2659df0a08847b
-- 
2.37.3

