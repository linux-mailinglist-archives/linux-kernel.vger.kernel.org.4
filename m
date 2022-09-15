Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B3985BA194
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 21:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIOTmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 15:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiIOTlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 15:41:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4806D9F777
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 12:38:15 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id 3so13765121qka.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 12:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=VhWltIWQGr4otQw1ais9xJMa50uESeMiXqro3LvTwg8=;
        b=ZOzER003YVUI0wX40DWwfYnP8PmDaWJ1GUNNHRfVg+RBqRnDWZhobIt10jbRXG8ikP
         34RlHzRathp0u9FK7XGi0BLgao/yNkGHKjbQLgAQez8U/Fhwf9EYBjieRXyIlHh6xXY2
         OevX6u1otUPcmldEFrNI5xLckhnjUCJ0SfDqAcm4iJwRkTv239iIvcgO2kRWb8jlWWs5
         5j9nX8N+bM4li1mPoUvQv3damgywG3DWnKZ/rNZkmx3EnWm9jeo6MomLeWsIqSY88BrG
         D2mcSfMSddHnyLQjz6qPki3X548HVK9mZUvsHKjjIfayptk1JD4au5JFBBJkao5Oi76J
         ro+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VhWltIWQGr4otQw1ais9xJMa50uESeMiXqro3LvTwg8=;
        b=B0w4x1aHVuJSi1N756XIaxmCSe51X7lS2eAVtzzDh1YQuRE1h633eq1XONyCbOBufA
         8TShn38iIm6msqLTNhyb+Peu9te/90IoX1al6aeHwFvBUTjxC39CnWBCAznsmb2Buisa
         WkmnKoWDJOuMC2J+YJUYDEC9157KOGphts0sbih2Ot29ElIof8Z+w6OfClpKFn8pSHJ9
         DK3wstH5KK9az6fCeO9NrFpOaPtFMrJ/L+dp0Qu1S53M2LAVuOW9FYAMAsX09P7dXWxs
         pOD6bBnqmZBq+LXILpllZANwIK9zyGipQk7hmiZogLleAwC/ARMYsJAtUUC3F7NfK8wR
         3O3w==
X-Gm-Message-State: ACrzQf0os7eFCpggmyCxTjqdjoKTBK9uWLE8x6E0U2gpgVo71dGtCw6e
        HEPThsYOxvB/LeNWSNhTWYagEg==
X-Google-Smtp-Source: AMsMyM5HYNnkqQFryIhusPOXnsW0KKQfhvLYBxoxwi2MA6hkWp7FXfscczo+CSe0KbEGeI/30Dqumg==
X-Received: by 2002:a05:620a:40c6:b0:6bb:3d30:735 with SMTP id g6-20020a05620a40c600b006bb3d300735mr1394165qko.653.1663270635403;
        Thu, 15 Sep 2022 12:37:15 -0700 (PDT)
Received: from abrestic-xps.ba.rivosinc.com (pool-71-105-112-35.nycmny.fios.verizon.net. [71.105.112.35])
        by smtp.gmail.com with ESMTPSA id r1-20020ae9d601000000b006b872b606b1sm4596459qkk.128.2022.09.15.12.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 12:37:15 -0700 (PDT)
From:   Andrew Bresticker <abrestic@rivosinc.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, Ruizhe Pan <c141028@gmail.com>,
        Conor.Dooley@microchip.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@rivosinc.com>,
        stable@vger.kernel.org, Atish Patra <atishp@rivosinc.com>
Subject: [PATCH v4 1/2] riscv: Make VM_WRITE imply VM_READ
Date:   Thu, 15 Sep 2022 15:37:01 -0400
Message-Id: <20220915193702.2201018-2-abrestic@rivosinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220915193702.2201018-1-abrestic@rivosinc.com>
References: <20220915193702.2201018-1-abrestic@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V does not presently have write-only mappings as that PTE bit pattern
is considered reserved in the privileged spec, so allow handling of read
faults in VMAs that have VM_WRITE without VM_READ in order to be consistent
with other architectures that have similar limitations.

Fixes: 2139619bcad7 ("riscv: mmap with PROT_WRITE but no PROT_READ is invalid")
Cc: <stable@vger.kernel.org> # v4.19+
Reviewed-by: Atish Patra <atishp@rivosinc.com>
Signed-off-by: Andrew Bresticker <abrestic@rivosinc.com>
---
new in v3
v3 -> v4: add Fixes tag
---
 arch/riscv/mm/fault.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index f2fbd1400b7c..d86f7cebd4a7 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -184,7 +184,8 @@ static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
 		}
 		break;
 	case EXC_LOAD_PAGE_FAULT:
-		if (!(vma->vm_flags & VM_READ)) {
+		/* Write implies read */
+		if (!(vma->vm_flags & (VM_READ | VM_WRITE))) {
 			return true;
 		}
 		break;
-- 
2.25.1

