Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A75173F8D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjF0JfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbjF0JfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:35:06 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A682B18E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:35:04 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3B5E1EC068F;
        Tue, 27 Jun 2023 11:35:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687858502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=LKNgx+hMijp2pUG3Nb7xz7HnVNhjLeso1D/g6pycai0=;
        b=hle/es8FRkda7NNi4K6GT2pD1x2O8LXV/DGqXtf4JSFeZG9fAZy1O3bZHlmgIGChY82ZEy
        H7MtPOHvvu76HD2HR8OfAUyWX7qMu6497eAjD6TfiTdzqFnucHhjRbogYiz6A+CmnsJAqs
        DmOFKMlqkIYzjJbikyry4nRUIEPGI+o=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q-EOo01HKVtN; Tue, 27 Jun 2023 09:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687858499; bh=LKNgx+hMijp2pUG3Nb7xz7HnVNhjLeso1D/g6pycai0=;
        h=Date:From:To:Cc:Subject:From;
        b=k2xEAMj2zCSYIDYb9FT93FlRJoljfFISRF03Rcp+B6XwkofBOGuadVDLCnt+swxUf
         joae2RmTlEqyz4gPY96LeJvdM6qBYwKbajkU4W/60iUuo0rY98DH074BXVMsZ4c7Is
         r8pcuOlHUGXi/JFzqJV97E4Re2WUWVBLrfy4REeDyhMVIZwzDQ8AY54bpmkDTiHtHo
         6X97UAzOjfs4zqyRldpYNU79Rk8V6k45dQ0rfddD/0N/b+xkB5ZyNQ3msHs2Nc0arN
         7AdXnVftWp+70FzDZfEPbitpfAXWlKPLK7Runp0btzv+aPdPPIZr5VtnPkrJcgTfA1
         ZdllGP8+TS3Je/vsF+NqivPsBZOugWkPIEURW4M2uOHXICoHDly43eWOZmUXe+M7Aa
         Ao0WmWp/w2Q+4HJio+Fc50B/VqXxBimbYOG1+55oWwhXGQ6nyqaUvt/yxCgrD6KZIe
         nUthfZg3oK1858HcY5HWl4WPaGEZybcF/cEFjQa5SSD9qVwonGC+QiYGgUP67lVz18
         vwkPXUkV6AntBb1ELvb5mbKaOfVVQtHXBoiEVLEl89ZDe+SAcmr7j/sWGfU02AU0nf
         uhOYxo1POY0kk1W68c7sJLU9plXUMl4YWihtjmymU++G08caHUo2/9LVNSNx4u2j08
         F5VD5QnqYMYZkvdwuCiLh8Ds=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C718940E0033;
        Tue, 27 Jun 2023 09:34:56 +0000 (UTC)
Date:   Tue, 27 Jun 2023 11:34:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for 6.5
Message-ID: <20230627093452.GBZJqtPAaq9JI9AFZR@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull the updates to the x86 microcode loader for 6.5.

Thx.

---

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.5

for you to fetch changes up to a32b0f0db3f396f1c9be2fe621e77c09ec3d8e7d:

  x86/microcode/AMD: Load late on both threads too (2023-06-12 11:02:17 +0200)

----------------------------------------------------------------
- Load late on both SMT threads on AMD, just like it is being done in
  the early loading procedure

- Cleanups

----------------------------------------------------------------
Borislav Petkov (AMD) (2):
      x86/microcode/AMD: Get rid of __find_equiv_id()
      x86/microcode/AMD: Load late on both threads too

Nathan Fontenot (1):
      x86/microcode/amd: Remove unneeded pointer arithmetic

 arch/x86/kernel/cpu/microcode/amd.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
