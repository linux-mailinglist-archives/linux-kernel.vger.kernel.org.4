Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4449272F6FD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 09:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243580AbjFNHxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 03:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243512AbjFNHxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 03:53:32 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFED62967
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 00:52:36 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgyLB2SLJzBQJZ9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 15:51:46 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686729106; x=1689321107; bh=GbMA96N6fkIEVSOvqvmSVjZbJ5G
        6XDpFunUoVOB6GoU=; b=kM8oYGCEJjyTO2baJyQ492clo6dnj+U0JIliQ8SQhXC
        E8PqTlCrT63Gs/6cPO7yBkzFf0gizzy8jGGFzvr/kJ4Sow48yHeducTpPSMNN0xJ
        rc7wvrAZWTdHAdV2PjGwMgp2QbOWBoDKElDO3jUcToZq3LE10aJvWnFEo0RaRz19
        GluMbsjJ0sDVnp2yi11cjtu5ek0Y4BP0FmNEj6Gqm1/ZT/G5C6+Kngmdnf+ZF5kZ
        dE1XaILka6lAQlC12fb8F1MJHvQ2da1womIi+5EiYOewbrDJs7Rwsh7e3Pnc6M+1
        VzomZHsEk4Ncq0vDZLfD77RrYB0+awQLlMZegJiJELQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BiLiVItnQGPO for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 15:51:46 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgyLB0MFCzBQJYq;
        Wed, 14 Jun 2023 15:51:46 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 15:51:45 +0800
From:   baomingtong001@208suo.com
To:     agk@redhat.com, snitzer@kernel.org, dm-devel@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] dm: remove unneeded variable from ql_status()
In-Reply-To: <20230614074927.4072-1-luojianhong@cdjrlc.com>
References: <20230614074927.4072-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <6b5a89f9478bae992bedf18dead1e60c@208suo.com>
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

drivers/md/dm-ps-queue-length.c:90:14-16: Unneeded variable: "sz". 
Return "0".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  drivers/md/dm-ps-queue-length.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm-ps-queue-length.c 
b/drivers/md/dm-ps-queue-length.c
index e305f05ad1e5..59411d0a2083 100644
--- a/drivers/md/dm-ps-queue-length.c
+++ b/drivers/md/dm-ps-queue-length.c
@@ -87,7 +87,6 @@ static void ql_destroy(struct path_selector *ps)
  static int ql_status(struct path_selector *ps, struct dm_path *path,
               status_type_t type, char *result, unsigned int maxlen)
  {
-    unsigned int sz = 0;
      struct path_info *pi;

      /* When called with NULL path, return selector status/args. */
@@ -109,7 +108,7 @@ static int ql_status(struct path_selector *ps, 
struct dm_path *path,
          }
      }

-    return sz;
+    return 0;
  }

  static int ql_add_path(struct path_selector *ps, struct dm_path *path,
