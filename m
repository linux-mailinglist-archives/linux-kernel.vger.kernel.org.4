Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0746E1054
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 16:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjDMOr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 10:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjDMOrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:47:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB8DA250;
        Thu, 13 Apr 2023 07:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E2A663F36;
        Thu, 13 Apr 2023 14:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFF2C433EF;
        Thu, 13 Apr 2023 14:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681397215;
        bh=sD6MHcpYAz7We+U724CzFeQCJalgnzUEbBogL3Or51A=;
        h=From:To:Cc:Subject:Date:From;
        b=qbujdr7GRVbl7JYDHkho8At2w1sMdCSmby2FLYLenTm3vmBtZa0pKGB2gEydEPDFj
         zPkB2O/jWsyHjr5yEUT9kFNucxu7XyPI30O2ldm6wi+0V5YdBElATYIn7xO1b3Kc+z
         fJXgIYYLqbEAiwrwrECmu2mMI+88Q8GtzYwjp3UCitt4/0ctqJTvctNoMqhlIqvZlV
         hwecA3q+uNfhKqx4GRH3fSpc2UwUi47qspGtIjixej8GrFlS7bln3RrF/BgBHZvT0u
         rIMzzFE9O7fgx9AE1YGYpp4XmRLKiOin2qZTCDnTFXqaLbwN7N8RH7NtHZT6fTse8d
         FRzHbW1fZRTtA==
From:   broonie@kernel.org
To:     Gao Xiang <xiang@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jingbo Xu <jefflexu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the erofs tree with the vfs-idmapping tree
Date:   Thu, 13 Apr 2023 15:46:51 +0100
Message-Id: <20230413144651.3519980-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the erofs tree got a conflict in:

  fs/erofs/xattr.c

between commit:

  a5488f29835c0 ("fs: simplify ->listxattr() implementation")

from the vfs-idmapping tree and commit:

  303f50cf89b24 ("erofs: handle long xattr name prefixes properly")

from the erofs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc fs/erofs/xattr.c
index 015462763bdd5,a04724c816e5f..0000000000000
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@@ -483,12 -517,28 +513,26 @@@ static int xattr_entrylist(struct xattr
  {
  	struct listxattr_iter *it =
  		container_of(_it, struct listxattr_iter, it);
- 	unsigned int prefix_len;
- 	const char *prefix;
+ 	unsigned int base_index = entry->e_name_index;
+ 	unsigned int prefix_len, infix_len = 0;
+ 	const char *prefix, *infix = NULL;
+ 	const struct xattr_handler *h;
+ 
+ 	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
+ 		struct erofs_sb_info *sbi = EROFS_SB(_it->sb);
+ 		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
+ 			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
+ 
+ 		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
+ 			return 1;
+ 		infix = pf->prefix->infix;
+ 		infix_len = pf->infix_len;
+ 		base_index = pf->prefix->base_index;
+ 	}
  
- 	prefix = erofs_xattr_prefix(entry->e_name_index, it->dentry);
- 	if (!prefix)
+ 	h = erofs_xattr_handler(base_index);
+ 	if (!h || (h->list && !h->list(it->dentry)))
  		return 1;
 -
 -	prefix = xattr_prefix(h);
  	prefix_len = strlen(prefix);
  
  	if (!it->buffer) {
