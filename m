Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E1E6B826E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjCMUM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjCMUMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:12:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0108B07E
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 13:12:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67FCF6147B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 20:12:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49BFC433EF;
        Mon, 13 Mar 2023 20:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678738347;
        bh=93oBMhuuWAg7pa428yDott1Pdcee67T+Qwe4d9PxvgM=;
        h=From:To:Cc:Subject:Date:From;
        b=lR2dCQZ75GzqqfbwgBo3G/Gad6lzit53Eq10yxIBT5ufJDzbpeAfwZ/nZVEwjYbxs
         uFutQQYE+rWYUxqtTc2q9vzougmNrmXi6iNbkhQl+fpJpZf2PjpG835zSBE3n44Fdm
         InQARHxj3aAVK5nowH/AyooQOjDSjHs3rGe8WEKF04iTOGX28ooUReP9PI875jPrNm
         gn1SrWKG/J591OYn+L8t6QJEyfxt4dt2l0R/DDyA9pyG3kRRxx75s1FE0A3az/yejJ
         sl1MO9kmdKESq+PlGLGgAfTW0mmIzknVt4jR4nqRxHHA2wgy20Hr8sal+Q0JmSGggt
         f6/9QCWbK1zLw==
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 0/3] remove shared memory structures
Date:   Mon, 13 Mar 2023 13:12:13 -0700
Message-Id: <20230313201216.924234-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series removes the use of rb_entry based on memory alignment which doesn't
look like a right design when considering various architectures/compilers.

 v2 from v1:
  - adjusted Eric's review
  - refactored gc.c further to clean up

Jaegeuk Kim (3):
  f2fs: factor out victim_entry usage from general rb_tree use
  f2fs: factor out discard_cmd usage from general rb_tree use
  f2fs: remove entire rb_entry sharing

 fs/f2fs/extent_cache.c | 241 ++++++++++++---------------------------
 fs/f2fs/f2fs.h         |  38 +------
 fs/f2fs/gc.c           | 139 ++++++++++++++---------
 fs/f2fs/gc.h           |  14 +--
 fs/f2fs/segment.c      | 252 +++++++++++++++++++++++++++--------------
 5 files changed, 324 insertions(+), 360 deletions(-)

-- 
2.40.0.rc1.284.g88254d51c5-goog

