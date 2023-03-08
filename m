Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA266B0096
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 09:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCHIMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 03:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjCHIMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 03:12:46 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F650A72B9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 00:12:26 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3288CEMC106909;
        Wed, 8 Mar 2023 02:12:14 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678263134;
        bh=5YvPoxDtlLeFTE68Ce/dakxGSjGl/35caDdUQ33Fxhk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kR57E3SFdLAYxHJC9zgcqz6IFVWkPAMIw8HLtd6AWj1JuyeHaQLE5z42vi4qYIKiy
         NDaqydiS0vXbyRpWszYjvUt7HKpE21Pn2W+Ldj47N5UPRMEcqgIz+3cM6Le6TUYPbF
         yCIrteUpn1SFUCDE081jLpEwfXz4w/Dbu1QodO5s=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3288CDqm075409
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 8 Mar 2023 02:12:14 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 8
 Mar 2023 02:12:13 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 8 Mar 2023 02:12:13 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3288CDQv013351;
        Wed, 8 Mar 2023 02:12:13 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <peter.ujfalusi@gmail.com>, <ssantosh@kernel.org>,
        Nicolas Frayer <nfrayer@baylibre.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <khilman@baylibre.com>,
        <glaroque@baylibre.com>, <mkorpershoek@baylibre.com>
Subject: Re: [PATCH v2] soc: ti: k3-ringacc: Add try_module_get() to k3_dmaring_request_dual_ring()
Date:   Wed, 8 Mar 2023 02:12:12 -0600
Message-ID: <167826310101.381619.1421590979379152790.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221230001404.10902-1-nfrayer@baylibre.com>
References: <20221230001404.10902-1-nfrayer@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas Frayer,

On Fri, 30 Dec 2022 01:14:04 +0100, Nicolas Frayer wrote:
> When the k3 ring accelerator driver has been modified to add module build
> support, try_module_get() and module_put() have been added to update the
> module refcnt. One code path has not been updated and it has introduced
> an issue where the refcnt is decremented by module_put() in
> k3_ringacc_ring_free() without being incremented previously.
> Adding try_module_get() to k3_dmaring_request_dual_ring() ensures the
> refcnt is kept up to date.
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: k3-ringacc: Add try_module_get() to k3_dmaring_request_dual_ring()
      commit: 5f1732a8683c1da8faaa90d6ffc3bd6d33013a58

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

