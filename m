Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9D160E517
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 18:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbiJZQAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 12:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiJZP74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:59:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F552A449
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666799983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qgreuePZp+4AtHTNoAATRGXVf37qFz6VqTZ1TsIsSCk=;
        b=B67Ui64x5q3x7RSkOesjOozZiCVPINYHtPt2+l55G8pXRj5t5Dl7jrh1F/JbgqN+BrcKdN
        N7k0DPSUo8Rnjc42UF0mNM9pQmmq78OB9u9hxY9+ydXyu90kEyRm5e9Rbuu1Z2g2KHanqc
        afw44j12x0mFv2HaSuqvofOm7yf8ksg=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-311-KwnlF-61N3WSE1q9gOnApg-1; Wed, 26 Oct 2022 11:59:41 -0400
X-MC-Unique: KwnlF-61N3WSE1q9gOnApg-1
Received: by mail-ej1-f72.google.com with SMTP id hp41-20020a1709073e2900b0078e07dbf280so4753067ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qgreuePZp+4AtHTNoAATRGXVf37qFz6VqTZ1TsIsSCk=;
        b=it26AbCjKzjltTR+X1EfXZiHpckU8w/g6mEp7fDe8L61MpX8zsZl7eJP1j2sDHd344
         l1IKn2UXozN4sF4GPhv6VOC93vbv0CiBkXUXcuh8sYTeqZt+Gk6HIFRpHgRJSQnmPvWk
         UL6Y4vT9T3NuUBEgHWS4tmpYsgvTGBpC4CGjgp++Bx/Yu/HiIqxY5YNphxyjp6ppT6NN
         rh6CR7f8rUJcq6jsyinuRI2Zfp77jqBCeKmlbInsoerdxjgz8swwmXlGKdpE+yN+RkBZ
         Mv3ybp7jC58Lfiat1ReYkBLKdd4gKksXYpNDUTVokR6hy0roNIxvCD1In/XW8vRypf7Y
         gA3A==
X-Gm-Message-State: ACrzQf2PRsScbd5EvLhBW1+MNH5u0svqLuzpxmQNcQM9SST2FYfkoUT9
        rb0Y+uKLzA2e8DfBrT5Ly1DGP7DlhqfE+VcqdeZmL+is3Aw0b6PaT+bV/sGtg4qOc4IvyewQTW8
        fwYl4rSeCK5S5/+uMWWQXwEtd
X-Received: by 2002:a17:907:6e18:b0:78d:b374:8989 with SMTP id sd24-20020a1709076e1800b0078db3748989mr37902973ejc.552.1666799980691;
        Wed, 26 Oct 2022 08:59:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4nFY1b7F7PXIeIa9vbku1XcB89X6nlx28mnFIdln+HRp8pTaHGtsxr4DiRXOYLY2Ek4SMHlA==
X-Received: by 2002:a17:907:6e18:b0:78d:b374:8989 with SMTP id sd24-20020a1709076e1800b0078db3748989mr37902957ejc.552.1666799980484;
        Wed, 26 Oct 2022 08:59:40 -0700 (PDT)
Received: from pollux.. ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709066d1300b0078d4c72e2cesm3119035ejr.44.2022.10.26.08.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:59:39 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v3 0/5] drm/arm/malidp: use drm managed resources
Date:   Wed, 26 Oct 2022 17:59:29 +0200
Message-Id: <20221026155934.125294-1-dakr@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
  - While protecting critical sections with drm_dev_{enter,exit} I forgot to
    handle alternate return paths within the read-side critical sections, hence
    fix them.
  - Add a patch to remove explicit calls to drm_mode_config_cleanup() and switch
    to drmm_mode_config_init() explicitly.

Changes in v3:
  - Remove patches to protect platform device bound resources with
    drm_dev_{enter,exit}, since this would leave the hardware enabled when
    regularly unloading the driver e.g. via rmmod.
    Instead do this in a later series, once we got drm_dev_unplug() in place
    to deal with a regular driver shutdown.

Danilo Krummrich (5):
  drm/arm/malidp: use drmm_* to allocate driver structures
  drm/arm/malidp: replace drm->dev_private with drm_to_malidp()
  drm/arm/malidp: crtc: use drmm_crtc_init_with_planes()
  drm/arm/malidp: plane: use drm managed resources
  drm/arm/malidp: remove calls to drm_mode_config_cleanup()

 drivers/gpu/drm/arm/malidp_crtc.c   |  7 ++-
 drivers/gpu/drm/arm/malidp_drv.c    | 69 +++++++++++------------------
 drivers/gpu/drm/arm/malidp_drv.h    |  2 +
 drivers/gpu/drm/arm/malidp_hw.c     | 10 ++---
 drivers/gpu/drm/arm/malidp_mw.c     |  6 +--
 drivers/gpu/drm/arm/malidp_planes.c | 32 ++++---------
 6 files changed, 48 insertions(+), 78 deletions(-)


base-commit: e1e7bc481d49c3e3ada11029ce0d9b85a0a539d7
-- 
2.37.3

