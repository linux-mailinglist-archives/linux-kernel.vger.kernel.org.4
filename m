Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A817D6D94A3
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbjDFLDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236330AbjDFLDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:03:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FB47A9D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680778973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=AB7yfzjEvRHH8TidDe0npRB6+mGa6JkmpE43QroBrFU=;
        b=hunrB7ieYYlW6Navi4d4LCGkvYv5nCfqJml/XkQOuizYLPo7PzGCh9zdrMMQPoZPBQlLmy
        qtfF7tR1qde0ocHn67nvid7n8Bu7h1Zf/Ebq1SYTXSBvkPpddvEqpSVw+tc8gHoMNK58Zx
        qiN+MeXeEe8uQu3WbcQk4sqlUa1O7Sw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-6B8NM9A4Mvul7qj7CoDhRQ-1; Thu, 06 Apr 2023 07:02:52 -0400
X-MC-Unique: 6B8NM9A4Mvul7qj7CoDhRQ-1
Received: by mail-wm1-f72.google.com with SMTP id m5-20020a05600c4f4500b003ee8db23ef9so20025363wmq.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680778971;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AB7yfzjEvRHH8TidDe0npRB6+mGa6JkmpE43QroBrFU=;
        b=ciqOFOvZqfesUFD3wk4GM3sNCgGHba36NYq+R3muvCY3LgGmnnPtaTfaGJc2K2nmDx
         7EFUiFGE+a+v5LRtwBxtjfPQdTbyspcIUgUCXqtvUDOkfpViYPIRk34hkawQoC9tePvN
         7eKD9ZXknO6t9QBayeL9Z/89iVuA68PiqFhXSf68LBilsqYlzRSs3h7ipxMxr2uXcsgm
         /yz93oNo5g9oWQahrEcq8bIdOCXU1sEyWtBYjxV6QGB2uHVp/OgwtHfFkU+iXM7u4QZ6
         /CKPDvV+hNYahkMoLh0ur3iDeoBVTwodL4CyDmmecntQvYayGsqtxGlhHqcPL/MzyWWk
         qLbQ==
X-Gm-Message-State: AAQBX9cUfakRE6+G9UMkx9tHi2llVpQQ7QntyZN0TOMfBDd0GcUxAk3V
        OnOwm+wsZFV8kbocv5iYbSnqj1rqzx3spnXisQCtp+ccs1B4WAIlzqoW0AKrr5lAj0y4DtGfH7/
        LTLZNQKhKfgIkYnlJVv4QL2Epwu+nzcXHDmGo8oTcri9faomw8xy/D3y0gMy3oubwrzoMvZqzNI
        WcUJzA+D4=
X-Received: by 2002:a05:6000:114b:b0:2ca:5c9a:a548 with SMTP id d11-20020a056000114b00b002ca5c9aa548mr6541536wrx.60.1680778971029;
        Thu, 06 Apr 2023 04:02:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350YZGlsDxDnoj90UVq3SMMDRgQ3LgI89wpVhHKxclDtqB1PH2+qbh3D6NTE4BnMgDDroL68gEg==
X-Received: by 2002:a05:6000:114b:b0:2ca:5c9a:a548 with SMTP id d11-20020a056000114b00b002ca5c9aa548mr6541510wrx.60.1680778970731;
        Thu, 06 Apr 2023 04:02:50 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id b6-20020a05600010c600b002d8566128e5sm1472401wrx.25.2023.04.06.04.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:02:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
        Marius Vlad <marius.vlad@collabora.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 0/2] drm/vkms: A couple of trivial cleanups
Date:   Thu,  6 Apr 2023 13:02:33 +0200
Message-Id: <20230406110235.3092055-1-javierm@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series contains two trivial cleanups for the vkms driver.

Patch #1 just gets rid of a wrapper helper that wasn't really adding that
much value and patch #2 drops the <drm/drm_simple_kms_helper.h> header
that was only used to call the drm_simple_encoder_init() function helper.

Best regards,
Javier


Javier Martinez Canillas (2):
  drm/vkms: Drop vkms_connector_destroy() wrapper
  drm/vkms: Remove <drm/drm_simple_kms_helper.h> include

 drivers/gpu/drm/vkms/vkms_output.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)


base-commit: 77d08a2de6a43521f5a02848f11185b6f46af21c
-- 
2.40.0

