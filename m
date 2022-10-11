Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8EF75FBA96
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiJKSky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiJKSku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:40:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375F37C758
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:40:48 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n18-20020a17090ade9200b0020b0012097cso2102224pjv.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 11:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERLKnWgpFtVqzoSU44W3worzEWB0a03vIi6zG/hd2Qc=;
        b=QFQN5rlHiCyzloNEdPEFYRYrZd0bqEgI0E75b7bEfoPe3yqTD/6k3wsCxOOYiGCi9R
         ZpvjE1KUK6t/pcibjKoOk/quG5n30LkGUcE+v7gtdTrB+WeyxZulcozSlPrCcW+pY+AV
         wqVCdjaqyyerDT2MbPxlEKIOwcdJwbKVsQXgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERLKnWgpFtVqzoSU44W3worzEWB0a03vIi6zG/hd2Qc=;
        b=qpx2grjd+N4K/jc+QsVjc2hskdwSf0GGpqj8lcr57wW+KyRH/Cj3hYua0pXsLCHfVz
         4O9Y4kB2jrbs9+jgKGMx0MhlyjuGcP2a/+BAVMJlbdqIuxT8OXV0YrNT3JPwpcGYjmKJ
         1Gobq49UdOfx5cmPybhsw31MU6LWg9tT3KKdOcOgUEKv/LL2kUtP0zsAuc9SafG56YIO
         klzCk4o82qZwvldZcA793bZ3D5I2IYMSmJVTjSWbEdwFV/0SjDqsWiz3CJ/M8SliMFzD
         QBJSTGDr0ORc9PNsTIygb2egZNgPCmkmJLEFVx4tVZCXdYkXiB+tGb5a06ienB3QtVc7
         3/hA==
X-Gm-Message-State: ACrzQf0h06GIKEU6CBSvUj1FX8ngZJi8w9S3qjWNGSqWiI5oqu0nQgBl
        qpniWJr1c62hLg9nO01kZlzii1mggWTrdA==
X-Google-Smtp-Source: AMsMyM5X65We0X/Ht0ZSbcTFw63RgxlYYbI+FE7dMqtjj305K9Zf1bAk4DBv3Sh3Eenfm8k5K/NJSw==
X-Received: by 2002:a17:90b:4c52:b0:20d:7917:4cb3 with SMTP id np18-20020a17090b4c5200b0020d79174cb3mr613006pjb.6.1665513648289;
        Tue, 11 Oct 2022 11:40:48 -0700 (PDT)
Received: from localhost (226.75.127.34.bc.googleusercontent.com. [34.127.75.226])
        by smtp.gmail.com with UTF8SMTPSA id w4-20020a170902ca0400b0017eea4a3979sm8860022pld.154.2022.10.11.11.40.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 11:40:48 -0700 (PDT)
From:   pso@chromium.org
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Paramjit Oberoi <psoberoi@google.com>,
        Paramjit Oberoi <pso@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>
Subject: [PATCH 1/1] pstore/ram: Ensure stable pmsg address with per-CPU ftrace buffers
Date:   Tue, 11 Oct 2022 11:36:31 -0700
Message-Id: <20221011113511.1.I1cf52674cd85d07b300fe3fff3ad6ce830304bb6@changeid>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
In-Reply-To: <20221011183630.3113666-1-pso@chromium.org>
References: <20221011183630.3113666-1-pso@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paramjit Oberoi <psoberoi@google.com>

When allocating ftrace pstore zones, there may be space left over at the
end of the region. The paddr pointer needs to be advanced to account for
this so that the next region (pmsg) ends up at the correct location.

Signed-off-by: Paramjit Oberoi <pso@chromium.org>
Reviewed-by: Dmitry Torokhov <dtor@chromium.org>
Signed-off-by: Paramjit Oberoi <psoberoi@google.com>
---

 fs/pstore/ram.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
index fefe3d391d3af..3bca6cd34c02a 100644
--- a/fs/pstore/ram.c
+++ b/fs/pstore/ram.c
@@ -554,10 +554,12 @@ static int ramoops_init_przs(const char *name,
 			goto fail;
 		}
 		*paddr += zone_sz;
+		mem_sz -= zone_sz;
 		prz_ar[i]->type = pstore_name_to_type(name);
 	}
 
 	*przs = prz_ar;
+	*paddr += mem_sz;
 	return 0;
 
 fail:
-- 
2.38.0.rc1.362.ged0d419d3c-goog

