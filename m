Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C92A63FD77
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 02:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiLBBEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 20:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiLBBET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 20:04:19 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8072CB20E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 17:04:17 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so6855118pjc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 17:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mgD8FhgaFk9oCftVcbd5rE8c85Ck+hk9NaPIDPM9D7Y=;
        b=aXrpwNbgm5OLZXe+psbrCgfJS4wj+DxUnSQ11xpRLZp40aoUthPqou72FOg4Nk2znH
         WQrtt3K6jfLcVlpWIHtisgX0R7aWBFh2i7PfSELXEFP/a6bue3UTlFtiw48XuH4WDtc0
         F8Xh1TTkIXfh1heg7JV6bZrQ7+BE0SvwOoZaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgD8FhgaFk9oCftVcbd5rE8c85Ck+hk9NaPIDPM9D7Y=;
        b=TU91tIEWkRSRc9KxLYTrR9D0fyeu+vxnuBWLDqJMZZWkEDRIBN+tk4mQ8u/vKI3hNJ
         5bUoovwKYUbKLBXHQrLFbrkp4Am3E6CgipA3VA7eeg2OI0kEK0+ciG1hfaYUlwzZ7a+k
         ODUTFuvxgQYhFTvHEztCceEandlraXyxFn/Wk/IvIThxJeQWLIoUv2F1zIVkLvjlkN5D
         EbWmpfLbqhU7TJws5DCMmgV/dUENG7tghNK7knSn7u2rfuk+bWRjrwVpUaNvRmcNAjP1
         65oAJf8bcqgxIX/aVlWXnDw1x8cHQcjg7s14wnSPVh/FjFZdFICA+kV+LUWbLuebp0AQ
         Qy/w==
X-Gm-Message-State: ANoB5pmNoil1nhIV+Yzlc6093VdIFPawvUt6eih+jWv82nJB3aOLAJcz
        SDigByKUrWz3tGPjNXEBAsLC7Q==
X-Google-Smtp-Source: AA0mqf5o3BeIFoW83AbmXDjzB9oWBsGdeQwe595mOIjOvfykNr4VKujP0z1ZS/WKspE1J6UFVJIEgA==
X-Received: by 2002:a17:902:bd04:b0:189:38a1:30fe with SMTP id p4-20020a170902bd0400b0018938a130femr47006070pls.47.1669943057301;
        Thu, 01 Dec 2022 17:04:17 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w81-20020a627b54000000b0057255b7c8easm3839384pfc.33.2022.12.01.17.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 17:04:16 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Kees Cook <keescook@chromium.org>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] crypto/caam: Avoid GCC constprop bug warning
Date:   Thu,  1 Dec 2022 17:04:14 -0800
Message-Id: <20221202010410.gonna.444-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2834; h=from:subject:message-id; bh=xh4MxFL84Wy20TxfRpoAzNdIE896T/TUz2F6Ru6YtCM=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjiU8Nv8CsDf2sTBuvc9KYWF5qFW721OEsR46gpWiR MEbbVnOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY4lPDQAKCRCJcvTf3G3AJlVYD/ 9v+qIE/EyYegIvaxfV8obcYEMuN3x9SF+CAa68Qd6JGjXbCipnKim4YNCrlIhsmVwE/tO06p+LJk2S kHXAL6vsoN8TZnp6ByyH6NeLmuftpptVBT6wu4lxkXmBjJQzuYtlgAkRDOgOq9Wm0D+ly2MlMJW9h2 bKGxJY8YkYWTDT9OzSKuQLpU6y5kVkfDiGDP7QKRkpk7buT2aQa0xHRZTZY7MFutfNstcw+XeL8e5C 5DFuHMKzZQtXsN9p9O5QsBFqsphVli3xl34t3YDd9c4uyhL8mdl6ahVQeOYmu8tr+6a+OShw+WEi1b nGhekoLQM5CB6XTAfmvV2XIMVgfpb0c2zR16DGGCqgKDZKfe2ZgCyywnkt7MN6aVc9+Y66GkgZ1kEV 7pSNjP3T+YYOiWVM/52S6yQna03IBCV9ls5bEO32XUxOniZWb1JxXCyjQ+w6DfISBx8Rl5zjNq1Fz0 KRlV6zqUf0PO65GGn1POuty8nOLxPQ6hbt6PylPrXDbBGkRq7Cjcc6K70xyNWWxCeHgm+f7uVqmdoX 7RdOXI8r5s+3uFH+cSuH2dawHfH/sLmip+qlNnjFG83BrSygx0nb1kYoWmEXcdc4ZR4iFVaD8GZshx JBcSKCu2FceYBBugRUkJC/L2PFrEceTaJS/hTlK+dX1X8pnHU6o06gAjfBVQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 12 appears to perform constant propagation incompletely(?) and can
no longer notice that "len" is always 0 when "data" is NULL. Expand the
check to avoid warnings about memcpy() having a NULL argument:

   ...
                    from drivers/crypto/caam/key_gen.c:8:
   drivers/crypto/caam/desc_constr.h: In function 'append_data.constprop':
   include/linux/fortify-string.h:48:33: warning: argument 2 null where non-null expected [-Wnonnull]
      48 | #define __underlying_memcpy     __builtin_memcpy
         |                                 ^
   include/linux/fortify-string.h:438:9: note: in expansion of macro '__underlying_memcpy'
     438 |         __underlying_##op(p, q, __fortify_size);                        \
         |         ^~~~~~~~~~~~~

The NULL was being propagated from:

        append_fifo_load_as_imm(desc, NULL, 0, LDST_CLASS_2_CCB |
                                FIFOLD_TYPE_MSG | FIFOLD_TYPE_LAST2);
...
static inline void append_##cmd##_as_imm(u32 * const desc, const void *data, \
                                         unsigned int len, u32 options) \
{ \
        PRINT_POS; \
        append_cmd_data(desc, data, len, CMD_##op | options); \
}
...
APPEND_CMD_PTR_TO_IMM(fifo_load, FIFO_LOAD);
...
static inline void append_cmd_data(u32 * const desc, const void *data, int len,
                                   u32 command)
{
        append_cmd(desc, command | IMMEDIATE | len);
        append_data(desc, data, len);
}

Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "Horia Geantă" <horia.geanta@nxp.com>
Cc: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Gaurav Jain <gaurav.jain@nxp.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/lkml/202210290446.qBayTfzl-lkp@intel.com
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20221028210527.never.934-kees@kernel.org/
v2: update comment (anders)
Note that this is about GCC, not sparse (any more).
---
 drivers/crypto/caam/desc_constr.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/caam/desc_constr.h b/drivers/crypto/caam/desc_constr.h
index 62ce6421bb3f..d9da4173af9d 100644
--- a/drivers/crypto/caam/desc_constr.h
+++ b/drivers/crypto/caam/desc_constr.h
@@ -163,7 +163,8 @@ static inline void append_data(u32 * const desc, const void *data, int len)
 {
 	u32 *offset = desc_end(desc);
 
-	if (len) /* avoid sparse warning: memcpy with byte count of 0 */
+	/* Avoid GCC warning: memcpy with NULL dest (but byte count of 0). */
+	if (data && len)
 		memcpy(offset, data, len);
 
 	(*desc) = cpu_to_caam32(caam32_to_cpu(*desc) +
-- 
2.34.1

