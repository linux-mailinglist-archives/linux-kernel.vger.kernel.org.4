Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DF46B4328
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 15:11:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjCJOK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 09:10:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbjCJOKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 09:10:30 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25699B4828
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:09:34 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q31-20020a17090a17a200b0023750b69614so5257306pja.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 06:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678457373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ovPXs9MehGBYBIHk7wrYEU43S8Y6XZuCrY7g+yNUkVA=;
        b=juDmrOAi39O2cmvlqIA/LvXbua98bxzmMBl2GpixuujkLSg9TIm9we/0CqErDnlMFU
         KiLWlgeJPgJY/oMDhcNTs6eIv7fx6iWI2j8Q1LjDKzlFHWVikPpIeIIR5Ogrh0Fc5cAp
         ZsCL/yEo2LepP1lZ5n9c4FGZ3Q5yn3ojvYXiEfhxXwRnAU240NeAfyvAD5EXaDP8Ng03
         K6IweKFdTW/bQNs8e9box0dKPqu4jiu5LZaxgXNdqrPaLEmhC+Ik8s4DDlAd5n+4+Cxk
         hWi9vFawnyDVmmXEobEFoHKbg5FG3MS+sbwvEuBUsYCq5SyYhTbC/edUVp3tDGAeqZWN
         VA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678457373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovPXs9MehGBYBIHk7wrYEU43S8Y6XZuCrY7g+yNUkVA=;
        b=FN4unBv37+Kakj57GPhSH6T9HKccWXxwy719kynI6IRoBwgmfRU52w/GrZNc9knWYv
         Jqw/sHzTk9h0j1cK3id+d0GhaXb2kL1JdK9EnCzBFrXBPnMnKkdz8c9fTA0cghdcwYcG
         b7P8Qfl1Ao7TEdsDDPj0B7rBkKGbvOheYyeNdc1y3SGujP6Hz7vQqk+BeIFKnkysjz4T
         1Ln+maNksL3Y+ax7rdA4rKN4VspNh6M8GJPEu27XNOm1UZ2ylCfe3+PsPa7g3YAq2d5Y
         KSp1eb0aeb/5wXDFIaRa129yO6SP6NGk8Y/PIDglXpkFiljCsJIGTf3glCJXhAUIPLxy
         LKkA==
X-Gm-Message-State: AO0yUKUPqz/crdI0RDdcJmDIedcHB7m3+0RISm4nK0YJzbuNP0hGiVMm
        pjCRggrZD4Sh+h3lBsH2APTjs1hZ+IjF0IZzdOA=
X-Google-Smtp-Source: AK7set9aiW5npy5CKT6CRn0jn5y+r0nPWNQVWr9wn2+1K38DZc48LQjVsbVHHxfa8aNfrxkb6tocJA==
X-Received: by 2002:a17:90b:4d11:b0:23a:4875:6e07 with SMTP id mw17-20020a17090b4d1100b0023a48756e07mr25570275pjb.40.1678457373594;
        Fri, 10 Mar 2023 06:09:33 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id fu11-20020a17090ad18b00b002375c356b0csm6753pjb.19.2023.03.10.06.09.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 10 Mar 2023 06:09:32 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 0/4] Some fixes and cleanup for maple tree.
Date:   Fri, 10 Mar 2023 22:08:43 +0800
Message-Id: <20230310140848.94485-1-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
There are some fixes for maple tree that may be needed.
When reviewing the maple tree I thought some code was verbose so I did some
cleanup and I double checked the boundaries so there should be no errors. Less
code is easier to maintain, and you can ignore it if you don't like it.
All patches passed the maple tree test program.

Thanks,
Peng.

Peng Zhang (4):
  maple_tree: Fix get wrong data_end in mtree_lookup_walk()
  maple_tree: Simplify mas_wr_node_walk()
  maple_tree: Fix a potential concurrency bug in RCU mode
  maple_tree: Simplify the code of mas_mab_cp()

 lib/maple_tree.c | 76 ++++++++++--------------------------------------
 1 file changed, 16 insertions(+), 60 deletions(-)

-- 
2.20.1

