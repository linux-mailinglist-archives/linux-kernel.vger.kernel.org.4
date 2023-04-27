Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9321F6F0638
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 14:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243787AbjD0MzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 08:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbjD0MzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 08:55:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBACB1B0;
        Thu, 27 Apr 2023 05:55:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48B5B60EB9;
        Thu, 27 Apr 2023 12:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08FDC433EF;
        Thu, 27 Apr 2023 12:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682600110;
        bh=LmgvIly1Ne0ymmEh9oLGXj6eLOHzFWRvAJDW2clDJQY=;
        h=From:To:Cc:Subject:Date:From;
        b=V1zHbNj2K5hWRCeoWJkPp5n7d2oqbdjFQ9QWvOD2YfuqjxDo9l8hspNPZSKE1KNcu
         5hiX/iQvNQzk8q8nFvZrdOb7GVu74MsVQEG7np0Q6w9JgWbNVXUAyQPj1SOKqH/BwW
         nkCgGV29k0VVwwpRV+2Td5Y903CW3UdL3433Xmh10Jm6B0XANDV8xPsaBv4ASn/O7X
         8WdnGb2hgBcHd7drNTYb1d5se+NS1pB1bDTT5WbIWCP/J+QFNW6LN5TzZXTOn+3cjB
         mHvCulRGN5N9jlTOacWTJBR+OoNoOUdoG1lLU5FKKqzMXSw4PBFe4Lr8ZmlXuvMHgG
         1kjiwfhHtlOHA==
From:   broonie@kernel.org
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the tpmdd tree
Date:   Thu, 27 Apr 2023 13:55:06 +0100
Message-Id: <20230427125506.43348-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After merging the tpmdd tree, today's linux-next build (arm64 defconfig
and others) failed like this:

In file included from /tmp/next/build/include/linux/tpm_eventlog.h:6,
                 from /tmp/next/build/drivers/char/tpm/tpm-chip.c:24:
/tmp/next/build/include/linux/tpm.h:285:9: error: redeclaration of enumerator 'TPM_CHIP_FLAG_FIRMWARE_UPGRADE'
  285 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          = BIT(7),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/tpm.h:284:9: note: previous definition of 'TPM_CHIP_FLAG_FIRMWARE_UPGRADE' with type 'int'
  284 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          = BIT(7),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/tpm.h:286:9: error: redeclaration of enumerator 'TPM_CHIP_FLAG_FIRMWARE_UPGRADE'
  286 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          = BIT(7),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/tpm.h:285:9: note: previous definition of 'TPM_CHIP_FLAG_FIRMWARE_UPGRADE' with type 'int'
  285 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          = BIT(7),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[5]: *** [/tmp/next/build/scripts/Makefile.build:252: drivers/char/tpm/tpm-chip.o] Error 1
make[4]: *** [/tmp/next/build/scripts/Makefile.build:494: drivers/char/tpm] Error 2
make[3]: *** [/tmp/next/build/scripts/Makefile.build:494: drivers/char] Error 2
make[3]: *** Waiting for unfinished jobs....
In file included from /tmp/next/build/include/keys/trusted-type.h:12,
                 from /tmp/next/build/crypto/af_alg.c:26:
/tmp/next/build/include/linux/tpm.h:285:9: error: redeclaration of enumerator 'TPM_CHIP_FLAG_FIRMWARE_UPGRADE'
  285 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          = BIT(7),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/tpm.h:284:9: note: previous definition of 'TPM_CHIP_FLAG_FIRMWARE_UPGRADE' with type 'int'
  284 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          = BIT(7),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/tpm.h:286:9: error: redeclaration of enumerator 'TPM_CHIP_FLAG_FIRMWARE_UPGRADE'
  286 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          = BIT(7),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
/tmp/next/build/include/linux/tpm.h:285:9: note: previous definition of 'TPM_CHIP_FLAG_FIRMWARE_UPGRADE' with type 'int'
  285 |         TPM_CHIP_FLAG_FIRMWARE_UPGRADE          = BIT(7),
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[3]: *** [/tmp/next/build/scripts/Makefile.build:252: crypto/af_alg.o] Error 1

Caused by commit

  e2f14081c6839 ("tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM drivers")

I will use the tree from yesterday instead.
