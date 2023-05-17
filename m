Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A41705C25
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 03:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbjEQBC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 21:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjEQBCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 21:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4557E1BFD;
        Tue, 16 May 2023 18:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB20264073;
        Wed, 17 May 2023 01:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF893C433EF;
        Wed, 17 May 2023 01:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684285371;
        bh=nVMhlmmUXfL1NdxdVCdqZzrzgKQ9uLWQHIfd1j3SZzA=;
        h=Date:From:To:Cc:Subject:From;
        b=AMP3rdH1zjSserQL0c9yAZPalpvwfhgz/4bMBrVqJE2dS6Ln6f/w24UpmFrinkwaG
         MOW9rbW8RAsq4t6F+zAId0LrfuI/Fc3EcDNvhMYPjiu+RcI0rbEmkdy7fqZiSRsx6I
         TQp1QqVq6YAKat7pbiwEp0AvhX2B6xZUB5+9pe2jiQYe+NCJKjK2XhGGpakPwJ2qbr
         GJQnJRk5u78PDtRIVhh4P8Z0wXTNe37uc5cn8rZsoytD27gs7/ijuQz21G530mkx1u
         Pd5HjfJJVLAdUxX8a1guhBCKCoeMRuxccDt5LheXXoWdLYXVvR64bnUGEK8QVO2VQQ
         5ydG6NC7cR25g==
Date:   Tue, 16 May 2023 19:03:39 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] media: venus: hfi_cmds: Replace fake flex-array with
 flexible-array member
Message-ID: <ZGQn63U4IeRUiJWb@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are deprecated, and we are replacing them with flexible
array members instead. So, replace one-element arrays with flexible-array
members in struct hfi_sys_set_resource_pkt, and refactor the rest of
the code, accordingly.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

The only binary differences seen before/after changes are the
following:

     17ba:      mov    %rbx,%rdi
     17bd:      call   17c2 <pkt_sys_set_resource+0x42>
                        17be: R_X86_64_PLT32    __tsan_write4-0x4
-    17c2:      movl   $0x14,(%rbx)
+    17c2:      movl   $0x10,(%rbx)
     17c8:      lea    0x4(%rbx),%rdi
     17cc:      call   17d1 <pkt_sys_set_resource+0x51>
                        17cd: R_X86_64_PLT32    __tsan_write4-0x4

which is expected once this accounts for the following line of code
at  drivers/media/platform/qcom/venus/hfi_cmds.c:73

73         pkt->hdr.size = sizeof(*pkt);

and as *pkt is of type struct hfi_sys_set_resource_pkt, sizeof(*pkt) is
reduced by 4 bytes, due to the flex-array transformation.

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/293
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 2 +-
 drivers/media/platform/qcom/venus/hfi_cmds.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 3f74d518ad08..7c82e212434e 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -83,7 +83,7 @@ int pkt_sys_set_resource(struct hfi_sys_set_resource_pkt *pkt, u32 id, u32 size,
 		res->size = size;
 		res->mem = addr;
 		pkt->resource_type = HFI_RESOURCE_OCMEM;
-		pkt->hdr.size += sizeof(*res) - sizeof(u32);
+		pkt->hdr.size += sizeof(*res);
 		break;
 	}
 	case VIDC_RESOURCE_NONE:
diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.h b/drivers/media/platform/qcom/venus/hfi_cmds.h
index ba74d03eb9cd..dd9c5066442d 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.h
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.h
@@ -56,7 +56,7 @@ struct hfi_sys_set_resource_pkt {
 	struct hfi_pkt_hdr hdr;
 	u32 resource_handle;
 	u32 resource_type;
-	u32 resource_data[1];
+	u32 resource_data[];
 };
 
 struct hfi_sys_release_resource_pkt {
-- 
2.34.1

