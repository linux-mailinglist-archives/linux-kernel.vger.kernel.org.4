Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF7E7437B0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 10:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjF3Ip3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 04:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjF3Ip0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 04:45:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC987194;
        Fri, 30 Jun 2023 01:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40CA2616FE;
        Fri, 30 Jun 2023 08:45:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72995C433C8;
        Fri, 30 Jun 2023 08:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688114724;
        bh=XCGEJy3R7r9qVEdodIrivlpUMg2Wf0w09Wh06MmqfKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qYGriyuY2tStPWMV981uCR6OqpUX/wtnRmIwGMQ3laEM3IMXL8dDhFVcnZK9ojCNI
         aEHF4JJeazTc0Z1NsmkdzpmKoZlUH6ao5cdFcUSxErg/lAFP4K2KIYyNdFNCdZGnNI
         QnFR8IWiVZNRKWnHgUZVPtcdMJKRMZJpt7nYiEAXIdewNqW9mDbbLFGdWCtU6HvYCm
         PNISEJy7QyzRudTeJ+bS5onYKnvJKmjHb4dOeO0P7mRjv6/ficWNt8FgvsI+3PSS2W
         4fL73WDcCEwmVaz8Hm8e6lCLXKFuVgcpAw6glYqmoPLxo00V0rC1FirDJzYbV/srTV
         SDXqMKN7TX2zQ==
From:   Christian Brauner <brauner@kernel.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Christian Brauner <brauner@kernel.org>,
        Tyler Hicks <code@tyhicks.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 0/3] fs/ecryptfs: Replace kmap{,_atomic}() with kmap_local_page()
Date:   Fri, 30 Jun 2023 10:45:17 +0200
Message-Id: <20230630-umfang-pumpt-a0cd2d6cdd91@brauner>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230426172223.8896-1-fmdefrancesco@gmail.com>
References: <20230426172223.8896-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1421; i=brauner@kernel.org; h=from:subject:message-id; bh=HdGmSeFl/tSI7e/B0hTSZaffBkpDR39gQdEGFv0fcNQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTMm/q5w0P88u6dt4yW36v8rt9/Q/rcsnOdsmYpbg7N/TyC G1ynd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykvZeR4aOQ1qeDzv99p/35FxF17o jlK+GUZD3OtZ3dRw4rSonNVWD4H7Xs4+V5Ja3fPnxcVWPek30q3vX4ZqmX8pMP2Lh1sK2LZAEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
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

On Wed, 26 Apr 2023 19:22:20 +0200, Fabio M. De Francesco wrote:
> kmap() and kmap_atomic() have been deprecated in favor of
> kmap_local_page().
> 
> Therefore, replace kmap() and kmap_atomic() with kmap_local_page().
> 
> Tested in a QEMU/KVM x86_32 VM, 6GB RAM, booting a kernel with
> HIGHMEM64GB enabled.
> 
> [...]

Picking this up. Please tell me if this should be routed somewhere else.
vfs.misc will be rebased once v6.5-rc1 is released.

---

Applied to the vfs.misc branch of the vfs/vfs.git tree.
Patches in the vfs.misc branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.misc

[1/3] fs/ecryptfs: Replace kmap() with kmap_local_page()
      https://git.kernel.org/vfs/vfs/c/7a367455b6a5
[2/3] fs/ecryptfs: Use kmap_local_page() in ecryptfs_write()
      https://git.kernel.org/vfs/vfs/c/55f13011af9d
[3/3] fs/ecryptfs: Use kmap_local_page() in copy_up_encrypted_with_header()
      https://git.kernel.org/vfs/vfs/c/de9f5a15080f
