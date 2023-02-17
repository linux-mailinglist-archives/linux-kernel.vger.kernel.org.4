Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD7A69ACD6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjBQNpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBQNp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:45:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975A9126D1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676641479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7uKZrgGFJpURUNNqYPRQvVp3RBdWsUReZR9Qa+W+o5s=;
        b=BNUcM6POrJG74JL6p38XolGt+ycNnXKd0YIX+BflxiyUJ3YHnbPI8+pLq6T2z0bmii5OSu
        T+hYxR683U+lcnetgEsI2gROjRggvDErFRMaT0KALxjGqjvqV/BrIfQ2Ig4oNxlASf04HY
        xwaXCUgL9iYyPSl4ZN1CfA/4A3ITdcY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-623-2u7igbg5Mqqh0vxl0AQhWw-1; Fri, 17 Feb 2023 08:44:38 -0500
X-MC-Unique: 2u7igbg5Mqqh0vxl0AQhWw-1
Received: by mail-ed1-f71.google.com with SMTP id cy15-20020a0564021c8f00b004aaa054d189so1571814edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 05:44:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uKZrgGFJpURUNNqYPRQvVp3RBdWsUReZR9Qa+W+o5s=;
        b=CVDvmwVPcdr4oWfU4whltEFaoIN1GLGs6g3l7zo6yqmH2ERzM63AmdLxTR4i9Pc7Yb
         JjFo225v/mC/Mp7hvD748xGo6rXcOiZSeG7sKDBHVHlMAm/vgpo/zRpsg1Rl7uM5bpKZ
         UGoZ35FUDlOLKXEbsPVZzBvA3w4ogPBiiyB6bf1YjJ/5Tf0tTiGrEljCsfwReQQqFjf9
         ICrFjJF/AQDQ0OlQth0momkHhM1MbsD9YPcsyDG0L2lTOb/ZwjEAZCjKYsqDLvSvAyWe
         Dc9KBDFx1chWi5ySgGrFjgnWdPUoCV/lTC7EgofR2yOxzQbUtJLlOtP9uWMGB/FZ1m3R
         3jvA==
X-Gm-Message-State: AO0yUKU92qBjIUjiGs87HI+Fo/E6hWmja1Fl5i+/483HjbW2yAJMZHcr
        39pAxzLEIDvJWJKMeFD2HxIhtc1WaDCPA6FpkDadg75C30IOfYvaVqs7QkViFPMCjUI7bdjqFQn
        Pr/zj3kFVqNJSTFZOfIBnDAsD
X-Received: by 2002:aa7:c9c6:0:b0:4ae:e51e:9e3e with SMTP id i6-20020aa7c9c6000000b004aee51e9e3emr348781edt.24.1676641477312;
        Fri, 17 Feb 2023 05:44:37 -0800 (PST)
X-Google-Smtp-Source: AK7set9IRUJksGLLW/RDiXSfuPpHSO6kl3p0Lri0OcDeobF/5J+q0ZakgTJZKlO0HFr6pr+zDCdPAg==
X-Received: by 2002:aa7:c9c6:0:b0:4ae:e51e:9e3e with SMTP id i6-20020aa7c9c6000000b004aee51e9e3emr348775edt.24.1676641477173;
        Fri, 17 Feb 2023 05:44:37 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id u8-20020a509508000000b004ad61135698sm1948004eda.13.2023.02.17.05.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 05:44:36 -0800 (PST)
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
Subject: [PATCH drm-next v2 02/16] drm/exec: fix memory leak in drm_exec_prepare_obj()
Date:   Fri, 17 Feb 2023 14:44:08 +0100
Message-Id: <20230217134422.14116-3-dakr@redhat.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230217134422.14116-1-dakr@redhat.com>
References: <20230217134422.14116-1-dakr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Don't call drm_gem_object_get() unconditionally.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 drivers/gpu/drm/drm_exec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index ed2106c22786..5713a589a6a3 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -282,7 +282,6 @@ int drm_exec_prepare_obj(struct drm_exec *exec, struct drm_gem_object *obj,
 			goto error_unlock;
 	}
 
-	drm_gem_object_get(obj);
 	return 0;
 
 error_unlock:
-- 
2.39.1

