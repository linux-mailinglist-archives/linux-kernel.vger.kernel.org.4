Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8094365FD54
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjAFJNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:13:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjAFJNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:13:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B4663B9
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:13:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id cf42so1196073lfb.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 01:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEDGHzm1mOzONxL5Aym9lGmFycCpQZhbnPpiRS2qK6Y=;
        b=Jm/FCQrcVuioN5f1aSO8pBAZPxhzjWeaXXYbpsep5oCRCMXumnNOpSPdsWvorl15eb
         PRHr6lAxOzZH32YFs8I0MvswcNeMEjVk8ieCJjuAlO5+RJoTEBl225IOj941CHAeC2Hc
         laS/HO2Cmban/s9cahutzHjK925YmUfAIvMBjr1u8z66btoJnaN9Eduh/IaVJOdcc959
         JFn9KqFhuOlEcmunM9CU7yCYMa5pnBzEel8N1+dFmM77dFWv3ZPC+yoGwBN6l6fXeQSG
         QtUjoxgdhTThYhpw3vv6OiuB2ORNqh8D5EbydhT04Nz/h9m6/IA69abmHY/xqW4FSCqp
         AZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEDGHzm1mOzONxL5Aym9lGmFycCpQZhbnPpiRS2qK6Y=;
        b=d4pzx4y4uMvjlKZkiojZaV2YmfqvXmpEavMsBUcRfXq/YUAs8jOGCNhNeMBNk+BB+p
         HgX3LUxWKXr82B/+g3v+kxuAB7VMDsTfwZsyxB077PwUxhL8uUxqH5Of/usuTZ9mFl3q
         Y+cK98VwwUC3D/hcnAt1GrF4IBlJHAeuQMy7d6ySUsUZeVE1/chnd4cMLaY34QuspYc3
         T1P6Nj4pz7cHzpN4Vz+XVZOhau/ZsB90FBQHLOKabKaBLeiuVNa5g944W4CI60Ast2vU
         Fr/8gVUfIqZ2dp87htx1aJ3WmWWKct4qNRYXLC4TWZVLUyv7ky/f4IThePaE9i7SD6oZ
         cwKQ==
X-Gm-Message-State: AFqh2koNZ/GCgWQoYBArX0ewdNNG0dzCB87Zzuad8pnqDbxM883WN9sA
        4erIDHyHxY8Vf+XbRmSzDMdE1IjOTStttCHh
X-Google-Smtp-Source: AMrXdXtRGE+5eTyNIrmNJH+BgnOgKA/fsks/OjC+G4z+9FuBypJw0OlDur1pAgseIW7YaVxse9h/Og==
X-Received: by 2002:a05:6512:2395:b0:4cb:4344:a786 with SMTP id c21-20020a056512239500b004cb4344a786mr4028043lfv.20.1672996413204;
        Fri, 06 Jan 2023 01:13:33 -0800 (PST)
Received: from localhost.localdomain ([46.147.136.10])
        by smtp.gmail.com with ESMTPSA id u4-20020a05651220c400b004b4b600c093sm87475lfr.92.2023.01.06.01.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 01:13:32 -0800 (PST)
From:   Alexander Pantyukhin <apantykhin@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
        nborisov@suse.com, alexpantyukhin <apantykhin@gmail.com>
Subject: [PATCH] scripts/bloat-o-meter: use the reverse flag for sort
Date:   Fri,  6 Jan 2023 14:13:19 +0500
Message-Id: <20230106091319.3824-1-apantykhin@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: alexpantyukhin <apantykhin@gmail.com>

The sort function has the inbuilt reversal option.
We can use it for save some time.

Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
---
 scripts/bloat-o-meter | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/scripts/bloat-o-meter b/scripts/bloat-o-meter
index f9553f60a14a..36303afa9dfc 100755
--- a/scripts/bloat-o-meter
+++ b/scripts/bloat-o-meter
@@ -80,8 +80,7 @@ def calc(oldfile, newfile, format):
         if d<0: shrink, down = shrink+1, down-d
         delta.append((d, name))
 
-    delta.sort()
-    delta.reverse()
+    delta.sort(reverse=True)
     return grow, shrink, add, remove, up, down, delta, old, new, otot, ntot
 
 def print_result(symboltype, symbolformat):
-- 
2.25.1

