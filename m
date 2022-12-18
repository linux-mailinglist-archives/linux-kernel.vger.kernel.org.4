Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC17D650459
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 19:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbiLRSbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 13:31:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbiLRSaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 13:30:35 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF1355B0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 10:19:06 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w15so6784889wrl.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 10:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mail.huji.ac.il; s=mailhuji;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yxdu72YhCTISL2BPtVB+B8zb3J0dRA9fDH5fu8L77EM=;
        b=ofTP31M0qkkWWR1vwtEoZJ3F61v0rpEoDk5RKSZw4+WHAw9KRF1dDlLhfqIhke21/C
         gvAqtaS5IEdG0wOIV+MCawfTFs/s57vteMpt/5rsYsmMsiKMbX7VOdo6K01IGjEei3Mi
         gKC8S6Px/FBRos77qCtzDAzncon4bagRkSDt4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yxdu72YhCTISL2BPtVB+B8zb3J0dRA9fDH5fu8L77EM=;
        b=FGfRPjw3roJdPrf5jZgIr9lUX+W36Ox67OM3lPHltqn4ck0+ARvb4KILKcv95eaMtV
         6MYtqO2zzqfI5zDvWwe6oOugvsLXiguFgBoOzPaEzyB+VO8YZDYlL6AOitoRmSn9Fp++
         xZQSzzrhPvka8uhCMlDUWmarZHscyQFrKz5cpO4HSd2pyPFlp18tSWTrzmd1VlQKEKMs
         6m3Sleg3XJxnok09ikIXXtIVWtjvV4UDduN8tl5wnHRvyUZGXbKUVEazgo2qppntFiA+
         ECauzr/WS4qnWej81qo2E/WebpoWqQkOdOWA7eiJeZrb94NksWhYBFIqKxKIp7sWlhsC
         77Kg==
X-Gm-Message-State: ANoB5pmgcaKsxiUgXu5xH15fH8E86Fr9W48E4nV4JLImq+E9VWnp0O7m
        xQaJAsK1D4CTChgX5FBhvPzVuJ1+etyL6YN414W/RqR0L01d2LtpmU4VOfHbcMEHujnNCs+u69u
        QX4OjWDEpVtvwZyY77C3UNnNL/uJ1UpyRB11fzRXMw1/jPMbvUwzNOPrHS/AdF0HThy0XUKb7So
        yZw+GuWHgOartD12rzFNlCnWg=
X-Google-Smtp-Source: AA0mqf71WDDq80LmTFC8T3VFJz2DJudTFRdPyMXPdL8mtQi2rHRbQA1ofTDIQxeWj5vqryeMY772Bg==
X-Received: by 2002:adf:ee12:0:b0:242:1cc2:b1eb with SMTP id y18-20020adfee12000000b002421cc2b1ebmr25898728wrn.5.1671387544992;
        Sun, 18 Dec 2022 10:19:04 -0800 (PST)
Received: from MacBook-Pro-6.lan ([2a0d:6fc2:218c:1a00:c45e:1c4b:fab4:ee34])
        by smtp.gmail.com with ESMTPSA id b13-20020a05600003cd00b0024cb961b6aesm7956489wrg.104.2022.12.18.10.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 10:19:04 -0800 (PST)
From:   david.keisarschm@mail.huji.ac.il
To:     linux-kernel@vger.kernel.org
Cc:     Jason@zx2c4.com,
        David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>,
        aksecurity@gmail.com, ilay.bahat1@gmail.com, bpf@vger.kernel.org
Subject: [PATCH v3 0/3] Replace invocations of prandom_u32() with get_random_u32()
Date:   Sun, 18 Dec 2022 20:18:57 +0200
Message-Id: <cover.1671277662.git.david.keisarschm@mail.huji.ac.il>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Keisar Schmidt <david.keisarschm@mail.huji.ac.il>

Hi,

This third series add some changes to the commit messages,
and also replaces get_random_u32 with get_random_u32_below,
in a case a modulo operation is done on the result.

The security improvements for prandom_u32 done in commits c51f8f88d705
from October 2020 and d4150779e60f from May 2022 didn't handle the cases
when prandom_bytes_state() and prandom_u32_state() are used.

Specifically, this weak randomization takes place in three cases:
    1.	mm/slab.c
    2.	mm/slab_common.c
    3.	arch/x86/mm/kaslr.c

The first two invocations (mm/slab.c, mm/slab_common.c) are used to create
randomization in the slab allocator freelists.
This is done to make sure attackers can’t obtain information on the heap state.

The last invocation, inside arch/x86/mm/kaslr.c,
randomizes the virtual address space of kernel memory regions.
Hence, we have added the necessary changes to make those randomizations stronger,
switching  prandom_u32 instances to get_random_u32.

# Changes since v2

* edited commit message in all three patches.
* replaced instances of get_random_u32 with get_random_u32_below
    in mm/slab.c, mm/slab_common.c

# Changes since v1

* omitted the renaming patch, per the feedback we received
* omitted the replace of prandom_u32_state with get_random_u32 in bpf/core.c
 as it turned out to be a duplicate of a patch suggested earlier by Jason Donenfeld

Regards,


David Keisar Schmidt (3):
  Replace invocation of weak PRNG in mm/slab.c
  Replace invocation of weak PRNG inside mm/slab_common.c
  Replace invocation of weak PRNG in arch/x86/mm/kaslr.c

 arch/x86/mm/kaslr.c |  5 +----
 mm/slab.c           | 25 ++++++++++---------------
 mm/slab_common.c    | 11 +++--------
 3 files changed, 14 insertions(+), 27 deletions(-)

-- 
2.38.0

