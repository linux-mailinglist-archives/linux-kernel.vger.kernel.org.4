Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50BC6F5237
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjECHuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjECHuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:50:01 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1C42120;
        Wed,  3 May 2023 00:49:59 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 56CD6C020; Wed,  3 May 2023 09:49:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1683100198; bh=1Jr6SQdK7M5acrT1P40JH2SkrtTm7xWnHTF1Ugx2KeU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=W4N9wVWMI0TNJRmVaZm0QoBKG5yEhDrFZ8sLwmEMRgBUt8C6GgPYs570a4bkSHTqw
         nJTLRGmmNAsgEwuvya5QO7nNah4VQ7S62Arg7h/Uu7hjSkRwURbOoYwRm4yRwV0/8p
         ioVKL7sScDR67F09ue5udveu8Zl4NO6sAo1k4met6v/7evU9R8B53jbDaFafbWFJXJ
         akt65MyknhLc5BRpUuttrHSLya5bU6OTv494v75ZgMJ+vP18iA2bxspPG1Kzk/JSmN
         WXLcsGK559ZR3PGPFijO3sJ7YkZbEsKWhA6pemPtAfZr6AwHzrFNhHCviJPrQNPIMN
         SdT4/dYKZjxEw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id D6642C01C;
        Wed,  3 May 2023 09:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1683100197; bh=1Jr6SQdK7M5acrT1P40JH2SkrtTm7xWnHTF1Ugx2KeU=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=U5F1hQdmW5ecqDVHupT+OXuCEXwrmJ7mLGKMRUhn+5RZ5qdM0t2ppZsiNIBs7x34n
         0t9McldIPzIvHayubcwiej9BZREEEqwqiArHSanQQEKOVoEbtM1D5l2OBOIDNu9jkZ
         mm1GV8JjjRKarGYoP98Q3oo+E5wVC90oI9bOOEal0sxAnqXzqrf/RTd7TbvrKEapyY
         O8wfjcfQrn/UZaJcYOavkT7arcTjO3c+DBNytsWfXfZCNAXPI3wI6AO0ePRCPmN+BU
         WHMCxpgSAz6mTLMsl+PVrIfQjzbfsaoYyqIhrXIK+gcsYxW0h+Xp8HufnN8dvU8V+Q
         iFe/ifeg3nPEA==
Received: from [127.0.0.2] (localhost [::1])
        by odin.codewreck.org (OpenSMTPD) with ESMTP id b4109f14;
        Wed, 3 May 2023 07:49:37 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
Date:   Wed, 03 May 2023 16:49:27 +0900
Subject: [PATCH v2 3/5] 9p: virtio: make sure 'offs' is initialized in
 zc_request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230427-scan-build-v2-3-bb96a6e6a33b@codewreck.org>
References: <20230427-scan-build-v2-0-bb96a6e6a33b@codewreck.org>
In-Reply-To: <20230427-scan-build-v2-0-bb96a6e6a33b@codewreck.org>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Simon Horman <simon.horman@corigine.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.13-dev-f371f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=vhjUjQLTL0bzvtWRoRMBT59Y+F+0DRe8NxWoHtMoq0M=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBkUhIR1SXh7VwBjG2iq8nQNm0Lx3pG8+75NFVpz
 u+o++lwu+mJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZFISEQAKCRCrTpvsapjm
 cPQcD/0eNUjIdy/ox9zl2KORjzzu+7EapK/XLxBHOqcUzWal/SWa1I3vmak3k35GueIco9YH5z+
 gFH5m5xE5LM5azeCYHW4Aih6wsP/XtUvKW8iDLodfdZbXIkkyC2NOJghoNnDgbodETIGutZJrB1
 pRUd1MhakD+HQ9U5JfToISTJ2GnmNss/OxSoP4mbgIPYouzwawXYGPvX4LtNqo0TTndvMFjza4s
 nUgbLRKcHWbF8lZbLUyEuDfy1QWfFO7FB8MhXEYAaeprfniu2BHDrwCTROJ9DyQtu+uypH6jPM3
 HRVjg8LlIbWEQKpDN5aqqc9GpdoWIOHhkMJNfGA7zTDykjhhsX+cnhXjt6nq7iqbRavjmqn7wV7
 3OeAUXBm057jV1jbqLlQh0DJpxrTL0y77Obxqrzwbti8LB9RycOUHXSTtS5T8yF+UVG6lwXc5B6
 0tnMJpr4Dw2u7/w6apa+9JxJ9OXuVJ+052+HqzQxZF6ZitlbODP+nr047oMYrYRaEt/7Fh2RfXi
 sbsSM19OmACmMmde2bfDl4tkzThSQvx70E+7HfObBFzKTOoGLGsg9HIuLzBzbq9HuwsTpZUKYrZ
 cm+YmDCjN4CU1pSlLxxUp1Yx2eKu9YTMR51fkD8tpCzwIzL3xWcVlKrD7x5OwqP3ZUhEW4V2xTI
 f8b7Zr1sxcSEcsg==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to the previous patch: offs can be used in handle_rerrors
without initializing on small payloads; in this case handle_rerrors will
not use it because of the size check, but it doesn't hurt to make sure
it is zero to please scan-build.

This fixes the following warning:
net/9p/trans_virtio.c:539:3: warning: 3rd function call argument is an uninitialized value [core.CallAndMessage]
                handle_rerror(req, in_hdr_len, offs, in_pages);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/trans_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index 2c9495ccda6b..f3f678289423 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -428,7 +428,7 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	struct page **in_pages = NULL, **out_pages = NULL;
 	struct virtio_chan *chan = client->trans;
 	struct scatterlist *sgs[4];
-	size_t offs;
+	size_t offs = 0;
 	int need_drop = 0;
 	int kicked = 0;
 

-- 
2.39.2

