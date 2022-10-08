Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 850555F83E7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 09:02:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJHHCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 03:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJHHCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 03:02:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE421A87AD
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 00:02:11 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r18so6370165pgr.12
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 00:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b9N5RbcXNeHRQoNQNCKxlzUZ9H+RkGCubTDWVE1lNM8=;
        b=K6xslpaQm12IfNE9utx1q9cy5IMiP9iK/yybo0lEVo6aeCAghlYhYnYeepo3Ra/Nc8
         Ut05uHV/8T3k+mWTswCtJtBOS5SXV/CVmSpccrJEVdHPganNHibOtBs03zdCH6QOdNUc
         yzzdVA4KzcbQroZu9/a6ZrGPRgqc+UUo/HMK83g1kjYDdu7QJONtu//EyckiCMDuKimI
         P1LvoWPHNqzQ+ov8pYjR3QCRt5ilB6u1oT0R/+bQUE2oSqkSnsyR35IA+y7cw2KJvK+E
         Yb2EsjLvXB08pph9MnMYCvl7CjhNpnt5bnQ7feWmaypfGCYjh8RF2Pq7+bx/e0bO2ly9
         BTFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b9N5RbcXNeHRQoNQNCKxlzUZ9H+RkGCubTDWVE1lNM8=;
        b=eM+T1A+tCbhNigmwrkbx8Gy7AT+KoSg5Ia4R3WfKwO/uYr4FzgBaXSsTl+swGc5nUv
         VpxIIcQsEoyceA3BCILhjJA6ofasvdK3vHsJw+Scj5PEi74ripsV0zrJ5gzRfBDltFOf
         PBcg8eAwP0OcQygaDK7Okab2TUwm4GdvvI7RoUueF6nkPgi8gtvU4DWSfAVyCpSSIROE
         u0UDeIW2YKwIBkGIHJ4vfqhFfEYjiFlZ3NFqz91khM82skoTRsATep1h32qEWnSWrz4D
         x2qEN/awtbwmogZYdJlfVVD3wqiGxAR8u7I4EI3VGg0yCHPL3kG0P90YNyd6T9sYGuZc
         KMVw==
X-Gm-Message-State: ACrzQf1GluQsRlGblEldF49Hv89LtdQWytzTvt8b4vLASwEinwpNMECQ
        W60dL1Fi+0H93RqoL1JYhKc=
X-Google-Smtp-Source: AMsMyM7J+etiNelbRnm852vp9JCNZ1MD2yn70pGzDcgK6o+ADrXnsfe1G/Hi+DN8AxFrJLsEr9UBpg==
X-Received: by 2002:a63:2155:0:b0:455:7b5b:c2d7 with SMTP id s21-20020a632155000000b004557b5bc2d7mr7708186pgm.309.1665212531485;
        Sat, 08 Oct 2022 00:02:11 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id x9-20020a170902a38900b0017f9db0236asm2618726pla.82.2022.10.08.00.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 00:02:10 -0700 (PDT)
From:   xu.xin.sc@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     ran.xiaokai@zte.com.cn, yang.yang29@zte.com.cn,
        jiang.xuexin@zte.com.cn, imbrenda@linux.ibm.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: [PATCH 0/5] ksm: support tracking KSM-placed zero-pages
Date:   Sat,  8 Oct 2022 07:01:56 +0000
Message-Id: <20221008070156.308465-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

From: xu xin <xu.xin16@zte.com.cn>

Before enabling use_zero_pages by setting /sys/kernel/mm/ksm/
use_zero_pages to 1, pages_sharing of KSM is basically accurate. But
when enabling use_zero_pages, all empty pages that are merged with
kernel zero page are not counted in pages_sharing or pages_shared.
That is because these empty pages are merged with zero-pages then no
longer managed by KSM, which leads to two issues at least:

1) MADV_UNMERGEABLE and other ways to trigger unsharing will *not*
   unshare the shared zeropage as placed by KSM (which is against the 
   MADV_UNMERGEABLE documentation at least); see the link:
   https://lore.kernel.org/lkml/4a3daba6-18f9-d252-697c-197f65578c44@redhat.com/

2) we cannot know how many pages are zero pages placed by KSM when
   enabling use_zero_pages, which leads to KSM not being transparent
   with all actual merged pages by KSM.

With the patch series, we can unshare zero-pages(KSM-placed) accurately
and count ksm zero pages.


*** BLURB HERE ***

xu xin (5):
  ksm: abstract the function try_to_get_old_rmap_item
  ksm: support unsharing zero pages placed by KSM
  ksm: count all zero pages placed by KSM
  ksm: count zero pages for each process
  ksm: add zero_pages_sharing documentation

 Documentation/admin-guide/mm/ksm.rst |  10 +-
 fs/proc/base.c                       |   1 +
 include/linux/mm_types.h             |   7 +-
 mm/ksm.c                             | 177 +++++++++++++++++++++------
 4 files changed, 157 insertions(+), 38 deletions(-)

-- 
2.25.1

