Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80BF6546E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 20:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbiLVTs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 14:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiLVTss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 14:48:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1347018378
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:48:41 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id co23so2697576wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 11:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FtOA/G1DpjjrVMsZI4k2Vt28ANwPj2q63Muqqvyu2zA=;
        b=jyRHh+0uRVaab71ue7ES0wpumLeHKUwXW4PjtQUWE98J+2/wd09BkW1+41UAv3J91l
         Cn4ug5ObpzDr9pU+f5HaT2nLf4hHj7tcjo5D25lVixKDgfibIlTMR1VFrPAsIpGuwdNl
         qb0TGjOqnBtYz0KX3J6tdyidtI8R4Y7/zFuzOQ5XukhAGioiDUQtS0v16h56wDIU540B
         un2uxpOnmololAGHsH0NvBpmhNGKlQRdULhyLaZ70SvGav10GApOSrlPL39MX28AhOvi
         DMpTeWE3A/4aJ0N+79GnGw1uadvJFpgnH7trtwI+akOWKJ/B0hDyb5jjQMB25MBOlfjP
         kOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FtOA/G1DpjjrVMsZI4k2Vt28ANwPj2q63Muqqvyu2zA=;
        b=pfdzexlokP8EBfywFx+NzN1E3a7gdp56ck2rEw+Jx+0jDGF072pfruQyO8lWAzycnd
         CDNq1SM8kz0k+ISpm4jpcmpWm1+Cp+3be7bfqP3iO7grjwt8ndqK4nL4KbN+mbplJwHK
         9p2WMY+UHxwDuazQc3u3e6hJODf7pdwgwW3dqQuqZz1Q9zEv0v/NYyKi5twQVOxgMgHO
         kwNxDiCYEGRAtQc3CWFH5+PIzWVbIR4vuTyDz5b1JEbZNZSOu2D7zZWpwKIYqBJkEuXc
         MXUJAxG3wQJDMYAwhF2o3Ty+j0JGcIsAtDOjIP1ClZA3xRLJqHal0EYF8gR4smxBZbp6
         wkeg==
X-Gm-Message-State: AFqh2krcTXBWK15I0tTUywnvglA+IpJBsWSzeorfr5qz0/HcqWqyMm2I
        SM0E67+uJggPJ/oe3pPtgGY=
X-Google-Smtp-Source: AMrXdXtVDFnuywO3qY8gU1BLBO/McMKtUZpmNx9eFyAO4XUFYBVpOJMgY+iLji/tNZ/pHLnkONFQwQ==
X-Received: by 2002:adf:f74e:0:b0:22e:6227:34e4 with SMTP id z14-20020adff74e000000b0022e622734e4mr4619931wrp.0.1671738519675;
        Thu, 22 Dec 2022 11:48:39 -0800 (PST)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id i1-20020adfb641000000b002425787c5easm1349317wre.96.2022.12.22.11.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 11:48:38 -0800 (PST)
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
Subject: [PATCH 0/4] update mlock to use folios
Date:   Thu, 22 Dec 2022 19:48:29 +0000
Message-Id: <cover.1671738120.git.lstoakes@gmail.com>
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
