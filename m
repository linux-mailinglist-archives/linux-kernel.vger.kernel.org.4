Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBC06141E1
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 00:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiJaXh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 19:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJaXhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 19:37:23 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F06B14085;
        Mon, 31 Oct 2022 16:37:22 -0700 (PDT)
Received: from hatter.bewilderbeest.net (97-113-250-99.tukw.qwest.net [97.113.250.99])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 9FFE41A6;
        Mon, 31 Oct 2022 16:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1667259441;
        bh=GLGVMdoDtbXFLdR5gzwkTxprtOlfY6bO49NgltdEOWU=;
        h=From:To:Cc:Subject:Date:From;
        b=CmWtz2Lk/qhETggmfAmjtxDSQO+qfOCyCLtG4uqyWok43srnVxM6XaJCPsWLgLvRk
         ktAsSp2/Mqo6y4Eyhvm3YVzTzkyHK/KuyDoOBskoxzjVns6TG73O5CkTFAU8urzWWN
         jmNiDOceza1QEnS4Ykk3oQmUMozhSFBxZjNZXNkY=
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
Subject: [PATCH v2 0/3] regulator: Add DT support for regulator-output connectors
Date:   Mon, 31 Oct 2022 16:37:01 -0700
Message-Id: <20221031233704.22575-1-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.38.1
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

This is v2 of my recent series adding support for userspace-controlled
regulator-supplied power outputs [2].  This is an important feature
for some kinds of BMC (baseboard management controller) systems where
the BMC provides an operator with manual control of a set of DC power
outputs.

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

The DT binding added in patch 2 is essentially identical to one I
posted in a previous patchset that had an R-B from Rob [1], but has
had some minor rewording and been moved from the extcon subsystem to
the regulator subsystem.

Changes since v1 [2]:
 - removed 'regulator-leave-on' DT property
 - added .is_visible method to hide sysfs 'name' property when it's
   NULL


Thanks,
Zev

[0] https://lore.kernel.org/all/20220707081826.953449-4-Naresh.Solanki@9elements.com/
[1] https://lore.kernel.org/linux-kernel/20220505232557.10936-2-zev@bewilderbeest.net/
[2] https://lore.kernel.org/openbmc/20220925220319.12572-1-zev@bewilderbeest.net/

Zev Weiss (3):
  regulator: devres: Add devm_regulator_bulk_get_exclusive()
  dt-bindings: regulator: Add regulator-output binding
  regulator: userspace-consumer: Handle regulator-output DT nodes

 .../bindings/regulator/regulator-output.yaml  | 39 +++++++++++
 drivers/regulator/core.c                      | 42 +++++++-----
 drivers/regulator/devres.c                    | 66 ++++++++++++++-----
 drivers/regulator/internal.h                  |  2 +
 drivers/regulator/userspace-consumer.c        | 60 +++++++++++++++--
 include/linux/regulator/consumer.h            |  2 +
 include/linux/regulator/userspace-consumer.h  |  1 +
 7 files changed, 169 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/regulator/regulator-output.yaml

-- 
2.38.1

