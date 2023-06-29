Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E44B741C6D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjF1XZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjF1XYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:24:49 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6F8131;
        Wed, 28 Jun 2023 16:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=I6mOd3aGt7IBhtkudJQZT6k5aBQc6MxUgBycQg/Cs5I=; b=a83Tv9TIpQJv5ZtnBTsDgxFVPh
        SIOggketT4m8GX08VNFiU5uY72vY2beAMlj5didxij6rtPETdocvzkrM9Ej4js60yXaXEYvIU8mDG
        KrM11X+GcFvzEPukt0S6GjDBshMkvQEgYAn87Ym1c3X2ignspImXGGZPZaoT4kUCRo0pZMbvTNkdh
        zOkKefnmjW5a0QEF2+XPsMWSB2hXS3Ia59OWBvidcCHgHr05Nl4HXQgBgxdKF0qONGoddUX7r4IF3
        m91xFQt8+Lh/fLBOf6sh9VhW4tcqnmfuIJhH3zewcibbNMItzzfIHVBB//ltK1pEd+iBY7bjqTngy
        7GJIKYXw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
        by mx.treblig.org with esmtp (Exim 4.94.2)
        (envelope-from <linux@treblig.org>)
        id 1qEeWU-00GXy3-Pt; Wed, 28 Jun 2023 23:24:29 +0000
From:   linux@treblig.org
To:     sfrench@samba.org, linkinjeon@kernel.org, tom@talpey.com,
        linux-cifs@vger.kernel.org
Cc:     krisman@collabora.com, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH v2 0/4] dedupe smb unicode files
Date:   Thu, 29 Jun 2023 00:24:13 +0100
Message-ID: <20230628232417.120844-1-linux@treblig.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The smb client and server code have (mostly) duplicated code
for unicode manipulation, in particular upper case handling.

Flatten this lot into shared code.

There's some code that's slightly different between the two, and
I've not attempted to share that - this should be strictly a no
behaviour change set.

In addition, the same tables and code are shared in jfs, however
there's very little testing available for the unicode in there,
so just share the raw data tables.

I suspect there's more UCS-2 code that can be shared, in the NLS code
and in the UCS-2 code used by the EFI interfaces.

Lightly tested with a module and a monolithic build, and just mounting
itself.

This dupe was found using PMD:
  https://pmd.github.io/pmd/pmd_userdocs_cpd.html

Dave

Version 2
  Moved the shared code to fs/nls after v1 feedback.
  Renamed shared tables from Smb to Nls prefix
  Move UniStrcat as well
  Share the JFS tables

Dr. David Alan Gilbert (4):
  fs/smb: Remove unicode 'lower' tables
  fs/smb: Swing unicode common code from smb->NLS
  fs/smb/client: Use common code in client
  fs/jfs: Use common ucs2 upper case table

 fs/jfs/Kconfig               |   1 +
 fs/jfs/Makefile              |   2 +-
 fs/jfs/jfs_unicode.h         |  17 +-
 fs/jfs/jfs_uniupr.c          | 121 -------------
 fs/nls/Kconfig               |   8 +
 fs/nls/Makefile              |   1 +
 fs/nls/nls_ucs2_data.h       |  15 ++
 fs/nls/nls_ucs2_utils.c      | 144 +++++++++++++++
 fs/nls/nls_ucs2_utils.h      | 285 ++++++++++++++++++++++++++++++
 fs/smb/client/Kconfig        |   1 +
 fs/smb/client/cifs_unicode.c |   1 -
 fs/smb/client/cifs_unicode.h | 330 +----------------------------------
 fs/smb/client/cifs_uniupr.h  | 239 -------------------------
 fs/smb/server/Kconfig        |   1 +
 fs/smb/server/unicode.c      |   1 -
 fs/smb/server/unicode.h      | 325 +---------------------------------
 fs/smb/server/uniupr.h       | 268 ----------------------------
 17 files changed, 467 insertions(+), 1293 deletions(-)
 delete mode 100644 fs/jfs/jfs_uniupr.c
 create mode 100644 fs/nls/nls_ucs2_data.h
 create mode 100644 fs/nls/nls_ucs2_utils.c
 create mode 100644 fs/nls/nls_ucs2_utils.h
 delete mode 100644 fs/smb/client/cifs_uniupr.h
 delete mode 100644 fs/smb/server/uniupr.h

-- 
2.41.0

