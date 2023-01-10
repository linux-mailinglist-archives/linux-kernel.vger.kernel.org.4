Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C1E46636CF
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 02:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235197AbjAJBkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 20:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbjAJBkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 20:40:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6483AA84;
        Mon,  9 Jan 2023 17:40:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E9BF6B810B3;
        Tue, 10 Jan 2023 01:40:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08390C433F0;
        Tue, 10 Jan 2023 01:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673314802;
        bh=0XRaSMKMF65v6PaaPxlzlon39xDFwuy4Mex263cEfq4=;
        h=Date:From:To:Cc:Subject:From;
        b=KwtiLhcCuBFU6WjfUQ6rJ94CB4jppcI6FBU8LY0zR9y5h79fvwT0pD7J6BLNB38Sj
         dbTceFPZmncr0NGW9yhrQOn3ITkOD2igAiua9u5Rpe8LbCTc8JaWbKB+w7XJVMsxe5
         gmRVI2NEZ+dTA4DEtFKOxN/COEj/NFZ6ZBU8AwLq7yo1jNcJ1HmA7+nCXf2WPVujVh
         nCW5qttlLdjJxes2Ypq54aRbsmlN+xjeb5rQXGuB4gr78vCwDVwJfGS1wjjl8Yp4qq
         pctcbBfSEACtXSpfYifbsWvD1NrgfpnU1+14USiscConIuEP/gNELSML0BuhqmwFbY
         MGiQ9b/tfoHVQ==
Date:   Mon, 9 Jan 2023 19:40:10 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] nvmem: u-boot-env: replace zero-length array with
 flexible-array member
Message-ID: <Y7zB+s2AC6O+CRR+@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated[1] and we are moving towards
adopting C99 flexible-array members instead. So, replace zero-length
array declaration in struct u_boot_env_image_broadcom with flex-array
member.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [2].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays [1]
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
Link: https://github.com/KSPP/linux/issues/78
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/nvmem/u-boot-env.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index 29b1d87a3c51..6b48637d9e64 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -45,7 +45,7 @@ struct u_boot_env_image_broadcom {
 	__le32 magic;
 	__le32 len;
 	__le32 crc32;
-	uint8_t data[0];
+	uint8_t data[];
 } __packed;
 
 static int u_boot_env_read(void *context, unsigned int offset, void *val,
-- 
2.34.1

