Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AEA70845E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 16:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjERO4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 10:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjEROzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 10:55:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37DF11C
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 07:55:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C7FC64FED
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 14:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E965AC433D2;
        Thu, 18 May 2023 14:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684421728;
        bh=rJ8Zak39w7CtOYLtgafcmk/YeBO+i/iIqJ6y3UtNwdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LQs0Ki8WszLf3yHy4ktR898ITP5BaljyV9uKw+xdZer8uJPq9lyoJ1j57V5DZfLP7
         wIsSRJ/KqTocra7feyZTq/H8hA4CboUe2DaEbbkgVKvZVbH4OD2IBX6H8mdueCe4pH
         /9G7OXi8BHiOWWyjMniPKsu+XEdzI54urT50yEqNJ/XU0ywcP74D1QmaUI+3B+vizO
         WjMK9ZjAZGfR8KtUFbUO9HGjrwBRWGFkezP3Nk6DLxzo+1mIjXZWdH7ZS90EYdBcfp
         OOagrVCYS1d2qsZGfDTHb2jd1OfRwe878Vu5d030Ff/GR2YvZaYVJbFlltQUebz8nr
         y/x/5mKeU3qcw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 292CBCE190B; Thu, 18 May 2023 07:55:23 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 nolibc 10/15] tools/nolibc: use __inline__ syntax
Date:   Thu, 18 May 2023 07:55:16 -0700
Message-Id: <20230518145521.3806117-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
References: <4817a4dc-69e6-4937-84d5-f2f630ff646c@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Weißschuh <linux@weissschuh.net>

When building in strict C89 mode the "inline" keyword is unknown.
While "__inline__" is non-standard it is used by the kernel headers
themselves.
So the used compilers would have to support it or the users shim it with
a #define.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/stdlib.h | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index 894c955d027e..902162f80337 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -102,7 +102,7 @@ char *_getenv(const char *name, char **environ)
 	return NULL;
 }
 
-static inline __attribute__((unused,always_inline))
+static __inline__ __attribute__((unused,always_inline))
 char *getenv(const char *name)
 {
 	extern char **environ;
@@ -231,7 +231,7 @@ int utoh_r(unsigned long in, char *buffer)
 /* converts unsigned long <in> to an hex string using the static itoa_buffer
  * and returns the pointer to that string.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *utoh(unsigned long in)
 {
 	utoh_r(in, itoa_buffer);
@@ -293,7 +293,7 @@ int itoa_r(long in, char *buffer)
 /* for historical compatibility, same as above but returns the pointer to the
  * buffer.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *ltoa_r(long in, char *buffer)
 {
 	itoa_r(in, buffer);
@@ -303,7 +303,7 @@ char *ltoa_r(long in, char *buffer)
 /* converts long integer <in> to a string using the static itoa_buffer and
  * returns the pointer to that string.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *itoa(long in)
 {
 	itoa_r(in, itoa_buffer);
@@ -313,7 +313,7 @@ char *itoa(long in)
 /* converts long integer <in> to a string using the static itoa_buffer and
  * returns the pointer to that string. Same as above, for compatibility.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *ltoa(long in)
 {
 	itoa_r(in, itoa_buffer);
@@ -323,7 +323,7 @@ char *ltoa(long in)
 /* converts unsigned long integer <in> to a string using the static itoa_buffer
  * and returns the pointer to that string.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *utoa(unsigned long in)
 {
 	utoa_r(in, itoa_buffer);
@@ -367,7 +367,7 @@ int u64toh_r(uint64_t in, char *buffer)
 /* converts uint64_t <in> to an hex string using the static itoa_buffer and
  * returns the pointer to that string.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *u64toh(uint64_t in)
 {
 	u64toh_r(in, itoa_buffer);
@@ -429,7 +429,7 @@ int i64toa_r(int64_t in, char *buffer)
 /* converts int64_t <in> to a string using the static itoa_buffer and returns
  * the pointer to that string.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *i64toa(int64_t in)
 {
 	i64toa_r(in, itoa_buffer);
@@ -439,7 +439,7 @@ char *i64toa(int64_t in)
 /* converts uint64_t <in> to a string using the static itoa_buffer and returns
  * the pointer to that string.
  */
-static inline __attribute__((unused))
+static __inline__ __attribute__((unused))
 char *u64toa(uint64_t in)
 {
 	u64toa_r(in, itoa_buffer);
-- 
2.40.1

