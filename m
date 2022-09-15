Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EE65B9B24
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 14:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiIOMmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 08:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiIOMmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 08:42:33 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463B7617C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:42:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id v1so18221878plo.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Qyyly0y8hqdRh/t9nYiYaAraDfG9P+e3ebneuWywx+A=;
        b=et8SUZfoNeMLnBl0MYEBpYeDFeu37dGfFrRRjQ3AaSxd8mtSowHWfpGGv23g3PclEl
         rgBoVJGjypKu0gzrIGPI32O/YAaVP3IBo2CqI3GwpG50VYJCT/VLn/PefDTSP4ScGOeV
         8gw76ga6vh3F0wTgV/EJQOyXCnDggxUUWVUSahI18DNxw3/pIw+4CYWKjOJdgx/RcVFw
         njw6xSqeSSHJlZIjWtf+8vvHJiTjTyOwuj4vJOpIU8M+1LOlig0Mc60vsGYkEYADlGgJ
         BIzUJSej46PeT0PMCaFJFwlU4nASJaiHY5B42BznFYhPOAqMqaQK1C5O2MQk/8bS78i6
         RbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Qyyly0y8hqdRh/t9nYiYaAraDfG9P+e3ebneuWywx+A=;
        b=ad2TtnxHJNrh1kBgBNpDMQC+E/1iFmA4dK6yIrYeAeTSqqwmfZu1sz+ZZ7+2V107He
         72igf5syuGpWPcunwqe72gaDJizxv0QBiMgesaiEhdrM8pqnp99ZHJkxt9/IOnXVYhas
         cw02IUjeOmP1hqdbUPrI9IAlXHwmQoqD4rOm15wzrXQ12yJYE/F4w9wjlNASnl4hKoGp
         /+l+7Oefdbnu+Kz60zO4VzwFkhUxrLO/l6eDFIKVkDJyaOfmY6CtiuSavmVCX4+v59sA
         PP7P+v+y249VZz10b3ygo/hD9JhGthVy1ZnBZ9tcgcHGAABHJHlqZw8J9VAs1hnCIgto
         2RdQ==
X-Gm-Message-State: ACrzQf1SpkraHIR/0FB0qE8G+YYmgesAvHgAERfqEOaO5J5+pFaN1MkR
        BPDgnbnYzIZGKSivHIT60LkDgg==
X-Google-Smtp-Source: AMsMyM6L9o52U6lZPoVzHgkmu9KCrPUsx4XZmvaJZ+/KCAxjWxbWhbI2BTZHjNqBttWAXeWa68I2HQ==
X-Received: by 2002:a17:90a:db8b:b0:203:1de7:eaaf with SMTP id h11-20020a17090adb8b00b002031de7eaafmr8232679pjv.168.1663245752797;
        Thu, 15 Sep 2022 05:42:32 -0700 (PDT)
Received: from C02G705SMD6V.bytedance.net ([61.120.150.76])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902780800b001637529493esm12721906pll.66.2022.09.15.05.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 05:42:32 -0700 (PDT)
From:   Jia Zhu <zhujia.zj@bytedance.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yinxin.x@bytedance.com, jefflexu@linux.alibaba.com,
        Jia Zhu <zhujia.zj@bytedance.com>
Subject: [PATCH V4 1/6] erofs: use kill_anon_super() to kill super in fscache mode
Date:   Thu, 15 Sep 2022 20:42:08 +0800
Message-Id: <20220915124213.25767-2-zhujia.zj@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20220915124213.25767-1-zhujia.zj@bytedance.com>
References: <20220915124213.25767-1-zhujia.zj@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kill_anon_super() instead of generic_shutdown_super() since the
mount() in erofs fscache mode uses get_tree_nodev() and associated
anon bdev needs to be freed.

Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
Reviewed-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3173debeaa5a..9716d355a63e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -879,7 +879,7 @@ static void erofs_kill_sb(struct super_block *sb)
 	WARN_ON(sb->s_magic != EROFS_SUPER_MAGIC);
 
 	if (erofs_is_fscache_mode(sb))
-		generic_shutdown_super(sb);
+		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
 
-- 
2.20.1

