Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1872A6E8DE6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbjDTJWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbjDTJWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:22:01 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DAEF5581
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 02:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=k1; bh=tgHxq77KpnhUpL5OSbhEdqj2wQT
        tR9CP6lGArPFA3/o=; b=rvIfNQK39wXSE8FTWDa2JSwMAcSpYKvjqjJdc4G/SnT
        KTb6a05nLv/mF6pI7x2At896wyUq1NVQyT6He1Xr9L7Bh+mT2rHdq1HPKdNs5rXp
        uzSN7RU03lEOgxSXZ956WxOaaxnPLeobw+6vyIOhLdw5T6xmTegES4ghMz+lLOeY
        =
Received: (qmail 4000041 invoked from network); 20 Apr 2023 11:21:45 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 20 Apr 2023 11:21:45 +0200
X-UD-Smtp-Session: l3s3148p1@OD28EcH5xM0ujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH RFT v2 0/3] drivers/thermal/rcar_gen3_thermal: add Gen4 fuse support
Date:   Thu, 20 Apr 2023 11:21:24 +0200
Message-Id: <20230420092128.6073-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

R-Car Gen4 has the fuse registers at different locations and with
different names, but with the same purpose. So, first refactor IP core
differences into a 'info' struct, then add the fuse_read callback to it.

Changes since RFT v1:
* Patches are rebased on top of thermal-next as of today.
* Added tags from Niklas (thanks!)

They have been tested on R-Car H3 ES2.0 and M3-N against regressions.
Actual testing of the new fuses on Gen4 still needs to be done because I
don't have access to such HW.

@Shimoda-san: maybe the BSP team or Test team can test these patches?
A branch for testing can be found here:
git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git renesas/for-thermal

Looking forward to other review comments, too, of course.

Happy hacking,

   Wolfram

Wolfram Sang (3):
  drivers/thermal/rcar_gen3_thermal: introduce 'info' structure
  drivers/thermal/rcar_gen3_thermal: refactor reading fuses into
    seprarate function
  drivers/thermal/rcar_gen3_thermal: add reading fuses for Gen4

 drivers/thermal/rcar_gen3_thermal.c | 141 ++++++++++++++++++++--------
 1 file changed, 102 insertions(+), 39 deletions(-)

-- 
2.30.2

