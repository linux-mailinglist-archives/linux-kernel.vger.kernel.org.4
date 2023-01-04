Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D874765DBD5
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239942AbjADSFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239879AbjADSFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:05:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF322C74;
        Wed,  4 Jan 2023 10:05:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3422BCE1874;
        Wed,  4 Jan 2023 18:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DB01C433EF;
        Wed,  4 Jan 2023 18:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672855545;
        bh=iVmBN9SHSGFL/TV+7lxsQZWmvPT0HnyqZTF9juJjaoE=;
        h=From:To:Cc:Subject:Date:From;
        b=kQEc2kIoUCCFh7Op1s23+WJCbDRblqlVIqVFce+4CF46aXL6XZEp/yMEaBjlVoQLU
         IM9N1Eegc85q2xWFo9fM8n7UBZsK/iUpFvGk89wZsQpNWqNHB669/AZq7NpASMEkqs
         0ML6KoTtbUMJcYVN2Pjtx/TALHKsuZSgBUERGqTWgZMUYBvQe3Tm1S2SKnKTn34+hn
         469P4j0xXhjPXCIDSxDLtFx5zdUJ7ez+L84QR0xq4VUntWOuaAdLWAV+8rsCasc+hp
         fU63HJfAF+vj0lokM1+PBg89NtsQTEQZPK56nzDGl+crpyGaxBaceol14vSVIA+6gg
         DGBaBvonyYXWw==
From:   Conor Dooley <conor@kernel.org>
To:     palmer@dabbelt.com
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Ley Foon Tan <leyfoon.tan@starfivetech.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-doc@vger.kernel.org
Subject: [PATCH v1 0/2] dt-bindings: Add a cpu-capacity property for RISC-V
Date:   Wed,  4 Jan 2023 18:05:12 +0000
Message-Id: <20230104180513.1379453-1-conor@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795; i=conor.dooley@microchip.com; h=from:subject; bh=s3BpJ32EHXPzoyo62faAGG7G7L5gAZvAoU9KdjWADYo=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDMlb919wdHcN+r+rJ2Kim/E/iUClU78XqzE1nw3RaAis5xWp KlHtKGVhEONgkBVTZEm83dcitf6Pyw7nnrcwc1iZQIYwcHEKwESuBjIyvIhhy5ebwXxh/yP2E3MTzm 82LU30OqrYVZEhNUOS+du504wMP66pvlicmmK99qFWumBMeZPdne3B3NGyzTeOFk0JNz3PBgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

Hey,

Ever since RISC-V starting using generic arch topology code, the code
paths for cpu-capacity have been there but there's no binding defined to
actually convey the information. Defining the same property as used on
arm seems to be the only logical thing to do, so do it.

It's worth noting that right now, actually putting this property in a DT
will cause allocation failures on RISC-V - but there's already a patch
for that thanks to Ley Foon Tan:
https://patchwork.kernel.org/project/linux-riscv/patch/20230103035316.3841303-1-leyfoon.tan@starfivetech.com/

Thanks,
Conor.

CC: Ley Foon Tan <leyfoon.tan@starfivetech.com>
CC: Sudeep Holla <sudeep.holla@arm.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Jonathan Corbet <corbet@lwn.net>
CC: Alex Shi <alexs@kernel.org>
CC: Yanteng Si <siyanteng@loongson.cn>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-riscv@lists.infradead.org
CC: linux-doc@vger.kernel.org

Conor Dooley (2):
  dt-bindings: arm: move cpu-capacity to a shared loation
  dt-bindings: riscv: add a capacity-dmips-mhz cpu property

 Documentation/devicetree/bindings/arm/cpus.yaml             | 2 +-
 .../devicetree/bindings/{arm => cpu}/cpu-capacity.txt       | 4 ++--
 Documentation/devicetree/bindings/riscv/cpus.yaml           | 6 ++++++
 Documentation/scheduler/sched-capacity.rst                  | 2 +-
 .../translations/zh_CN/scheduler/sched-capacity.rst         | 2 +-
 5 files changed, 11 insertions(+), 5 deletions(-)
 rename Documentation/devicetree/bindings/{arm => cpu}/cpu-capacity.txt (98%)

-- 
2.39.0

