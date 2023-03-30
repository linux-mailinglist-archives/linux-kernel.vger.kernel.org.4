Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C476D0841
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjC3O1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjC3O13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:27:29 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27235114;
        Thu, 30 Mar 2023 07:27:28 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id dw14so12640454pfb.6;
        Thu, 30 Mar 2023 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680186447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lT1BKGfQqFBUgSJ293/p9fRof3Zd4Kmxm7+XqMUW1Yw=;
        b=iJyOXHNKCdBXBK/TazEMoDQzyTokg0h/SwmbFN3hXJwbXICH2T5W2AU7tv/RuQUoRG
         ztJ6V1vbRB24yil7fx96GQhb9VakUsL1WXyXtgHfyNXPj1dO1gmugDFNVKzY3kp+DRfq
         TPNmv1QTpkdWFJM6GNW6CLXAAAw8pLNd2cLd0vPEo3S8Bc4GCWfe/hyTiJ9Jnmyw55LO
         6GLFMCHZIs3iHs7gLMxbgj0A9vluHvsMtwPoYr9Jo7PoIWfDGS3T96U1L2X4SP23X2pF
         /H4vZxVe3eK8cbVhQFgUaFQBiCgzJOClQHeqVVsfbsghZdnoHhJG4rKUdF5ta3xS1anL
         +SQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680186447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lT1BKGfQqFBUgSJ293/p9fRof3Zd4Kmxm7+XqMUW1Yw=;
        b=B250tu/3gXvWYzrMNPFiNVQ7F17MUBHYfcMOMCf6kPsaNaLlK8MvE3fJlGNXVtDAD1
         Cs0AGKHrgXNilY0Du1y3KWPsgtnZ0Z+e4Lj4J2a2N+xYPPOnqPWVfQNLzbnB1ENNEhea
         l423Cws4IyCiYXsosZetqcm0059cAKWd0hKht6JvDlQ8CjYxpxGGnlFdjygKbmfEzilI
         xRHeNejguNV94PSkXtVPHd8wsye2Ui2wDLIxovfvHmNosn9CJIBaz1G8Pbc1yE1O2Cb4
         zNo1GRlSuZzUAPA5AH0kqvDfUjzoLpvZjb3ZUpcf2yjBBMQFND6ujjc3tqriEG6e25oL
         ZOYg==
X-Gm-Message-State: AAQBX9d0+WEiHzurgPMxvbmYmH5XZ0zFt0d3OBgTa5ZjKCEzZH9v2iW5
        EdcN4O8CYbvWdEf8FeYvNTd0hoAlyto=
X-Google-Smtp-Source: AKy350Y7rTtG18MNfmqE4A3kTB8R6xRJGDHDAoNmFmObn5jQOspYcFH6ZMZP7du4K/SydIl/ebTE/g==
X-Received: by 2002:aa7:9597:0:b0:627:df8d:350f with SMTP id z23-20020aa79597000000b00627df8d350fmr23098126pfj.4.1680186447492;
        Thu, 30 Mar 2023 07:27:27 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:61b:48ed:72ab:435b])
        by smtp.gmail.com with ESMTPSA id h4-20020aa786c4000000b00627ed4e23e0sm21673169pfo.101.2023.03.30.07.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:27:27 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Rob Clark <robdclark@chromium.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Hackmann <ghackmann@google.com>,
        Rob Clark <robdclark@gmail.com>,
        linux-media@vger.kernel.org (open list:SYNC FILE FRAMEWORK),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dma-buf/sync_file: Fix doc build warning
Date:   Thu, 30 Mar 2023 07:27:20 -0700
Message-Id: <20230330142720.882045-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

Fixes warning:

  include/uapi/linux/sync_file.h:77: warning: Function parameter or member 'num_fences' not described in 'sync_file_info'

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 2d75c88fefb2 ("staging/android: refactor SYNC IOCTLs")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 include/uapi/linux/sync_file.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/sync_file.h b/include/uapi/linux/sync_file.h
index d61752dca4c6..ff1f38889dcf 100644
--- a/include/uapi/linux/sync_file.h
+++ b/include/uapi/linux/sync_file.h
@@ -56,7 +56,7 @@ struct sync_fence_info {
  * @name:	name of fence
  * @status:	status of fence. 1: signaled 0:active <0:error
  * @flags:	sync_file_info flags
- * @num_fences	number of fences in the sync_file
+ * @num_fences:	number of fences in the sync_file
  * @pad:	padding for 64-bit alignment, should always be zero
  * @sync_fence_info: pointer to array of struct &sync_fence_info with all
  *		 fences in the sync_file
-- 
2.39.2

