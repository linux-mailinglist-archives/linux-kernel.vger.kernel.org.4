Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A9C7359B0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjFSOf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjFSOfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:35:24 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A954E65
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 07:35:19 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id C32965FD29;
        Mon, 19 Jun 2023 17:35:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687185316;
        bh=vOptDmCkWp0Vg807Z3mpwjOiUhmN7B6iZRQCC7ASrDc=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Zi5W5Q0dJ3YXoA0SuuSNOheJK+QXKGhkZwCVaDSTmnaBlQDm05zkRQHmyAWBuxAeK
         d0xDuTf+Fw3EwzCyyspASZJpUl9dF1GbBS4T3Ex2cXWW/CnWzWjKgCzyYy2vQd7F9e
         gC5NBHKYbaLqJUplSZDUcvCz6ZYxWyGPHYEaMeaNJcuVGbutpfyY8HeE2uneU+Ncb9
         qMzo00sc2YRBSH0P2YekH1xzobAmuwVwo30Eqz1PI5bPdXWjtgWX9kBMg1qgsBq/9/
         8GVND0QuJZMzbGzv1fY9mspHqNDiJom1tznSjb40iyxdEMINvyMPGjO33Gn3LE+Mm3
         Hta1oXH7/oBjQ==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 19 Jun 2023 17:35:15 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 0/2] Add obj allocated counter for subpages
Date:   Mon, 19 Jun 2023 17:35:04 +0300
Message-ID: <20230619143506.45253-1-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/19 10:56:00 #21523989
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a count of allocated objects for each of the
zspage subpages. The main idea is that we can use the extra bytes
of the page_type field, because with PAGE_SIZE = 4096 we only use
the first two bytes there.

By storing the number of allocated objects, we can optimize, for
example, the running time of function find_allocated_obj, as well
as the entire compact algorithm as a whole. Also, counting allocated
objects has no effect on the performance of the entire zsmalloc:
bitwise operations are fast and we don't use any extra memory.

I also believe that we can also use this counter (maybe in the future)
in some other things, which will speed up the allocator even more.

Alexey Romanov (2):
  zsmalloc: add allocated objects counter for subpage
  zsmalloc: check empty page in find_alloced_obj

 mm/zsmalloc.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

-- 
2.38.1

