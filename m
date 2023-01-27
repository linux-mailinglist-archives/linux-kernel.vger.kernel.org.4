Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCF067E2E9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 12:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjA0LRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 06:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjA0LRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 06:17:43 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6C7BB8E
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:42 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n7so4667140wrx.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 03:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EjW5VyxY9sFWnuMhNtR0kAZqSnnK4aigybJavuaVtDc=;
        b=MDOJyu+QBNbK81y6SckyFSvcPpNxtETWWYS/EPB42mwBq+b+Dy2POzDIrt1jHDx/Pd
         Yg6i/stwUKXf2Lf60xM60X3BezpkZ++2BC9QNyPDRjoEW4zD0/pKPGURyfLnZjNPlxrd
         62QmHmhfsnxM8LoI1yoQoZ7Vq2cLPW/aRWEQsz7FyjSanoJrhlIIvjAmolHU/2LkAUUx
         eq3lv2CYthoFx1mdmHmIBAbME/QSXnYXRaJCU2eXcl/lOERLueObygTUZ2vOxkSrzfE8
         v4WJpXHGdYgY9PbIr4S97ps+TPkg7jnDjfyi/HXk+2hVlKcdXKvIgBrIy8X1cKH19X4D
         zWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EjW5VyxY9sFWnuMhNtR0kAZqSnnK4aigybJavuaVtDc=;
        b=gk87Ogi9b04bF1V78FPozArdYy3i7MNd52OFs5eyDxrt/8k8FyeRSKSRW6MfChSWIA
         3O/HV04zN7nfUXfufY/OIj+ZcWpOFSrMITu/yy3NQtrFL+dWA1duxa8SS5tpHjC3uW3v
         8P2MCeE7jh42CVdLhnGLezWzgDpigU6vY8+vmIXQnb5aEu1b3op1SxomI9J1LvR5ZmHf
         d71Cq+uvYiAtJymwj5bq8J1HIees6odg812eFO4xx9IBIrCW7x+xeL2+tWKsfuir90RG
         tOe1XBMnGWAqno+QbY8rDydwLKQrUkqKrUz/yk6QxuR5gPgmGPdUTp/Rh64IRm04HZJB
         ZOaA==
X-Gm-Message-State: AFqh2kooBlxWDOnnCg/HUJlv6uH6BiaNZ3MR126nEvE6zTkfVHyZSQ0l
        02L3H/suS/wHPtWfhHE5vS5WaQ==
X-Google-Smtp-Source: AMrXdXvI15F0m5dqbLZ82KZbmEE2Qeks7b96EuoznQXqmNnfS5jWR5BNmbAG3Cs6Y0nISFxy7ESbOA==
X-Received: by 2002:adf:b604:0:b0:242:1809:7e17 with SMTP id f4-20020adfb604000000b0024218097e17mr33098627wre.6.1674818260522;
        Fri, 27 Jan 2023 03:17:40 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id c13-20020adffb0d000000b002bfd190fd60sm1843314wrr.108.2023.01.27.03.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 03:17:39 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 00/37] nvmem: patches for 6.3
Date:   Fri, 27 Jan 2023 11:15:28 +0000
Message-Id: <20230127111605.25958-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some nvmem patches bit more than usual for 6.3 which includes

- Adding support for nvmem layouts, thanks to Michael and Miquel for
  driving this effort.
- Add support to stm32 STM32MP15x OPTEE based nvmem provider
- Updated to qfprom bindings to include various Qualcomm SoCs.
- adding sl28vpd provider layout
- move imx provider to use new layout apis
- add ONIE provider layout. 
- new helper eth_addr_add().
- few minor enhancements to core and providersdrivers.

Can you please queue them up for 6.3.

thanks for you help,
srini

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

AngeloGioacchino Del Regno (1):
  dt-bindings: nvmem: Fix qcom,qfprom compatibles enum ordering

Arnd Bergmann (1):
  nvmem: stm32: fix OPTEE dependency

Colin Ian King (2):
  nvmem: layouts: Fix spelling mistake "platforn" -> "platform"
  dt-bindings: nvmem: Fix spelling mistake "platforn" -> "platform"

Johan Hovold (1):
  nvmem: qcom-spmi-sdam: register at device init time

Konrad Dybcio (2):
  dt-bindings: nvmem: Add compatible for SM8150
  dt-bindings: nvmem: Add compatible for SM8250

