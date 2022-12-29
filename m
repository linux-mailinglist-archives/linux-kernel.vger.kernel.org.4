Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26306591A5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 21:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbiL2Uj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 15:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbiL2Uic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 15:38:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB17917059
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 12:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672346264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=CxtpMgRv0k0qCDaERH6Q08EjUCmn4oR74f97lfTFabI=;
        b=CQm9upLuMj3t89XZtgxVF2+ZML5v/LnPTHntpR+pbwU0FWJ1WAppOdyA/PH0XNV2Mu6K73
        TlXblsMzrr7wjiCqKTyJ6/QyAyM7Q+Lpbzj+t5lryxV9Xc5CCNwXfYJiG3iWRCE24hf9b1
        S3+y/HLX4r3vvko9RoF3U4JQlR5Q6mc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-OqHRH9skM9qLEFXXrqUGOA-1; Thu, 29 Dec 2022 15:37:40 -0500
X-MC-Unique: OqHRH9skM9qLEFXXrqUGOA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CEB68F6E88;
        Thu, 29 Dec 2022 20:37:40 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-208-2.brq.redhat.com [10.40.208.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCB9C1121339;
        Thu, 29 Dec 2022 20:37:37 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Nicolai Stange <nstange@suse.de>, Elliott Robert <elliott@hpe.com>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH v2 0/6] Trivial set of FIPS 140-3 related changes
Date:   Thu, 29 Dec 2022 21:37:02 +0100
Message-Id: <20221229203708.13628-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset and cover letter was initially composed by Nicolai Stange
and sent earlier as:

https://lore.kernel.org/r/20221108142025.13461-1-nstange@suse.de/
with a subject: [PATCH 0/4] Trivial set of FIPS 140-3 related changes

I'm adding patches 2 and 3 which (I hope) resolve issues spotted by
reviewers of previous version of the patchset. This new patchset should
ease our future kernel work on the FIPS mode.

I'm quoting Nicolai's cover letter here:

> Hi all,
> 
> these four rather unrelated patches are basically a dump of some of the
> more trivial changes required for working towards FIPS 140-3 conformance.
> 
> Please pick as you deem appropriate.
> 
> Thanks!
> 
> Nicolai

v2:
- fixed a block comment formatting
- "Reviewed-by: Eric Biggers" was copied from the v1 thread:
  https://lore.kernel.org/r/Y6OXuT95MlkNanSR@sol.localdomain/

Nicolai Stange (4):
  crypto: xts - restrict key lengths to approved values in FIPS mode
  crypto: testmgr - disallow plain cbcmac(aes) in FIPS mode
  crypto: testmgr - disallow plain ghash in FIPS mode
  crypto: testmgr - allow ecdsa-nist-p256 and -p384 in FIPS mode

Vladis Dronov (2):
  crypto: xts - drop xts_check_key()
  crypto: xts - drop redundant xts key check

 arch/s390/crypto/aes_s390.c                   |  4 ---
 arch/s390/crypto/paes_s390.c                  |  2 +-
 crypto/testmgr.c                              |  4 +--
 drivers/crypto/atmel-aes.c                    |  2 +-
 drivers/crypto/axis/artpec6_crypto.c          |  2 +-
 drivers/crypto/cavium/cpt/cptvf_algs.c        |  8 +++---
 .../crypto/cavium/nitrox/nitrox_skcipher.c    |  8 +++---
 drivers/crypto/ccree/cc_cipher.c              |  2 +-
 .../crypto/marvell/octeontx/otx_cptvf_algs.c  |  2 +-
 .../marvell/octeontx2/otx2_cptvf_algs.c       |  2 +-
 include/crypto/xts.h                          | 25 +++++++------------
 11 files changed, 23 insertions(+), 38 deletions(-)

base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
-- 
2.38.1


