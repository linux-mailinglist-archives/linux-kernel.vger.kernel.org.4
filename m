Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644D767A53B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 22:49:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjAXVs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 16:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjAXVsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 16:48:54 -0500
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E80449969;
        Tue, 24 Jan 2023 13:48:51 -0800 (PST)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1pKR9s-0049W3-LT; Tue, 24 Jan 2023 22:48:48 +0100
Received: from [185.238.219.21] (helo=[192.168.46.66])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_128_GCM_SHA256
          (envelope-from <kernel@mkarcher.dialup.fu-berlin.de>)
          id 1pKR9N-0044P4-Fd; Tue, 24 Jan 2023 22:48:48 +0100
Message-ID: <619fa552-c988-35e5-b1d7-fe256c46a272@mkarcher.dialup.fu-berlin.de>
Date:   Tue, 24 Jan 2023 22:48:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Subject: [PATCH v5 1/1] arch/sh: avoid spurious sizeof-pointer-div warning
To:     linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Original-Sender: kernel@mkarcher.dialup.fu-berlin.de
X-Originating-IP: 185.238.219.21
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gcc warns about the pattern sizeof(void*)/sizeof(void), as it looks like
the abuse of a pattern to calculate the array size. This pattern appears
in the unevaluated part of the ternary operator in _INTC_ARRAY if the
parameter is NULL.

The replacement uses an alternate approach to return 0 in case of NULL
which does not generate the pattern sizeof(void*)/sizeof(void), but still
emits the warning if _INTC_ARRAY is called with a nonarray parameter.

This patch is required for successful compilation with -Werror enabled.

The idea to use _Generic for type distinction is taken from Comment #7
inhttps://gcc.gnu.org/bugzilla/show_bug.cgi?id=108483  by Jakub Jelinek

Signed-off-by: Michael Karcher<kernel@mkarcher.dialup.fu-berlin.de>
---
(resend of the mail as plaintext only instead of multipart/alternative)
History:
v5:
   - Cleanly generated the patch
v4:
   - Put the case distinction into the numerator instead of the denominator
   - Refactor the case disctinction into a second macro
v3:
   - I had a stern discussion with Thunderbird about not mangling the
     space characters in my email, and I hope spaces get sent as standard
     spaces now
v2:
   - improve title and remove mostly redundant first sentence of the
     description
   - adjust formatting of the _Generic construction

diff --git a/include/linux/sh_intc.h b/include/linux/sh_intc.h
index c255273b0281..37ad81058d6a 100644
--- a/include/linux/sh_intc.h
+++ b/include/linux/sh_intc.h
@@ -97,7 +97,10 @@ struct intc_hw_desc {
         unsigned int nr_subgroups;
  };

-#define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
+#define _INTC_SIZEOF_OR_ZERO(a) (_Generic(a,                 \
+                                 typeof(NULL):  0,           \
+                                 default:       sizeof(a)))
+#define _INTC_ARRAY(a) a, _INTC_SIZEOF_OR_ZERO(a)/sizeof(*a)

  #define INTC_HW_DESC(vectors, groups, mask_regs,       \
                      prio_regs, sense_regs, ack_regs)   \



