Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493776690CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbjAMI1x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:27:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbjAMI1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:27:30 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C69048287
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:27:08 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id a184so15643702pfa.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 00:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G3rqt8U/fmU9xdq4C5+W4HE9DlCGSdVe4EIC0wcKppU=;
        b=yzrVwWu7C3NSCFGCHVk5Hyc+CUi0GnXALmrCmXsGOx+12/p+tc8QUorV6ZPdrkBahB
         T7B3KJQCt14brVLptUmUsM6bdnx8XbaTWg+U3fmsFvEp/2V06D0lKjHqLfusm+DJZ9av
         ky2Hog1hhK04nZZHrSlbRMfvdTBzeanwDhv+WQPMFJ1/66t5LJV2cid+QFRzzz5Pkz/y
         ZnzqcVBozQ9xvUR4tlDyA9Anl0tjJ8Jt4gbTxqBmSCebxrBIbFQ8AAY4yqjCntrf/fVD
         hQHHi2pVaOb7O5/LILuh+EakQMJObwmbwvQpgOW3iJZLoC22aotoKZhP2kj5t5NYvud3
         Gnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G3rqt8U/fmU9xdq4C5+W4HE9DlCGSdVe4EIC0wcKppU=;
        b=Ibh+RcHXkeu0z8yhueOYFq+G9sE8zAs/PiSMn3zgyHl+uW/78oCvNjgwWyBmdyikuP
         Y9vYQPUcCN5a/1I0hue+jFG5fmc/2Fnzm8OZ/ixq2/5wHHYxIXGpGItOH3FYnGzd/9nQ
         RgeY98GF0IeX9SHUQtx5QKsCE6jyhtP5LggUhuc49jpO9NM/mj6pct1HtSTRd5LbMRq3
         HHL1LREPrj3qKTMHyfRJg0DgPfQKwik4WSOe4+/3Q9XQWFTXRHk2Nh8kXPrKIiaSUvs5
         9Bh6VYpkSgy/JtCs0YpHFBHA58X6/jXwsRr2eUE7BMPgjvHf5enaWOHrb0HXIrUdO/ns
         bGEw==
X-Gm-Message-State: AFqh2kq5doNordtTxLwh88HG6q8Frb8H62kbcGvqBaBfNT5O8aX+PgmI
        MBHG6tGygSrZD5/m3TJJqo5ICw==
X-Google-Smtp-Source: AMrXdXvfTi6zQScrQ5bOmQy6GI4Kn/U9O40ztqvFG1UjTLpDUc64K7zHvwp9nvavQhVnnuaAOg2+Hw==
X-Received: by 2002:a05:6a00:d4e:b0:581:a2b6:df19 with SMTP id n14-20020a056a000d4e00b00581a2b6df19mr52218940pfv.14.1673598427671;
        Fri, 13 Jan 2023 00:27:07 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id l123-20020a622581000000b005818d429d98sm13092738pfl.136.2023.01.13.00.27.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 13 Jan 2023 00:27:07 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     rppt@kernel.org, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 0/3] Some small improvements for memblock.
Date:   Fri, 13 Jan 2023 16:26:56 +0800
Message-Id: <20230113082659.65276-1-zhangpeng.00@bytedance.com>
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

Hi,
I found some small optimizations while reading the code of memblock.
Please help to review. Thanks.

Peng Zhang (3):
  memblock: Make a boundary tighter in memblock_add_range().
  memblock: Make finding index faster when modify regions.
  memblock: Avoid useless checks in memblock_merge_regions().

 mm/memblock.c | 71 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 54 insertions(+), 17 deletions(-)

-- 
2.20.1

