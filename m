Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2C65E68D3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiIVQwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiIVQww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:52:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87A7EB12E;
        Thu, 22 Sep 2022 09:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B7D160C2A;
        Thu, 22 Sep 2022 16:52:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22C39C433C1;
        Thu, 22 Sep 2022 16:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663865570;
        bh=hlZjxdcn5v2wOH7QP04F6w54uk+2v/O1zw7TS12q0qA=;
        h=Date:From:To:Cc:Subject:From;
        b=onE4/5h57laZYP0V91SPWuH29kCSVTkGUiAmEw6ZtTpc2ueUxLEWxC1pkIdqJMQOP
         8YRpqjAByzjbThSKFquDpwMXg2eypUlC2zkM7S9tTZq0SlwUwwBZDkLRqCmnPK5hlX
         4/i9kq2YW0WOV/FhdQJCQnYZ/cATmqeu9l9rtfSCtE6mzAGOULxEMxVS6reQkSfBZ1
         THVfFDfSDYmMKk6+ak1iLgS+U6Kp6RXyqNpCEGSZKVZR8cuwg8M7WcI9YnoxhNqpE3
         8nBKOdjsgURyYYZnpojZ7ChghsQsLDZ57POonPzhLKzmGyRAvx0X0diHyAH3yL7UVQ
         5+Hj/CcwQmDZg==
Date:   Thu, 22 Sep 2022 11:52:45 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     HighPoint Linux Team <linux@highpoint-tech.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/2][next] Replace one-element array with flexible-array
 member
Message-ID: <cover.1663865333.git.gustavoars@kernel.org>
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

This series aims to replace one-element arrays with flexible-array
members in drivers/scsi/hptiop.h

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://en.wikipedia.org/wiki/Flexible_array_member
Link: https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays
Link: https://github.com/KSPP/linux/issues/79
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101836 [1]

Gustavo A. R. Silva (2):
  scsi: hptiop: Replace one-element array with flexible-array member
  scsi: hptiop: Use struct_size() helper in code related to struct
    hpt_iop_request_scsi_command

 drivers/scsi/hptiop.c | 9 +++------
 drivers/scsi/hptiop.h | 2 +-
 2 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.34.1

