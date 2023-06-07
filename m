Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 616E072536D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbjFGFiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjFGFiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:38:02 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38ECD19AE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 22:38:02 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 086EA68AA6; Wed,  7 Jun 2023 07:37:59 +0200 (CEST)
Date:   Wed, 7 Jun 2023 07:37:58 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: rootwait regression in linux-next
Message-ID: <20230607053758.GA20425@lst.de>
References: <CAOMZO5A6MoDDLmQHoFCvewjpuPhC8_nbOVrKZR9d8Fn1d+3VgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5A6MoDDLmQHoFCvewjpuPhC8_nbOVrKZR9d8Fn1d+3VgQ@mail.gmail.com>
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

can you try this patch?

diff --git a/block/early-lookup.c b/block/early-lookup.c
index 3ff0d2e4dcbfb8..ca3b4f494c9330 100644
--- a/block/early-lookup.c
+++ b/block/early-lookup.c
@@ -174,7 +174,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
 	while (p > s && isdigit(p[-1]))
 		p--;
 	if (p == s || !*p || *p == '0')
-		return -EINVAL;
+		return -ENOENT;
 
 	/* try disk name without <part number> */
 	part = simple_strtoul(p, NULL, 10);
