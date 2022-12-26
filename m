Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97836560A3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 08:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbiLZHJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 02:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbiLZHI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:08:57 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738952626
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 23:08:56 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id ja17so7130803wmb.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 23:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtOA/G1DpjjrVMsZI4k2Vt28ANwPj2q63Muqqvyu2zA=;
        b=AswLI8hV/oLvJZ410Ful7+/TIqPpN8RYUHJaQaWvQ8SqdHzQ962rNqoBnNsDSXQNx/
         JdrFXb1FPbi5CGOu6kX495SzdTRZ0Xa9173jdgGHdksj5286D7m28jZl4elPdv29QSj8
         wuGTxI4v9TSxN81JANG98QbJgxx2uCaZlRviDC9WlQ7KYaWuA+2GLnsndy6hhxBB4pBM
         s4rmFfM6eXi/yXJPfwfzETbOP0Skb8Zcw2VUmqoOeUUgx5JHz1idEphkJOS1oEGMYcQ2
         +SOE4YNG2WbZFBvMKc75l4dVvs5Yu5979kdiwoe/IrMxyarTpAbScVkLpTxyIjT6h0kl
         6CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtOA/G1DpjjrVMsZI4k2Vt28ANwPj2q63Muqqvyu2zA=;
        b=sa2k3pyPMpf1NOAw1h/ez7sfILsx4x3qsiDMnRU4zwvnYS8jVzyQeaMN4ppAMudCmB
         gp9kiisOYWn9MVCfxjdzr1EFDeKZyLcyTew0gvtg7KoEEeYUxXcRqH+EfAcu+SxZUpdW
         nhDW1nPoWyWp+ceTB0Wg5YXTwvqKbgAvmoZPzzHSe9PyJYjsbm94kIM6lEqa2bDYdtyD
         uPAW8c1/CnehOSvXeTu1LGVLAWa/1muetEVDyUUeCQWy33Cftm+GAsEthvd6NBZzuRBc
         Yz+yZmbFQEOA7kAlIWE6AJ7n/RwPPmKbMoi2lT8BLzDQpkoyS3ZUpArh0niHhYqGN4tK
         9w3A==
X-Gm-Message-State: AFqh2kpKOeXnWMe7+p5pt99iSzceJC/x46q7FAfobGnqpgCQZ5K4Wv2G
        TLyy07/o3JFEZiqUBQb1XYM=
X-Google-Smtp-Source: AMrXdXsJ4ohmvdD7FijMII+Vw9E9gE8ywaI/mpE4VyVrcjBT09p8NWowIvChovjOyfG7kSpMrwN1UQ==
X-Received: by 2002:a05:600c:4191:b0:3d7:9ae7:e4f2 with SMTP id p17-20020a05600c419100b003d79ae7e4f2mr12756529wmh.35.1672038534893;
        Sun, 25 Dec 2022 23:08:54 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e16-20020a05600c4e5000b003c21ba7d7d6sm13191456wmq.44.2022.12.25.23.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 23:08:54 -0800 (PST)
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
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v2 0/4] update mlock to use folios
Date:   Mon, 26 Dec 2022 07:08:43 +0000
Message-Id: <cover.1672038314.git.lstoakes@gmail.com>
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

Lorenzo Stoakes (4):
  mm: pagevec: add folio_batch_reinit()
  mm: mlock: use folios and a folio batch internally
  mm: mlock: update the interface to use folios
  Documentation/mm: Update references to __m[un]lock_page() to *_folio()

 Documentation/mm/unevictable-lru.rst |  12 +-
 include/linux/pagevec.h              |   5 +
 mm/internal.h                        |  26 ++-
 mm/mlock.c                           | 266 +++++++++++++--------------
 mm/swap.c                            |   2 +-
 5 files changed, 161 insertions(+), 150 deletions(-)

--
2.39.0
