Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080045B91B2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 02:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiIOAdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 20:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiIOAco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 20:32:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BFE89CCC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663201960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=hw7ZED2okp8mQvltefC6fsCVEpzJEwtDfN39KXAnS80=;
        b=KL6Kg7+yHgp+pQmVsdBPKQpjx66cjf22fy0dz9dC/MzMmkh5nV7UPpkAiM1xuTvlDhrw77
        7Bq1NPqT9xgkzIhRTaw4523Rskntip6zv/hfBN+kWF6wrHNleWFLxboJAQrNMAxmOd0fSn
        CCdmq0LxQtWZe2eWJ5wGGyYVvqaXXSI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-wwXTQayXO-aOXhgKP1D8_w-1; Wed, 14 Sep 2022 20:32:39 -0400
X-MC-Unique: wwXTQayXO-aOXhgKP1D8_w-1
Received: by mail-ej1-f71.google.com with SMTP id qf40-20020a1709077f2800b0077b43f8b94cso5213276ejc.23
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 17:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=hw7ZED2okp8mQvltefC6fsCVEpzJEwtDfN39KXAnS80=;
        b=RB7Bz7BeOVm1AHKvr9FtWspX96nC4XhyZhv6xiZAd7UqJxrQaBC4ToSCtqTcKMXuME
         P11x+Ic1HYb0NDnT8cdcq5wTfUUUnA5XOiXERFfM7x2e/kR4rxbRIDDNdrPnPRG8cLIM
         H8arVe7zFC9P8U92eRrGxqmgD0QVx+f7jM3aWYYoyLQdyNOjgXQyHn+vxXwafwjrEFb4
         YyhmHK4eqMEhecat49yPwzZekcuEsI9M+CgG/CQjnIWnthMAOZ2MDAJvWepEmWz37bEE
         7qsgBWtKalyd73CdYCUb7cz0EfKb9kgajGBKi0JHl8nJHJSeZlMClk6a/MWPpEcb0GVe
         NFGA==
X-Gm-Message-State: ACgBeo1KcwYo2gn1ao+ntXuba02MzLs8Y5c6bG0oB/RwFUnveXp/18C0
        QjQcxP5L9kFN005pEE8mmfpUdy1JdHmg+qMj+yxF1f+JSMtlrPhDRgIgqGdAOg5VSsYGEXNBRjF
        1A12mm4upQqDoemcYXueDfTMJ
X-Received: by 2002:a05:6402:450c:b0:443:6279:774f with SMTP id ez12-20020a056402450c00b004436279774fmr33329986edb.11.1663201956682;
        Wed, 14 Sep 2022 17:32:36 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7nHZI5XsD9F+qgRoUEGMlldRyh+VMTm0OqtySWAdIM5cFZPuKz7TCcA7Zl5iHzsZT5OuxwcA==
X-Received: by 2002:a05:6402:450c:b0:443:6279:774f with SMTP id ez12-20020a056402450c00b004436279774fmr33329970edb.11.1663201956387;
        Wed, 14 Sep 2022 17:32:36 -0700 (PDT)
Received: from pollux.redhat.com ([2a02:810d:4b40:2ee8:642:1aff:fe31:a15c])
        by smtp.gmail.com with ESMTPSA id p6-20020a17090653c600b007724b8e6576sm8304419ejo.32.2022.09.14.17.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 17:32:35 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@linux.ie, tzimmermann@suse.de,
        mripard@kernel.org, stefan@agner.ch, alison.wang@nxp.com
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-misc-next 0/8] drm/fsl-dcu: use drm managed resources
Date:   Thu, 15 Sep 2022 02:32:23 +0200
Message-Id: <20220915003231.363447-1-dakr@redhat.com>
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

Danilo Krummrich (8):
  drm/fsl-dcu: use drmm_* to allocate driver structures
  drm/fsl-dcu: replace drm->dev_private with drm_to_fsl_dcu_drm_dev()
  drm/fsl-dcu: crtc: use drmm_crtc_init_with_planes()
  drm/fsl-dcu: plane: use drm managed resources
  drm/fsl-dcu: use drm_dev_unplug()
  drm/fsl-dcu: plane: protect device resources after removal
  drm/fsl-dcu: crtc: protect device resources after removal
  drm/fsl-dcu: remove trailing return statements

 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_crtc.c  | 64 ++++++++++++++++-----
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c   | 43 ++++++--------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h   |  4 +-
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_kms.c   | 19 +++---
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_plane.c | 48 ++++++++--------
 drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_rgb.c   |  8 +--
 6 files changed, 108 insertions(+), 78 deletions(-)


base-commit: 961bcdf956a4645745407a5d919be8757549b062
-- 
2.37.3

