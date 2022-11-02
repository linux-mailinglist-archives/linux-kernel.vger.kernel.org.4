Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3343F616A8C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 18:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiKBRWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 13:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbiKBRWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 13:22:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E481248D2;
        Wed,  2 Nov 2022 10:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A17EB61ACE;
        Wed,  2 Nov 2022 17:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D909C4347C;
        Wed,  2 Nov 2022 17:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667409760;
        bh=foDU0kOGB3Y9bXEW8iH6cIhgf/I30VbPYNdf7dmOjzY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VrKllPQPByJ1N/zF9Dh6x2gj5Mig3NCL28wytBkURpeSdUcqa550up1Ur2N6emiyu
         Fp1w/T8tr/7XadiZuhbAMLWuL7BRejXRjswOzbAVmUyK8YDnF5EYvjQ7Q/Q5hZEMBW
         HIcf/vA+phrgUBpnlLfKuPQSUZdjiNzJDXiW61SKwXjICgpK3T4nLOxo2cEPcbIBYF
         vZXf4DRGljvyqC99CLhzoU9TYKrMTCEHpuV4cZOSBGt7kAmRu8eu+BSEw5Qtq8ovS3
         9JZcTo6voD7BE3Z5W4yus0HCEdieagzOVwNEV0XvtMDYOnVJmgc6cBMN+UH6tqPN7s
         N3G2N7sQ6ucNQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>, linux-omap@vger.kernel.org
Subject: [PATCH 3/4] counter: ti-ecap-capture: Adjust final parameter type of ecap_cnt_pol_{read,write}()
Date:   Wed,  2 Nov 2022 10:22:16 -0700
Message-Id: <20221102172217.2860740-3-nathan@kernel.org>
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

  drivers/counter/ti-ecap-capture.c:384:2: error: incompatible function pointer types initializing 'int (*)(struct counter_device *, struct counter_signal *, size_t, u32 *)' (aka 'int (*)(struct counter_device *, struct counter_signal *, unsigned long, unsigned int *)') with an expression of type 'int (struct counter_device *, struct counter_signal *, size_t, enum counter_signal_polarity *)' (aka 'int (struct counter_device *, struct counter_signal *, unsigned long, enum counter_signal_polarity *)') [-Werror,-Wincompatible-function-pointer-types-strict]
          COUNTER_COMP_ARRAY_POLARITY(ecap_cnt_pol_read, ecap_cnt_pol_write, ecap_cnt_pol_array),
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/counter.h:627:27: note: expanded from macro 'COUNTER_COMP_ARRAY_POLARITY'
          .signal_array_u32_read = (_read), \
                                  ^~~~~~~
  drivers/counter/ti-ecap-capture.c:384:2: error: incompatible function pointer types initializing 'int (*)(struct counter_device *, struct counter_signal *, size_t, u32)' (aka 'int (*)(struct counter_device *, struct counter_signal *, unsigned long, unsigned int)') with an expression of type 'int (struct counter_device *, struct counter_signal *, size_t, enum counter_signal_polarity)' (aka 'int (struct counter_device *, struct counter_signal *, unsigned long, enum counter_signal_polarity)') [-Werror,-Wincompatible-function-pointer-types-strict]
          COUNTER_COMP_ARRAY_POLARITY(ecap_cnt_pol_read, ecap_cnt_pol_write, ecap_cnt_pol_array),
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ./include/linux/counter.h:628:28: note: expanded from macro 'COUNTER_COMP_ARRAY_POLARITY'
          .signal_array_u32_write = (_write), \
                                    ^~~~~~~~
  2 errors generated.

->signal_array_u32_read() and ->signal_array_u32_write() in 'struct
counter_comp' expect a final parameter type of 'u32 *' and 'u32'
respectively, not 'enum counter_signal_polarity *' and 'enum
counter_signal_polarity'. Adjust the final parameter type of
ecap_cnt_pol_{read,write}() to match the prototype's to resolve the
warning and CFI failure.

Link: https://github.com/ClangBuiltLinux/linux/issues/1750
Reported-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Julien Panis <jpanis@baylibre.com>
Cc: linux-omap@vger.kernel.org
---
 drivers/counter/ti-ecap-capture.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/counter/ti-ecap-capture.c b/drivers/counter/ti-ecap-capture.c
index 96e5d1f271b8..49e349680884 100644
--- a/drivers/counter/ti-ecap-capture.c
+++ b/drivers/counter/ti-ecap-capture.c
@@ -234,7 +234,7 @@ static int ecap_cnt_clk_get_freq(struct counter_device *counter,
 
 static int ecap_cnt_pol_read(struct counter_device *counter,
 			     struct counter_signal *signal,
-			     size_t idx, enum counter_signal_polarity *pol)
+			     size_t idx, u32 *pol)
 {
 	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
 	int bitval;
@@ -250,7 +250,7 @@ static int ecap_cnt_pol_read(struct counter_device *counter,
 
 static int ecap_cnt_pol_write(struct counter_device *counter,
 			      struct counter_signal *signal,
-			      size_t idx, enum counter_signal_polarity pol)
+			      size_t idx, u32 pol)
 {
 	struct ecap_cnt_dev *ecap_dev = counter_priv(counter);
 
-- 
2.38.1

