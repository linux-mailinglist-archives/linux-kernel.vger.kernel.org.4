Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD81630C48
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 06:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbiKSFvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 00:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiKSFva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 00:51:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF8A903B8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 21:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5JckQtjLFKaJhNfVuiFkZN/oxJZBwctXTxGO8rRRZjA=; b=ir8REqR3W9lZQ472FC+xBvYPoe
        tIwzBaRkUNflMPbcxr8YugGkVZ/H3hkTgpMqR0PcT6Jcds9HIDwuW7M2ay+74zkadmTLLPQNnBBHp
        J3pi9dbJimeaUb9tKxTDXmRv6xtQo8dWyv5Gr6Vcf4TcUvOtgALYCOHidWkuh1q693pH3zf/BD/yA
        PqkKtu/0eXWWEo1CHvTKXIsGS0gvereK54Aytp+HYPrHuZGievNRNO1L8Bz1CpOFAbPFLCENJLnGE
        XJUmPOCC2NxEIi+FoWwidAzp8MjxtplNwLe6EKFOoJgjFPBlJHiUNBC6ndOR4qruZhP2LbnPwpg/Y
        vCf4WHrw==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owGlE-0030wo-Le; Sat, 19 Nov 2022 05:51:29 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH] maple_tree: allow TEST_MAPLE_TREE only when DEBUG_KERNEL is set
Date:   Fri, 18 Nov 2022 21:51:17 -0800
Message-Id: <20221119055117.14094-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
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

Prevent a kconfig warning that is caused by TEST_MAPLE_TREE by adding a
"depends on" clause for TEST_MAPLE_TREE since 'select' does not follow
any kconfig dependencies.

WARNING: unmet direct dependencies detected for DEBUG_MAPLE_TREE
  Depends on [n]: DEBUG_KERNEL [=n]
  Selected by [y]:
  - TEST_MAPLE_TREE [=y] && RUNTIME_TESTING_MENU [=y]

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: kernel test robot <lkp@intel.com>
Fixes: 120b116208a0 ("maple_tree: reorganize testing to restore module testing")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Liam Howlett <liam.howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 lib/Kconfig.debug |    1 +
 1 file changed, 1 insertion(+)

diff -- a/lib/Kconfig.debug b/lib/Kconfig.debug
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2259,6 +2259,7 @@ config TEST_XARRAY
 	tristate "Test the XArray code at runtime"
 
 config TEST_MAPLE_TREE
+	depends on DEBUG_KERNEL
 	select DEBUG_MAPLE_TREE
 	tristate "Test the Maple Tree code at runtime"
 
