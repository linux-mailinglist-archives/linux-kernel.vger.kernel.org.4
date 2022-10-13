Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6F45FE587
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 00:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJMWpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 18:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJMWpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 18:45:04 -0400
Received: from resqmta-c1p-023465.sys.comcast.net (resqmta-c1p-023465.sys.comcast.net [IPv6:2001:558:fd00:56::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46755F234
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 15:44:56 -0700 (PDT)
Received: from resomta-c1p-023267.sys.comcast.net ([96.102.18.232])
        by resqmta-c1p-023465.sys.comcast.net with ESMTP
        id j2WSoDUqzf0y0j6uGoIgBW; Thu, 13 Oct 2022 22:42:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20211018a; t=1665700944;
        bh=uV9jv29H6aFjQ0ZSoY1eBV2TaHPRxfvEQYTsQ4HbTmo=;
        h=Received:Received:From:To:Subject:Date:Message-Id:MIME-Version;
        b=pkixH37in8eAtc+ANM7ONsju8O0nl69xc2fbW3o9jM11zq3Z4fkA0wCOI59y1/RCl
         Hpzt8pT/j8XmFzjczzffsJuYoiHEVK4gI3mMJ64PS1rkHq1mQ7WLlb0Jq8XfqcuWDB
         eMKgePlLoZP+aPHhm7Z7pW/IMg0oo4BKcP2bqGh3V8xbPwqQMmVBNltvrIUWeik2mU
         Wf9zXB1kEkRmtl5YdVH0qLGIbwSdV/aEjH4bDCLl/aMNV9u4pploA3xOd0WhDegXeU
         xna7IeSPPhE5P2rQd6e/N0o+gw5F/aWYPndf9oJk8dmmcfb9xGWcL7DWrMFYVr+DgX
         krdoBC0fbd4gw==
Received: from jderrick-mobl4.amr.corp.intel.com ([71.205.181.50])
        by resomta-c1p-023267.sys.comcast.net with ESMTPA
        id j6toofOVmA6uYj6ttozg6o; Thu, 13 Oct 2022 22:42:02 +0000
X-Xfinity-VAAS: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekuddgudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvehomhgtrghsthdqtfgvshhipdfqfgfvpdfpqffurfetoffkrfenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheplfhonhgrthhhrghnucffvghrrhhitghkuceojhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghvqeenucggtffrrghtthgvrhhnpedvtdejiefgueelteevudevhfdvjedvhfdtgfehjeeitdevueektdegtedttdehvdenucfkphepjedurddvtdehrddukedurdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopehjuggvrhhrihgtkhdqmhhosghlgedrrghmrhdrtghorhhprdhinhhtvghlrdgtohhmpdhinhgvthepjedurddvtdehrddukedurdehtddpmhgrihhlfhhrohhmpehjohhnrghthhgrnhdruggvrhhrihgtkheslhhinhhugidruggvvhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqrhgrihgusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghksehsoh
 hlihguihhgmhdrtghomhdprhgtphhtthhopehjohhnrghthhgrnhigrdhskhdruggvrhhrihgtkhesihhnthgvlhdrtghomhdprhgtphhtthhopehmrghrihhushiirdhtkhgrtgiihihksehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepjhhonhgrthhhrghnrdguvghrrhhitghksehlihhnuhigrdguvghv
X-Xfinity-VMeta: sc=-100.00;st=legit
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
To:     Song Liu <song@kernel.org>
Cc:     <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        jonathan.derrick@solidigm.com, jonathanx.sk.derrick@intel.com,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>
Subject: [PATCH v2 0/3] Bitmap percentage flushing
Date:   Thu, 13 Oct 2022 16:41:48 -0600
Message-Id: <20221013224151.300-1-jonathan.derrick@linux.dev>
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

This introduces a percentage-flushing mechanism that works in-tandem to the
mdadm delay timer. The percentage argument is based on the number of chunks
dirty (rather than percentage), due to large drives requiring smaller and
smaller percentages (eg, 32TB drives-> 1% is 320GB).

This set hopes to provide a way to make the bitmap flushing more consistent. It
was observed that a synchronous, random write qd1 workload, could make bitmap
writes easily become almost half of the I/O. And in similar workloads with
different timing, it was several minutes between bitmap updates. This is too
inconsistent to be reliable.

This first and second patches adds the flush_threshold parameter. The default
value of 0 defines the default behavior: unplugging immediately just as before.
With a flush-threshold value of 1, it becomes more consistent and paranoid,
flushing on nearly every I/O, leading to a 40% or greater situation. From
there, the flush_threshold can be defined higher for those situations where
power loss is rare and full resync can be tolerated.

The third patch converts the daemon worker to an actual timer. This makes it
more consistent and removes some ugly code.

Jonathan Derrick (3):
  md/bitmap: Add chunk-threshold unplugging
  md/bitmap: Add sysfs interface for flush threshold
  md/bitmap: Convert daemon_work to proper timer

 Documentation/admin-guide/md.rst |  5 ++
 drivers/md/md-bitmap.c           | 98 +++++++++++++++++++++++++-------
 drivers/md/md-bitmap.h           |  4 +-
 drivers/md/md.c                  |  9 ++-
 drivers/md/md.h                  |  2 +
 5 files changed, 93 insertions(+), 25 deletions(-)

-- 
2.31.1

