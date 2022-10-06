Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D497F5F70F8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 00:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiJFWJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 18:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbiJFWJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 18:09:14 -0400
Received: from resqmta-h1p-028593.sys.comcast.net (resqmta-h1p-028593.sys.comcast.net [IPv6:2001:558:fd02:2446::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFDAABF17
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 15:09:11 -0700 (PDT)
Received: from resomta-h1p-028434.sys.comcast.net ([96.102.179.205])
        by resqmta-h1p-028593.sys.comcast.net with ESMTP
        id gVlMoYu4LrhuigZ3Foqf4F; Thu, 06 Oct 2022 22:09:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1665094149;
        bh=IKYUboxuiUIaVRLX9+Ls9Ayah1lDyM2CjdHPVn2SJhY=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version;
        b=pS92lRNt/kQ6IP1lIEp7tajA7dP81pNBSj6Dy+Ba7tiE6lHU0kDVY2hXcn3OH9nYJ
         9AVb8cyUTnZj+ASjHsI9U9A1RE9dngd0ic0sgAGX/GAKNuYotzOX+Md0jpOtFcEW+j
         1QOIonsglywIxgQZ5vMN7Ywot1+ndtfBBQAF+r4t9xvD1/eieEz/8H+ZQwahWs3FGa
         nNyhOOZNTy2abruKUzjPNOC/WtEA1Kprfo0d559f5ghF9LkclPKG6imMI11/vpQrK7
         Xb7t826LQbLM1Lohf0mxz4oAvviR6vO5DnX2c38lauRi3G28ZTOto1meEH1V2/nPOW
         BXki4viB+LkFw==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-h1p-028434.sys.comcast.net with ESMTPA
        id gZ2nocknTZjG3gZ2roEgwk; Thu, 06 Oct 2022 22:08:47 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeiiedgtdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedvtdejiefgueelteevudevhfdvjedvhfdtgfehjeeitdevueektdegtedttdehvdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepiedprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgrihgusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghksehsoh
 hlihguihhgmhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhigrdhskhdruggvrhhrihgtkhesihhnthgvlhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvh
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Song Liu <song@kernel.org>
Cc:     <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        jonathan.derrick@solidigm.com, jonathanx.sk.derrick@intel.com,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH 0/2] Bitmap percentage flushing
Date:   Thu,  6 Oct 2022 16:08:37 -0600
Message-Id: <20221006220840.275-1-jonathan.derrick@linux.dev>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces a percentage-flushing mechanism that works in-tandem to
the delay timer. The percentage argument is based on the number of
chunks dirty. It was chosen to use number of chunks due to large drives requiring
smaller and smaller percentages (eg, 32TB drives-> 1% is 320GB).

The first patch fixes a performance gap observed in RAID1
configurations. With a synchronous qd1 workload, bitmap writes can
easily become almost half of the I/O. This could be argued to be
expected, but undesirable. Moving the unplug operation to the periodic
delay work seemed to help the situation.

The second part of this set adds a new field in the superblock and
version, allowing for a new argument through mdadm specifying the number
of chunks allowed to be dirty before flushing.

Accompanying this set is an RFC for mdadm patch. It lacks documentation
which will be sent in v2 if this changeset is appropriate.

Jonathan Derrick (2):
  md/bitmap: Move unplug to daemon thread
  md/bitmap: Add chunk-count-based bitmap flushing

 drivers/md/md-bitmap.c | 38 +++++++++++++++++++++++++++++++++++---
 drivers/md/md-bitmap.h |  5 ++++-
 drivers/md/md.h        |  1 +
 drivers/md/raid1.c     |  2 --
 drivers/md/raid10.c    |  4 ----
 5 files changed, 40 insertions(+), 10 deletions(-)

-- 
2.31.1

