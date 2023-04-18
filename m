Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8476E661D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjDRNkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjDRNkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:40:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21997210B;
        Tue, 18 Apr 2023 06:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B078962BD4;
        Tue, 18 Apr 2023 13:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2826CC433D2;
        Tue, 18 Apr 2023 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681825219;
        bh=yHZZr9lbmqRMgIawoEACPWeAMair9uMLVjV2HPRCkNU=;
        h=From:To:Cc:Subject:Date:From;
        b=jUCCiLjo7SQ8eRBAbb7yao1W41i0rlmUgl/dgo0tH62cowuC277QchWQrrzIRHvcX
         /gMdpGJNMGjrm11Z7/qve7i9URidQmcDoGX0IsEP/oJW67BBwJ2Fk71WFSf73NhoAQ
         5veID3B4RO0ksV1/M3//sQNmLpsTaz8fiBXMHN1iCu/7aBpGJcZFdFppF7LpcsvKw0
         2QDQ1nJOU9LGmO0+Myge7O1AWIzZKtnVcx53MpVdNw5CiXZKWJDTiymiNIqEsLXJpU
         aBcasELBj5HyHmVQTt0pz/GSRtWQr5PykEaKz11uIuQyPkJseS76QCq7kTt5MPN/Pj
         c1lEuWtyeycKw==
From:   broonie@kernel.org
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: linux-next: manual merge of the tip tree with the s390 tree
Date:   Tue, 18 Apr 2023 14:40:10 +0100
Message-Id: <20230418134010.69844-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/s390/kernel/setup.c

between commit:

  944c78376a39b ("s390: use init_thread_union aka initial stack for the first process")

from the s390 tree and commit:

  9ea7e6b62c2bd ("init: Mark [arch_call_]rest_init() __noreturn")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc arch/s390/kernel/setup.c
index 0903fe3566341,4259b6c505163..0000000000000
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
