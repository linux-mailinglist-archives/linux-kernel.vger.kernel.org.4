Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79BD1718A54
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjEaTjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjEaTjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:39:43 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67709F;
        Wed, 31 May 2023 12:39:41 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2af189d323fso17477801fa.1;
        Wed, 31 May 2023 12:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685561980; x=1688153980;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lIjT4mlISJu8jR4A4B3Vr7/4Ms0dWMMpltQFK9LUYNc=;
        b=L58nvViZD0KH+VQ5yAqbKU2jFHE6oQB0HRCpn4oTQLxAQEXebHFUPqcOzrOGg5/C+A
         WCo0xaRs+JM0GCvsA84QzNVc9bvd9byzc8UdePptAMcuSpGGW26DvBSjacJXtYKzV92K
         hgibMm0TAGvBEgkhTqjqaaa4XIeQcLXCR2fdS2TAe8RlF3kw/Qm4dIJNK9J8hTvzTIvJ
         bjhMfT54X2rSesOBQ/hnaYtr/JhcmXzCExJrM4vSaJCBGE4CFyQOuIe1jdmcQTOffd/D
         rXZRardaTlta2RTDcjObfnjRcGGfqRaw/9SiUI0+LhjYvKlb+7S8/b2gui2zy3Q2IQ+J
         /oEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685561980; x=1688153980;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIjT4mlISJu8jR4A4B3Vr7/4Ms0dWMMpltQFK9LUYNc=;
        b=a8InKojx2seoBv/9nJR8cGSJlxBmDaK2DB4T8Q8z/Ju5XHvxgkmrrjb91chfV3maEQ
         U/b6x0C5wXKAXy9tD0xUApclgzMC9Lm258klxFM2/97EEhQoUYppo44BoGuX8DeNZgqr
         3SXyv2fNikbvlnZzDDlX0I0szSbDYUZQGrjKsM2fx3egxJjHyYPDXtMw45nFQvjehfai
         nNpNYp/hGXpXSpU4Zqf4kUo51jHDIYtmUs6xbq2TB2zBPExKwwGVWMrUnelMw88eNehE
         0F30+FUJjmu+FGE8QaTnYRL32siWzG8+As9I19azOaGy21cUIkzB8xPbuasdopIkHOBV
         k9DQ==
X-Gm-Message-State: AC+VfDxzoQJPDfUzGIpeBsWYImR9NKW9KZaVhnsc3yKK1X+DNUrENVvm
        xA4eGUoh4+igGaXjl32EdY8LAte7bDJdSX2jGoO8EKU/7DEpzW6y
X-Google-Smtp-Source: ACHHUZ59hm9oaUSYvVzDdJBx6cyogcBsvy5MvOYD6rtwvjlf3/S83PwBZh3IJ8O3dd3+apQ4TdWFX0mqGNKPQbYtgUk=
X-Received: by 2002:a2e:b626:0:b0:2ad:9edd:4e2 with SMTP id
 s6-20020a2eb626000000b002ad9edd04e2mr5673915ljn.20.1685561979662; Wed, 31 May
 2023 12:39:39 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 31 May 2023 14:39:28 -0500
Message-ID: <CAH2r5msPYB8mYc1caQoBP36UhOdJx1rzK3EsxZbQfuhRzu=MAw@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
0d85b27b0cc6b5cf54567c5ad913a247a71583ce:

  Merge tag '6.4-rc3-smb3-client-fixes' of
git://git.samba.org/sfrench/cifs-2.6 (2023-05-25 19:23:18 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc4-smb3-client-fixes

for you to fetch changes up to fdd7d1fff4e3b97c4706f4c0e000a38b134b7ae5:

  cifs: address unused variable warning (2023-05-27 03:33:23 -0500)

----------------------------------------------------------------
four small smb3 client fixes
- two small fixes suggested by kernel test robot
- small cleanup fix
- update Paulo's email address in the maintainer file
----------------------------------------------------------------
Dan Carpenter (1):
      smb: delete an unnecessary statement

Steve French (3):
      smb3: update a reviewer email in MAINTAINERS file
      smb3: missing null check in SMB2_change_notify
      cifs: address unused variable warning

 MAINTAINERS             | 2 +-
 fs/smb/client/ioctl.c   | 6 +++++-
 fs/smb/client/smb2ops.c | 1 -
 fs/smb/client/smb2pdu.c | 2 +-
 4 files changed, 7 insertions(+), 4 deletions(-)


-- 
Thanks,

Steve
