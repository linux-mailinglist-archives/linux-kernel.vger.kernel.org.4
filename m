Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA9B6A030C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 08:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjBWHBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 02:01:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjBWHBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 02:01:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D69149886
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 23:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=IxmQQoiv4zd0sXAXrZdHnjwV4WUcXZ4Ow9C4raydYTA=; b=3a0VaGCfdEWsxlHBFoLewcx7rM
        y3ytzZMgT68GyP4S54Hz4unOjQZgCo3oB83XVbMwbI7bgL+XrOF7510wj7TCpcvQLXWVzlKZ58+v7
        3KJidHDLifH+OnZ2Eu1fZlsrSwwLMcs9+C1ImY3OdeWYZUghAN8p0FHPM8w+6u8T316UuqSOu7Bye
        B7F3nDckF0UocPVnMkez9fkHuwK0zVmbrLPgCQvzrQjWbC0eZnf8j0o7QVrCMTz8vaZVdYQquFC3g
        T2FrAJZ5J8RH7DCUzxjutE/zE9EUhtnpxJhpF+sPxbeKAjxY3EzQfXHnn+jr64t7Zz1AOc+M2NbMr
        a5t1pmZw==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pV5bS-00FMG2-Tb; Thu, 23 Feb 2023 07:01:18 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Gerhard Sittig <gsi@denx.de>,
        Anatolij Gustschin <agust@denx.de>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/4] clk: mpc512x: fix resource printk format warning
Date:   Wed, 22 Feb 2023 23:01:13 -0800
Message-Id: <20230223070116.660-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223070116.660-1-rdunlap@infradead.org>
References: <20230223070116.660-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "%pa" format specifier for resource_size_t to avoid a compiler
printk format warning.

../arch/powerpc/platforms/512x/clock-commonclk.c: In function 'mpc5121_clk_provide_backwards_compat':
../arch/powerpc/platforms/512x/clock-commonclk.c:989:44: error: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t' {aka 'long long unsigned int'} [-Werror=format=]
  989 |         snprintf(devname, sizeof(devname), "%08x.%s", res.start, np->name); \
      |                                            ^~~~~~~~~  ~~~~~~~~~
      |                                                          |
      |                                                          resource_size_t {aka long long unsigned int}

Prevents 24 such warnings.

Fixes: 01f25c371658 ("clk: mpc512x: add backwards compat to the CCF code")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Gerhard Sittig <gsi@denx.de>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/512x/clock-commonclk.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/powerpc/platforms/512x/clock-commonclk.c b/arch/powerpc/platforms/512x/clock-commonclk.c
--- a/arch/powerpc/platforms/512x/clock-commonclk.c
+++ b/arch/powerpc/platforms/512x/clock-commonclk.c
@@ -986,7 +986,7 @@ static void __init mpc5121_clk_provide_m
 
 #define NODE_PREP do { \
 	of_address_to_resource(np, 0, &res); \
-	snprintf(devname, sizeof(devname), "%08x.%s", res.start, np->name); \
+	snprintf(devname, sizeof(devname), "%pa.%s", &res.start, np->name); \
 } while (0)
 
 #define NODE_CHK(clkname, clkitem, regnode, regflag) do { \
