Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF7A26FFA0D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 21:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbjEKTWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 15:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjEKTWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 15:22:30 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFA87DA9
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 12:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=k1; bh=RRZQj4nBkrR9NFE2zBxx97pW/jO
        S3vBpJjNEk+Dn3bQ=; b=iSoNI/ugjVZSCt5R6vpeJcW9IBZNFNezQl8HV6RUVLR
        bTR8ZuESPkrOru5I2k08zLvOmUgqwAP3yOOixL7rrJDacDPt2JFqIRDiC1M13ltL
        3TCy1I44/scISC/4qtzT8STS/JUCBN0bnl1MK2HycCA/quhRne0COqHfu6MMD4C4
        =
Received: (qmail 2935127 invoked from network); 11 May 2023 21:22:27 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 May 2023 21:22:27 +0200
X-UD-Smtp-Session: l3s3148p1@CR606G/7XuAujnsI
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-renesas-soc@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH RFT v3 0/3] drivers/thermal/rcar_gen3_thermal: add Gen4 fuse support
Date:   Thu, 11 May 2023 21:22:16 +0200
Message-Id: <20230511192220.7523-1-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.35.1
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

Changes since RFT v2:
* In patch 3, I mixed up the PTAT and THCODE registers. Fixed now.
  (Thanks, Shimoda-san!)
* patches are rebased to 6.4-rc1

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
2.35.1

