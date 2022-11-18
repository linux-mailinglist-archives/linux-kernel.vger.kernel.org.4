Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B5763081E
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 01:45:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238051AbiKSApa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 19:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236727AbiKSApG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 19:45:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3181BD39F8;
        Fri, 18 Nov 2022 15:46:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4DBA627B9;
        Fri, 18 Nov 2022 23:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F883C433D6;
        Fri, 18 Nov 2022 23:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668815196;
        bh=mq6yPCqX22eHbmxs61ieFNDcYRcxIKCg8jAgghOAhVI=;
        h=Date:From:To:Cc:Subject:From;
        b=F71YIb4iF66AT2xgpSZbPmYkvhO6pgg+5pWCAv8woAtx0hpyWRDuBmfw6rlixEayH
         uQK5tew6hP61wy+AOxJBg5Is6MXkjzdmovBKF14warorwuWzF2rlgHkji3p1qyLIZf
         pVHR5BYNjPSx9QlSih+zC4VTAbhwv/evBiQeO2fkellBlp6fFjqQ1R21XqAssSITVO
         5zk/dib0mqv5LNmfUs+ya/VA3O4l5XVD3/62JTAFxQNq5di3KAwXjewK8VgSFCa/gd
         +RLyhompfyVtojP7laKt6F8bPwcEZ1huTdR6TcigLRf7BOAk6YWPUrK4h+pIeoH6bi
         +BrTLpaATbpQw==
Date:   Fri, 18 Nov 2022 17:46:21 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        Nilesh Javali <njavali@marvell.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/2][next] scsi: qla2xxx: Replace one-element array with
 flexible-array member
Message-ID: <cover.1668814746.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series aims to replace a one-element array with flexible-array
member in drivers/scsi/qla2xxx/qla_def.h through the use of the
DECLARE_FLEX_ARRAY() helper.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays
Link: https://github.com/KSPP/linux/issues/79
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]

Gustavo A. R. Silva (2):
  scsi: qla2xxx: Replace one-element array with DECLARE_FLEX_ARRAY()
    helper
  scsi: qla2xxx: Use struct_size() in code related to struct
    ct_sns_gpnft_rsp

 drivers/scsi/qla2xxx/qla_def.h | 4 ++--
 drivers/scsi/qla2xxx/qla_gs.c  | 5 ++---
 2 files changed, 4 insertions(+), 5 deletions(-)

-- 
2.34.1

