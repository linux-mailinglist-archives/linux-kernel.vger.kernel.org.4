Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1ED6EF9D2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 20:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236017AbjDZSKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 14:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjDZSKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 14:10:01 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F917298
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:10:00 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id af79cd13be357-74e3c84e689so577302285a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 11:10:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682532599; x=1685124599;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RliUpkr7G0qjHBFEov7zbIInpq/EheTg4CUqoVj5+Sk=;
        b=lFkXN3iDuzgJgPb1QBydHfhgIuw/alSNaRURMYZTVareNCG5hRMiGBKPfHqrvxkIDr
         WZIdTIZOaOPaXUr78gWDVjOmzP/F3AFRYmUXPA79BH51eybI+TNvxmC+1QVVAeWe073P
         Qv7wXe/1aLnR69N43boBYLL2BVKBrbA6vinLJGNTiDuhfVXzj1+mZIG6p+2KzHC9xJxH
         R5xJBJI6DngqIlcNMspfcVYyhtfdy2E02r+BkZIoWb5hM3K3sH26upf1PHfKP4doNxEe
         KvhJHSpjMfpiFNBJIhjg7y4TJOgUNhjOfMWGNlJY+FP9M9gjgqn2mevuX416Iuo3i4cw
         vwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682532599; x=1685124599;
        h=content-transfer-encoding:content-disposition:mime-version:reply-to
         :message-id:subject:cc:to:from:date:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RliUpkr7G0qjHBFEov7zbIInpq/EheTg4CUqoVj5+Sk=;
        b=CQjQPKW1kO0ZC4EvThGhwO+c2xHnTc0GXMT/ZujNGdZK2KJh83VDnPpOPZSWFtrKY6
         2jPqJhLg2o0imcwnyXzmj7rfqLhZwvp9K3GAulkCrCO2Yr0SJ2PH6HXDBbczr44OlGKM
         VOPCBt9mhjiCMLa7HySVQrJctRw/icKDi7MXpOu//ne+JdTTThCAEOR8pgBebojsLmUj
         99ldPmJsvVN7u8min2XKQTNrOaKytLNxvAyfVJTpfFkt8/GsydVK8DuewAm3LXh8mkQD
         CZYV3fssDar9vUrj+oxQGMzl0PAAhbV7DQ8vwas4ndyEyOPo07rdPBrWGtBJcMC76dc4
         vQ1w==
X-Gm-Message-State: AAQBX9djjKNzKMo4+JOKebdXm7aqNgtdrhl/5cUPX6/4j0HFCivakIFg
        vgFD6mnoDWghZzp06VSUk1OVpcbyHw==
X-Google-Smtp-Source: AKy350YbHGj8VbYC419CT9o2eijYTCDvIIqMfvcFa9OU7XODwnmcKsIdb+lsOZDEqEnxGdg9jV48yQ==
X-Received: by 2002:ad4:5ceb:0:b0:5f0:128f:2a66 with SMTP id iv11-20020ad45ceb000000b005f0128f2a66mr37975860qvb.28.1682532599318;
        Wed, 26 Apr 2023 11:09:59 -0700 (PDT)
Received: from serve.minyard.net ([47.184.185.84])
        by smtp.gmail.com with ESMTPSA id cf23-20020a05622a401700b003ef58044a4bsm5166482qtb.34.2023.04.26.11.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 11:09:58 -0700 (PDT)
Sender: Corey Minyard <tcminyard@gmail.com>
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:772b:130b:d11f:1565])
        by serve.minyard.net (Postfix) with ESMTPSA id CDFFE180011;
        Wed, 26 Apr 2023 18:09:57 +0000 (UTC)
Date:   Wed, 26 Apr 2023 13:09:56 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 6.4
Message-ID: <ZElo9Dgm1JV80b3h@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pull request:
-------------
The following changes since commit 982818426a0ffaf93b0621826ed39a84be3d7d62:

  Merge tag 'arm-fixes-6.3-1' of git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc (2023-02-27 10:09:40 -0800)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-6.4-1

for you to fetch changes up to d08076678ce72140a40553d226f90d189fbe06d1:

  ipmi:ssif: Drop if blocks with always false condition (2023-04-12 11:13:26 -0500)

----------------------------------------------------------------
Minor bug fixes for the IPMI driver

There was a bug in the SSIF driver where in certain conditions it could
stop working.

Outside of that: spelling fixes, removing some dead code, re-adding a
missing statistic increment, and removal of register_sysctl_table().

----------------------------------------------------------------
Corey Minyard (1):
      ipmi:ssif: Add send_retries increment

Luis Chamberlain (1):
      ipmi: simplify sysctl registration

Randy Dunlap (1):
      ipmi: ASPEED_BT_IPMI_BMC: select REGMAP_MMIO instead of depending on it

Uwe Kleine-König (1):
      ipmi:ssif: Drop if blocks with always false condition

Zhang Yuchen (1):
      ipmi: fix SSIF not responding under certain cond.

zipeng zhang (1):
      char:ipmi:Fix spelling mistake "asychronously" -> "asynchronously"

 drivers/char/ipmi/Kconfig         |  3 ++-
 drivers/char/ipmi/ipmi_poweroff.c | 16 +---------------
 drivers/char/ipmi/ipmi_ssif.c     | 16 ++++++----------
 3 files changed, 9 insertions(+), 26 deletions(-)