Marijn Suijten (1):
  dt-bindings: nvmem: Add compatible for MSM8976

Michael Walle (19):
  net: add helper eth_addr_add()
  of: base: add of_parse_phandle_with_optional_args()
  of: property: make #.*-cells optional for simple props
  of: property: add #nvmem-cell-cells property
  nvmem: core: add an index parameter to the cell
  nvmem: core: move struct nvmem_cell_info to nvmem-provider.h
  nvmem: core: drop the removal of the cells in nvmem_add_cells()
  nvmem: core: add nvmem_add_one_cell()
  nvmem: core: use nvmem_add_one_cell() in nvmem_add_cells_from_of()
  nvmem: core: introduce NVMEM layouts
  nvmem: core: add per-cell post processing
  nvmem: core: allow to modify a cell before adding it
  nvmem: imx-ocotp: replace global post processing with layouts
  nvmem: cell: drop global cell_post_process
  nvmem: core: provide own priv pointer in post process callback
  nvmem: layouts: add sl28vpd layout
  MAINTAINERS: add myself as sl28vpd nvmem layout driver
  nvmem: core: return -ENOENT if nvmem cell is not found
  of: property: fix #nvmem-cell-cells parsing

Miquel Raynal (2):
  nvmem: layouts: Add ONIE tlv layout driver
  MAINTAINERS: Add myself as ONIE tlv NVMEM layout maintainer

Patrick Delaunay (2):
  nvmem: stm32: add OP-TEE support for STM32MP13x
  nvmem: stm32: detect bsec pta presence for STM32MP15x

Rafał Miłecki (1):
  nvmem: core: fix nvmem_layout_get_match_data()

Randy Dunlap (1):
  nvmem: rave-sp-eeprm: fix kernel-doc bad line warning

Richard Acayan (1):
  dt-bindings: nvmem: qfprom: add sdm670 compatible

Robert Marko (1):
  dt-bindings: nvmem: qfprom: add IPQ8074 compatible

Russell King (Oracle) (1):
  nvmem: core: remove spurious white space

Samuel Holland (1):
  nvmem: sunxi_sid: Drop the workaround on A64

 .../nvmem/layouts/onie,tlv-layout.yaml        |   2 +-
 .../bindings/nvmem/qcom,qfprom.yaml           |   7 +-
 Documentation/driver-api/nvmem.rst            |  15 +
 MAINTAINERS                                   |  12 +
 drivers/nvmem/Kconfig                         |  14 +
 drivers/nvmem/Makefile                        |   2 +
 drivers/nvmem/core.c                          | 283 ++++++++++++-----
 drivers/nvmem/imx-ocotp.c                     |  34 +-
 drivers/nvmem/layouts/Kconfig                 |  23 ++
 drivers/nvmem/layouts/Makefile                |   7 +
 drivers/nvmem/layouts/onie-tlv.c              | 244 ++++++++++++++
 drivers/nvmem/layouts/sl28vpd.c               | 153 +++++++++
 drivers/nvmem/qcom-spmi-sdam.c                |  13 +-
 drivers/nvmem/rave-sp-eeprom.c                |   2 +-
 drivers/nvmem/stm32-bsec-optee-ta.c           | 298 ++++++++++++++++++
 drivers/nvmem/stm32-bsec-optee-ta.h           |  80 +++++
 drivers/nvmem/stm32-romem.c                   |  84 ++++-
 drivers/nvmem/sunxi_sid.c                     |   8 +-
 drivers/of/property.c                         |   6 +-
 include/linux/etherdevice.h                   |  14 +
 include/linux/nvmem-consumer.h                |  17 +-
 include/linux/nvmem-provider.h                |  95 +++++-
 include/linux/of.h                            |  25 ++
 23 files changed, 1310 insertions(+), 128 deletions(-)
 create mode 100644 drivers/nvmem/layouts/Kconfig
 create mode 100644 drivers/nvmem/layouts/Makefile
 create mode 100644 drivers/nvmem/layouts/onie-tlv.c
 create mode 100644 drivers/nvmem/layouts/sl28vpd.c
 create mode 100644 drivers/nvmem/stm32-bsec-optee-ta.c
 create mode 100644 drivers/nvmem/stm32-bsec-optee-ta.h

-- 
2.25.1

