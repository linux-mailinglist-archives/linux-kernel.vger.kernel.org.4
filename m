Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D135BD5B5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 22:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiISUZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 16:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiISUYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 16:24:54 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EFDB4B2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 13:24:50 -0700 (PDT)
Received: from terra.. (unknown [109.129.72.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id C403B321012;
        Mon, 19 Sep 2022 22:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1663619088;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WINLzGqV3gFQ6xH0fXi4UbaSB1EO5JOkWTJ4XNqIlb8=;
        b=s9KDPZp3d8w5eXh3WUYpfV9BYy146Qfg41rxNDboaAxuDEjQQEmZtr1lbT3B34P17nfLdF
        LGWK5cMYQwrtaSHedND/jpOJiMsFbWLFL8P1dAlwKRp6HyO2LnQpvDEzlTV8bgTwJaFcux
        6XFH1eXuGUTdF07NIc85KLxIr4Vo1RbK2K3yFOISOIMhUuLvIsRCZy7r1yS40DVrY1YXxF
        /UGrJltndCxy1aQUzVmoFTQmW/C0IPhbuhSnsqcTGcc9a84C8rzy0UugT1ZhRD9xEQ9RX0
        V//P2n4WVWv4iCyJYpCf6+FLSuj/EheJLU7kJDzKloLJybeF5bkpW2aV8DXJhw==
From:   Sander Vanheule <sander@svanheule.net>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sander Vanheule <sander@svanheule.net>
Subject: [PATCH v6 0/3] Deprecate interrupt-map for realtek-rtl IRQ driver
Date:   Mon, 19 Sep 2022 22:24:40 +0200
Message-Id: <cover.1663617425.git.sander@svanheule.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original implementation for this interrupt controller/router used
an interrupt-map parser to determine which parent interrupts were
present. However, this controller is not transparent, so a list of
parent interrupts seems more appropriate, while also getting rid of the
assumed routing to parent interrupts.

Changes since v5:
Link: https://lore.kernel.org/all/cover.1644864700.git.sander@svanheule.net/

- Allow interrupt-map for new compatibles, but mark as deprecated
- Change back to single-cell interrupt specifiers
- Drop patch adding a domain for every output line

Changes since v4:
Link: https://lore.kernel.org/all/cover.1644165421.git.sander@svanheule.net/

- Add Rob's Reviewed-by
- Use irq_domain_add_linear instead of irq_domain_add_simple
- Drop 'inline' specifiers from static functions
- Drop WARN in intc_select() to only warn once for old bindings

Changes since v3:
Link: https://lore.kernel.org/all/cover.1641739718.git.sander@svanheule.net/

- Patches with fixes were merged, so these are no longer included.
- Update the devicetree changes to more clearly indicate the controller
  is not transparent.

Changes since v2 (RFC):
Link: https://lore.kernel.org/all/cover.1640548009.git.sander@svanheule.net/

- Define new, two-part compatibles for devicetree bindings. The existing format
  is kept for the old one-part compatible, but deprecated. New compatibles will
  require a different way of specifying parent interrupts and interrupt routing.
- Add change to handle all pending SoC interrupts in one go.

Changes since v1 (RFC):
Link: https://lore.kernel.org/all/cover.1640261161.git.sander@svanheule.net/

- Split some of the changes to limit the patch scope to one issue.
- Dropped some small (spurious or unneeded) changes
- Instead of dropping/replacing interrupt-map, the last patches now provide an
  implementation that amends the current situtation.

Sander Vanheule (3):
  irqchip/realtek-rtl: use irq_domain_add_linear
  dt-bindings: interrupt-controller: realtek,rtl-intc: require parents
  irqchip/realtek-rtl: use parent interrupts

 .../realtek,rtl-intc.yaml                     |  60 ++++++--
 drivers/irqchip/irq-realtek-rtl.c             | 134 ++++++++----------
 2 files changed, 106 insertions(+), 88 deletions(-)

-- 
2.37.3

