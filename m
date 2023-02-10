Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D70D692A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 23:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjBJWmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 17:42:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjBJWmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 17:42:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8989372885
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 14:42:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 241AEB8260F
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 22:42:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89679C433EF;
        Fri, 10 Feb 2023 22:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676068930;
        bh=lean2QP7sM/VxWfpzVyF1SwVdvPL+L0ykV3X0Mivkhc=;
        h=From:To:Cc:Subject:Date:From;
        b=WwJm2H7vK4Fc7JspfZsTwrY2E4UU+fclg2VDoT2DYwASVoHvAmc6ZQ+ooRVoaMfdo
         QvzCpJcgQIWQzwHU87cmgLfS6ShUB9A2x/BacR4ViURx+gsNFTIBN1v/QWAZf/0bG2
         xJk/3DyS00bKY5cjt2KhPK3pwH1nhPdgjWG34ey4ItHLXsWkqgitutY10o+KW4uLLF
         /pUJk9Fncio/lCR26HiXaPa8jGwnFKcCqd/7W/TiJrm3aS9IF5BD/131aEmVdmpfB8
         qBLYpZwKh/PQI+/cSLqPKa67jOe88z/uS6w6av+FSi4pO3Ah6Z50dOwcDwpvjt2Ku2
         KUmCT1VMhji8g==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Chen Zhongjin <chenzhongjin@huawei.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/2] x86/unwind/orc: Fix unwinding from kprobe on PUSH/POP instruction
Date:   Fri, 10 Feb 2023 14:42:00 -0800
Message-Id: <cover.1676068346.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Poimboeuf (2):
  x86/unwind/orc: Add 'signal' field to ORC metadata
  x86/entry: Fix unwinding from kprobe on PUSH/POP instruction

 arch/x86/entry/entry_64.S              |  9 ++++++++-
 arch/x86/include/asm/orc_types.h       |  4 +++-
 arch/x86/include/asm/unwind_hints.h    | 10 +++++-----
 arch/x86/kernel/unwind_orc.c           |  5 ++---
 include/linux/objtool.h                | 11 +++++++----
 tools/arch/x86/include/asm/orc_types.h |  4 +++-
 tools/include/linux/objtool.h          | 11 +++++++----
 tools/objtool/orc_dump.c               |  4 ++--
 8 files changed, 37 insertions(+), 21 deletions(-)

-- 
2.39.1

