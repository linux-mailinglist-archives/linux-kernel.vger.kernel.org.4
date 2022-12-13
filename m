Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DA864B07C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 08:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbiLMHiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 02:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbiLMHiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 02:38:09 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87EB21BEB4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:38:08 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id m13-20020a170902f64d00b001899a70c8f1so12606481plg.14
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 23:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i6QWiJwRe9f0JGDfy4JA1PfdSVRPrblGsjegNHexZOw=;
        b=OTU2S16tVfSajllMUhTa9aKhUqIAo/c7aUL2k1yT/cZ7YXFSxbO39kh295Y0hjSzWJ
         wfm3804m3bfiu66tb44oq/inqmaBvsy5eRmU8VmLdjA8UbjYjPwARyzlSrVKQnptSsMc
         LiEN1UCz8VVZFlD6xtq+wYThvIgB6yi9/HdMvZmiyZapST0jMjd/Ui6OuKcOLqAxpxlU
         NLPgBInuXVogfauMRpOeTzIw0OQNaKmVY/9jUMalddHQCqM5GwUogDKFrLHCA0+8saNr
         SS0UYJTWy63ZuKhKEUnfNSgPmRRvVYTGigsb0F17kKInV502/XqAWTtlbaTMr048/uaT
         BoXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i6QWiJwRe9f0JGDfy4JA1PfdSVRPrblGsjegNHexZOw=;
        b=j0Ls1loPB47yg56pAWvu2Vs1CyS/QhwQLpAK8aJFthbK+QTc23GvIjL6o3qkTOA07H
         mI5zbTbf8d5RurxYC4UVOy4NbiS84MMXOLy1K/WDLC8AThDA5wIXcAWDPBxIkvhVX5HI
         eep5uDq1uAuN6y0esCS2yklpzQILyxecUDk+Yc3wLv+t2zVecc5GEkDM5IP3DNwulCWW
         aBgHgW/okZH8VKfGEBqcGtfjYboMfQ/TFlFKNv/aACKTPsNXgW2cBVM1qxCTXWkdVvtF
         bljqGEAn2yuWtDBZ3b29x8ZFsBwn35qVJwaG+hyWNeG5/LSMVimPjIPP1I1HtghQ5YjR
         yM/A==
X-Gm-Message-State: ANoB5plUK7fvthM/wU6va1qOLd9YafSGIjOXGiYjS60j8LedS32yz8Xe
        ruBHBvGN9YDotU/GkVRdSD/5Wb0Svw==
X-Google-Smtp-Source: AA0mqf6OHS7uUGcB7u72yohpnH5p2oezghcxO2ato9mxnLRTwA03CcQff+7ft2KuXEtpVMGfOJje7TXq2Q==
X-Received: from decot.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:5fa2])
 (user=decot job=sendgmr) by 2002:aa7:80c4:0:b0:574:8c08:595f with SMTP id
 a4-20020aa780c4000000b005748c08595fmr66938029pfn.38.1670917087855; Mon, 12
 Dec 2022 23:38:07 -0800 (PST)
Date:   Mon, 12 Dec 2022 23:38:01 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221213073801.361500-1-decot+git@google.com>
Subject: [PATCH v1 1/1] net: neigh: persist proxy config across link flaps
From:   David Decotigny <decot+git@google.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Nikolay Aleksandrov <razor@blackwall.org>,
        David Ahern <dsahern@kernel.org>,
        "Denis V. Lunev" <den@openvz.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        David Decotigny <ddecotig@google.com>,
        Yuwei Wang <wangyuweihx@gmail.com>,
        Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>,
        Thomas Zeitlhofer <thomas.zeitlhofer+lkml@ze-it.at>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Decotigny <ddecotig@google.com>

Without this patch, the 'ip neigh add proxy' config is lost when the
cable or peer disappear, ie. when the link goes down while staying
admin up. When the link comes back, the config is never recovered.

This patch makes sure that such an nd proxy config survives a switch
or cable issue.

Signed-off-by: David Decotigny <ddecotig@google.com>


---
 net/core/neighbour.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 952a54763358..5ad7ac674daa 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -426,7 +426,10 @@ static int __neigh_ifdown(struct neigh_table *tbl, struct net_device *dev,
 {
 	write_lock_bh(&tbl->lock);
 	neigh_flush_dev(tbl, dev, skip_perm);
-	pneigh_ifdown_and_unlock(tbl, dev);
+	if (skip_perm)
+		write_unlock_bh(&tbl->lock);
+	else
+		pneigh_ifdown_and_unlock(tbl, dev);
 	pneigh_queue_purge(&tbl->proxy_queue, dev ? dev_net(dev) : NULL,
 			   tbl->family);
 	if (skb_queue_empty_lockless(&tbl->proxy_queue))
-- 
2.39.0.rc1.256.g54fd8350bd-goog

