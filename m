Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109EA6EB931
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 14:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjDVMq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 08:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjDVMq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 08:46:57 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF3919A6;
        Sat, 22 Apr 2023 05:46:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-51f597c97c5so2273374a12.0;
        Sat, 22 Apr 2023 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682167616; x=1684759616;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=m2O8emGU/1aRanCBdkH+9Iyixy0g4IVb5HIaoIUN3PI=;
        b=VZizgABQtdlUQXpqlnDCHy5eM1NWD4h/9aGFqTRbXHYo/Dp6KGHq3FqpUudhHQfwFw
         gqbrrAAwclGzSvDsDZNZGyLam0qDaz6TH4R4hzIsYQ+TXW/TA6X4LMcilWG9ho/M7YbV
         c9QkaqLI5UZjMUddzWX6vsHNIgBhr3Aa5WJa79noxLPMzKXqIbXsab1pQspxw4Ic1HJ8
         BscNcRSWAJUXysIDT9b9cCH3zV1yGR0VRV3IgjpM2dBSwoxXb+heJSGIs54NtDCjodbR
         X6nd4sr08PKVj3uWxwlL7FXC31bHOT/CvxkurfqtDRR0f43C98EYDtqXVRKfsn2z3Hy8
         13gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682167616; x=1684759616;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m2O8emGU/1aRanCBdkH+9Iyixy0g4IVb5HIaoIUN3PI=;
        b=WU4OQ6zdbbZsLJdJXNo2njqA2bce7mCtQA5gP5c8sGeJQ8ep8c/E6P19izPEJmVAtg
         Zhka64gdWkpdEwaw9s3HQjjSXqw3mDv1DnkFuMFjk6WOmEtWg/TMmWGaljmlnN7n/tJA
         XzCgHrN54AM1KNatSxfBTHq3VUM68yKtMAvATWArcMOHYwsHIioKMNh6DTOkrYsWZg0X
         rgGlirg2S7sBgMZSN98JDGUylTlOuReUlAD/B1bhRHCIvo/OeDtJomGqcu5R+UHXLae6
         YLvxiJX+8efUv7wrM9WjyXQ6j4Rk7kTsxge9gcaqnwgBqJAKHDNwVW4VC1oncOb7/Bqm
         oRkQ==
X-Gm-Message-State: AAQBX9efuZakkPjrYUL9vA+hMVu2x/63qnS0EML/xXFSFzG9AdVhLPYh
        17zU7rh9HQHie+i4iC7He/gn5IeDPwVMx+MgBFijVvC4e7w=
X-Google-Smtp-Source: AKy350bpKitbfeLCPQ3PxdWhS1ofVmulhkrg720nWstlpjoGcHKdtyUGL4sSAVDRG2o+KRHaCS6AepRdspyzaAwAkQ8=
X-Received: by 2002:a17:90a:ae81:b0:247:78e6:b025 with SMTP id
 u1-20020a17090aae8100b0024778e6b025mr8313373pjq.17.1682167615951; Sat, 22 Apr
 2023 05:46:55 -0700 (PDT)
MIME-Version: 1.0
From:   Zhouyi Zhou <zhouzhouyi@gmail.com>
Date:   Sat, 22 Apr 2023 20:46:44 +0800
Message-ID: <CAABZP2xJRGhPmfB-PrfesQKzP7fsuZsj+3TewAiLLW8u=YK4dg@mail.gmail.com>
Subject: BUG : PowerPC RCU: torture test failed with __stack_chk_fail
To:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        rcu <rcu@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, lance@osuosl.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NORMAL_HTTP_TO_IP,
        NUMERIC_HTTP_ADDR,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear PowerPC and RCU developers:
During the RCU torture test on mainline (on the VM of Opensource Lab
of Oregon State University), SRCU-P failed with __stack_chk_fail:
[  264.381952][   T99] [c000000006c7bab0] [c0000000010c67c0]
dump_stack_lvl+0x94/0xd8 (unreliable)
[  264.383786][   T99] [c000000006c7bae0] [c00000000014fc94] panic+0x19c/0x468
[  264.385128][   T99] [c000000006c7bb80] [c0000000010fca24]
__stack_chk_fail+0x24/0x30
[  264.386610][   T99] [c000000006c7bbe0] [c0000000002293b4]
srcu_gp_start_if_needed+0x5c4/0x5d0
[  264.388188][   T99] [c000000006c7bc70] [c00000000022f7f4]
srcu_torture_call+0x34/0x50
[  264.389611][   T99] [c000000006c7bc90] [c00000000022b5e8]
rcu_torture_fwd_prog+0x8c8/0xa60
[  264.391439][   T99] [c000000006c7be00] [c00000000018e37c] kthread+0x15c/0x170
[  264.392792][   T99] [c000000006c7be50] [c00000000000df94]
ret_from_kernel_thread+0x5c/0x64
The kernel config file can be found in [1].
And I write a bash script to accelerate the bug reproducing [2].
After a week's debugging, I found the cause of the bug is because the
register r10 used to judge for stack overflow is not constant between
context switches.
The assembly code for srcu_gp_start_if_needed is located at [3]:
c000000000226eb4:   78 6b aa 7d     mr      r10,r13
c000000000226eb8:   14 42 29 7d     add     r9,r9,r8
c000000000226ebc:   ac 04 00 7c     hwsync
c000000000226ec0:   10 00 7b 3b     addi    r27,r27,16
c000000000226ec4:   14 da 29 7d     add     r9,r9,r27
c000000000226ec8:   a8 48 00 7d     ldarx   r8,0,r9
c000000000226ecc:   01 00 08 31     addic   r8,r8,1
c000000000226ed0:   ad 49 00 7d     stdcx.  r8,0,r9
c000000000226ed4:   f4 ff c2 40     bne-    c000000000226ec8
<srcu_gp_start_if_needed+0x1c8>
c000000000226ed8:   28 00 21 e9     ld      r9,40(r1)
c000000000226edc:   78 0c 4a e9     ld      r10,3192(r10)
c000000000226ee0:   79 52 29 7d     xor.    r9,r9,r10
c000000000226ee4:   00 00 40 39     li      r10,0
c000000000226ee8:   b8 03 82 40     bne     c0000000002272a0
<srcu_gp_start_if_needed+0x5a0>
by debugging, I see the r10 is assigned with r13 on c000000000226eb4,
but if there is a context-switch before c000000000226edc, a false
positive will be reported.

[1] http://154.220.3.115/logs/0422/configformainline.txt
[2] 154.220.3.115/logs/0422/whilebash.sh
[3] http://154.220.3.115/logs/0422/srcu_gp_start_if_needed.txt

My analysis and debugging may not be correct, but the bug is easily
reproducible.

Thanks
Zhouyi
