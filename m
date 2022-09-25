Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619645E9699
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 00:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232994AbiIYWLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 18:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiIYWKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 18:10:52 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C91140E9;
        Sun, 25 Sep 2022 15:10:50 -0700 (PDT)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id C6BA81AE;
        Sun, 25 Sep 2022 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1664143472;
        bh=55QOZ/Sosj9iz7tF65g2uHc/YtzXw/1I5tJ5UeOj3pc=;
        h=From:To:Cc:Subject:Date:From;
        b=cSWhvHJldr4rpvt9/S6OgfH9CPdFlIJJHSLURXJwwyN49c6BreR4p3QHUWte2rDDK
         uMYzBIUoTECVbMuNfgHPDnmTQtY9uy4/kNyJzL7/0BfJuBtrzYOqjNTZ+TcjLU+tWb
         o8WmdMwUQLSljh9mDZ1WiodBhcdpDig+RPHZ6ZyQ=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, linux-kernel@vger.kernel.org,
        Naresh Solanki <naresh.solanki@9elements.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, openbmc@lists.ozlabs.org
Subject: [PATCH 0/3] regulator: Add DT support for regulator-output connectors
Date:   Sun, 25 Sep 2022 15:03:16 -0700
Message-Id: <20220925220319.12572-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series is another attempt at implementing support for
userspace-controlled regulator-supplied power outputs.  This is an
important feature for some kinds of BMC (baseboard management
controller) systems where the BMC provides an operator with manual
control of a set of DC power outputs.

As in a broadly similar patchset that was recently almost merged [0],
this takes the approach of providing support by extending the existing
userspace-consumer regulator driver.  A couple questions about the
userspace-consumer driver came up along the way, however.

First, how (if at all) is it currently being used?  It appears the
last in-tree use of it was removed a bit over two years ago in commit
9d3239147d6d ("ARM: pxa: remove Compulab pxa2xx boards").  Aside from
just adding DT support I've made a couple small tweaks to the driver
in patch 3 that I hope are compatible with any current usage, but
without any extant examples to look at it's kind of hard to say.

Second, how critical is its support for controlling multiple
regulators?  (i.e. its use of regulator_bulk_data and friends instead
of a single struct regulator.)  As far as I can see every in-tree use
of it that's ever existed has used num_supplies = 1.  If it's not
important to retain, patch 1 of this series could be supplanted by one
that instead simplifies the driver slightly by removing that
functionality.

The DT binding added in patch 2 is very similar to one I posted in a
previous patchset that had an R-B from Rob [1], but has had some minor
rewording and gained one new (optional) property.

Laxman, Naresh, Patrick -- please let me know if there are any aspects
of this implementation that would be incompatible with your needs.


Thanks,
Zev

[0] https://lore.kernel.org/all/20220707081826.953449-4-Naresh.Solanki@9elements.com/
[1] https://lore.kernel.org/linux-kernel/20220505232557.10936-2-zev@bewilderbeest.net/

Zev Weiss (3):
  regulator: devres: Add devm_regulator_bulk_get_exclusive()
  dt-bindings: regulator: Add regulator-output binding
  regulator: userspace-consumer: Handle regulator-output DT nodes

 .../bindings/regulator/regulator-output.yaml  | 47 +++++++++++++
 drivers/regulator/core.c                      | 42 +++++++-----
 drivers/regulator/devres.c                    | 66 ++++++++++++++-----
 drivers/regulator/internal.h                  |  2 +
 drivers/regulator/userspace-consumer.c        | 43 ++++++++++--
 include/linux/regulator/consumer.h            |  2 +
 include/linux/regulator/userspace-consumer.h  |  1 +
 7 files changed, 162 insertions(+), 41 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator-output.yaml

-- 
2.37.3

