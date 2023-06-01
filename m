Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CF4719B85
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjFAMKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbjFAMKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E337C9D;
        Thu,  1 Jun 2023 05:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C52E6362E;
        Thu,  1 Jun 2023 12:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A98C433EF;
        Thu,  1 Jun 2023 12:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685621419;
        bh=SvRJEGwApsVQ6jziK8jAnPbJhsGPVsEeuQqaBcetPfY=;
        h=From:To:Cc:Subject:Date:From;
        b=jGSgR900uLo52Hj0tg3P9s7X3GGyPr/QIe4osZQ+sieqMxFDk/6cyQqcV6RX0kOGS
         Q/mmFFu7cR6J1UpF7/DoKEpsJy4zPAmIZwy2SGCFyAc+JxEFFMiy18KIetb1AMc9GN
         AQC+9JL50GXK/o5m76U5eweRqHGisk+ShS2B682KS3/MBsrS4zyJ70FA2jgYmuXO2x
         Gd/gLbWXlq3fhexOfG5ZNo7MiihngDRY3TZSDXNzUxSSgRnGth1OggLdB/Rf+0et/m
         u567reb/qlpSnPERExlhmKT/cp5VeImOhRo5AEmhfaKBf2TNgY45GHxNiqa74uU3l6
         vrnkNR6qQpo6A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "David A. Long" <dave.long@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tony Lindgren <tony@atomide.com>
Subject: [PATCH 0/7] modpost: fix section mismatch detection for ARM
Date:   Thu,  1 Jun 2023 21:09:54 +0900
Message-Id: <20230601121001.1071533-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

addend_arm_rel() is completely, entirely bogus.

Fix the code, and also catch more section mismatches.

I confirmed this series is cleanly applicable to linux-next 20230601.



Masahiro Yamada (7):
  modpost: fix section mismatch message for R_ARM_ABS32
  modpost: fix section mismatch message for R_ARM_{PC24,CALL,JUMP24}
  modpost: detect section mismatch for R_ARM_{MOVW_ABS_NC,MOVT_ABS}
  modpost: refactor find_fromsym() and find_tosym()
  modpost: detect section mismatch for R_ARM_THM_{MOVW_ABS_NC,MOVT_ABS}
  modpost: fix section_mismatch message for
    R_ARM_THM_{CALL,JUMP24,JUMP19}
  modpost: detect section mismatch for R_ARM_REL32

 scripts/mod/modpost.c | 193 ++++++++++++++++++++++++++++--------------
 1 file changed, 129 insertions(+), 64 deletions(-)

-- 
2.39.2

