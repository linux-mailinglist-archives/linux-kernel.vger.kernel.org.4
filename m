Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5076560A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 08:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiLZHJD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 02:09:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiLZHI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 02:08:58 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAE521AA
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 23:08:57 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso572872wms.5
        for <linux-kernel@vger.kernel.org>; Sun, 25 Dec 2022 23:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF0czWG0z2T4oq6TY2ZkLRE6dWmClGYr0kuRjGhgjlc=;
        b=fpdkSJF/JqUlKexT21mW8e+jSTKUNfkGzMkXrfOfL8HIFYx/Vq1hHyPBMjknJ2WtBK
         WrIcuPAHPepaz2AHevrqxKaipS445kAnZPURMVNYZHTNkuacttJ2UiXq3RvY2/Gt3Lyw
         bqgPnNwcChpmNMyk0XKDnTB16KN6xSc6zms8dljaclOqZVhCPVDsbRisayFao3u42G9V
         OVqutqKiT99JxTmxQaPT1PaWfI6Tg/hRRf1UYwL+F4dLe7ZBRYtVxulB8bGPlDUuIKMM
         0qftQCz9/GBw2P5y4J4/TvoPqdAqIMJXl1s/DMbHk6YaN5YZ3Q30KzMr41ELzyYZuCpf
         K/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF0czWG0z2T4oq6TY2ZkLRE6dWmClGYr0kuRjGhgjlc=;
        b=jgFty1oqyu8+59JkD3q8VsvPnKX0tD7Q5W7vXf4lDGCIhKX8r+zAsLrli+teQnqZAO
         s1I8tKgP9ddZfC/A3f6vqtkYeCCJYM9gTiqduyNZgUisS+FvY71d9tqlAmRbIuLu30gH
         EXHokd5pUw9lnm0AxANlET9Kd2iha6H49EIydYe1qtpFiUfVMkuv7XprVHOo/QYf3CPe
         Rp0/+avJw9+r41fDgbByCbU4z8yTcHwzBfZtfrgV5PSmA9XJfm5S3Iz/ArcqoDFk01gu
         8h/TWUxipS2eRP4pbuoaYQyDZfEjAlpmo8PYAY5tt0ddcgOgSJPYmA6yrftHzWQFSDUC
         l7lQ==
X-Gm-Message-State: AFqh2kqM0YDNKnH5fpcpVzFI4c/zfCrvvwBLFnuFwvkCRNTUKoHRvcK/
        XUQ7lQpNeRyN5loxu5gXB4w=
X-Google-Smtp-Source: AMrXdXsSiUJBjB/FhDmSCuSkDKJgGEs8hWcATc7EdSFhVVbhZyX7hNNQ4+aMSZDrUlPWscxg5IgwEg==
X-Received: by 2002:a05:600c:3589:b0:3d0:6c60:b4d1 with SMTP id p9-20020a05600c358900b003d06c60b4d1mr14506892wmq.6.1672038536088;
        Sun, 25 Dec 2022 23:08:56 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id e16-20020a05600c4e5000b003c21ba7d7d6sm13191456wmq.44.2022.12.25.23.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 23:08:55 -0800 (PST)
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
Subject: [PATCH v2 1/4] mm: pagevec: add folio_batch_reinit()
Date:   Mon, 26 Dec 2022 07:08:44 +0000
Message-Id: <b75d577d0994229f142bcca8ff330c4c587389dd.1672038314.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1672038314.git.lstoakes@gmail.com>
References: <cover.1672038314.git.lstoakes@gmail.com>
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

This performs the same task as pagevec_reinit(), only modifying a folio
batch rather than a pagevec.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/pagevec.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 215eb6c3bdc9..2a6f61a0c10a 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -103,6 +103,11 @@ static inline void folio_batch_init(struct folio_batch *fbatch)
 	fbatch->percpu_pvec_drained = false;
 }
 
+static inline void folio_batch_reinit(struct folio_batch *fbatch)
+{
+	fbatch->nr = 0;
+}
+
 static inline unsigned int folio_batch_count(struct folio_batch *fbatch)
 {
 	return fbatch->nr;
-- 
2.39.0

