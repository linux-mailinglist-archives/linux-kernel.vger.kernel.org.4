Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D426B6C08
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 23:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjCLWnD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 18:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCLWnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 18:43:01 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62FA986AF
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 15:42:59 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso9708736wmq.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 15:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678660977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b0ViGEbyFErRvg7Qz/LIg+Zt65cp8EPInnkG8HJXYoM=;
        b=oHrvhUBnl0o+IC2q/3qYaOvxNruVjAMTtaLY5g2hJNy//RWU/sAxjg5l/Fh36sWDRu
         h8//7vjugmj6jHAjSuVtpM9PIJiAQtkF9tlfDj8NQUAIf8HA70C7R5tXlm7gAcOVxddi
         DfOMP4N4h/BYAXysR+vCDTyN6D+j71Q8qz4bXfuU72TEVMyrZ7DZ7t3MZfmWp8y69K71
         ln6iUHVgfQmzAVThIT7pR2mUfIFDI5QZOdL8qJoGZzj3uih2oqq3pg++6f4KD3eixIdY
         zSJcQeMo6XLUgrHXLKG9YDFvTZmviI8osj1mdvmlqe7V3SAjQLmJfgrIWgrvvAHYOc1T
         HN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678660977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b0ViGEbyFErRvg7Qz/LIg+Zt65cp8EPInnkG8HJXYoM=;
        b=FEBiHLiIU12hjgcjxxamFHjJSXI3fkdAPSEuMV0Yc/LV6zBtR3GZiiwuP5ewceAacq
         FxFVK/1i5pe7sG6652Rsvo7e3IdUlmrfb6bey3lKr8qNDQXnSHgo3ooP+TrSeRyseORY
         Hu9+EOiEsK2mNDEA/zgxSxjitVAAltd8JUwaquA0FxlmA2TCgoEnoKGdJhPPIBl93X6b
         m9h6VDiI9Wk/IlHrH1+PSX8NRjjBh2+BN+Dca9PFa+zTdkD40HuvXAwI7w48eVVA0URU
         FMz+DmIoS2jyiBcStD89HnAQMO8Dvmm0nkz5kixGAsXOprmQtqxaXPY89gRg+qyWLnl1
         /J+A==
X-Gm-Message-State: AO0yUKVGmvncSyW/WiAgsPdbfvfZTWmLtrVu/2S6oyDmHaw6jdSpbWAG
        w+YAufPLsMqtnmAVhEXh+4gkQin5euEFbg==
X-Google-Smtp-Source: AK7set/6UZOvxL1VAlulZhWciaG+yLSLeCHvf2bE1OEOwze3wPBFMFsTiKUztjVCYlACS0KZoPXXyw==
X-Received: by 2002:a05:600c:3506:b0:3e2:c67:1c7f with SMTP id h6-20020a05600c350600b003e20c671c7fmr8914733wmq.10.1678660977395;
        Sun, 12 Mar 2023 15:42:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:5d37:537d:cd23:cd6e:ae14:44fe])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6844000000b002ce3b31753fsm6137544wrw.26.2023.03.12.15.42.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 15:42:56 -0700 (PDT)
From:   Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     jgg@ziepe.ca, Liam.Howlett@Oracle.com, jhubbard@nvidia.com,
        david@redhat.com, willy@infradead.org, akpm@linux-foundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Subject: [RFC PATCH v1 1/1] linux: mm_types: allow to modified the vm_flags in vm_area_struct
Date:   Sun, 12 Mar 2023 23:42:50 +0100
Message-Id: <20230312224250.425727-1-vincenzopalazzodev@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With 6.3-rc1 is not possible to build the following drivers

- nvidia, that the compilation returns the following errors

/var/lib/dkms/nvidia/525.89.02/build/nvidia/nv-mmap.c: In function ‘nvidia_mmap_numa’:
/var/lib/dkms/nvidia/525.89.02/build/nvidia/nv-mmap.c:455:19: error: assignment of read-only member ‘vm_flags’
  455 |     vma->vm_flags |= VM_MIXEDMAP;
      |                   ^~
/var/lib/dkms/nvidia/525.89.02/build/nvidia/nv-mmap.c: In function ‘nvidia_mmap_helper’:
/var/lib/dkms/nvidia/525.89.02/build/nvidia/nv-mmap.c:599:23: error: assignment of read-only member ‘vm_flags’
  599 |         vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND;
      |                       ^~
/var/lib/dkms/nvidia/525.89.02/build/nvidia/nv-mmap.c:666:23: error: assignment of read-only member ‘vm_flags’
  666 |         vma->vm_flags |= (VM_IO | VM_LOCKED | VM_RESERVED);
      |                       ^~
