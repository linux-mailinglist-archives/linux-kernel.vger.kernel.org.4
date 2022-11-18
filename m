Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499C662F69E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 14:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241523AbiKRN4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 08:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKRN4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 08:56:03 -0500
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83D3B855
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:56:01 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
        id E763EC020; Fri, 18 Nov 2022 14:56:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1668779765; bh=2zvNrnwZIdlntvmhBz/DN7S4Glsc0P6Qb340ojUDEN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeAPOtRVbJ7Wva3/UzmTuuf7pmbZUYr64c0FxzoXadMWRdyZtMCZNm5J3k8BCIeQw
         i0bAV78KpveYWd8UC7vHHmsE2Lf71ObZCIIMmGc2GPrYoOWzeJ0qt+CoeqzbzO7bil
         5NC7290ME3DmigoT1BzBuEzeux9Ape6cGp8tZnmQEOyeZsDI1ZRBmpd5pdrxBRM7Ky
         PY96OSDWxN71Cq0biGnxl5ktsa8DSZkabg6MVdfHwqbL2PnI5JSKnLdp3WN1mE6lbY
         zg2rnnArrZao8DjmAbrjfTaTDzoXSm5t0n8CEd2VigSfiRGD/VAgEKNF9sT6VOHT09
         hW8B4Jcv1/B6Q==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id E9FDEC01B;
        Fri, 18 Nov 2022 14:56:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1668779764; bh=2zvNrnwZIdlntvmhBz/DN7S4Glsc0P6Qb340ojUDEN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M9LB1/hKMOS7DeTEEQ1/0eAXlpmjuJsOBW/Ir2WRkCVKs7K+eleFNnn5X5DwNO0qk
         QAWeOYLys+gqtNHBvt5w+EBeF6GBYNb2rhZf/qj+GM4UlPmci7lZiBFhTJSWaVThTY
         a58N+X6CJoeOQjCAfFWoK6V3gaDRBdy0Hgstqm1rwGnm5S0XqgSPZRZnEe2hzxCxQ3
         jT6oHNQITzzlYsuDi8YobMdqtP2cpPxbw7Psr0Wphh23A5U+xZLpC2yVQox05Dge1w
         +FhfTOP+8P+/jiFuTfUl196RscW3+Gf1X13NTlCtmgRPqr56rqMu1DeSrUTtlDWtd8
         lbHRDzRlH2+NQ==
Received: from localhost (odin.codewreck.org [local])
        by odin.codewreck.org (OpenSMTPD) with ESMTPA id e762b5e8;
        Fri, 18 Nov 2022 13:55:50 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     GUO Zihua <guozihua@huawei.com>, linux_oss@crudebyte.com,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 2/2] 9p: ensure logical size fits allocated size
Date:   Fri, 18 Nov 2022 22:55:42 +0900
Message-Id: <20221118135542.63400-2-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221118135542.63400-1-asmadeus@codewreck.org>
References: <20221118135542.63400-1-asmadeus@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

all buffers used to be msize big, but the size can now vary based on
message type and arguments.

Adjut p9_check_error() to check the logical size (request payload) fits
within the allocated size (capacity) rather than msize

Transports normally all check this when the packet is being read, but
might as well stay coherent.

Fixes: 60ece0833b6c ("net/9p: allocate appropriate reduced message buffers")
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---

I think with the previous patch this is purely redundant, but better
safe than sorry...
The main problem is that if we didn't find this before we already
overflowed a buffer, so this is quite late!

 net/9p/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/client.c b/net/9p/client.c
index aaa37b07e30a..45dcc9e5d091 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -514,7 +514,7 @@ static int p9_check_errors(struct p9_client *c, struct p9_req_t *req)
 	int ecode;
 
 	err = p9_parse_header(&req->rc, NULL, &type, NULL, 0);
-	if (req->rc.size >= c->msize) {
+	if (req->rc.size >= req->rc.capacity) {
 		p9_debug(P9_DEBUG_ERROR,
 			 "requested packet size too big: %d\n",
 			 req->rc.size);
-- 
2.38.1

