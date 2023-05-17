Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48D1707417
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjEQVWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjEQVWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:22:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1505BD;
        Wed, 17 May 2023 14:21:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79F6464B50;
        Wed, 17 May 2023 21:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC1E4C433D2;
        Wed, 17 May 2023 21:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684358495;
        bh=Eh3f3FtoI4HWyfnKAxrWwMdGKCBxeO7yHOlO7PGZfvU=;
        h=Date:From:To:Cc:Subject:From;
        b=H0Ve+HQ0Pap5XhimsVLlnIIqEX5PVaZiYgYNHcMfBMdK+7kYqZguYQd1mB5ohrVpe
         pKG5TQj7uE+rkLSAR7eYeIqamXnu2DgoEnem8st4UARvdCP6ZkM6fQEU/j2lM5kZHl
         cIz9M7lbbH+TvC22iGDHy3lxbqa2OwzKaFuKWigVFBOjGCXzbNbi0CpkoLW9YNmoz5
         Z3ZHOSQ3e0i729yb5XSW+41UiDBa066BgfJ1xapdkDIaX2GqWCF0BzuAqvO3QkwQQl
         BTo8mSVr7SD6CIY3TW4YHTUeMEoGeFUEUuDmSCLb36HUIug4cklJc4F5qjRAKBI9E9
         l17+lKOLqm5vQ==
Date:   Wed, 17 May 2023 15:22:24 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        James Smart <james.smart@broadcom.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/2][next] scsi: lpfc: Replace one-element array with
 flexible-array member
Message-ID: <cover.1684358315.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This small series aims to replace a one-element array with a
flexible-array member in a couple of structures.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/160
Link: https://github.com/KSPP/linux/issues/295
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]

Gustavo A. R. Silva (2):
  scsi: lpfc: Replace one-element array with flexible-array member
  scsi: lpfc: Use struct_size() helper

 drivers/scsi/lpfc/lpfc_ct.c | 4 ++--
 drivers/scsi/lpfc/lpfc_hw.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.34.1

