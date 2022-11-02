Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F165616A89
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231349AbiKBRWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbiKBRWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8325A26139;
        Wed,  2 Nov 2022 10:22:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2899C61A32;
        Wed,  2 Nov 2022 17:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7984C433D7;
        Wed,  2 Nov 2022 17:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667409758;
        bh=VOPxx1E3nzgzSX4/T9iDwxmKIdfR07u/REHayG82ioQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZtR38H8afcyKcjaRxplQiaodCrL6U01+2ictVzJ4eHQLw6h4wKkBdIU9rNti2ps1Y
         TXphRcqiH+UQYvmt9VNEY0vEPDdvb+86uKZpXSicZgUZoBJN1FaZFT0S89R9Td4ev8
         +tDz9GkFAhGFTE30cokMoULtgCD+J8197M/VdNPkFqCWjR2HiULLjuLIqd/3/bN7nT
         SIXXwSuZvJ4SdT/WVIzQoLCIUnlnAR4uo1u1B+EZx7rXmqVpz7E+n8DlbLEZZPucyw
         VmAV9DBVfsAvOuR40tskWxq/YywPMtvI93YZQAMuIh2QLOy6ZCBhehYTMcbdv8shMR
         C7srL5Lm0GQ9g==
From:   Nathan Chancellor <nathan@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH 2/4] counter: stm32-timer-cnt: Adjust final parameter type of stm32_count_direction_read()
Date:   Wed,  2 Nov 2022 10:22:15 -0700
Message-Id: <20221102172217.2860740-2-nathan@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102172217.2860740-1-nathan@kernel.org>
References: <20221102172217.2860740-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With clang's kernel control flow integrity (kCFI, CONFIG_CFI_CLANG),
indirect call targets are validated against the expected function
pointer prototype to make sure the call target is valid to help mitigate
ROP attacks. If they are not identical, there is a failure at run time,
which manifests as either a kernel panic or thread getting killed. A
proposed warning in clang aims to catch these at compile time, which
reveals:

  drivers/counter/stm32-timer-cnt.c:220:2: error: incompatible function pointer types initializing 'int (*)(struct counter_device *, struct counter_count *, u32 *)' (aka 'int (*)(struct counter_device *, struct counter_count *, unsigned int *)') with an expression of type 'int (struct counter_device *, struct counter_count *, enum counter_count_direction *)' [-Werror,-Wincompatible-function-pointer-types-strict]
          COUNTER_COMP_DIRECTION(stm32_count_direction_read),
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/counter.h:596:20: note: expanded from macro 'COUNTER_COMP_DIRECTION'
          .count_u32_read = (_read), \
                            ^~~~~~~
  1 error generated

->count_u32_read() in 'struct counter_comp' expects a return type of
'u32 *', not 'enum counter_count_direction *'. Adjust the final
parameter type of stm32_count_direction_read() to match the prototype's
to resolve the warning and CFI failure.

Link: https://github.com/ClangBuiltLinux/linux/issues/1750
Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
---
 drivers/counter/stm32-timer-cnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index ece55113ba85..4062296f4bd4 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -137,7 +137,7 @@ static int stm32_count_function_write(struct counter_device *counter,
 
 static int stm32_count_direction_read(struct counter_device *counter,
 				      struct counter_count *count,
-				      enum counter_count_direction *direction)
+				      u32 *direction)
 {
 	struct stm32_timer_cnt *const priv = counter_priv(counter);
 	u32 cr1;
-- 
2.38.1

