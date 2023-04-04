Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7146D55FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 03:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjDDB2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 21:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbjDDB2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 21:28:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B60C4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 18:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680571676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qy5D/ZZ0dwag1BT8hM3evEqOdQXhrzVTN7mL8aXSMGo=;
        b=bUxs+PFGo4AlzpQjpN8Wql3VNehMvI6WPQLFoa+Wyc1AyjN9TtIS4O3X9JCei27gYG2lao
        2IKQlC9v3Ha3bTLUrBb4WvH2ukgB2KvTPj7q/hj0hBOwQhmVOgYbw9a+9DBtHWFGcCH2K8
        l5rb2yfpk7C2KOp06wvXtdcvebZoQK4=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-1scEHFkRO3Cjh-fIUmpAGw-1; Mon, 03 Apr 2023 21:27:55 -0400
X-MC-Unique: 1scEHFkRO3Cjh-fIUmpAGw-1
Received: by mail-ed1-f70.google.com with SMTP id k30-20020a50ce5e000000b00500544ebfb1so43368898edj.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 18:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qy5D/ZZ0dwag1BT8hM3evEqOdQXhrzVTN7mL8aXSMGo=;
        b=Xvd4tdnwOmPEHJim0fXAUCO/XYpdi4ok68cbTdiwNBHSL6IcYmtjwMuNT12H0OvmK8
         PeAWogJHkFC1PW8YMuSzzm6uAGEwYUWP+BUFGKIyRydwCx1mAyZp25h+z5prMGclAkgz
         0JVygKeRZxj1ui2V/PHugw7OSPZ7zZ2qAFePw3hxx21zXeIr7hBiRYsEG4wIt4QCRr20
         jUGk8fHCTZODyqbsSS4DKdx2XUCZNWrvKeQPaZEil9areQIrit/rUDKeTQ3Ut/1ZjWKu
         2km8Pc8gporvOmo3v4H+HC+RNQKGCqWIVFtf3NnhJSkWhknro/odJLF/G/KbkXO1WGC6
         WK1w==
X-Gm-Message-State: AAQBX9fjHiBve2BcMX3pWCnH/LJVL8RbPJv0xFNjtpnqADEj9JskXVU7
        d6fJJoU5+YFB84axv4r8dyUM3iEgv8MduHI6iF1QeUohR0B9y7rbPm2UkjUpNwvtb85oMYyrTgs
        UxtknODIBHOTwRtdg3JzM2mQ/
X-Received: by 2002:a17:906:4dc1:b0:8b0:ad0b:7ab8 with SMTP id f1-20020a1709064dc100b008b0ad0b7ab8mr537822ejw.14.1680571674352;
        Mon, 03 Apr 2023 18:27:54 -0700 (PDT)
X-Google-Smtp-Source: AKy350aYg00eHiyswbtoLlF56sjeND5GW8MPldJF2FDkJFmQJWCtDChMw3C466wihCFb4E1/7woEmA==
X-Received: by 2002:a17:906:4dc1:b0:8b0:ad0b:7ab8 with SMTP id f1-20020a1709064dc100b008b0ad0b7ab8mr537795ejw.14.1680571674124;
        Mon, 03 Apr 2023 18:27:54 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id mh13-20020a170906eb8d00b00931024e96c5sm5222682ejb.99.2023.04.03.18.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 18:27:53 -0700 (PDT)
From:   Danilo Krummrich <dakr@redhat.com>
To:     airlied@gmail.com, daniel@ffwll.ch, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net, christian.koenig@amd.com,
        bskeggs@redhat.com, Liam.Howlett@oracle.com,
        matthew.brost@intel.com, boris.brezillon@collabora.com,
        alexdeucher@gmail.com, ogabbay@kernel.org, bagasdotme@gmail.com,
        willy@infradead.org, jason@jlekstrand.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next v3 02/15] drm_exec: fix double dma_resv unlock
Date:   Tue,  4 Apr 2023 03:27:28 +0200
Message-Id: <20230404012741.116502-3-dakr@redhat.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404012741.116502-1-dakr@redhat.com>
References: <20230404012741.116502-1-dakr@redhat.com>
MIME-Version: 1.0
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

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index df546cc5a227..f645d22a0863 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -62,7 +62,6 @@ static void drm_exec_unlock_all(struct drm_exec *exec)
 	}
 
 	if (exec->prelocked) {
-		dma_resv_unlock(exec->prelocked->resv);
 		drm_gem_object_put(exec->prelocked);
 		exec->prelocked = NULL;
 	}
-- 
2.39.2

