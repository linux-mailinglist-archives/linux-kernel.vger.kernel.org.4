Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8595072F4F9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbjFNGg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243199AbjFNGg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:36:26 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E412100
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:36:11 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4Qgwfx3ncnzBR5FR
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 14:36:09 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686724569; x=1689316570; bh=fBVC6xsCAum3rHr1Uv93Te96s9n
        vVxgWPdrXmRL9+Sw=; b=WIc7l9Sj2CmO+xpv9dpIDBuMXb8iq2GAddFlPEWb8PQ
        zGqGzc2KrpDKm12K/panI13SAIhCqQtEdqiI1Jdt2w2UahvfxsFf1o7ahpvgXqU0
        u6sgZ+LqWeuE7CvQkYHpyMZyPOUrgEZJMs5t1c+xUrvCwlwZkb0nGO7FfDlIaQ1c
        6FOmGECM75qas2+4qsdFRFOmK8dAVFRrKODeV5VCVFGnuzP3h4QvNhPNcqGGHzvP
        BHEhhpYYox7I26dJr7G66LIN4zDzkScN6vuHhwXRCerBNa+jKvijz4am71uHdRSe
        R1r/znAM8fc0XTWx2PZx6aBv2bym5BIiKMFMDiqtSyw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 3yv0cqD7QXAc for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 14:36:09 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4Qgwfx2NgVzBQgp9;
        Wed, 14 Jun 2023 14:36:09 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 14:36:09 +0800
From:   baomingtong001@208suo.com
To:     jpoimboe@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] objtool: remove unneeded variable from add_prefix_symbols()
In-Reply-To: <20230614063248.27844-1-luojianhong@cdjrlc.com>
References: <20230614063248.27844-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <92605b0b9589ffc556dfd0d279635dc9@208suo.com>
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

tools/objtool/check.c:4135:5-13: Unneeded variable: "warnings". Return 
"0".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  tools/objtool/check.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index a13c257f80dd..d12de0e2cf00 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4132,7 +4132,6 @@ static int add_prefix_symbols(struct objtool_file 
*file)
  {
      struct section *sec;
      struct symbol *func;
-    int warnings = 0;

      for_each_sec(file, sec) {
          if (!(sec->sh.sh_flags & SHF_EXECINSTR))
@@ -4146,7 +4145,7 @@ static int add_prefix_symbols(struct objtool_file 
*file)
          }
      }

-    return warnings;
+    return 0;
  }

  static int validate_symbol(struct objtool_file *file, struct section 
*sec,
