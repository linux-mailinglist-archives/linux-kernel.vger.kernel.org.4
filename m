Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7421369EC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjBVAwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjBVAwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:52:35 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F4930E90
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 16:52:30 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C65992C0488;
        Wed, 22 Feb 2023 13:52:28 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1677027148;
        bh=keNdBvr9szQdnT+AOaLT/I7jh4u91DA9dfek36nMTaU=;
        h=From:To:Cc:Subject:Date:From;
        b=NhaVvxXq4IJBVtcIM7NVUBkS2myVCTzKpwuXKjrRCTzw+cHdv+VfX+fO+x3qV6XqY
         +MKS0i2/iqSrmWeI6j2ZKHWzRGLXrEKQZk2A6Wc2wZDvAGj2PsG3uBTEzGcW2/Ql98
         xOsBo3wqRAnR3z2P/KDCBrE0mvsBH/Bp6Xq0oJVaeuebbA2NKy+TbgCHfT5W9rvk0h
         4GzXu8NtkwtE2KuaVrRfN0nBVlOWcY2/kd/wjUcPwamOSAiPQQoIjMXUJfBYQuaOzq
         GQ/IFsnuzzt9/bBJOlCRDpjxXMvZxlaEguaVNKe4G973V8bmbp3A18fLggToAr4FLn
         D7srmZ3W5T/Lg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B63f5674c0000>; Wed, 22 Feb 2023 13:52:28 +1300
Received: from tonyo-dl.ws.atlnz.lc (tonyo-dl.ws.atlnz.lc [10.33.12.31])
        by pat.atlnz.lc (Postfix) with ESMTP id 7B82213ED6B;
        Wed, 22 Feb 2023 13:52:28 +1300 (NZDT)
Received: by tonyo-dl.ws.atlnz.lc (Postfix, from userid 1161)
        id 7776CA0083; Wed, 22 Feb 2023 13:52:28 +1300 (NZDT)
From:   Tony O'Brien <tony.obrien@alliedtelesis.co.nz>
To:     jdelvare@suse.com, linux@roeck-us.net, linux-hwmon@vger.kernel.org
Cc:     chris.packham@alliedtelesis.co.nz, hdegoede@redhat.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] hwmon: (adt7475) Fixes for acoustics and hysteresis
Date:   Wed, 22 Feb 2023 13:52:26 +1300
Message-Id: <20230222005228.158661-1-tony.obrien@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=GdlpYjfL c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=m04uMKEZRckA:10 a=lM6UcDNat5HMF8i9s88A:9
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches contained herein fix the ADT7475 driver.  The first fixes
the reading of the Enhanced Acoustics Register 2, and the second fixes th=
e
setting of the hysteresis registers.

Tony O'Brien (2):
  hwmon: (adt7475) Display smoothing attributes in correct order
    changes in v2:
    - None
  hwmon: (adt7475) Fix masking of hysteresis registers
    changes in v2:
    - Removed erroneous fix for clamping the hysteresis value. It
      should be an absolute value and not a relative value.

 drivers/hwmon/adt7475.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--=20
2.39.2

