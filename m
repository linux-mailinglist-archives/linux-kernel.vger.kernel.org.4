Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7C1601B81
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 23:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJQVtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 17:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiJQVtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 17:49:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7311513E2C;
        Mon, 17 Oct 2022 14:49:40 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a10so20512142wrm.12;
        Mon, 17 Oct 2022 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DRMvlUa5zMmVyx/M59YbOtEpJ0BRHrD5Glzjdb3HncY=;
        b=j/wIHS3CEfNqhCuDDUkj2BgQx+EWYuuZ7dt9b+oHUKWVeshbBrM3+MJRYnYqdDFmyl
         V0fOKZYhLnwe/FhgQl9KodPexyFy5Y86hPWCniHYgVRGfdBkj3eHR7q+kjwMSODk4NAp
         z+ed58w1xpDwpDzsEir5OKMaFanEkxe1QyolMriuw7vygvTj0HaAj7bKcIv3FLxEZj6o
         icp5IqFoGn5+oaMAfc3RR614IM9rd985k9b7lvoGI1w/giswsAXgoRozO3PkOJ4FzBx5
         IqCXA48bY+Hg+kg9qWo1I4dgFhqrSxxDgllFzF5sZAOU5/NqXLqE667anCmFrg9Peyqj
         6qhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DRMvlUa5zMmVyx/M59YbOtEpJ0BRHrD5Glzjdb3HncY=;
        b=adLd46cC4QkLeJPgTKPpaN4iAyVzQGYEYtaLB7zJIS/fVpvuxnf3siL16jJmoJ90fV
         Y5nq6lXbq8cAiD9UepapzAhaBlgcdRCXkoBjTbUpmErlpU7kUPLyaKVccA2nmDHoLbLj
         ee538xOmXVOdxxnN731JyJPaPR2x/F0yC1TBFarn25i9qpYPeCfzCCu9ikfFslRgSNyu
         VRgQhezAJbhdXKJ5w3uINJxJoQ9mAJadXkQc5Q+Ar11Z0GObASb+er2SN9xEGGzk4fi7
         Lx+yiFuVnY3Ta/1rwtbbnQQIHt/6DyW/hnFMOnKDAYKtJqptpX0SDWVh+CuirltxVI8Q
         IBag==
X-Gm-Message-State: ACrzQf2UZ4YjZuoacTWt3wQyUxveG4A21iq61xW9yaCrZ2gecay3w7/l
        JSl5cyYB4USvCleLwELHb/4=
X-Google-Smtp-Source: AMsMyM5tpfTxJIu061YdCiW8F0VAn+NIgBQhnzZ+jFbOFtNAmMxCspejaeBn2EukfKwtAaMNMOIrOQ==
X-Received: by 2002:adf:ec03:0:b0:22e:4d3:bb37 with SMTP id x3-20020adfec03000000b0022e04d3bb37mr7161337wrn.665.1666043379018;
        Mon, 17 Oct 2022 14:49:39 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id g8-20020a7bc4c8000000b003c0d504a92csm15911953wmk.22.2022.10.17.14.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 14:49:38 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Mike Marshall <hubcap@omnibond.com>,
        Martin Brandenburg <martin@omnibond.com>,
        devel@lists.orangefs.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] orangefs: remove redundant assignment to variable buffer_index
Date:   Mon, 17 Oct 2022 22:49:37 +0100
Message-Id: <20221017214937.863599-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

The variable buffer_index is assigned a value that is never read,
it is assigned just before the function returns. The assignment is
redundant and can be removed.

Cleans up clang scan build warning:
fs/orangefs/file.c:276:3: warning: Value stored to 'buffer_index'
is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/orangefs/file.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 732661aa2680..167fa43b24f9 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -273,7 +273,6 @@ ssize_t wait_for_direct_io(enum ORANGEFS_io_type type, struct inode *inode,
 		gossip_debug(GOSSIP_FILE_DEBUG,
 			"%s(%pU): PUT buffer_index %d\n",
 			__func__, handle, buffer_index);
-		buffer_index = -1;
 	}
 	op_release(new_op);
 	return ret;
-- 
2.37.3

