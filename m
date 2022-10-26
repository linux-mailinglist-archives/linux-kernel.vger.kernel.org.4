Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F67560E497
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234577AbiJZPer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiJZPen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:34:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718E26D0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666798481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Bk5/l1P1WJsBzjE+AIX4jodlD6n3+SoO3yq57seOT+g=;
        b=JCfqsjCMutkSY3IsifVc3OZI1O5gAD+vH1G0VB1oz40hkvG+rumtXtdLpoIFRSEYvhQQ1i
        dg5JDLS3AR9ho58cdspVMeM02hPAQTEF9SqiMwDMfymw3wOrhpwmz4CUiU3pzydiwHfScG
        nya30lUeybcK1MvpbEnec1sHa/DE2xs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-115-joDZwGFbN2qj5BhMUkM4zQ-1; Wed, 26 Oct 2022 11:34:39 -0400
X-MC-Unique: joDZwGFbN2qj5BhMUkM4zQ-1
Received: by mail-ej1-f71.google.com with SMTP id qb12-20020a1709077e8c00b007a6c5a23a30so3641183ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bk5/l1P1WJsBzjE+AIX4jodlD6n3+SoO3yq57seOT+g=;
        b=NoiU1qBVHdNjnVkq9roYHkrSM4HfJhZEYBrVueQO9WhQyoVTB5NkWmjebNw62N0qUk
         Il8wdU2aipIlRxwySAtvVBXvftWDbyPAmwwzxKNx5sBDtVZtNLP4IJvlAdU1et07Y8Pw
         WZinloksKZCMA9W8B4Lyi0QxwHNJX2L4q7mfY1UE2hGyripdV2mVqUAodX/tLKWG5ka1
         5LnJUny7OuoH/Pq7Bwqy3unTEVV7HxNiu3NC0JQ92GvTviy9JBr7ICcore5ZKMs4Cu2W
         a9g1czmyCbntDv2rnU8UGTSLVZBf5hJWNFY1oOi26/jo3rCAvFWHu4sd1YK10oreCzZv
         lQbA==
X-Gm-Message-State: ACrzQf1u5ttc4kQhAH8t8Kkp0Hp6SYWQREkBZkAV5mn3VI0iqJLOHIxI
        Rx8PmzCjDnNRauQjK0PGK61Ioi8rkHvJiMzqK4jxUtqcKc1SbtSLPYUJoCOGORjtEdGGvuUhOFW
        2AD8E44oyF1Xuke2135/C2uVI
X-Received: by 2002:a17:906:9bc8:b0:7ad:7e6a:50ac with SMTP id de8-20020a1709069bc800b007ad7e6a50acmr3060186ejc.66.1666798478391;
        Wed, 26 Oct 2022 08:34:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Tqza3Pl4lNkWJ5bPEYyIoT8BN17lubrg5b1xiKYtRizsuI5HD6j3De8gqbHdjxFOW/rFRTA==
X-Received: by 2002:a17:906:9bc8:b0:7ad:7e6a:50ac with SMTP id de8-20020a1709069bc800b007ad7e6a50acmr3060174ejc.66.1666798478229;
        Wed, 26 Oct 2022 08:34:38 -0700 (PDT)
Received: from pollux.. ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id r1-20020a1709061ba100b007a9c3831409sm3125296ejg.137.2022.10.26.08.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:34:37 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, liviu.dudau@arm.com, brian.starkey@arm.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next v4 0/4] drm/arm/hdlcd: use drm managed resources
Date:   Wed, 26 Oct 2022 17:34:27 +0200
Message-Id: <20221026153431.72033-1-dakr@redhat.com>
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
  - drop patch "drm/arm/hdlcd: crtc: use drmm_crtc_init_with_planes()"

Changes in v3:
  - Fix alternate return paths in srcu read-side critical sections causing a
    stall when unregistering the driver.
  - Fix potential null pointer dereference in hdlcd_crtc_cleanup() introduced
    dropping the patch in v2.
  - Add a patch to remove explicit calls to drm_mode_config_cleanup().

Changes in v4:
  - Remove patches to protect platform device bound resources with
    drm_dev_{enter,exit}, since this would leave the hardware enabled when
    regularly unloading the driver e.g. via rmmod.
    Instead do this in a later series, once we got drm_dev_unplug() in place
    to deal with a regular driver shutdown.

Danilo Krummrich (4):
  drm/arm/hdlcd: use drmm_* to allocate driver structures
  drm/arm/hdlcd: replace drm->dev_private with drm_to_hdlcd_priv()
  drm/arm/hdlcd: plane: use drm managed resources
  drm/arm/hdlcd: remove calls to drm_mode_config_cleanup()

 drivers/gpu/drm/arm/hdlcd_crtc.c | 24 +++++++------------
 drivers/gpu/drm/arm/hdlcd_drv.c  | 41 ++++++++++++++++----------------
 drivers/gpu/drm/arm/hdlcd_drv.h  |  2 ++
 3 files changed, 32 insertions(+), 35 deletions(-)


base-commit: e1e7bc481d49c3e3ada11029ce0d9b85a0a539d7
-- 
2.37.3

