Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 977186015F6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 20:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230360AbiJQSIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 14:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbiJQSIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 14:08:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B65574B96;
        Mon, 17 Oct 2022 11:08:08 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 70so11678697pjo.4;
        Mon, 17 Oct 2022 11:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=j+6AzcAmfBx0xUHJ63qpwud6aVQ2MeRWJvAvvAZy204=;
        b=df1mUr0ZglwQIJA+IDJ2PKj3HincJCT4yn6Ok3stVuoThYw9gU/b36/5zrABvt5I5/
         YOYwPXfWWqFe2mLnOtVTdkG0I95HLaNMud4MjZKflaBTMYTbK/KhcEoFGxyd6T97biS1
         kHroCbOrV6ASFmLmcIJDP2Euh/TeLsqCGBzWAq8rg2cxveJIeDJc6ElNjj21FzZQFwM5
         49vAcRkHxn6NQAB2Ccb/GexDy4vIB+Hq4GSBAWNN3s3WAziY/udr8x1Hv+rKceTte4Ce
         wX/k8cA0HB0oxuZChTLol/nDCeAqmPwg8oHHgcWa3Sm5I26rXSLlNw8G0XxEcIepf7MR
         zsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+6AzcAmfBx0xUHJ63qpwud6aVQ2MeRWJvAvvAZy204=;
        b=zkzDuKnUylH38rSs+9HXrg7s+ISyJPZKrnPwKn3cSsFxCpAStAkh8EAYbM3BvIOVbq
         SiABPEriz5CSTiamiJAcMjWp4RYI0Z0FcSJkoq332mHSUwjfSrZcfbdJ86POnfV8JHU5
         2L16bDC07Ou8YzJDleLNivwPuNAVeVEWoea3/p1XlGWSoFLWdb4V1vKuQF8Z/BycCgAl
         6Gx/Ylh+E0eZKKUzZLL5bAAhXK+0Hd6W4uPI8y2TlKtUO58gR2+/sizM3ibEP0rlbIXy
         EjlViLYDvQGfLO77KkPNRpOt/BWXduFADLBv/aLe7AEBJ8r+Xub4BssouctO0rDu1tWu
         FsBA==
X-Gm-Message-State: ACrzQf3P4MImmy6IA7z7tQZdvQQUdFNCamwsEu8lPYKW/PxQhEUTTgFa
        QY7+1ZyNyTQ46HNC/9ndYL4=
X-Google-Smtp-Source: AMsMyM6M5d+OGm43rGPhrW1+8SuoVc8fACmMPYJooWBkdHdTA2MU/RuIiLzFqoP2atLJ8l8r2n1L4w==
X-Received: by 2002:a17:90b:f02:b0:20a:9965:eeee with SMTP id br2-20020a17090b0f0200b0020a9965eeeemr14812788pjb.182.1666030087348;
        Mon, 17 Oct 2022 11:08:07 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78f37000000b00562a5f29ac1sm7432574pfr.100.2022.10.17.11.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 11:08:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Oct 2022 08:08:05 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH cgroup/for-6.1-fixes] blkcg: Update MAINTAINERS entry
Message-ID: <Y02aBVTCSggxKWXT@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josef wrote iolatency and iocost is missing from the files list. Let's add
Josef as a maintainer and add blk-iocost.c to the files list.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Hello,

If everyone is okay with this, I'll route this through the cgroup tree.

Thanks.

 MAINTAINERS |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cf0f18502372..07938eab80dd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5266,6 +5266,7 @@ F:	tools/testing/selftests/cgroup/
 
 CONTROL GROUP - BLOCK IO CONTROLLER (BLKIO)
 M:	Tejun Heo <tj@kernel.org>
+M:	Josef Bacik <josef@toxicpanda.com>
 M:	Jens Axboe <axboe@kernel.dk>
 L:	cgroups@vger.kernel.org
 L:	linux-block@vger.kernel.org
@@ -5273,6 +5274,7 @@ T:	git git://git.kernel.dk/linux-block
 F:	Documentation/admin-guide/cgroup-v1/blkio-controller.rst
 F:	block/bfq-cgroup.c
 F:	block/blk-cgroup.c
+F:	block/blk-iocost.c
 F:	block/blk-iolatency.c
 F:	block/blk-throttle.c
 F:	include/linux/blk-cgroup.h
