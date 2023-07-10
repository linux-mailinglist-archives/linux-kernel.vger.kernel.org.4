Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B6874CC38
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 07:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjGJFd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 01:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjGJFd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 01:33:56 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A57EB3;
        Sun,  9 Jul 2023 22:33:55 -0700 (PDT)
X-UUID: fe22782b6d154cc5ac9c2e0da43990b4-20230710
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:89717b82-668f-4e85-85c5-8e906053f2e7,IP:15,
        URL:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:6
X-CID-INFO: VERSION:1.1.27,REQID:89717b82-668f-4e85-85c5-8e906053f2e7,IP:15,UR
        L:0,TC:0,Content:0,EDM:0,RT:0,SF:-9,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:6
X-CID-META: VersionHash:01c9525,CLOUDID:1f2cd0da-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:230710133120G82S8ADA,BulkQuantity:4,Recheck:0,SF:24|17|19|42|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_FSI,
        TF_CID_SPAM_ULS
X-UUID: fe22782b6d154cc5ac9c2e0da43990b4-20230710
X-User: jianghaoran@kylinos.cn
Received: from localhost.localdomain [(39.156.73.12)] by mailgw
        (envelope-from <jianghaoran@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 1249612017; Mon, 10 Jul 2023 13:33:26 +0800
From:   Haoran Jiang <jianghaoran@kylinos.cn>
To:     chenhuacai@kernel.org
Cc:     andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, haoluo@google.com, jianghaoran@kylinos.cn,
        john.fastabend@gmail.com, jolsa@kernel.org, kernel@xen0n.name,
        kpsingh@kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, loongarch@lists.linux.dev,
        martin.lau@linux.dev, nathan@kernel.org, ndesaulniers@google.com,
        sdf@google.com, song@kernel.org, trix@redhat.com,
        yangtiezhu@loongson.cn, yhs@fb.com
Subject: [PATCH v2] samples/bpf: Fix compilation failure for samples/bpf on LoongArch Fedora
Date:   Mon, 10 Jul 2023 13:27:50 +0800
Message-Id: <20230710052750.259595-1-jianghaoran@kylinos.cn>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <CAAhV-H6s3N=-brDz24PfrtEKNFjvnLjbDR2NpOVDF_fN7rA53A@mail.gmail.com>
References: <CAAhV-H6s3N=-brDz24PfrtEKNFjvnLjbDR2NpOVDF_fN7rA53A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building the latest samples/bpf on LoongArch Fedora

     make M=samples/bpf

There are compilation errors as follows:

In file included from ./linux/samples/bpf/sockex2_kern.c:2:
In file included from ./include/uapi/linux/in.h:25:
In file included from ./include/linux/socket.h:8:
In file included from ./include/linux/uio.h:9:
In file included from ./include/linux/thread_info.h:60:
In file included from ./arch/loongarch/include/asm/thread_info.h:15:
In file included from ./arch/loongarch/include/asm/processor.h:13:
In file included from ./arch/loongarch/include/asm/cpu-info.h:11:
./arch/loongarch/include/asm/loongarch.h:13:10: fatal error: 'larchintrin.h' file not found
         ^~~~~~~~~~~~~~~
1 error generated.

larchintrin.h is included in /usr/lib64/clang/14.0.6/include,
and the header file location is specified at compile time.

Test on LoongArch Fedora:
https://github.com/fedora-remix-loongarch/releases-info

Signed-off-by: Haoran Jiang <jianghaoran@kylinos.cn>

---
v2:
use LoongArch instead of Loongarch in the title and commit message.
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 615f24ebc49c..b301796a3862 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -434,7 +434,7 @@ $(obj)/%.o: $(src)/%.c
 	@echo "  CLANG-bpf " $@
 	$(Q)$(CLANG) $(NOSTDINC_FLAGS) $(LINUXINCLUDE) $(BPF_EXTRA_CFLAGS) \
 		-I$(obj) -I$(srctree)/tools/testing/selftests/bpf/ \
-		-I$(LIBBPF_INCLUDE) \
+		-I$(LIBBPF_INCLUDE) $(CLANG_SYS_INCLUDES) \
 		-D__KERNEL__ -D__BPF_TRACING__ -Wno-unused-value -Wno-pointer-sign \
 		-D__TARGET_ARCH_$(SRCARCH) -Wno-compare-distinct-pointer-types \
 		-Wno-gnu-variable-sized-type-not-at-end \
-- 
2.27.0

