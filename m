Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A263452E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 21:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234596AbiKVUIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 15:08:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234372AbiKVUIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 15:08:36 -0500
Received: from lizzy.crudebyte.com (lizzy.crudebyte.com [91.194.90.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F2EB406B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 12:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Cc:To:Subject:Date:From:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
        Content-Description; bh=+Lw5Yj6TM+hHPWr+jQTkw9CKbMZOMA2vynPfEzxVjGo=; b=eTkNq
        DEJGfm5EinjESW5SPfc+fH9xo0gJHL/h03ZqpclUoQQQXFv0ZLSwhb5BlB+9e9aOiGvCwTRDsX/D5
        4j1JUcc4URGRLo3e18YP10Rsj8MyV4/WGq4/+zRLyrWcD3O9YB1XDwIHFd+V1f4MNzirKbRYhTnt7
        6HUrNy/JaEWhY3Eh1G3R7b8/dKW5hdzk+f5UuA3FQboCnU6Y5CJjAtlPXf3BYZyze8KZUSw/ZhZeX
        jDli/SxpX7XKTTX8/XBEpKNUE6bcuwPOLUwD+z3QLx4LdqscLfoKx/WStfgh3jbDPFv2KLVwE7gJw
        vzhcJFlGlNmuaX1iXBZs/r9PeOB0g==;
Message-Id: <cover.1669144861.git.linux_oss@crudebyte.com>
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
Date:   Tue, 22 Nov 2022 20:21:01 +0100
Subject: [PATCH v2 0/2] net/9p: fix response size check in p9_check_errors()
To:     Dominique Martinet <asmadeus@codewreck.org>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        GUO Zihua <guozihua@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow-up fix for:
https://lore.kernel.org/linux-kernel/Y3hADWgV9JeajmfF@codewreck.org/

Dominique, I moved `zc` to the end of the structure to somewhat address
the layout padding. If you prefer a function argument in the first place,
let me know and I'll send a v3.

v1 -> v2:

  * Move `zc` to end of struct p9_rstatf (to avoid huge padding).
    [patch 1]

  * Fix format specifier for `capacity` (reported by kernel test bot).
    [patch 2]

  * Fix code style. [patch 1..2]

  * Extend and adjust commit log messages. [patch 1..2]

Christian Schoenebeck (2):
  net/9p: distinguish zero-copy requests
  net/9p: fix response size check in p9_check_errors()

 include/net/9p/9p.h |  2 ++
 net/9p/client.c     | 13 +++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

-- 
2.30.2

