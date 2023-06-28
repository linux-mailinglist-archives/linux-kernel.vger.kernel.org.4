Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E38E7417A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 19:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjF1R45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 13:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjF1Rz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:55:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13207ED;
        Wed, 28 Jun 2023 10:55:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 935F16141D;
        Wed, 28 Jun 2023 17:55:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABBEC433C9;
        Wed, 28 Jun 2023 17:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687974958;
        bh=7gxVFglFtXDu/AnNBVBeHPlv7TElOsSUgfmrlZBHPf0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VAGQADKajLlW1y4fkCGn3p1Dl/RgpYmd4NHIx7S2mGSb25bdu9R0GYH1edCFjDrWT
         tXuz1a1LhxR9StVgXR8q7G8ihL/kHAHNTNvO02H6CAtQ53yaCW8SQxL91q+IcPztHO
         x8k9ggymNK9nKqeSCuiHLU8YFCgb/bcppPK6nN0BDcvaxUzXBhxLzrU0buDQaaxdY9
         P8nN1N9Z6XKDbOIYmGbz83ZnbMmWUFe74RzFn5BkhzaXhX5Kqe3n2fZ78BKFnP/5dh
         A2L1fOV2uIw7mb2Vyd7sBLkGNsY3X2Vw7VjYyvnMt6jxpNh8HI9rlL4fD0cP0LurMh
         bK1wlm/YrdjmA==
Date:   Wed, 28 Jun 2023 11:56:52 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 07/10][next] scsi: aacraid: Replace one-element array with
 flexible-array member in struct user_sgmap64
Message-ID: <bf0845f7cbe2a507a54b9d5bb35a22a1ca265178.1687974498.git.gustavoars@kernel.org>
References: <cover.1687974498.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1687974498.git.gustavoars@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace one-element array with flexible-array member in struct
user_sgmap64.

This results in no differences in binary output.

Issue found with the help of Coccinelle and audited and fixed,
manually.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/ClangBuiltLinux/linux/issues/1851
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/scsi/aacraid/aacraid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
index 87015dd2abd9..94eb83d38be6 100644
--- a/drivers/scsi/aacraid/aacraid.h
+++ b/drivers/scsi/aacraid/aacraid.h
@@ -522,7 +522,7 @@ struct sgmap64 {
 
 struct user_sgmap64 {
 	u32		count;
-	struct user_sgentry64 sg[1];
+	struct user_sgentry64 sg[];
 };
 
 struct sgmapraw {
-- 
2.34.1

