Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A95D6C796F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 09:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjCXIP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 04:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCXIP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 04:15:27 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D58123861
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:15:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bn14so635665pgb.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 01:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679645723;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Gte3KdIlbvBpKTWmWyAgQcCPANDQeniPU6SZWvI0BrM=;
        b=ScfrgAoCl1N+wKjFLznONp7Qh7CaXtuur0XCCOJ8WVx6wtx1HwUG2asADPWV7wGhqu
         STTNzkdasarroUswQrKy1vUCwuaSsF53JOBZwhl91ztlvbN/Lpot5j73nDWckiYwAD73
         rzDae4OPXX5ZJb4vY8Ef3pis2zK+qBWSN7lccD5qKur+3WrNYaUe+mjiTqs94tuH0jZf
         3Us0r55bkUHqMOr4xBdxwOQ0My1XdL1ZPNBiCFbHaFIzcZBSdHjXGLj6ScuAD0mijhQs
         imB4VIoMjcGtxqeYj0+5raDlb7TKjrvQauRQugf7iooICCFF23C8NS0DDOW4JRx6UIhE
         EIJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679645723;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gte3KdIlbvBpKTWmWyAgQcCPANDQeniPU6SZWvI0BrM=;
        b=TizZPfqAs01PRBwgH9/q7mJvn+mIReNLQToDzYF4lGyWrflUeW6g88oPPTPhATCmMJ
         PzLd9nUxPPhrZheNOpO/eY7f8U3q/CuwpZZOW2QhGo5UfmihwA/K49ziHvd/r1PVkMn1
         CXXDHp2CifriL+K5v3n+vE7CQ5w6aqGMUfZNjAOJiEA0YYGLwyRmQAMeDvTigrl5wJVZ
         Mzlz3F0O+T3cBo+GO23TsijGzey5Fa+frPwSKyiLAbMgoi7BST7Vc5DddUx54pbW0ZNL
         OT+VZKHN3E20sqq+RKsQ9b0wbfVGU0m8Ra/NLgk4NmjbE5cOOVWsQ8W+EkqM3gddkpKD
         HufQ==
X-Gm-Message-State: AAQBX9cdoWSrD2kUJ2Mn553bgwR+dPczh07eiKF41pQ60DBQQF8pv7xM
        7SpKhNn2wAiMIu8t/r4BDHOYJwVWCG81KCFewgPu5OWny2k5QJAr
X-Google-Smtp-Source: AKy350YTd9kahCaVbHy83/95dp8Pj/IQDt/5EPlUott562SdQ9M0SiawLCK30FO2voFhrkEMjpSHoeVRh0D2cKnKpe0=
X-Received: by 2002:a05:6a00:8c7:b0:625:cda5:c28c with SMTP id
 s7-20020a056a0008c700b00625cda5c28cmr1117597pfu.6.1679645723618; Fri, 24 Mar
 2023 01:15:23 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?57qq5a6P5a6+?= <jihongbin999@gmail.com>
Date:   Fri, 24 Mar 2023 16:15:13 +0800
Message-ID: <CAGeo-3e1emyUvqoQBz-v0CQQQasytb15SyhVVhiPwdheYgN=ow@mail.gmail.com>
Subject: [PATCH] memblock: Make memblock memblock_dbg info handle overflowing
 range @base + @size
To:     rppt@kernel.org
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow memblock users to specify range where @base + @size overflows,
This will cause the address range information in the debug output to
be displayed incorrectly.

For example, calling memblock_remove(1ULL << PHYS_MASK_SHIFT,
ULLONG_MAX) in arch/arm64/mm/init.c,
would be displayed as:
[ 0.000000] memblock_remove: [0x0001000000000000-0x0000fffffffffffe]
arm64_memblock_init+0x24/0x270
but we expect the output:
[ 0.000000] memblock_remove: [0x0001000000000000-0xffffffffffffffff]
arm64_memblock_init+0x24/0x270

Signed-off-by: Hongbin Ji <jhb_ee@163.com>
---
 mm/memblock.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index 25fd0626a9e7..567b99e4355d 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -700,7 +700,7 @@ static int __init_memblock
memblock_add_range(struct memblock_type *type,
 int __init_memblock memblock_add_node(phys_addr_t base, phys_addr_t size,
        int nid, enum memblock_flags flags)
 {
- phys_addr_t end = base + size - 1;
+ phys_addr_t end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;

  memblock_dbg("%s: [%pa-%pa] nid=%d flags=%x %pS\n", __func__,
       &base, &end, nid, flags, (void *)_RET_IP_);
@@ -721,7 +721,7 @@ int __init_memblock memblock_add_node(phys_addr_t
base, phys_addr_t size,
  */
 int __init_memblock memblock_add(phys_addr_t base, phys_addr_t size)
 {
- phys_addr_t end = base + size - 1;
+ phys_addr_t end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;

  memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
       &base, &end, (void *)_RET_IP_);
@@ -822,7 +822,7 @@ static int __init_memblock
memblock_remove_range(struct memblock_type *type,

 int __init_memblock memblock_remove(phys_addr_t base, phys_addr_t size)
 {
- phys_addr_t end = base + size - 1;
+ phys_addr_t end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;

  memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
       &base, &end, (void *)_RET_IP_);
@@ -854,7 +854,7 @@ void __init_memblock memblock_free(void *ptr, size_t size)
  */
 int __init_memblock memblock_phys_free(phys_addr_t base, phys_addr_t size)
 {
- phys_addr_t end = base + size - 1;
+ phys_addr_t end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;

  memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
       &base, &end, (void *)_RET_IP_);
@@ -865,7 +865,7 @@ int __init_memblock memblock_phys_free(phys_addr_t
base, phys_addr_t size)

 int __init_memblock memblock_reserve(phys_addr_t base, phys_addr_t size)
 {
- phys_addr_t end = base + size - 1;
+ phys_addr_t end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;

  memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
       &base, &end, (void *)_RET_IP_);
@@ -876,7 +876,7 @@ int __init_memblock memblock_reserve(phys_addr_t
base, phys_addr_t size)
 #ifdef CONFIG_HAVE_MEMBLOCK_PHYS_MAP
 int __init_memblock memblock_physmem_add(phys_addr_t base, phys_addr_t size)
 {
- phys_addr_t end = base + size - 1;
+ phys_addr_t end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;

  memblock_dbg("%s: [%pa-%pa] %pS\n", __func__,
       &base, &end, (void *)_RET_IP_);
@@ -1645,7 +1645,7 @@ void __init memblock_free_late(phys_addr_t base,
phys_addr_t size)
 {
  phys_addr_t cursor, end;

- end = base + size - 1;
+ end = base + min(size, PHYS_ADDR_MAX - base + 1) - 1;
  memblock_dbg("%s: [%pa-%pa] %pS\n",
       __func__, &base, &end, (void *)_RET_IP_);
  kmemleak_free_part_phys(base, size);
-- 
2.34.1
