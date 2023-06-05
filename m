Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7CF0722C45
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 18:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjFEQMe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 12:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjFEQMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 12:12:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBBF94
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 09:12:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDB7661290
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 16:12:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC48DC433D2;
        Mon,  5 Jun 2023 16:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685981550;
        bh=8Y/t9HaVqkUndf9wUDX4kz/LL1+KOvF3O3NWSi2hmpQ=;
        h=From:To:Cc:Subject:Date:From;
        b=urkx5DKq/xZlADMXHTnP+KBkfpVJN7iVKaJLAa5SFZN4WiJaHFeCelScJ6GhLsdW/
         bm5TnHq1X7uIp+gLXwKL0SPVNFXOdokA5aSr/Qac+tRYroI3oX7ezQK4CbiJXm0SDV
         R+/LwiKgSeQjSHSXS3zMLH/7CeE7ujZcLVThJ2DHw47ol9vm6rFrDpFtUf0ZiJQQj0
         fYpIFaJbAIHePrzYDRXBVCh+5Oh0rB01qBpPzlmqGhIC+GPmNTmStLoy4bOg7vz7te
         /XdMh/ZhgWROW6ryVvpmw/u7aiAV7mL3ms9YDe3rF7BQNutZKtWJEXarwpLBeaLVXl
         OA58YHV3B0nRg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        linux-graphics-maintainer@vmware.com, Zack Rusin <zackr@vmware.com>
Subject: [PATCH v2 0/2] objtool,drm/vmwgfx: Add unwind hints around RBP clobber
Date:   Mon,  5 Jun 2023 09:12:20 -0700
Message-Id: <cover.1685981486.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Fix the (theoretical) ORC bug

Josh Poimboeuf (2):
  objtool: Allow stack operations in UNWIND_HINT_UNDEFINED regions
  drm/vmwgfx: Add unwind hints around RBP clobber

 arch/x86/include/asm/unwind_hints.h     |  9 +++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_msg_x86.h | 16 ++++++++++++----
 tools/objtool/check.c                   | 12 ++++++++++++
 tools/objtool/include/objtool/cfi.h     |  1 +
 4 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.40.1

