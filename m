Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79F4608D6A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJVNeX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 09:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiJVNeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 09:34:19 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332CF250292;
        Sat, 22 Oct 2022 06:34:15 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id a10so8412904wrm.12;
        Sat, 22 Oct 2022 06:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fs1ugU1QCtTRojQKok2Y9RVK5OYpb5v6MU7b7mZxaIU=;
        b=ADfCJtpLhac9mODNjRtR9Trv7yVpCi+0T6WbsfEnkaoGWXQ23gFvNm1td9GyxF8AR+
         sdXo88xxA8Kj0PLQxckvQ5bOJlYh+Bv4yqHPMX9ELqMnRmkh9FTIqnwOYIeXKq6aRJ0r
         73TrRdD6/cWa/CzN+OAbySB5UT4pnve4pJT68lMowsBZqxGeUtzDeQnq+pXiprhK60LW
         pU5Wx3u+FvYqMKj6XCl87ShDLO8h8+6oPxhdrp5cLtQgaUhvmY2MQMX0E1xJeP3MpHGk
         6oDpRwWVCRpmb5DIjToNNTSglYNC9NCCZWPrJsNpVfNwsnlgRaj8d/5lm2d9VzkrpjUm
         LFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fs1ugU1QCtTRojQKok2Y9RVK5OYpb5v6MU7b7mZxaIU=;
        b=FwPsmZ4mM75Ap4aJ+LXoNwgn8wKNXPlnWAYFpszrD6ipjdwRMQhibmrraEXjTTkx/+
         cTjikCaNxEPgdoq1Lvhq8qSp2/lfR/EOfby2ASSCGKc0pCEGC9lwhC9cF72p4JsAJO3z
         ivue+korHe3b+o6P7ObzO5qxzxzXW5nETO8FfflwKzGdV1IRL4oH8yBIS1a4cffuMf0c
         rb3z3V2W4EtkawdTNBd6jyLFbpqBzqP1QDOtBYkOJMsMFNx4+mB8vB404K+ycd1eb4SU
         8a1fxPcNC52B6HhC6kSKPJInw+/jhdzq+r8k+xzdNb0rctuf0Ueh6CI7Ge8KWdSQwE+l
         rVCQ==
X-Gm-Message-State: ACrzQf345t999ORet5ezZ3FJm7lcHceu+T/wyksrJeDIf7/b0zw3rJp/
        sPmRy0MB8hiQfZFshL9n69pK+3+QKx0=
X-Google-Smtp-Source: AMsMyM6+Gp773kEwcLrpKgHk/yCZrQqvJIxZTgbaVCwMd9zoBCYVvddNef0t+kT59rcLdwldK52wZw==
X-Received: by 2002:a5d:6f17:0:b0:22e:33e7:6f6c with SMTP id ay23-20020a5d6f17000000b0022e33e76f6cmr14986014wrb.201.1666445653321;
        Sat, 22 Oct 2022 06:34:13 -0700 (PDT)
Received: from debby ([2a01:e0a:a6d:a8d0:7ff4:8f61:5574:9f95])
        by smtp.gmail.com with ESMTPSA id t2-20020adff602000000b0023659925b2asm2770617wrp.51.2022.10.22.06.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 06:34:12 -0700 (PDT)
From:   Romain Perier <romain.perier@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>,
        Romain Perier <romain.perier@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v7 0/1] ARM: mstar: cpupll
Date:   Sat, 22 Oct 2022 15:34:03 +0200
Message-Id: <20221022133404.3832-1-romain.perier@gmail.com>
X-Mailer: git-send-email 2.35.1
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

This is a resend of the remaining patches of this series. I have kept
the cover letter in order to do not loose context of the previous series.

This series adds a basic driver for the PLL that generates
the cpu clock on MStar/SigmaStar ARMv7 SoCs.

Unfortunately there isn't much documentation for this thing
so there are few magic values and guesses.

This needs to come after the MPLL DT changes.

Changes since v6:
- Add my Signed-off-by tag

Changes since v5:
- Fixed tags for Willy
- Add missing kernel.h and device.h
- Use devm_of_clk_add_hw_provider
- Move "cpupll_parent" on the stack as it is only used by
  devm_clk_hw_register (it seems safe).

Changes since v4:
- Removed merged patches (dt-bindings documentation and dt-bindings)
- Rebased onto 5.19

Changes since v3:
- Added Reviewed-by on Daniel's patches
- Removed "[PATCH v3 8/9] ARM: mstar: Add OPP table for mercury5"

Changes since v2:
- Re-ordered Kconfig by name
- Re-ordered includes alphabetically and removed useless ones
- Used timeout for cpu_relax
- Returned DIV_ROUND_DOWN_ULL() directly in
  msc313_cpupll_frequencyforreg()
- Returned DIV_ROUND_DOWN_ULL() directly in
  msc313_cpupll_regforfrequecy()
- Reduced the number of lines for msc313_cpupll_of_match
- Removed CLK_IS_CRITICAL

Changes since v1:
- Re-worked the series and ensure that 'make dt_binding_check' passes.
  The required commit is merged now, so it is okay.
- Fixed coding style issues in the driver and makes check_patch.pl happy
- Added one more commit for extending the opp_table for infinity2m.

Daniel Palmer (1):
  clk: mstar: msc313 cpupll clk driver

 drivers/clk/mstar/Kconfig             |   7 +
 drivers/clk/mstar/Makefile            |   1 +
 drivers/clk/mstar/clk-msc313-cpupll.c | 220 ++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100644 drivers/clk/mstar/clk-msc313-cpupll.c

-- 
2.35.1

