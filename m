Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1932267FDB6
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 10:00:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjA2JAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 04:00:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjA2JAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 04:00:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147DA1F939
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:00:44 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id t12-20020a17090aae0c00b00229f4cff534so11109814pjq.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 01:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xQ0k6JVZhUSEJzZMJ/ASIu8LoWBFAOy6ubnzAcHb5Vg=;
        b=b72FVq5WlJwktSzvl0isua2/Dy3KN+iDUxCjPMTceNN1UJhL4MfFT7oiG8LOfKKxHD
         agYJhb2WFCOFT5RE1Od+r5cmEeCxWXiRllooLPvmDOClzhfkgP8YSmXpol2u+ePi8Cqe
         2sfwcKZYGzmgQCqDolvoHHwWAtmixd9TK9rcQxw/KIO9TRPyOdT+tULvpaIxjBerpIYt
         b0ZANIsdMg+h4Cqyjy8VyRnYWlaX52l/3Ki4RCVPzPnNp7BRgJsjWt2Lxok69tvCnJIZ
         ClmxAfFj62cxuiCnDaYJ5sVzr00N/Cl0CmtG2sxlibRwP5KRh0cUYBsQdeChCwEZ6tFJ
         bYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQ0k6JVZhUSEJzZMJ/ASIu8LoWBFAOy6ubnzAcHb5Vg=;
        b=uqtw2RLwEp5ngPqVKVoTWvI5V+LeT5LxLBoAHFVONWJniMrGDmUArX4ZoYxPv4YKnp
         kkfnf7YHTENynCDEutend2/cnvPF/MpDzj18bbFxy3CvGHpDgVa69WDiT/D1zBDJTj4i
         FClGYxy81lFai1E1tdej9sCjxznt401GaxyIGQQgrCn0v++h9x8BssnLKpYbnoywimWV
         b2FXwLfGiSH1PrD7UunthP68JKt+AemMkBVNcJ1tg8r8wuKf41fUeyrepKSNzR/+wm5G
         HcSlyXWL8vrUW/S8+go9LTbAB/22XqOtPpg0L7xfyi9sqNxfKGTW5MvF4XKZD/YvBPSl
         iEKQ==
X-Gm-Message-State: AFqh2kpBYQy2C8Jwqw7fWs+zYc2Q9v57SWPA2c3TW55uY080R9hAUEMF
        +7VY9MRo1+hebayZ5mV0u2SpbnZzlKv2A8jq
X-Google-Smtp-Source: AMrXdXt1TReSIi6UFcZgA36w4/Fy7Kq8wUYQTHAR+L28DMQCurQUCEBcY5lS+f4G7XuExjl+Yma1IQ==
X-Received: by 2002:a17:903:22c9:b0:191:e0b0:f8df with SMTP id y9-20020a17090322c900b00191e0b0f8dfmr61311849plg.58.1674982843595;
        Sun, 29 Jan 2023 01:00:43 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f54d00b0019607984a5esm2142689plf.95.2023.01.29.01.00.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 29 Jan 2023 01:00:43 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 0/2] Some small improvements for memblock.
Date:   Sun, 29 Jan 2023 17:00:32 +0800
Message-Id: <20230129090034.12310-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
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

Some small optimizations for memblock.

Changes since v1:
- Delete the second patch that complicate code
- Adjust the code of memblock_merge_regions()

Peng Zhang (2):
  memblock: Make a boundary tighter in memblock_add_range().
  memblock: Avoid useless checks in memblock_merge_regions().

 mm/memblock.c | 41 +++++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 14 deletions(-)

-- 
2.20.1

