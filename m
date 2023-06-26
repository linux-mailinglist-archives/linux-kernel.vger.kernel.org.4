Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141B473E6BC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjFZRmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjFZRmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:42:16 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAD83AB9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 10:41:15 -0700 (PDT)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 913531EC01E0;
        Mon, 26 Jun 2023 19:41:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1687801273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=YQ0dVqYysNZmO3j5TMTghHTaawmwBTbHH2stACshiJw=;
        b=S7eLSTaHa23S20H0PQlC/+DdlEoK+BRa2X+YNuD1rn/bGsv++d3mWYnc6S3+1C+CCRX0aC
        Z2TMa+bWJDi63VeXNX9a8NdRvZ1QR8GluSc+qf+MEG1dTeoboUG5LlLv2WM9wFsXcpVbx8
        JI3D/01VAh/vFq/izbFC3FEDN8zi5tA=
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JivJiRQ1z_2A; Mon, 26 Jun 2023 17:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1687801271; bh=YQ0dVqYysNZmO3j5TMTghHTaawmwBTbHH2stACshiJw=;
        h=Date:From:To:Cc:Subject:From;
        b=DAdulc0uYqFp/nmsWaAt5aos3/dgmRKlhhcTbrPv8im4rJnU7MeORooWyZHhR4y45
         9I2r0aKQdjvvxh/2gpYR9flWtRQ2pbCVEiB4oHgVBJYr85ia84KnKrkyavezri5Pk/
         U53zEoDsiKJ9c9HPq6ZQXsAYmYG3dzVv143vvDHStTxkpJemWkJlYIlWSUsMlF/UCL
         nMJ7OGSg0sSlyrS/cKhYPbi1R+MXISRwGSS1dK3eo1anRAyOraBwLYj97v7lla+8wO
         FDtxM0JMiwKrAB4lQzVTWZcQA0qSE4YugBURpQS7FzPj3kjCDdR6opb+V4QPK6eY5q
         j0vqt7kStJQ1qLF6awg8QsUluQ6FDmQeiI1y6wroX4juQ+Mg9+gKT8IKxL1RYMZ5eq
         9Jn/t3H+pic9q4e5ngA/L6cmHuZIXoLYt3iJPX3IiWHrLlmB9XdvD/tAkSxIslPtvK
         VmDU8NboxENj1rO9Xd+QWU3teT2s3sJTdmWlCX62RDznht4DinacvEsM7K9poQqCuA
         3aE1AYwhsmlDLsxsbbPw+OYfvfHQ+EkUJqSkoph0M4eNDyufYjDNqmGTq5mP2E1eL5
         RlkcegXHw0GDADmIey7wnPy8ck1c59t4iuXQVhXVx8fQ7Y74cKG1YOZFv+HBFFrMJq
         7jckQYID25TzaywGWOTovMas=
Received: from zn.tnic (pd9530d32.dip0.t-ipconnect.de [217.83.13.50])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF17C40E0033;
        Mon, 26 Jun 2023 17:41:07 +0000 (UTC)
Date:   Mon, 26 Jun 2023 19:41:07 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cache for 6.5
Message-ID: <20230626174107.GIZJnNs+znIs2NuiTm@fat_crate.local>
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

please pull some x86 resource control updates for 6.5.

Thx.

---

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cache_for_v6.5

for you to fetch changes up to e0a6ede2dd884adb73a7dde80444185b655f7c79:

  Documentation/x86: Documentation for MON group move feature (2023-06-07 12:42:12 +0200)

----------------------------------------------------------------
- Implement a rename operation in resctrlfs to facilitate handling
  of application containers with dynamically changing task lists

- When reading the tasks file, show the tasks' pid which are only in
  the current namespace as opposed to showing the pids from the init
  namespace too

- Other fixes and improvements

----------------------------------------------------------------
Peter Newman (3):
      x86/resctrl: Factor rdtgroup lock for multi-file ops
      x86/resctrl: Implement rename op for mon groups
      Documentation/x86: Documentation for MON group move feature

Shawn Wang (1):
      x86/resctrl: Only show tasks' pid in current pid namespace

 Documentation/arch/x86/resctrl.rst     |   7 ++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 171 ++++++++++++++++++++++++++++++---
 2 files changed, 163 insertions(+), 15 deletions(-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
