Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F89372616E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:37:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240290AbjFGNhh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235696AbjFGNhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:37:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A000B19BF
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:37:34 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CFEA968BEB; Wed,  7 Jun 2023 15:37:30 +0200 (CEST)
Date:   Wed, 7 Jun 2023 15:37:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: rootwait regression in linux-next
Message-ID: <20230607133730.GA21195@lst.de>
References: <CAOMZO5A6MoDDLmQHoFCvewjpuPhC8_nbOVrKZR9d8Fn1d+3VgQ@mail.gmail.com> <20230607053758.GA20425@lst.de> <CAOMZO5AmGHHs-aiBJz5rDO6bV0f2sNjOYkqQDewGPOvw_zQ=5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5AmGHHs-aiBJz5rDO6bV0f2sNjOYkqQDewGPOvw_zQ=5w@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

I guess we need an ENODEV for that last case as well.  Please try this
patch:

diff --git a/block/early-lookup.c b/block/early-lookup.c
index 3ff0d2e4dcbfb8..48ea3e982419cc 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -181,7 +181,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 	*p = '\0';
 	*devt = blk_lookup_devt(s, part);
 	if (*devt)
-		return 0;
+		return -ENODEV;
 
 	/* try disk name without p<part number> */
 	if (p < s + 2 || !isdigit(p[-2]) || p[-1] != 'p')
@@ -190,7 +190,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 	*devt = blk_lookup_devt(s, part);
 	if (*devt)
 		return 0;
-	return -EINVAL;
+	return -ENODEV;
 }
 
 static int __init devt_from_devnum(const char *name, dev_t *devt)
