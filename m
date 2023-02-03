Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D279688C7F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 02:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBCB2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 20:28:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjBCB2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 20:28:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A1D2CFD0;
        Thu,  2 Feb 2023 17:28:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E3CAB8289F;
        Fri,  3 Feb 2023 01:28:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FACC433EF;
        Fri,  3 Feb 2023 01:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675387686;
        bh=YDq9DRcIdKEp/Kugr9aBiusQ8u+FDDTKTPm1TZDr/f4=;
        h=Date:From:To:Cc:Subject:From;
        b=gvqoqpOSSNib2tlfvK8CGHUCDMHtfqmB61mU6rLB0+nAxmGZ8BWrhDDfM0G/8/mT8
         cZ3rqvfGxy6jIdw2sV1vLbFUWMYm6y0SleW7smBAxgJdOWDs1yWrpfOECUkpRQnOAH
         yLzOkQNAa27uTG95itmWYHH5KldEqiBj12toXdWvkYjGRPJEZpcKkUwT304JFofCLT
         ayZ3USV8QVWPt7fMVmOfHtwotw1VEhzVEz4yoN4NXm1RSBKYQ/4/V5w3507ctN/SdZ
         h1JaPYp69xj72VZ274xfpShjvcYtcjjUo8ILQ5FAl78Ld9M1ARS7arvgEa47b2j16W
         FILdpib+E6imQ==
Date:   Thu, 2 Feb 2023 19:28:23 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] xen: Replace one-element array with flexible-array
 member
Message-ID: <Y9xjN6Wa3VslgXeX@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element array with flexible-array
member in struct xen_page_directory.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

This results in no differences in binary output.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/255
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/xen/xen-front-pgdir-shbuf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/xen-front-pgdir-shbuf.c b/drivers/xen/xen-front-pgdir-shbuf.c
index 5c0b5cb5b419..b52e0fa595a9 100644
--- a/drivers/xen/xen-front-pgdir-shbuf.c
+++ b/drivers/xen/xen-front-pgdir-shbuf.c
@@ -30,7 +30,7 @@
 struct xen_page_directory {
 	grant_ref_t gref_dir_next_page;
 #define XEN_GREF_LIST_END	0
-	grant_ref_t gref[1]; /* Variable length */
+	grant_ref_t gref[]; /* Variable length */
 };
 
 /**
-- 
2.34.1

