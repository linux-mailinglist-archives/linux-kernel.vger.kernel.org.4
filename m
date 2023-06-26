Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8DD973E598
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 18:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjFZQqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 12:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjFZQqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:46:12 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A55A18E
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 09:46:11 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 14C501EC053F;
        Mon, 26 Jun 2023 18:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687797970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=Hgb5Nepegx+81oQkWdAK16yq4xTuK7HPfL6P9v3vXeU=;
        b=CiJQhiIj4s38Qn1t80REl0vGF/kzWJZHWaFsLWxHtq2fu/bZ9ZwHHc+crLGo9ykrFmto/9
        vsOZ8q7PzREBl4Sp2SOxEtgbrraI85ebrvcKYPxSvxtnFf9vpO0rbq7ypkK1nKx6uPfiD3
        nQ1bbPHTbOflFsShLnshmBkyb/9Jx2A=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id rs2NdD1rw2Vm; Mon, 26 Jun 2023 16:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687797964; bh=Hgb5Nepegx+81oQkWdAK16yq4xTuK7HPfL6P9v3vXeU=;
        h=Date:From:To:Cc:Subject:From;
        b=R223SU5jVFUCvCIcyXH3CvixBAyJnPjKnn/SaxFF++782l4N6EIvEkHKNb2JGQiFt
         Io4QezqqtuyIrUS8S1U6h46jBeAA6rHMM37EaoNFzUMQHfY8feIiKQYaJ9dvr+gRpr
         7pZWYv1PdeB4hsMNBU+sKkgCGcve+p89W+4UteotjsaVets44nSHO5u0NBHzfEOW/J
         auu0dtyVI/GptA1cVAK5vJWecx3kdsfRbt/3SRQ7MinUQdtjiAumlE9RG+V31ykoMP
         HgpRwKCRknIOwBLjyuM4gjqDsy/2mztOMzBIq0WfTwG8o5FH4IiVtGwOVSg1GscXTk
         E+Ky6mBJIk4CNIAT2AdYl8bh0wLJulH7OGHKcjKPuwg8GHXq3TEsyWRxxw8OWsyR9e
         f1ta2CYm6jEPn+Z2C6bR6EufJ9ikSFYLo2S5QxrvrXC1yqMiBOOOb3aDMa/uxJhnp1
         aA7KAh9bcOaPSA1jXOOKbXI2U2K7qZnhfynjK/AKTJdR8SCtiFpSdaxjJcAP2lFw5r
         7oGK1t8h8vfP6wwm/BbTvzq8IIt8KOiKrKRMyp0jC4dNAM7M/ZAn452e+YR3AFZfFK
         FnFcMrNZWZXPvjL40ida1I8Cr317HanMRQv60kItcT8tePB/6X6+7+rZmHgzQWNd9S
         Rhy6LwCptaY3Aeh0MqsC3Wok=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0B06A40E0033;
        Mon, 26 Jun 2023 16:46:01 +0000 (UTC)
Date:   Mon, 26 Jun 2023 18:45:56 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/build for 6.5
Message-ID: <20230626164554.GGZJnAwnKoOTCbvKfn@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a single x86 build optimization for 6.5.

Thx.

---

The following changes since commit 858fd168a95c5b9669aac8db6c14a9aeab446375:

  Linux 6.4-rc6 (2023-06-11 14:35:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_build_for_v6.5

for you to fetch changes up to 9d9173e9ceb63660ccad80f41373fd7eb48ff4ac:

  x86/build: Avoid relocation information in final vmlinux (2023-06-14 19:54:40 +0200)

----------------------------------------------------------------
- Remove relocation information from vmlinux as it is not needed by
  other tooling and thus a slimmer binary is generated. This is
  important for distros who have to distribute vmlinux blobs with their
  kernel packages too and that extraneous unnecessary data bloats them
  for no good reason

----------------------------------------------------------------
Petr Pavlu (1):
      x86/build: Avoid relocation information in final vmlinux

 arch/x86/Makefile.postlink        | 47 +++++++++++++++++++++++++++++++++++++++
 arch/x86/boot/compressed/Makefile |  8 +++----
 2 files changed, 50 insertions(+), 5 deletions(-)
 create mode 100644 arch/x86/Makefile.postlink

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
