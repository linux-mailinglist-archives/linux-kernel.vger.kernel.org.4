Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ECD60E020
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 14:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiJZMBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 08:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiJZMBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 08:01:04 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8445762900;
        Wed, 26 Oct 2022 05:01:01 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z97so41005332ede.8;
        Wed, 26 Oct 2022 05:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbtw+HRW2KLHl7Yg2Uo3gcNX/+9EYg5HCVoRagBLIkA=;
        b=ggUvJA2IjkkFVR7NAfRcitqbXwBiJfMYPc/6Rxg3BC0XsP6r3isgE7h6ThIPiNlA4o
         npPZMMp2U21fkqhALp56gPM2IEy7LfNkT/0Ir+tKimHwUuQiHMbfwG5za/rZ/WWujXIz
         zyqTmgTYVutFLxLcrwYLC1/W4qVAJgXVlHQMWORqIqfDWNvagTGJab0wLIw7UVWN9InC
         Zk6AAdIl/OdX7LRG8h+0HKi+BDtCJrstz6Kq58RrL6GbpOT6wZNG43JF/1BGpUmjD8ga
         LMNZoJWlxjgWumaLkui3hBf4nXI+9Eev35RDpkFI0JgfFIvhFGm7R/qj4XOdybFWYsUZ
         k6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbtw+HRW2KLHl7Yg2Uo3gcNX/+9EYg5HCVoRagBLIkA=;
        b=LWSYdvUT1kYfaMZqJRbxDq63SNqWKygyNCo5HIMEeIkCcwIk8kkMd9ujlaSWbDLZyo
         M3l/4ThkxeowXj4W9k4/vBkFvFw8RFAyWn9Ij5zNbv7FvL59ax5Fb9cQJTOhvW4GefEZ
         rEqsiafHV1lmXglbzeKuIpYCmmku/8StkrQKO0bJhUvXFkV4iBamA6f7WVrOrTDiuDxo
         wZqxJgxSgMXJWIGTpeapeAH1soLsL5SBXOT7h0Wb/z/4+jOdXPi97xl9TxtMd5/KBqz1
         PjgvGAkStVXcFXV/EHA8wK7FhA5mhUT64/m7EfzCq2U7I/jegAIuBGwzzMo4K6sp+g2E
         wucQ==
X-Gm-Message-State: ACrzQf0r4RsgYEgDq4pp5H/HkpMI/gDW2aaAOmmJthvJL4vJqXNEn8mE
        zrDWCab1hjcPONrFdZ+unrw=
X-Google-Smtp-Source: AMsMyM6cjz1cxDXxmcXl52+FSt5RnzvM6WTi/mlDsR93q4wrCLyCkB+KHz+hkJutaz5jUk7+0BAdmQ==
X-Received: by 2002:aa7:dc10:0:b0:440:b446:c0cc with SMTP id b16-20020aa7dc10000000b00440b446c0ccmr40232509edu.34.1666785659926;
        Wed, 26 Oct 2022 05:00:59 -0700 (PDT)
Received: from felia.fritz.box (200116b826195000091b3ab8e8f9a156.dip.versatel-1u1.de. [2001:16b8:2619:5000:91b:3ab8:e8f9:a156])
        by smtp.gmail.com with ESMTPSA id ky21-20020a170907779500b00788c622fa2csm2872760ejc.135.2022.10.26.05.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 05:00:58 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 0/1] Dead stores in maple-tree
Date:   Wed, 26 Oct 2022 14:00:28 +0200
Message-Id: <20221026120029.12555-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear maple-tree authors, dear Liam, dear Matthew,

there are some Dead Stores that clang-analyzer reports:

lib/maple_tree.c:2906:2: warning: Value stored to 'last' is never read [clang-analyzer-deadcode.DeadStores]
lib/maple_tree.c:2907:2: warning: Value stored to 'prev_min' is never read [clang-analyzer-deadcode.DeadStores]

I addressed these two cases, which were most obvious and clear to fix;
see patch of this one-element series.

Further, clang-analyzer reports more, which I did not address:

lib/maple_tree.c:332:2: warning: Value stored to 'node' is never read [clang-analyzer-deadcode.DeadStores]
lib/maple_tree.c:337:2: warning: Value stored to 'node' is never read [clang-analyzer-deadcode.DeadStores]

Unclear to me if the tool is wrong or right in its analysis here for the two functions above.

lib/maple_tree.c:1212:23: warning: Value stored to 'nodep' during its initialization is never read [clang-analyzer-deadcode.DeadStores]

A lot of pointer magic. Unclear to me if the tool is wrong or right in its analysis here.

lib/maple_tree.c:5014:5: warning: Value stored to 'count' is never read [clang-analyzer-deadcode.DeadStores]

Unclear if the code is intended as it is now.

In mas_anode_descend(), the variable count is really just assigned and used once
effectively. The second assignment is never read. So, the variable count could
just be removed in mas_anode_descend().


Maybe these further warnings are helpful to clean up the code or find an issue
that was overlooked so far.


Best regards,

Lukas


Lukas Bulwahn (1):
  lib: maple_tree: remove unneeded initialization in mtree_range_walk()

 lib/maple_tree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.17.1

