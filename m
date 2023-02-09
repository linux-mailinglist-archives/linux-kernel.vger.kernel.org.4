Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD4C690AA5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjBINl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjBINls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:41:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6402383D3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675950060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OzV7p16/yEZQKmwWUFxj9RZMdMX7gGqoUkNDU++eOPw=;
        b=JN82Cyndttb9a/MyIR8/P4gNLHm1e2xjdK1lRo9/5a9eRC3nEw65N0MGQ0qPVw6P0fGsYo
        KqpjdvEMOPjmgIh7e61CQjSs3/RdR9KAej84bCMWrD/xjwWOCHG+QPkZd1e6WqsQnTVe32
        B0BSRoVLZqDkJm+LYgAhp153r+kLsmE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-38-dYrwpGBrNE2blI3ICMGA6Q-1; Thu, 09 Feb 2023 08:40:59 -0500
X-MC-Unique: dYrwpGBrNE2blI3ICMGA6Q-1
Received: by mail-qv1-f72.google.com with SMTP id 98-20020a0c806b000000b0056c2797aa8bso1067625qva.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzV7p16/yEZQKmwWUFxj9RZMdMX7gGqoUkNDU++eOPw=;
        b=ClPPSveGs5dPlqFxS7EB8V9lpzmYKDhs66B9UnB/LJjj3U4g6JWwv2DaIgeUsuYNSJ
         NG+OPwRho9VZdHEUWOYwWVy7k70eZfx3BFbDdvp559p01dO9F3WnqwTPnUtXI5drT5WZ
         ZBVxAP8gcc5Mcpt2Ka6w7hlcBykk2JoXKv89J3RB1AVn+6TxgjPqYWpJuQemj8cNRXWQ
         PSCJtK9+Jxz/zdU+RAucKmktCkURRvOU1ng0qM/+4SYlyudJImbCJpp71+oW6iO18MVN
         TGqaEfrmVScd+T1Fi8DgrNocrxRNM0padGkgsjuUb5VU+9XUUoBOcevnc4KY/GEiCo8l
         2a3A==
X-Gm-Message-State: AO0yUKXM7iOI5BV0U7Dr0fQFZYnOTcJpi+VWXC1CyFza5yL9DRrElRq4
        LaZKaTv5icDt/ODPX8E+KoIAKlQZOkdAmzQaUamoKaNhkdIEKBkrhE0H9iPDPYtMa0BYWSmVYsq
        nIEvJ4l2JT1SPeusZNlC8D4Zo
X-Received: by 2002:a05:6214:2684:b0:56b:f2d7:f66d with SMTP id gm4-20020a056214268400b0056bf2d7f66dmr21321726qvb.46.1675950058607;
        Thu, 09 Feb 2023 05:40:58 -0800 (PST)
X-Google-Smtp-Source: AK7set8nFqGwwydA/Qv//jTnLpI8YmlDl2IBDR+nilaOo8Jek16gZhJgf+ALhc6AphqS+W1bio6i8w==
X-Received: by 2002:a05:6214:2684:b0:56b:f2d7:f66d with SMTP id gm4-20020a056214268400b0056bf2d7f66dmr21321696qvb.46.1675950058373;
        Thu, 09 Feb 2023 05:40:58 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id t187-20020ae9dfc4000000b0073902217c00sm224072qkf.23.2023.02.09.05.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:40:58 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, Dmytro.Laktyushkin@amd.com, qingqing.zhuo@amd.com,
        Charlene.Liu@amd.com, nicholas.kazlauskas@amd.com,
        meenakshikumar.somasundaram@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] drm/amd/display: set should_disable_otg storage-class-specifier to static
Date:   Thu,  9 Feb 2023 05:40:49 -0800
Message-Id: <20230209134049.2000865-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
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

smatch reports
drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c:90:6:
  warning: symbol 'should_disable_otg' was not declared. Should it be static?

should_disable_otg() is only used in dcn315_clk_mgr.c, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
index 8c368bcc8e7e..a737782b2840 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn315/dcn315_clk_mgr.c
@@ -87,7 +87,7 @@ static int dcn315_get_active_display_cnt_wa(
 	return display_count;
 }
 
-bool should_disable_otg(struct pipe_ctx *pipe)
+static bool should_disable_otg(struct pipe_ctx *pipe)
 {
 	bool ret = true;
 
-- 
2.26.3

