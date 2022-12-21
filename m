Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5766538D7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 23:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiLUWmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 17:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbiLUWmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 17:42:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873CBCD0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 14:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671662487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bLYZMh2LR87CuiMLuCzUcuWCtKa8d3kE51+MQe3QUCA=;
        b=Pvhg6h8RrVk2I/cHnbdCBQQqwPrlQH/wFAwKHc6iCt1gy34k+Q/ykaT6WSARbJkKUIEVON
        gmzdEukZKp2YAX+tVaFIbET0bzWGlPAsewtjKOtO9SGbkgjEguViP9QGNBviBgXj5yRY99
        Jvs9Q6TRhS/eagW0lZ/BrxWM3RUefLg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-623-ETNqCoCEOIag41ARSFnPAA-1; Wed, 21 Dec 2022 17:41:24 -0500
X-MC-Unique: ETNqCoCEOIag41ARSFnPAA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20F638F6E81;
        Wed, 21 Dec 2022 22:41:24 +0000 (UTC)
Received: from rules.brq.redhat.com (ovpn-208-11.brq.redhat.com [10.40.208.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 04A1240C2004;
        Wed, 21 Dec 2022 22:41:21 +0000 (UTC)
From:   Vladis Dronov <vdronov@redhat.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     nstange@suse.de, elliott@hpe.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, smueller@chronox.de,
        vdronov@redhat.com
Subject: [PATCH 0/6] Trivial set of FIPS 140-3 related changes
Date:   Wed, 21 Dec 2022 23:41:05 +0100
Message-Id: <20221221224111.19254-1-vdronov@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patchset and cover letter was initially composed by Nicolai Stange
and sent earlier as:

https://lore.kernel.org/all/20221108142025.13461-1-nstange@suse.de/
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

Nicolai Stange (4):
  crypto: xts - restrict key lengths to approved values in FIPS mode
  crypto: testmgr - disallow plain cbcmac(aes) in FIPS mode
  crypto: testmgr - disallow plain ghash in FIPS mode
  crypto: testmgr - allow ecdsa-nist-p256 and -p384 in FIPS mode

Vladis Dronov (2):
  crypto: xts - drop xts_check_key()
  crypto: xts - drop redundant xts key check

 arch/s390/crypto/aes_s390.c                        |  4 ----
 arch/s390/crypto/paes_s390.c                       |  2 +-
 crypto/testmgr.c                                   |  4 ++--
 drivers/crypto/atmel-aes.c                         |  2 +-
 drivers/crypto/axis/artpec6_crypto.c               |  2 +-
 drivers/crypto/cavium/cpt/cptvf_algs.c             |  8 +++-----
 drivers/crypto/cavium/nitrox/nitrox_skcipher.c     |  8 +++-----
 drivers/crypto/ccree/cc_cipher.c                   |  2 +-
 drivers/crypto/marvell/octeontx/otx_cptvf_algs.c   |  2 +-
 drivers/crypto/marvell/octeontx2/otx2_cptvf_algs.c |  2 +-
 include/crypto/xts.h                               | 24 ++++++++----------------
 11 files changed, 22 insertions(+), 38 deletions(-)


