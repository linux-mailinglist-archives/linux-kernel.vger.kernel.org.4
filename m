Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702E15F1861
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 03:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbiJABXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 21:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiJABV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 21:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF0E2B62B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664587166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wdNYs4R1bXZF1j2fHdctKVizjm4B3/LsaPspkYayHLg=;
        b=biRxUukSCcKkjIssxdaloMigXsKZ2a31QpzpmWvHUtPmA/e7UBroAN1azwrRwr6RabhrtB
        9HUlMZSBVW2Q5LvH2FDU5DI4KibfhE9+RloAC4/ck6+cDk3PotYGsMI74k0dlrRXgR4b/y
        JsxDvMuIr301qkseyjZy+enE+KgN1w0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-622-TdI-m7q4MeCxCC7fDP_anQ-1; Fri, 30 Sep 2022 21:19:10 -0400
X-MC-Unique: TdI-m7q4MeCxCC7fDP_anQ-1
Received: by mail-ed1-f71.google.com with SMTP id b16-20020a056402279000b0044f1102e6e2so4743255ede.20
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 18:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=wdNYs4R1bXZF1j2fHdctKVizjm4B3/LsaPspkYayHLg=;
        b=sGj5eCJqJkyXKPySCaWYkX6AkZFIJqNIyh5+2a2xRUE/KNoWVMuT2hcZTLqYltgSxf
         94e7uk7w1zEm1uuemJKoa15AKDUWpCTxOSKUgnehPi7Pizm3hxAIIpXEhCnnJ8R4M/x6
         B6267nPNWuvLNTKfoARMPLTxXGqdQNRcgr0DTpLIgQOWbpd40f0GlckmAwcUi2neNuHe
         b8jh8VJerMHdpUwB3lxRguYm3y3X5HQY/HuerHBsHRIv0MREXQ8Dc5aE4Z9hZtpC04bj
         HIMM5x2NYj1xUZVIeHSHZIuyoNKmRYeQiBujKz8Uvt5PsXWEsoQ/bKcqsAn/Akx+LCXb
         6w8g==
X-Gm-Message-State: ACrzQf256qtfIhIubN7MQKSW17LBAcpIbvPYhu9oZ0+W0Ee3JtwC938g
        rWzI7P2OtTTr/Rj2ahskJOZUDatk9qWpCOEWvYBSo1g6RJ7K14M/ogA3gdREVqkoDb3tRQ33mwi
        34N2yTJhSg0k9KfyjGWotq1Vc
X-Received: by 2002:a05:6402:493:b0:445:b5f0:7a0f with SMTP id k19-20020a056402049300b00445b5f07a0fmr9717242edv.120.1664587149236;
        Fri, 30 Sep 2022 18:19:09 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5r+fvRRbozeqSmGuL4DdbQm6Wcqo6l8koGDcwHtEbf+YfhfpQQbmvdhWAdhseet4Oim1KQBw==
X-Received: by 2002:a05:6402:493:b0:445:b5f0:7a0f with SMTP id k19-20020a056402049300b00445b5f07a0fmr9717233edv.120.1664587149085;
        Fri, 30 Sep 2022 18:19:09 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id n15-20020a056402514f00b00458b41d9460sm327502edd.92.2022.09.30.18.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 18:19:08 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 0/7] drm/arm/hdlcd: use drm managed resources
Date:   Sat,  1 Oct 2022 03:18:58 +0200
Message-Id: <20221001011905.433408-1-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v3:
  - Fix alternate return paths in srcu read-side critical sections causing a
    stall when unregistering the driver.
  - Fix potential null pointer dereference in hdlcd_crtc_cleanup() introduced
    dropping the patch in v2.
  - Add a patch to remove explicit calls to drm_mode_config_cleanup().

Danilo Krummrich (7):
  drm/arm/hdlcd: use drmm_* to allocate driver structures
  drm/arm/hdlcd: replace drm->dev_private with drm_to_hdlcd_priv()
  drm/arm/hdlcd: plane: use drm managed resources
  drm/arm/hdlcd: use drm_dev_unplug()
  drm/arm/hdlcd: crtc: protect device resources after removal
  drm/arm/hdlcd: debugfs: protect device resources after removal
  drm/arm/hdlcd: remove calls to drm_mode_config_cleanup()

 drivers/gpu/drm/arm/hdlcd_crtc.c | 84 ++++++++++++++++++++++++--------
 drivers/gpu/drm/arm/hdlcd_drv.c  | 55 ++++++++++++---------
 drivers/gpu/drm/arm/hdlcd_drv.h  |  2 +
 3 files changed, 98 insertions(+), 43 deletions(-)


base-commit: 08fb97de03aa2205c6791301bd83a095abc1949c
-- 
2.37.3

