Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BBB6DA027
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 20:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbjDFSpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 14:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240261AbjDFSpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 14:45:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B489A26C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 11:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680806682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LOzVIpJJM6v7k5No2ia8gTr6fhScQxv4U9oi5fa7u4c=;
        b=jGs95+7XH3VjWXpL9BuTI7FMWv6R7Ml1udZaOa9r//zWgE10uzXofusqs6fX4o2nlBa/x3
        W6gKU0kzVHQ+/49sg2IdRghl/ydaThCk5N2+WL3B8b9dPKICITJJZWn73oJFKxKqMDfZaY
        4JotBorwTQIrXKf2ZT6LrwGzNoCa45s=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-AW-a8q0SMH6jWg_0CExjDA-1; Thu, 06 Apr 2023 14:44:41 -0400
X-MC-Unique: AW-a8q0SMH6jWg_0CExjDA-1
Received: by mail-qk1-f198.google.com with SMTP id 72-20020a37044b000000b0074694114c09so18018858qke.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 11:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680806680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOzVIpJJM6v7k5No2ia8gTr6fhScQxv4U9oi5fa7u4c=;
        b=1mHvFYoj0FIYcBl/rQ35ng1aNgRjT+WhSunZ7u582mw027Ouzp9dudaEJqfVb4IOt9
         5RvRQEA401Xtdbq2h4ebHnxXqHFxvfoL7lSHERI69u/EYEFsUdPjx9rG6fIu+4EpxQR1
         jPeSTxZnoe0u9mp+TXeMsTmdq5aD0iC/jmjphTQuZ1L2IAIy/NzT1HiNSONx5TAotmZP
         bMXvy4E0ZV67iplM961ySaTzIHHXyq9xQx1io2uBb3g9wylRHjlMtVg7+tjX/LblcZNl
         jZ2RkKZ6apl52Yvck1lV+CbGiWG8PDhw4CG9XiOWjVZYya3k1QBzogv80ZnmYsw0+VUN
         h5Dw==
X-Gm-Message-State: AAQBX9f7sBB9cNhoOb5UlwROys5AYMmImgXk8B0uAWqoYuY7tDMFLkCc
        QnBY+K1rdKE9covO6oh9hdkh0NWcvnUPR4ZsLcLNgiVOzQv8Tfr6Qe2zAw8eLAFaCNgwOVfYc1w
        cMjisQCxLQ1f8cds4RTs6xA69
X-Received: by 2002:a05:6214:21ea:b0:5e6:8e03:994e with SMTP id p10-20020a05621421ea00b005e68e03994emr271468qvj.38.1680806680529;
        Thu, 06 Apr 2023 11:44:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350b2esvOM7SNf3mflCNYsRvsqb30rSrGo0KeUq5T2D+bFM8buWpXaMGtXaXNEy28BM83L3uLMQ==
X-Received: by 2002:a05:6214:21ea:b0:5e6:8e03:994e with SMTP id p10-20020a05621421ea00b005e68e03994emr271427qvj.38.1680806680099;
        Thu, 06 Apr 2023 11:44:40 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id lb30-20020a056214319e00b005dd8b93458esm708436qvb.38.2023.04.06.11.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 11:44:39 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, nicholas.kazlauskas@amd.com, Jun.Lei@amd.com,
        Pavle.Kotarac@amd.com, chiahsuan.chung@amd.com, duncan.ma@amd.com,
        Charlene.Liu@amd.com, muansari@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: set variable dcn3_14_soc storage-class-specifier to static
Date:   Thu,  6 Apr 2023 14:44:34 -0400
Message-Id: <20230406184434.1956813-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
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

smatch reports
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/dcn314_fpu.c:100:37: warning: symbol
  'dcn3_14_soc' was not declared. Should it be static?

This variable is only used in one file so should be static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index c52b76610bd2..44082f65de1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -97,7 +97,7 @@ struct _vcs_dpi_ip_params_st dcn3_14_ip = {
 	.dcc_supported = true,
 };
 
-struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
+static struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
 		/*TODO: correct dispclk/dppclk voltage level determination*/
 	.clock_limits = {
 		{
-- 
2.27.0

