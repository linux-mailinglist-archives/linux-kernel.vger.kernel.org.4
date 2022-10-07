Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F265F7447
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 08:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiJGGlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 02:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJGGlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 02:41:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6BBC8970
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 23:41:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1DB8C218FC;
        Fri,  7 Oct 2022 06:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665124906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fjnPZrMU8HQlRaEL1NbINikk37iX63+Ug6moJ46OZmk=;
        b=hYTSewCYiI+AB2wh7D9K8770bh/oZfm6y1fNcNhyF18xnoHpjxv9vyOEKHo/JgmjOEUkSr
        ejlzKkTwdN78gU9FbLy5mRYt+ERVN2a8+E9cpQeoTYHfRD2iIUWanZ7JciAtrBVkEUYRfZ
        t7xafpoAia1OgwgajW+TLytKRgpk9x0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A588B13A3D;
        Fri,  7 Oct 2022 06:41:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cy/WJinKP2PjSQAAMHmgww
        (envelope-from <jgross@suse.com>); Fri, 07 Oct 2022 06:41:45 +0000
From:   Juergen Gross <jgross@suse.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 0/3] xen/virtio: support grant based virtio on x86
Date:   Fri,  7 Oct 2022 08:41:40 +0200
Message-Id: <20221007064143.10049-1-jgross@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic support for virtio with grants on x86 by defaulting the
backend to be in dom0 in the case the guest kernel was built with
CONFIG_XEN_VIRTIO_FORCE_GRANT.

Juergen Gross (3):
  xen/virtio: restructure xen grant dma setup
  xen/virtio: use dom0 as default backend for
    CONFIG_XEN_VIRTIO_FORCE_GRANT
  xen/virtio: enable grant based virtio on x86

 arch/x86/xen/enlighten_hvm.c |  2 +-
 arch/x86/xen/enlighten_pv.c  |  2 +-
 drivers/xen/grant-dma-ops.c  | 83 +++++++++++++++++++++++++-----------
 include/xen/xen-ops.h        |  6 +++
 4 files changed, 65 insertions(+), 28 deletions(-)

-- 
2.35.3

