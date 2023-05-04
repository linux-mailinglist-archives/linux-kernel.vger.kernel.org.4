Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745F56F7493
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 21:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjEDTvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 15:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjEDTt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 15:49:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2980AD20;
        Thu,  4 May 2023 12:46:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 394F06378A;
        Thu,  4 May 2023 19:46:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE260C433D2;
        Thu,  4 May 2023 19:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683229569;
        bh=xrwjYdqolJOIzicyLA3w4BsXeJdbSfFobbOMVk4DBnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pqQXbcL5/gc/1lcNtyBCQUnizJAuO61to2kq6fx+RJVJykd+gTqyyGoqWLtXNsYKD
         2y18zBgfloJ9Qc9rrfRaEOt7yI4349PMbK+a08CQ9nqsQ97MJ6ToGryNyrKp8wyMt6
         MdFg1l7tsnEIvcibPQ0ykNaeftjOHuwmsb4ZXImChhMxocTyoVVW/Exxk58/4A6O3z
         tiJPrcijm0UZsENbnpAg5PjiLS66D38vlsI+7W6D0g2O+d75q+EK92lQQI+z6dMyV7
         VZlhr7Si5hHe00wRJe+SXeOFBm07TmGZdR8w773RfND5aXw2iKSQWmDM9Eozl7T6Rv
         niI/Jz6L/qbMw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Simon Horman <horms@kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>, horms@verge.net.au, ja@ssi.bg,
        davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, kadlec@netfilter.org,
        fw@strlen.de, netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: [PATCH AUTOSEL 6.2 43/53] ipvs: Update width of source for ip_vs_sync_conn_options
Date:   Thu,  4 May 2023 15:44:03 -0400
Message-Id: <20230504194413.3806354-43-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230504194413.3806354-1-sashal@kernel.org>
References: <20230504194413.3806354-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Horman <horms@kernel.org>

[ Upstream commit e3478c68f6704638d08f437cbc552ca5970c151a ]

In ip_vs_sync_conn_v0() copy is made to struct ip_vs_sync_conn_options.
That structure looks like this:

struct ip_vs_sync_conn_options {
        struct ip_vs_seq        in_seq;
        struct ip_vs_seq        out_seq;
};

The source of the copy is the in_seq field of struct ip_vs_conn.  Whose
type is struct ip_vs_seq. Thus we can see that the source - is not as
wide as the amount of data copied, which is the width of struct
ip_vs_sync_conn_option.

The copy is safe because the next field in is another struct ip_vs_seq.
Make use of struct_group() to annotate this.

Flagged by gcc-13 as:

 In file included from ./include/linux/string.h:254,
                  from ./include/linux/bitmap.h:11,
                  from ./include/linux/cpumask.h:12,
                  from ./arch/x86/include/asm/paravirt.h:17,
                  from ./arch/x86/include/asm/cpuid.h:62,
                  from ./arch/x86/include/asm/processor.h:19,
                  from ./arch/x86/include/asm/timex.h:5,
                  from ./include/linux/timex.h:67,
                  from ./include/linux/time32.h:13,
                  from ./include/linux/time.h:60,
                  from ./include/linux/stat.h:19,
                  from ./include/linux/module.h:13,
                  from net/netfilter/ipvs/ip_vs_sync.c:38:
 In function 'fortify_memcpy_chk',
     inlined from 'ip_vs_sync_conn_v0' at net/netfilter/ipvs/ip_vs_sync.c:606:3:
 ./include/linux/fortify-string.h:529:25: error: call to '__read_overflow2_field' declared with attribute warning: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Werror=attribute-warning]
   529 |                         __read_overflow2_field(q_size_field, size);
       |

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/ip_vs.h             | 6 ++++--
 net/netfilter/ipvs/ip_vs_sync.c | 2 +-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
index c6c61100d2445..b0111e50277ef 100644
--- a/include/net/ip_vs.h
+++ b/include/net/ip_vs.h
@@ -629,8 +629,10 @@ struct ip_vs_conn {
 	 */
 	struct ip_vs_app        *app;           /* bound ip_vs_app object */
 	void                    *app_data;      /* Application private data */
-	struct ip_vs_seq        in_seq;         /* incoming seq. struct */
-	struct ip_vs_seq        out_seq;        /* outgoing seq. struct */
+	struct_group(sync_conn_opt,
+		struct ip_vs_seq  in_seq;       /* incoming seq. struct */
+		struct ip_vs_seq  out_seq;      /* outgoing seq. struct */
+	);
 
 	const struct ip_vs_pe	*pe;
 	char			*pe_data;
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 4963fec815da3..d4fe7bb4f853a 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -603,7 +603,7 @@ static void ip_vs_sync_conn_v0(struct netns_ipvs *ipvs, struct ip_vs_conn *cp,
 	if (cp->flags & IP_VS_CONN_F_SEQ_MASK) {
 		struct ip_vs_sync_conn_options *opt =
 			(struct ip_vs_sync_conn_options *)&s[1];
-		memcpy(opt, &cp->in_seq, sizeof(*opt));
+		memcpy(opt, &cp->sync_conn_opt, sizeof(*opt));
 	}
 
 	m->nr_conns++;
-- 
2.39.2

