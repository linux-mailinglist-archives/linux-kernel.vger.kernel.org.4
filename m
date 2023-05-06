Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156796F94D3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 00:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjEFW7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 18:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjEFW7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 18:59:05 -0400
Received: from mx.kolabnow.com (mx.kolabnow.com [212.103.80.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEA219D4E;
        Sat,  6 May 2023 15:59:03 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mx.kolabnow.com (Postfix) with ESMTP id 77BE243580;
        Sun,  7 May 2023 00:59:01 +0200 (CEST)
Authentication-Results: ext-mx-out003.mykolab.com (amavisd-new);
        dkim=pass (4096-bit key) reason="pass (just generated, assumed good)"
        header.d=kolabnow.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:organization:mime-version:message-id
        :date:date:subject:subject:from:from:received:received:received;
         s=dkim20160331; t=1683413938; x=1685228339; bh=NGmi/Yp30yWXlFgp
        Ioa4xyZmRtWwzedF9jz+aQrN8TU=; b=XmB8K0mJQvNWRyUSw2uYjz/x1IuvgXIV
        NhHH7nxBFKtJl8AHr/lDmQE8AXR2a5GWhd1t376d0vfaXU2tSnT53gA7BloNc74B
        b6BKMzMRDJFtxWLrzs9dkzf4P5N04psvFkDcDtE99I0RwvoqJn/Z1brUxJVNSMZa
        8ad3X+Y55VX8LkEXyUbvt2GoSFAnOjyZhuqyNc7ALUdBEiLuKR6ybSkdDnLEBHBn
        kREj3jfdSnry8uRVQUbohIlmvPEsWAZDCg+ZQp5NIrq17RcvrV/Yhc2dPeoCFZxa
        oq2zhDFEpQFnZ5peJxxZXBWk8vH7xsiQlk6v6H1grHgnKCXxrrXROTj1CHN/UN1O
        h4idy+1y948HdqZlhyVo8agxAeeBXRHr3zvhAv3IDPyygTb+cGO/Nw+iFDPe65uo
        J+tq3L6EWxHWrCrv6o7r8jWn26DuUFNrDkNxcqCm6VM385y68YrZRlGTNfp2jiuK
        IRng3rh8G046IRxwKIJMvYiLw4wK4YFzbwz5yIuCcp4r9L8ohpzttgdVRjtgq4+9
        JhLWXWs/VqTfaeHV+V1EowSQ38I91y7V8GShynyP0xeeT0L0W7C1YR3ybFiSJXGT
        nVPPBCRGlCQbesfciQ3OxMYOPdejWz9eR0Iuc8+YzBN0u0ZxsWyulxe+0pW3DOdb
        kQS4o5LdgIo=
X-Virus-Scanned: amavisd-new at mykolab.com
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F-QQ4ALpNP_Z; Sun,  7 May 2023 00:58:58 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by mx.kolabnow.com (Postfix) with ESMTPS id 2C5A94357D;
        Sun,  7 May 2023 00:58:56 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 6F869D201;
        Sun,  7 May 2023 00:58:56 +0200 (CEST)
From:   alison@she-devel.com
To:     johan@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alison@she-devel.com,
        achaiken@aurora.tech, kernel test robot <lkp@intel.com>
Subject: [PATCH v4 0/2]  support config of U-Blox Zed-F9P GNSS
Date:   Sat,  6 May 2023 15:58:47 -0700
Message-Id: <20230506225849.2752103-1-alison@she-devel.com>
MIME-Version: 1.0
Organization: Aurora Innovation
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alison Chaiken <alison@she-devel.com>

Add generalized support for setting arbitrary configuration of the
U-Blox Zed-F9P GNSS.  Employ the new functionality to set the baud rate
of the Zed-F9P if the devicetree specifies a non-default value.

Tested with 6.1.22, only on a U-Blox Zed-F9P GNSS.

V4 -> V3 Lookup device-specific properties by matching driver data.
V2 -> V3 Add email recipients whom I foolishly missed the first two times.
V1 -> V2 Fixes error identified by kernel test robot:
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202304300819.u0hfUj33-lkp@intel.com/

Alison Chaiken (2):
  gnss: ubx: customize serial device open to set U-Blox Zed-F9P baud
  dt-bindings: gnss: Add U-Blox Zed-F9

 .../bindings/gnss/u-blox,neo-6m.yaml          |   1 +
 drivers/gnss/ubx.c                            | 237 +++++++++++++++++-
 2 files changed, 228 insertions(+), 10 deletions(-)


base-commit: dd9e11d6477a52ede9ebe575c83285e79e823889
-- 
2.39.2

