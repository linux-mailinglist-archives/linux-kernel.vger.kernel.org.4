Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603976A15D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 05:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjBXE1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 23:27:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjBXE12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 23:27:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B78F2CFD2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 20:27:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A73E617AF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 04:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD8BBC433D2;
        Fri, 24 Feb 2023 04:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677212843;
        bh=X/P6KRyU7oT0fpeqdRKwmkQX6R7d8WIchAugB9Cbtls=;
        h=From:To:Cc:Subject:Date:From;
        b=tlNisvho+7Rw65blcQhOddtNIrpkAC+OHKxdehzJtzGyMGElgpN+yKddoylKYRSuj
         +CcQQoGjKdhPZR9IIknN4p+KhJHamJnurCrZTTVoCxgNiRMsQN3lk4tw/bzeeGIqNm
         f73ToMkVuO9rOqh4NCjy+A3hvtGEVepiupRe3RgP0aDlxaly8K0WnuZzXlgkMkt5S1
         YzxOFmhrbxK3eClD4NlkVfDY6TbzRmydz8gs92Hz9qzhSq5EOByU08prCsPOSIU3gF
         i+2K43X6VBYn1vZuKhE+Xuc08HvUEMoVV21J1Xd0EEAuldYFejXiH8f+l8WYzHV/xp
         9vWQYn/bBDD/A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Li Lingfeng <lilingfeng3@huawei.com>,
        Yu Kuai <yukuai1@huaweicloud.com>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] lib: parser: update documentation for match_NUMBER functions
Date:   Thu, 23 Feb 2023 20:26:18 -0800
Message-Id: <20230224042618.9092-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Eric Biggers <ebiggers@google.com>

commit 67222c4ba8af ("lib: parser: optimize match_NUMBER apis to use
local array") removed -ENOMEM as a possible return value, so update the
comments accordingly.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 lib/parser.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/lib/parser.c b/lib/parser.c
index 2b5e2b480253..f4eafb9d74e6 100644
--- a/lib/parser.c
+++ b/lib/parser.c
@@ -133,7 +133,7 @@ EXPORT_SYMBOL(match_token);
  * as a number in that base.
  *
  * Return: On success, sets @result to the integer represented by the
- * string and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ * string and returns 0. Returns -EINVAL or -ERANGE on failure.
  */
 static int match_number(substring_t *s, int *result, int base)
 {
@@ -165,7 +165,7 @@ static int match_number(substring_t *s, int *result, int base)
  * as a number in that base.
  *
  * Return: On success, sets @result to the integer represented by the
- * string and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ * string and returns 0. Returns -EINVAL or -ERANGE on failure.
  */
 static int match_u64int(substring_t *s, u64 *result, int base)
 {
@@ -189,7 +189,7 @@ static int match_u64int(substring_t *s, u64 *result, int base)
  * Description: Attempts to parse the &substring_t @s as a decimal integer.
  *
  * Return: On success, sets @result to the integer represented by the string
- * and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ * and returns 0. Returns -EINVAL or -ERANGE on failure.
  */
 int match_int(substring_t *s, int *result)
 {
@@ -205,7 +205,7 @@ EXPORT_SYMBOL(match_int);
  * Description: Attempts to parse the &substring_t @s as a decimal integer.
  *
  * Return: On success, sets @result to the integer represented by the string
- * and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ * and returns 0. Returns -EINVAL or -ERANGE on failure.
  */
 int match_uint(substring_t *s, unsigned int *result)
 {
@@ -228,7 +228,7 @@ EXPORT_SYMBOL(match_uint);
  * integer.
  *
  * Return: On success, sets @result to the integer represented by the string
- * and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ * and returns 0. Returns -EINVAL or -ERANGE on failure.
  */
 int match_u64(substring_t *s, u64 *result)
 {
@@ -244,7 +244,7 @@ EXPORT_SYMBOL(match_u64);
  * Description: Attempts to parse the &substring_t @s as an octal integer.
  *
  * Return: On success, sets @result to the integer represented by the string
- * and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ * and returns 0. Returns -EINVAL or -ERANGE on failure.
  */
 int match_octal(substring_t *s, int *result)
 {
@@ -260,7 +260,7 @@ EXPORT_SYMBOL(match_octal);
  * Description: Attempts to parse the &substring_t @s as a hexadecimal integer.
  *
  * Return: On success, sets @result to the integer represented by the string
- * and returns 0. Returns -ENOMEM, -EINVAL, or -ERANGE on failure.
+ * and returns 0. Returns -EINVAL or -ERANGE on failure.
  */
 int match_hex(substring_t *s, int *result)
 {
-- 
2.39.2

