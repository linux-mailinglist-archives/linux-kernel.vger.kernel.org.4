Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF935642F5B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiLERrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:47:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbiLERq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:46:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B35223BF6;
        Mon,  5 Dec 2022 09:45:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F31E61286;
        Mon,  5 Dec 2022 17:45:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAEBC433C1;
        Mon,  5 Dec 2022 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670262341;
        bh=HO07O/dwEDuJ+b3MFU4z+ov/xFQe3b4wprxsPB4rHdg=;
        h=From:To:Cc:Subject:Date:From;
        b=JJnLXbPBpH8GZdzC+OwUEkp8WOan84oXpWZ3bj6Ss3lY77irpIXpE+xL3aLwt2ao5
         iyBs75jNgsqBFnEmI5SSpR7sMOie3IDLtY936bMf8SRvC8WeFOsVPX2Z2+AJ+I2sYo
         NDJfWtbwn8NuHRrow5GcSRT1Absh3ufIcqjP9jXPL9FhnLKtVAfYvnkl3pyaHb+VjD
         95Yz+pVzR3gmuiiEhKgNeC/nM/PdsGSKy8pKAjIJQEMssPUQgML3jxEGn6mA7hPclv
         wSJYoyIuHIsFTAlRrCVYPfbEoljUzCLkXj6USEudD4Es+SQpHL24BjnlfNCGC6mWzr
         R7tAHJWnrPLeQ==
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        Guo Ren <guoren@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] riscv,isa fixups
Date:   Mon,  5 Dec 2022 17:44:58 +0000
Message-Id: <20221205174459.60195-1-conor@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
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

I noticed ~today~ while looking at the isa manual that I had not
accounted for another couple of edge cases with my regex. As before, I
think attempting to validate the canonical order for multiletter stuff
makes no sense - but we should totally try to avoid false-positives for
combinations that are known to be valid.

All I've changed for v2 was collecting tags & adding in the missing
commit reference that Heiko pointed out.

v3 fixes an issue Jess spotted - it's *any* multi-letter extension that
can come immediately after the single-letter ones, not just ones
starting with Z.

@Palmer, either you can take this once the DT folks have ACKed it if you
like, or I will take onto some v6.2-rcN fixes branch. I don't think that
there is any urgency :)

Thanks,
Conor.

CC: Jessica Clarke <jrtc27@jrtc27.com>
CC: Conor Dooley <conor@kernel.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: Heiko Stuebner <heiko@sntech.de>
CC: Andrew Jones <ajones@ventanamicro.com>
CC: Guo Ren <guoren@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (2):
  dt-bindings: riscv: fix underscore requirement for multi-letter
    extensions
  dt-bindings: riscv: fix single letter canonical order

 Documentation/devicetree/bindings/riscv/cpus.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.38.1

