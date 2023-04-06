Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 152C56D99A0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239046AbjDFO3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbjDFO24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:28:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEFE8A5B;
        Thu,  6 Apr 2023 07:28:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DBBA60DEC;
        Thu,  6 Apr 2023 14:28:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CF8C433EF;
        Thu,  6 Apr 2023 14:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680791334;
        bh=PgjoeleWbPd7GMFZN7QiM6u68Sl9VVb7kxLeMWqvAZI=;
        h=Date:From:To:Cc:Subject:From;
        b=sWWo8JWXkw6mg9upeDBqXewzR+2cCDbpfuDDv0j80fGtMsyb4qJQznDV8yPGICHCy
         QoXTsBC4UHID/BDVJ9sKpSdLdy+7YyqEkWpT0YzugzTUHMaIb3SssFMrZNIY66CBo7
         9pg7TO32raKSkP3m1NMvXdc3mSjlpA7yYoBHOTgZO5fO86t0tO7swkbGYISRCsX8mF
         wIQ46hStd03A8aJIa5F3M2npcLagmAFS32XJ+jwSpRJXN/EpxDvBY3fDiZVb3uPjOR
         le5CgR2gi4vCu4YMr8I0hxZimdr39y7cuvlKKS08PxAPb1T9QWjaMuHtIrWjSuwNRC
         DIoOBCTBaub1Q==
Date:   Thu, 6 Apr 2023 08:29:35 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] s390/fcx: Replace zero-length array with
 flexible-array member
Message-ID: <ZC7XT5prvoE4Yunm@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zero-length arrays are deprecated [1] and have to be replaced by C99
flexible-array members.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE routines
on memcpy() and help to make progress towards globally enabling
-fstrict-flex-arrays=3 [2]

Link: https://github.com/KSPP/linux/issues/78 [1]
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [2]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 arch/s390/include/asm/fcx.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/fcx.h b/arch/s390/include/asm/fcx.h
index b8a028a36173..29784b4b44f6 100644
--- a/arch/s390/include/asm/fcx.h
+++ b/arch/s390/include/asm/fcx.h
@@ -286,7 +286,7 @@ struct tccb_tcat {
  */
 struct tccb {
 	struct tccb_tcah tcah;
-	u8 tca[0];
+	u8 tca[];
 } __attribute__ ((packed, aligned(8)));
 
 struct tcw *tcw_get_intrg(struct tcw *tcw);
-- 
2.34.1

