Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF16E74C192
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 10:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjGIITR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 04:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjGIITP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 04:19:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF43FC
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jul 2023 01:19:11 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B2C2D1EC08EA;
        Sun,  9 Jul 2023 10:19:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1688890749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=6lnx5Yqkr3KJe61meMdkwtLtbwfbWLg5/0usZ+5XhnE=;
        b=F3GDfL4QGYBAHSGlDKWeHAd9pQSQLwWoznIcfiNL37SHSpQVGper/XrItOqofj5mOtLXZB
        IG2JCQmRbx0vk1SO90pik1puMOCNFgFooJEPJjbjuXmknasOFbbUTleDeDBd1Yl3x6l1+5
        /8J7QB02OPwnx66KYlTHri2aT/wAjOQ=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id O27_wu_N6raP; Sun,  9 Jul 2023 08:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1688890747; bh=6lnx5Yqkr3KJe61meMdkwtLtbwfbWLg5/0usZ+5XhnE=;
        h=Date:From:To:Cc:Subject:From;
        b=XSKXPOk7l4LDB3d4h6huiLUeLAAw1Mz478XSSRrQfd3VHLftfbhd6gGoorvk3mpF5
         j2C8Pp0XxXX4Y2+98swy4aaMUkwtapsdnWWBzndU4U59AmVuFogNJCgN1sZ5PTmrHN
         d1VCIniI/88veOizftrcbQD5HSy2CzmqqDivuUwpZXwUAjVl9r7IPSB2yz0h4xVPhQ
         /oKIjxyFZinPZjnj12TDXMjd2ENTy2a8wdleNQvBdEM+mJ8QJf0killA+MidT9seu1
         YBBIOU5wDq5p/PkNASVqCW8L8rDxMY94CTkTh4Mls0J1Q38Zwv7Qq0pREGGIliWyD5
         wZVl54RMDXJFheEDdRb9XPMfP1Txx+gI0ybugTKsmfkhZjq/mu0Lsga8K7CrRfzg8d
         BSh0d8gfLo3KHuZGPXao3kMpVAj3/bqU3YSCzzCgstSmm+YxpXTd0ZR4wogZYrU0lr
         4ND95ga3aZXRcJljz3eYgnAQUWgALL/7Ju7FCNblwa6cRR5n/wcIAQkhnl1h1OvgSY
         jTKD7hpn7HJLw5I+ziPFeqfo3ksC+xtsgpKUmvdWbiyzzdn0k1bE7W0R2/j3whjRyH
         KQmE34bC75dk920x3vQ9MmTLYyfQo+SB8L9In8R5VdRRommlHjzDLlLx6kRqylOLvN
         e3J5/ZFe/s3CflomjNbTRxhk=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 45AD640E0033;
        Sun,  9 Jul 2023 08:19:04 +0000 (UTC)
Date:   Sun, 9 Jul 2023 10:19:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] objtool/urgent for v6.5-rc1
Message-ID: <20230709081903.GCZKptd16D1sbcDoIy@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single urgent objtool fix for 6.5-rc1.

Thx.

---

The following changes since commit 6f612579be9d0ff527ca2e517e10bfaf08cc1860:

  Merge tag 'objtool-core-2023-06-27' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2023-06-27 15:05:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/objtool_urgent_for_v6.5_rc1

for you to fetch changes up to cc592643a3ea1b2231628fb414dee203633a11c0:

  objtool: Remove btrfs_assertfail() from the noreturn exceptions list (2023-06-28 11:21:50 +0200)

----------------------------------------------------------------
- Fix a post-merge semantic conflict due to btrfs_assertfail() not being
  a noreturn function anymore

----------------------------------------------------------------
Ingo Molnar (1):
      objtool: Remove btrfs_assertfail() from the noreturn exceptions list

 tools/objtool/noreturns.h | 1 -
 1 file changed, 1 deletion(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
