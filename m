Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F22C72F71F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238622AbjFNH7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbjFNH6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:58:55 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B250410E3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:58:54 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgyVN4WQwzBQgnn
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:58:52 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686729532; x=1689321533; bh=NmBlqB3Wco6KNBhW1vridMv7ppb
        m36ZYaIfeY2ybop4=; b=xuWE4hMwMb4iFh0cBf2fXgNjv2qjjKK5Zd4Sv5Atwuh
        6VhSkbVESkRR76T/LxAsfmvfHGre7x0IDtMhPejxIvEj1s/SWBe6z7nAPFCZj4cy
        1hTetmGENb5c7xqUWwYBLCKo9zXxa2kWy5wSrHUeXWJpTI6rHc0Jd76vQW4b3go0
        zr3w7k6vcw59Nl2Ve5R043hpoPAarN2eWiZAKMAVA4isyHo6AC/dA5Ysc1QDMAcZ
        KfJC0UkIoCoNFtrp4S1iT+3oW14vLz6ZfnABzBKw5h8QkGkmg/tW4xE/nZQM46hh
        e8Ig6WeyJdBuXvKbDf7Cecu/s0uA63j8JTzBGB8RRrg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z-XwOrkHjt0p for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 15:58:52 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgyVN2VvMzBQJYp;
        Wed, 14 Jun 2023 15:58:52 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 15:58:52 +0800
From:   baomingtong001@208suo.com
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dm log: remove unneeded variable
In-Reply-To: <20230614075528.11930-1-luojianhong@cdjrlc.com>
References: <20230614075528.11930-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <d63fefa76e501dc05353a7d682d83541@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following coccicheck warning:

drivers/md/dm-snap-transient.c:94:14-16: Unneeded variable: "sz". Return 
"0".
drivers/md/dm-ps-historical-service-time.c:240:14-16: Unneeded variable: 
"sz". Return "0".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  drivers/md/dm-log.c | 6 ++----
  1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-log.c b/drivers/md/dm-log.c
index f9f84236dfcd..38bcdd5ddb21 100644
--- a/drivers/md/dm-log.c
+++ b/drivers/md/dm-log.c
@@ -793,7 +793,6 @@ static region_t core_get_sync_count(struct 
dm_dirty_log *log)
  static int core_status(struct dm_dirty_log *log, status_type_t status,
                 char *result, unsigned int maxlen)
  {
-    int sz = 0;
      struct log_c *lc = log->context;

      switch (status) {
@@ -812,13 +811,12 @@ static int core_status(struct dm_dirty_log *log, 
status_type_t status,
          break;
      }

-    return sz;
+    return 0;
  }

  static int disk_status(struct dm_dirty_log *log, status_type_t status,
                 char *result, unsigned int maxlen)
  {
-    int sz = 0;
      struct log_c *lc = log->context;

      switch (status) {
@@ -841,7 +839,7 @@ static int disk_status(struct dm_dirty_log *log, 
status_type_t status,
          break;
      }

-    return sz;
+    return 0;
  }

  static struct dm_dirty_log_type _core_type = {