/var/lib/dkms/nvidia/525.89.02/build/nvidia/nv-mmap.c:667:23: error: assignment of read-only member ‘vm_flags’
  667 |         vma->vm_flags |= (VM_DONTEXPAND | VM_DONTDUMP);
      |                       ^~
/var/lib/dkms/nvidia/525.89.02/build/nvidia/nv-mmap.c:673:23: error: assignment of read-only member ‘vm_flags’
  673 |         vma->vm_flags &= ~VM_WRITE;
      |                       ^~
/var/lib/dkms/nvidia/525.89.02/build/nvidia/nv-mmap.c:674:23: error: assignment of read-only member ‘vm_flags’
  674 |         vma->vm_flags &= ~VM_MAYWRITE;
      |                       ^~
/var/lib/dkms/nvidia/525.89.02/build/nvidia/nv-mmap.c: In function ‘nv_encode_caching’:
/var/lib/dkms/nvidia/525.89.02/build/nvidia/nv-mmap.c:353:16: warning: this statement may fall through [-Wimplicit-fallthrough=]
  353 |             if (NV_ALLOW_CACHING(memory_type))
      |                ^
/var/lib/dkms/nvidia/525.89.02/build/nvidia/nv-mmap.c:356:9: note: here
  356 |         default:
      |         ^~~~~~~
make[2]: *** [scripts/Makefile.build:252: /var/lib/dkms/nvidia/525.89.02/build/nvidia/nv-mmap.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [Makefile:2028: /var/lib/dkms/nvidia/525.89.02/build] Error 2
make[1]: Leaving directory '/home/vincenzopalazzo/gittea/linux'
make: *** [Makefile:82: modules] Error 2
------

- vboxhost/7.0.6_OSE where the build fails with the following errors
DKMS make.log for vboxhost-7.0.6_OSE for kernel 6.3.0-rc1-00231-g511e7733223b (x86_64)
Sat Mar 11 04:21:34 PM UTC 2023
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxnetflt/linux/VBoxNetFlt-linux.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxnetadp/linux/VBoxNetAdp-linux.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxnetflt/VBoxNetFlt.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/linux/SUPDrv-linux.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/SUPDrv.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxnetadp/VBoxNetAdp.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/SUPDrvGip.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxnetflt/SUPR0IdcClient.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/SUPDrvSem.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxnetflt/SUPR0IdcClientComponent.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxnetflt/linux/SUPR0IdcClient-linux.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/SUPDrvTracer.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/SUPLibAll.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/common/string/strformatrt.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/combined-agnostic1.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/combined-agnostic2.o
  CC [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/combined-os-specific.o
  LD [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxnetadp/vboxnetadp.o
In file included from /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/combined-os-specific.c:43:
/var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/r0drv/linux/memobj-r0drv-linux.c: In function ‘rtR0MemObjNativeLockUser’:
/var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/r0drv/linux/memobj-r0drv-linux.c:1404:39: error: assignment of read-only member ‘vm_flags’
 1404 |                 papVMAs[rc]->vm_flags |= VM_DONTCOPY | VM_LOCKED;
      |                                       ^~
/var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/r0drv/linux/memobj-r0drv-linux.c: In function ‘rtR0MemObjNativeMapUser’:
/var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/r0drv/linux/memobj-r0drv-linux.c:1876:35: error: assignment of read-only member ‘vm_flags’
 1876 |                     vma->vm_flags |= VM_DONTEXPAND | VM_DONTDUMP;
      |                                   ^~
make[2]: *** [scripts/Makefile.build:252: /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv/combined-os-specific.o] Error 1
make[2]: *** Waiting for unfinished jobs....
  LD [M]  /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxnetflt/vboxnetflt.o
make[1]: *** [scripts/Makefile.build:494: /var/lib/dkms/vboxhost/7.0.6_OSE/build/vboxdrv] Error 2
make: *** [Makefile:2028: /var/lib/dkms/vboxhost/7.0.6_OSE/build] Error 2
-----

The commands that I use to build these drivers are:

- sudo dkms install --no-depmod nvidia/525.89.02 -k 6.3.0-rc1-00231-g511e7733223b
- sudo dkms install --no-depmod vboxhost/7.0.6_OSE -k 6.3.0-rc1-00231-g511e7733223b

The following commit reverts the const constraint that was added in [1],
and also I tested this patch on my system and all started again as
6.2.2.

[1] https://lore.kernel.org/all/20230126193752.297968-3-surenb@google.com/T/#u

Signed-off-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
---
 include/linux/mm_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 0722859c3647..a354eb60c7e8 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -497,7 +497,7 @@ struct vm_area_struct {
 	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
 	 */
 	union {
-		const vm_flags_t vm_flags;
+		vm_flags_t vm_flags;
 		vm_flags_t __private __vm_flags;
 	};
 
-- 
2.39.2

