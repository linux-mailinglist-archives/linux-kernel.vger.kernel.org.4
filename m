Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858946FF024
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 12:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbjEKKuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 06:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjEKKuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 06:50:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23242D48
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:50:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso15549540a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 03:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683802209; x=1686394209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YYmQOiJo0GwahUuK9YIJi/PO7yGRaao3xUZsJxQQPGw=;
        b=Qq24/0rH2Wy7PCHvEv6ahBRTBtEhVyh/iSjSwPmN3k920PBQd4sEmegEq9y3Wme/d3
         2BzG92K6N91pdsVQrwOjolbvpXtAwomgqYwv4rWQuKz3DYTt5BpZuAbjkKsFTvd17FHy
         utp1kT4EnIqHutSwloEDpRiW1mimUBKo3CJhUwSjy9/dxrFZzwaCai9L/1FkywV78iuU
         aewPcQBpU3taQJZkatQmOqfwNkWgBGPtENCxlsmJ4EFAjATkWgdVCvA2gpEMDNKej1Ir
         S8VFm3KAKTQXMmtAMGoUsuGiJSlTurUCdPu6GBjEdh8oU0+OCa1jqJp7rJ4lAOdw5T0u
         U2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683802209; x=1686394209;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YYmQOiJo0GwahUuK9YIJi/PO7yGRaao3xUZsJxQQPGw=;
        b=CKd1/LDK/WvxbiyLwoe4OzAHyB5bhETrAKoKZflpOIOl16a0miT8EpBGnBEKFPu2wW
         f8mDVEcvt+ITS6GYgKhxoanMcdTO/eOj6ybKtofDPJOyGUdgl6LjdxoUb/zsjLhSpQG+
         lZQrBKevGKj1YBbfy+1y9zfD8BZ9qky4fY7tOEzJe9k9vgY2onsa/iIHVaS77G1SOfK9
         fgakJiyJdvyxeHnFw3L8WjK4Xrf6eMgg49U4toZaesy7DWDs59szUOl67/Y/jOC8156T
         Xuap8gNnEgLKteT9JuPZxrMQ/wRKBguPO7SHAoSEHAeeMif97tUImi20VKH17K8xP4Ri
         KjDg==
X-Gm-Message-State: AC+VfDxQ08OAlrCajhDNJnt2vmJABXizvY44hTz2RuK4PCpVNVI3sIJX
        VA4vW/2GvbJWxJYRKbWGo00Jnw==
X-Google-Smtp-Source: ACHHUZ7K5/ZpkInBfiFXdz7ldveY5d6mjUUS7cf4oZPvIEM3vCUsgAbg0ltzrAMTFOgTDPrNbtqv+w==
X-Received: by 2002:a17:906:fd8c:b0:953:3e29:f35c with SMTP id xa12-20020a170906fd8c00b009533e29f35cmr17143266ejb.45.1683802209171;
        Thu, 11 May 2023 03:50:09 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:41e7:1b68:d38e:1348])
        by smtp.gmail.com with ESMTPSA id ia21-20020a170907a07500b00966392de4easm3874389ejc.14.2023.05.11.03.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 03:50:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree fixes for v6.4, part 2
Date:   Thu, 11 May 2023 12:50:06 +0200
Message-Id: <20230511105006.176979-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

It's my first pull for you, so let me introduce myself.  With Rob Herring
and recently also Conor Dooley, I co-maintain the Devicetree
bindings [1].  I also maintain few other subsystems, but all my other
pull requests are going to SoC folks (Arnd and Olof).

The git tag for pull is signed with my usual key which you can get
from kernel.org pgp keys repo: keys/1B93437D3B41629B.asc

Rob is currently away from keyboard and he also mentioned in last pull
to you that something might be coming from me [2].  So here it goes - few
fixes for current cycle.

[1] https://www.kernel.org/doc/html/latest/process/maintainers.html#open-firmware-and-flattened-device-tree-bindings
[2] https://lore.kernel.org/all/20230505192951.GA3409270-robh@kernel.org/

Best regards,
Krzysztof


The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt-fixes-6.4

for you to fetch changes up to 8bbec86ce6d66fb33530c679f7bb3a123fc9e7da:

  dt-bindings: PCI: fsl,imx6q: fix assigned-clocks warning (2023-05-09 08:01:49 +0200)

----------------------------------------------------------------
Devicetree binding fixes for v6.4

Few fixes for Devicetree bindings and related docs, all for issues
introduced in v6.4-rc1 commits:

1. media/ov2685: fix number of possible data lanes, as old binding
   explicitly mentioned one data lane. This fixes dt_binding_check
   warnings like:
   Documentation/devicetree/bindings/media/rockchip-isp1.example.dtb: camera@3c: port:endpoint:data-lanes: [[1]] is too short
   From schema: Documentation/devicetree/bindings/media/i2c/ovti,ov2685.yaml

2. Maintainers: correct path of Apple PWM binding. This fixes
   refcheckdocs warning.

3. PCI/fsl,imx6q: correct parsing of assigned-clocks and related
   properties and make the clocks more specific per PCI device (host or
   endpoint).  This fixes dtschema limitation and dt_binding_check
   warnings like:

   Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.example.dtb: pcie-ep@33800000: Unevaluated properties are not allowed
   From schema: Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      dt-bindings: PCI: fsl,imx6q: fix assigned-clocks warning

Luca Weiss (1):
      media: dt-bindings: ov2685: Correct data-lanes attribute

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry for ARM/APPLE MACHINE SUPPORT

 .../devicetree/bindings/media/i2c/ovti,ov2685.yaml |  1 +
 .../bindings/pci/fsl,imx6q-pcie-common.yaml        | 13 +---
 .../devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml | 38 +++++++++++
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    | 77 ++++++++++++++++++++++
 MAINTAINERS                                        |  2 +-
 5 files changed, 119 insertions(+), 12 deletions(-)
