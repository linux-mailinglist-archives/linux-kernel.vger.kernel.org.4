Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08CD6B7000
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjCMHSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCMHSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:18:34 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE6322A03
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678691902; x=1710227902;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UTvS6bH+xEecuSdoABqAcL5lGczgRjF8mO/bWBDGeaE=;
  b=SFNpZxUhHAyS2pk02GecwqVPkpDcQI9bc4h9jvIq4z9iX+KpkXZB9xfW
   7bw9qdlRtu+cwXoWBQ9uJlQGvFItkp+thKe2oIe4skXNpI+0RTXJk/VM7
   ChMy1t8VJtA2oubzAttH6WJltHlssXggV8UUh5rpluTNVhXQVG3v6/Jwx
   /Spwzl6D79mMYaoUZjoXm3H+RSx5JzxVJoaf9aQG2d0rd7/legu1YH/k9
   WMwWmV3GfO3wBCgje5gV3B6k3Q/+cI+xTLw+SdcUSfR+dgH5s0PYTewbX
   7r4SEQq97XyZ1PiZ2SgGyA57P3E4MIcQISvymntNkHBpK8//PtcwuQrx9
   A==;
X-IronPort-AV: E=Sophos;i="5.98,256,1673910000"; 
   d="scan'208";a="29633087"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 13 Mar 2023 08:18:17 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Mon, 13 Mar 2023 08:18:17 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Mon, 13 Mar 2023 08:18:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678691897; x=1710227897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UTvS6bH+xEecuSdoABqAcL5lGczgRjF8mO/bWBDGeaE=;
  b=fsr+qiQSRvzHVr4IDA/vBWxzbhf8RZHSk8osvCbXUKn9JxnRlC2lkLbB
   +PGoWzQfJFdno935egoKYSzLJqXKrx9rzLF4jEPlaPEflYqKu4Xi//vCa
   q1ud6fgy3zm7necnjaRFGH1NYGq2MoxfJBNR9CzyL7lseyyJrYR4pNTDX
   I9jwkF+UlFOeYwPeroQEo0rf6fANaTusPUsU+LwId0cxDYtmiLsMQG6Hg
   2ybG+3jze8bTQ1nR/aN69Cd18CoN9zShArZLmW0TNFucsDG2t/yCKBvop
   N605p3BSREskRA++RZEBpwBDUZ+1u3x3N2niZxnTzbMnQiZZsDCOW3TMR
   w==;
X-IronPort-AV: E=Sophos;i="5.98,256,1673910000"; 
   d="scan'208";a="29633086"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 13 Mar 2023 08:18:16 +0100
Received: from steina-w.tq-net.de (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id BCF27280072;
        Mon, 13 Mar 2023 08:18:16 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] regmap: cache: Fix return value
Date:   Mon, 13 Mar 2023 08:18:12 +0100
Message-Id: <20230313071812.13577-2-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313071812.13577-1-alexander.stein@ew.tq-group.com>
References: <20230313071812.13577-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

checkpatch.pl warned:
WARNING: ENOSYS means 'invalid syscall nr' and nothing else
Align the return value to regcache_drop_region().

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/base/regmap/regcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index 8031007b4887d..0482cf1c3231b 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -242,7 +242,7 @@ int regcache_read(struct regmap *map,
 	int ret;
 
 	if (map->cache_type == REGCACHE_NONE)
-		return -ENOSYS;
+		return -EINVAL;
 
 	BUG_ON(!map->cache_ops);
 
-- 
2.34.1

