Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82688618E7D
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 03:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKDCzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 22:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKDCzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 22:55:32 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125096158;
        Thu,  3 Nov 2022 19:55:31 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2A42tPtQ129948;
        Thu, 3 Nov 2022 21:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1667530525;
        bh=B9t7qPNCO06TJ2fCgJEfonJ1S5L5njnWZmCjfRGILCU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=YAbbdJ8zNEoA6F3psX97SMhgxZ4FwRTSflPn+dbJB1TI6jA34PgdBWpJcFhw8vJ6O
         x8/4EsaD52XJb6gs/v030sDKluVWGV/CcCt80rr0N+mDGfc1YDfq7f0PlCQDTy/Slk
         CtoYMKPDCWE5yWVj0PipnJLGGfE9hJ0ZMZCzB15c=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2A42tPGG031425
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 3 Nov 2022 21:55:25 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Thu, 3 Nov
 2022 21:55:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Thu, 3 Nov 2022 21:55:24 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2A42tO1N010780;
        Thu, 3 Nov 2022 21:55:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        <christophe.jaillet@wanadoo.fr>, <kristo@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <kernel-janitors@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] firmware: ti_sci: Use devm_bitmap_zalloc when applicable
Date:   Thu, 3 Nov 2022 21:55:24 -0500
Message-ID: <166753051095.28029.3739907273009158243.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <43ab1a7dd073d0d037d5d4bbbd5f8335de605826.1667457664.git.christophe.jaillet@wanadoo.fr>
References: <43ab1a7dd073d0d037d5d4bbbd5f8335de605826.1667457664.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe JAILLET,

On Thu, 3 Nov 2022 07:41:30 +0100, Christophe JAILLET wrote:
> 'xfer_alloc_table' is a bitmap. So use 'devm_bitmap_zalloc()' to simplify
> code and improve the semantic of the code.
> 
> While at it, remove a redundant 'bitmap_zero()' call.
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] firmware: ti_sci: Use devm_bitmap_zalloc when applicable
      commit: 26507b033e84be6f821dc1693d667b5c809a7679

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

