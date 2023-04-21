Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BBB6EAA72
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 14:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjDUMi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjDUMi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 08:38:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7981E193;
        Fri, 21 Apr 2023 05:38:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BC86619F6;
        Fri, 21 Apr 2023 12:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C787C433EF;
        Fri, 21 Apr 2023 12:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682080704;
        bh=Wb2kVZRBio3negSD8saps8sPYVC/ecnBb/vgLu44iGc=;
        h=From:To:Cc:Subject:Date:From;
        b=mH8Ea4IvCu1EmY2SnFXKvKqg4RQr2nQkU1wpGMqWyU92AlZgVAoI0e67ytJ55NFxi
         HbILtRGgfWlvKgdIiaSoQ38ml/1Csg+JUKtF3dCH64U80o1M5KJx1p3vrc0Gnui+tL
         z3VChn9RxHmTakl75XjfHT3hENanxj1uEsdQuftlI0K0D3xA5iQytKJipjMdLXHCwe
         IVYMDWjiMFQWz1mw3iz2NqVxfAXqGkYBmCCcJUj57s7cEEbEUh/t20n+Lix2y/sDin
         vdI0gY/kdzQWz7SRxHQn+/+MbaW1uHdl39c61weJHn/Jcpmd0HCg2KulmT6MbrGknB
         3Zai1AEi1y6Sw==
From:   broonie@kernel.org
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>
Subject: linux-next: manual merge of the vfs tree with the ksmbd tree
Date:   Fri, 21 Apr 2023 13:38:20 +0100
Message-Id: <20230421123820.79447-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the vfs tree got conflicts in:

  include/linux/namei.h
  fs/ksmbd/vfs.c

between commits:

  624d981552e10 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
  0242bdc54a512 ("fs: introduce lock_rename_child() helper")
  35175d058b140 ("ksmbd: remove internal.h include")

from the ksmbd tree and commits:

  9bc37e04823b5 ("fs: introduce lock_rename_child() helper")
  211db0ac9e3dc ("ksmbd: remove internal.h include")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc fs/ksmbd/vfs.c
index 778c152708e43,cef07d7fb7dc4..0000000000000
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
diff --cc include/linux/namei.h
index 1463cbda48886,5864e4d82e567..0000000000000
--- a/include/linux/namei.h
+++ b/include/linux/namei.h

[The ksmbd version was already in the tree with one extra commit on top
of the two that appear to have been cherry picked from the vfs tree.]
