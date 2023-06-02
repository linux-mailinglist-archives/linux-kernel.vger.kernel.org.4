Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9B072078E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 18:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbjFBQ31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 12:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbjFBQ3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 12:29:24 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB0E1B1
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 09:29:22 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-33b398f2ab8so455ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685723361; x=1688315361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKBnoInz/hfKHAqZ0MziJwHfuM/u8WifJkdwiN8lH9c=;
        b=0dNapuj8fWuUrD05bvEuF/gQ9lzGpB/ebGiP3J8LGlV8M4twC1jeLAbcUYcoWGvx7S
         x4aGFL8zcJGqctUbBP6A0cqSxaH2NMN3uJ4d0wp/hOhkI0Tpca3LmSDAxW03IPfsaw4n
         a/J/xX4oBoF4gKt4jfdQHqS7jugAEk7IfxMPMNHxbeEfJosUtQNZDgPKZFIh9xIstDqI
         I1cy+vVbuUruH1Q17PRL7QReEqzaBggUOrFBe049n4OemV5eVd06t580FfSaadkBHfO3
         TftUHH5G0XSkWCCeQu+4QAz4PMmIQenCd7BcLFY10MS09IEW/ZSr3wIHFUW7FYi4ihFq
         OV5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685723361; x=1688315361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKBnoInz/hfKHAqZ0MziJwHfuM/u8WifJkdwiN8lH9c=;
        b=ZZZ/8YhWpqNpOrW7xSbxiiZebsO1QSOM2pbQo6LTyDUjRbNNhVFyl/Tr+g+hrAAN4M
         hgUGlj34fEXJJVvfblxeyyC/v6PzI1Srk5yTbvb8GCkGrFqqnOGDSE52Qi/530LNCGZ3
         /3cQ78Z1VRY6tXAZ8EBRE9BaTclRYdx5rz/Re56KMwBjVYaT5m7LFO4dpSthypdYoUkM
         MxJmwloaLri6crusEeED/uNP52zxXOiAYkmDs2a69S7sZEF8NhT2M0p4/bguuPO+oVQU
         ni/rn9oNPP1S1g3dJN/YIFVj0sc3XdFsiGYTk8Yd5ShK5z3NTsWBmWun6f6OY5cz3S2I
         W0Jg==
X-Gm-Message-State: AC+VfDzsH6FHMhipBLz0jhdHoIRf0OZG7iZVUfUJdR+SEWOwVcLKWb87
        3KlOdlTFB48+P4kTm3NWK02Txjf60oXPXYrFYuFtNQ==
X-Google-Smtp-Source: ACHHUZ7jmnT73huHmz9iN2tJAXJ8lyMfWvYoZhcBOrk6VnndDcSYSwNNGdjjayNalzZvjJ6g/Hkq/HRlJnfE7n6KHes=
X-Received: by 2002:a92:c543:0:b0:33a:e716:a768 with SMTP id
 a3-20020a92c543000000b0033ae716a768mr204439ilj.22.1685723361223; Fri, 02 Jun
 2023 09:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230602092949.545577-1-ryan.roberts@arm.com> <20230602092949.545577-4-ryan.roberts@arm.com>
In-Reply-To: <20230602092949.545577-4-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 2 Jun 2023 10:28:45 -0600
Message-ID: <CAOUHufZa7hzqC6tJMX1gm4kWmjB03f7qGhXUq1OLqfDQ789P5Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm/damon/ops-common: Refactor to use {pte|pmd}p_clear_young_notify()
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Uladzislau Rezki <urezki@gmail.com>, Zi Yan <ziy@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, damon@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 3:30=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> With the fix in place to atomically test and clear young on ptes and
> pmds, simplify the code to handle the clearing for both the primary mmu
> and the mmu notifier with a single API call.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Yu Zhao <yuzhao@google.com>
