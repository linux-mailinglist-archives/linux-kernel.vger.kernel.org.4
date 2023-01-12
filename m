Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69653667262
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 13:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjALMkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 07:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjALMjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:39:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9404C72E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:39:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so16487006wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 04:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1F5hZKUP2PlLbWKH0kODNe8bQmsfQoWefAi4zXNA/UY=;
        b=SaWGlmCqyO39Mkpqre4AEPrBUJX0bAhD8lTx0R6mWNFSzq4k91gA4SNmFFDs/+bGJe
         h1Ls8Ywo+pgSj6i35NxoRYedQ6SjFEUPjtc2kzFRAnhRVaeKuYQ7pB9LP922UfLyCF8J
         NCftknsoJQ9hsXgcyZNMphivDHo/mMRCIRgqv708Gm4C0c70xhsUaqdu7kqL9YBOAGGu
         e3jI3zVr/754Uw+z+/uLup9k1K5RacrCHjwUOuliZ+/xjzrEv7Tl+HGmXTAsei0sYbyD
         gzXHsJqZBk7+uIf0a/m/H5AiRC0LdthDtdiotb/DEyykTraPoG5ezfG9y/Mx6I/jFSR3
         rV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1F5hZKUP2PlLbWKH0kODNe8bQmsfQoWefAi4zXNA/UY=;
        b=FonkRu08PyJHlDn0Wz0ANSTKG24bxQ26JALq2Do/Gz8W9JfhMJJJvnTnoWF33bv8Kz
         6/PMI+YjP03VXIekX5rYRyU1oj8m/5Or4HBdI5RqRzjSFtlrrs8zy5WvCUGtXtmuDl8y
         z4SL1fle0B+2Tdtd9k31z7bEeom0KmTOgDP4GnIhBfxekPGLtfpuxrmd8aGG/HLZ9bim
         5ebaxxP099wWVglwU3NqNH7nDTvSo2psEWlUlMLqbw304Kup0QABVHg2T19gw7dWcrg0
         M6/mCY80AIKOYEwBOLPp8mLJptu6JFQbYxa4FDCGkNXye4Wmht8S6TRhf8PsJFxlL8Wi
         rp1A==
X-Gm-Message-State: AFqh2krwikkmnU/o+2Um4BJLuFIrWg+Vh09gqlUIVVzWJSmTqLqYUwB2
        DHvHx84Ai6PrHOEQFd+6xb4=
X-Google-Smtp-Source: AMrXdXuDbdrcAPYPvhGX5gk81jxxhlFBD8mA7wSio+fx+E/kAB/4BqAfHcPwgOWXYkr3uJcqF0hHiA==
X-Received: by 2002:a05:600c:44c9:b0:3d1:f6b3:2ce3 with SMTP id f9-20020a05600c44c900b003d1f6b32ce3mr65756414wmo.35.1673527189537;
        Thu, 12 Jan 2023 04:39:49 -0800 (PST)
Received: from lucifer.home (host86-164-169-89.range86-164.btcentralplus.com. [86.164.169.89])
        by smtp.googlemail.com with ESMTPSA id q1-20020a1ce901000000b003b3307fb98fsm20890797wmc.24.2023.01.12.04.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 04:39:48 -0800 (PST)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v4 0/5] update mlock to use folios
Date:   Thu, 12 Jan 2023 12:39:27 +0000
Message-Id: <cover.1673526881.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates mlock to use folios, converting the internal interface
to using folios exclusively and exposing the folio interface externally.

As a product of this moves to using a folio batch rather than a pagevec for
mlock folios, which brings it in line with the core folio batches contained
in mm/swap.c.

Lorenzo Stoakes (5):
  mm: pagevec: add folio_batch_reinit()
  mm: mlock: use folios and a folio batch internally
  m68k/mm/motorola: specify pmd_page() type
  mm: mlock: update the interface to use folios
  Documentation/mm: Update references to __m[un]lock_page() to *_folio()

 Documentation/mm/unevictable-lru.rst     |  30 +--
 arch/m68k/include/asm/motorola_pgtable.h |   2 +-
 include/linux/pagevec.h                  |   5 +
 mm/internal.h                            |  38 +--
 mm/migrate.c                             |   2 +-
 mm/mlock.c                               | 280 +++++++++++------------
 mm/page_alloc.c                          |   2 +-
 mm/rmap.c                                |   4 +-
 mm/swap.c                                |  10 +-
 9 files changed, 192 insertions(+), 181 deletions(-)

--
2.39.0
