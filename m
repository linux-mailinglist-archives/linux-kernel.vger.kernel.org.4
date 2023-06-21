Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86BDF73917F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjFUV2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjFUV2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459321988;
        Wed, 21 Jun 2023 14:28:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6D8F616DE;
        Wed, 21 Jun 2023 21:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72184C433C8;
        Wed, 21 Jun 2023 21:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687382907;
        bh=jMM5maLB1n7n18QpQ4GX1Q/OPQs1vFd4DPSmOfWIvKE=;
        h=Date:From:To:Cc:Subject:From;
        b=kllHomcKxmcBzBuz+hh7DjecvxYH5RCglPxKh1H80fArO2MG6W+WedoZkb7KIDcxB
         uJrF5+Q2dr0lmY0IcgGuuYfh0gDUfW6x9SqsbEdVbAPOc08jjFFpgVhPjychHWkWVG
         UHVlVHpCM+gzOqlhfnK24Az2TVP44ODC8tCovN8DO1XEgO8gHjZ01OmMBAcAxK1GLV
         puQQJ3I8RuF1zYbYBZHheXl47/2g30VZXVEeFxoopuGrryWobcL8Lr7gTvEuboE9gp
         PdBOde8gtOB73Lg6MgdEMdM6U0WJT8U4owN5uTKbSEaltrAl3QOHJiDkCtPX634s3y
         Q/RfrrW/uE30w==
Date:   Wed, 21 Jun 2023 15:29:22 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>
Cc:     linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] ksmbd: Use struct_size() helper in
 ksmbd_negotiate_smb_dialect()
Message-ID: <ZJNrsjDEfe0iwQ92@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prefer struct_size() over open-coded versions.

Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 fs/smb/server/smb_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index a7e81067bc99..b51f431ade01 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -266,7 +266,7 @@ static int ksmbd_negotiate_smb_dialect(void *buf)
 		if (smb2_neg_size > smb_buf_length)
 			goto err_out;
 
-		if (smb2_neg_size + le16_to_cpu(req->DialectCount) * sizeof(__le16) >
+		if (struct_size(req, Dialects, le16_to_cpu(req->DialectCount)) >
 		    smb_buf_length)
 			goto err_out;
 
-- 
2.34.1

