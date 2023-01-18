Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484C567148A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjARGuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjARGYO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:24:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B459951C4A
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674022413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9bPNRTAzSirKPyPC/a7kemJ9gbWhkHOBWemjVPOdr94=;
        b=D5XLcIm3F40BezvWsfnmWbzGJQPArQIhha6JyaGO1z9qb69iD63RiJ1x83bU/7OX7+Ny7b
        /hr/jFrx1LEhcDFvS9d8jrX2TiOXWnKXq5DcK8unDmQvCzUUQNCa/Gp2lXABMbQsTAmRKn
        8XJDvQZ4cldQV3Nb0c2F9rUaYYrd8ZQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-75qeEFwnO1WKGnZ3uQfY3A-1; Wed, 18 Jan 2023 01:13:32 -0500
X-MC-Unique: 75qeEFwnO1WKGnZ3uQfY3A-1
Received: by mail-ed1-f70.google.com with SMTP id b15-20020a056402350f00b0049e42713e2bso1687686edd.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9bPNRTAzSirKPyPC/a7kemJ9gbWhkHOBWemjVPOdr94=;
        b=yBDUFji8lJj1oF6eM8Y+zukkmTA5lX+Pg9fL1fBH3NVjD+seC7MIC0mldmUkSomZZS
         zx+IWi9BXUeA3i9ynma0TZYecvPLNCImtspsP2hdFaT0FJ8QuQ71W7lLuvbflXgecPPa
         fcvtN9mmnn2yF0c62Y1boxEV21ObKVv90WVXVKF/IjYoASwnPOEaX0kintnYF8E1sKs1
         V2Pkd5UOsJTQGFX19KswYxWVIR14McSDjVFuO/vgLnawTt1xZ+K1BJzOfslSZ72/qcBt
         wZrkR0PDgnxLTm6rKX4gsyU4l0B6QX4ns5a68eCO69+EnXlKF6H5gmb+aH3YBUEPgGFh
         5OPA==
X-Gm-Message-State: AFqh2kqY4+oH7mOZoXUi00qaBxjOkN9FptK2tebHxXb/FaMNituXbn5R
        dbSimm4KPUsWv2oA9PxxBLimmOW6YC7vIWo7Hbz36hvpX0iqWQktamYCe77X3rw3HwQWXb0aBE1
        bJM8QCVKtm7vS+huxlNC047WF
X-Received: by 2002:aa7:c0d4:0:b0:49d:9bd8:6253 with SMTP id j20-20020aa7c0d4000000b0049d9bd86253mr6311446edp.17.1674022411762;
        Tue, 17 Jan 2023 22:13:31 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtjvWeO5BcMo55Z0OQiMRRnw0jtETl53EDUmTCOZ9HyMXZACKq57o1DdaU9DHq6GmVA9kdq0w==
X-Received: by 2002:aa7:c0d4:0:b0:49d:9bd8:6253 with SMTP id j20-20020aa7c0d4000000b0049d9bd86253mr6311429edp.17.1674022411580;
        Tue, 17 Jan 2023 22:13:31 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:de78:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id y11-20020aa7c24b000000b004954c90c94bsm13745667edo.6.2023.01.17.22.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:13:31 -0800 (PST)
From:   Danilo Krummrich <dakr@redhat.com>
To:     daniel@ffwll.ch, airlied@redhat.com, christian.koenig@amd.com,
        bskeggs@redhat.com, jason@jlekstrand.net, tzimmermann@suse.de,
        mripard@kernel.org, corbet@lwn.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH drm-next 02/14] drm/exec: fix memory leak in drm_exec_prepare_obj()
Date:   Wed, 18 Jan 2023 07:12:44 +0100
Message-Id: <20230118061256.2689-3-dakr@redhat.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230118061256.2689-1-dakr@redhat.com>
References: <20230118061256.2689-1-dakr@redhat.com>
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
2.39.0

