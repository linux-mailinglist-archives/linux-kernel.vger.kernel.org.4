Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A5663E059
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbiK3S57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiK3S54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:57:56 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA7D6391FD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:57:54 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id w4-20020a17090ac98400b002186f5d7a4cso2918299pjt.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z9DRDfpuTxto0btyiBvLDBo0aAmHRlVAsle+L4IM7HE=;
        b=PNKkuryiCC03qi+nHXcczRpXoF+nnLD7QfK0NQGrVsLuscMwK3SS/+uPmUEr4pihne
         6ziHKGf3eqaB7fhkicVYQ9juKQeuQLPXHGgJqd2H6Fdu42vH43vrhkWyjAhR8Uoqfy2B
         yheasy/gYoQtCuBXKCb50oRutjSO53IBmuWM1ovrTYsf+tKYbhtsp7XiiL2rqcoXBsza
         b8DONcpKHUaPu8oG9L826eoSdO6GwP/0t2n9v5w9zDPUSUcaYwVnpGuT22ialgvsvReD
         eQX9wmLQjzit7nhIzaX7BAVxZy2OGc+nLFG7t5ZHcAWkT9uWEKciIvwgkZuFYBY2zstD
         pflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9DRDfpuTxto0btyiBvLDBo0aAmHRlVAsle+L4IM7HE=;
        b=SWxHsiME2ow80psjsfaOOr3Urm3wSiGP6hoNIMn8fePe8gzfQd1XhRGghQkMqkMS6e
         HC26ht+4fMY729RezfM6uKQUZluRlRYizedNUcb+Vq1rAr/rA39bSCbR1172nd+EdrsD
         piQN0/jggLSSwzGoanP1EK7TDvV4lEH66EStDac5rq9yKAmwpsb596DdbPFplT5KN2YA
         HcXF/nPH6pdRRf4pyqzK1APloPAotWROq3dEW0YM4XgqvUDOx2gupP0wJy1CnRs3vXoN
         x70x46QRoNPu0U+80EpiDpslTzLgpaFPdN6sEmKOOVknXcvByrhOHibDAROuUNGybYRy
         +z0g==
X-Gm-Message-State: ANoB5pnfoRSG3l+nu0uaQtWm7eyGnYce1Sk2sRwaJOWmiTkvg08d+Ywg
        A98TjZg7rPZCHCQ+sHK/xrw=
X-Google-Smtp-Source: AA0mqf42JG08PNHd3GskrjsNXuBk82rU6G24g+oLq5XewpXThxHwnd2fOBjGFYoRFhoBajyJ4p6Puw==
X-Received: by 2002:a17:902:e351:b0:189:6623:4c09 with SMTP id p17-20020a170902e35100b0018966234c09mr28576736plc.150.1669834674433;
        Wed, 30 Nov 2022 10:57:54 -0800 (PST)
Received: from localhost ([2a00:79e1:abd:4a00:2703:3c72:eb1a:cffd])
        by smtp.gmail.com with ESMTPSA id y6-20020a170902b48600b0018982bf03b4sm1826768plr.117.2022.11.30.10.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:57:53 -0800 (PST)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Rob Clark <robdclark@chromium.org>,
        Eric Anholt <eric@anholt.net>,
        linux-kernel@vger.kernel.org (open list),
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 0/2] drm/shmem-helper: Fix a couple of error path bugs
Date:   Wed, 30 Nov 2022 10:57:46 -0800
Message-Id: <20221130185748.357410-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

A couple fixes for error paths that userspace could manage to trigger.

Rob Clark (2):
  drm/shmem-helper: Remove errant put in error path
  drm/shmem-helper: Avoid vm_open error paths

 drivers/gpu/drm/drm_gem_shmem_helper.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

-- 
2.38.1

