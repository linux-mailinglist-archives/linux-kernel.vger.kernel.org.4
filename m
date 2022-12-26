Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE5F656137
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiLZIoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiLZIog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:44:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5ECB92
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:44:28 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h16so9542810wrz.12
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:44:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7XyBR4kfDs44qgIQDOGsK92MH7sQtM7JyUygoDESlY=;
        b=f0TOVHg8j/d78hQnX7TdGAudJghLXGgTu4Ya/sZZpA66wK1gDXOmTozweQuGkK93WD
         VzH8iOc242B+OjTIerZQVvgnGUz0z9uFmKD8ifbqehBWRLXa9JPyS4M9bbn0ePDwIn2g
         diY0EWofrTq5MJ9NDCIxhQdsHg75CE4hUhnnjqtd2QM0BWRITd5CFpGl4ZlsXa0y1SMT
         I1KGZUvLnvAkFlgjv7P6arBVqO22II5uJfYHukKdCg4j8Wl3zTwVuOurXBph3+6JSrUe
         tAmF4GGikwxYFU3iCIEoSNvt7AuU8t8U7+n6a8lcfPveODC6egfuL5sU+TWyMZshT6nL
         JnUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7XyBR4kfDs44qgIQDOGsK92MH7sQtM7JyUygoDESlY=;
        b=SV1gBKoYfOObGEANuHt8kS4oByTXH5aNZCnzi4Dckn6VBMUcrpwu1NBi4rzCNujrw6
         AGvEfOz6HpAvzezpdvc64e86TV9mxaLByVfMgQefz+qO4Uug60CySqEoLZwwJPcgnJG0
         gZm1tds/elGFN+pfVzUX0W6Ef1qG78BLgzv8aNVmj7Gz8/g23MjofSMaAOr6zUV7csAa
         xSoaETtar/18ZR4pS65iNWxiKuUSJM/68JJufShgtiEjW7aIZIyEHBP4sIKEklrMOmWz
         ISVWSSLdPi+30U4CcpYH5mj5ETw8zXus+i7J/2C5XuasyC4+pbKOwrJ0lqstcZZNCElT
         aHYg==
X-Gm-Message-State: AFqh2kosYknhcY+a9yEQzCYFWeEdNPqBONsksm5SlGjzG4/WvwSYme6y
        PcT5i4K7vSkSKFbBlrY5dvU=
X-Google-Smtp-Source: AMrXdXvgPrlAvTX7o3ZdOzKghVhdFHXZgoCM93qArZt9Dv4T7DKJf5CF/nW7P2pasUXuEQnjSwHBlA==
X-Received: by 2002:a5d:5308:0:b0:25a:f8a1:f136 with SMTP id e8-20020a5d5308000000b0025af8a1f136mr10541038wrv.67.1672044267368;
        Mon, 26 Dec 2022 00:44:27 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id m16-20020adffe50000000b00241bd7a7165sm10593253wrs.82.2022.12.26.00.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 00:44:26 -0800 (PST)
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
Subject: [PATCH v3 0/5] update mlock to use folios
Date:   Mon, 26 Dec 2022 08:44:18 +0000
Message-Id: <cover.1672043615.git.lstoakes@gmail.com>
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

 Documentation/mm/unevictable-lru.rst     |  12 +-
 arch/m68k/include/asm/motorola_pgtable.h |   2 +-
 include/linux/pagevec.h                  |   5 +
 mm/internal.h                            |  26 ++-
 mm/mlock.c                               | 266 +++++++++++------------
 mm/swap.c                                |   2 +-
 6 files changed, 162 insertions(+), 151 deletions(-)

--
2.39.0
