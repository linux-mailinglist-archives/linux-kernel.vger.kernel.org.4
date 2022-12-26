Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5966E656359
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 15:29:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiLZO3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 09:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbiLZO2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 09:28:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0FA2604
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 06:25:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 138CBB80CB0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 14:25:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A19C433D2;
        Mon, 26 Dec 2022 14:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672064736;
        bh=BhRFMETNlXTsYiPgfUz62y1WvJ6pI3PsWrIYNgOgGx4=;
        h=From:To:Cc:Subject:Date:From;
        b=kDhmHC8y6+6MFtpFn/p4pt8qEJ6hp2MEH9Oxo8RCz1rnJapNuKc0w5zEm1IVlvQwY
         7kcVb6IfseLklZI+VzRErl+7lZUg/iwjspTcbCnxdP1geJPh+OvnpOckK+u4wW/8nL
         a8Z68fnKdxKBqI/60984R9eZw3CGs0Uq4rG+4J1C3oQqgaNXtTbLeFgUTAVTDYvVGy
         +2B/E0lI6/SJLBzJ5DxYe8rAPxbB5MudIc6+9xLXH3qMeIsadbe144m2DKC1NWoa15
         1IYtBUnAbCCvzReU8aFWQPsBxFmyjGgbl7s1IXdwhXU0aijBdy59Ca+WzXdN9lW2P7
         cNS27d8MDbSYw==
Received: by pali.im (Postfix)
        id F24D99D7; Mon, 26 Dec 2022 15:25:33 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] fat: Fix return value of vfat_bad_char() and vfat_replace_char() functions
Date:   Mon, 26 Dec 2022 15:25:12 +0100
Message-Id: <20221226142512.13848-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These functions returns boolean value not wide character.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/fat/namei_vfat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index 21620054e1c4..0735e4f0aeed 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -200,7 +200,7 @@ static const struct dentry_operations vfat_dentry_ops = {
 
 /* Characters that are undesirable in an MS-DOS file name */
 
-static inline wchar_t vfat_bad_char(wchar_t w)
+static inline bool vfat_bad_char(wchar_t w)
 {
 	return (w < 0x0020)
 	    || (w == '*') || (w == '?') || (w == '<') || (w == '>')
@@ -208,7 +208,7 @@ static inline wchar_t vfat_bad_char(wchar_t w)
 	    || (w == '\\');
 }
 
-static inline wchar_t vfat_replace_char(wchar_t w)
+static inline bool vfat_replace_char(wchar_t w)
 {
 	return (w == '[') || (w == ']') || (w == ';') || (w == ',')
 	    || (w == '+') || (w == '=');
-- 
2.20.1

