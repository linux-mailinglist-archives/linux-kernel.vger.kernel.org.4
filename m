Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F65682A51
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 11:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbjAaKVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 05:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjAaKVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 05:21:10 -0500
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com [IPv6:2607:f8b0:4864:20::a32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FD21E9DF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:21:08 -0800 (PST)
Received: by mail-vk1-xa32.google.com with SMTP id l20so7111294vkm.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 02:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JccB23TS0/KWTmAaso9Rq5suOvDS6HlaZd7+/LF1Vkw=;
        b=kPzlMIjk1hn148XGLPYyLoo/c33fmO3machzfyEMLLC6AYuTlF/3rHyJqsHLaew3RC
         rKOZ7En6cxhBo1ETfCZ2h1PDtxGGnUYUGS4Bp8VKSqms4N83srTa0eq+S0uoIl5x4Aiq
         Idq4hcPXS+LD9AeAtOx2EWuWzBDeQYicw1d51crVIBtnAbtt3d9JuFud2MLjyUGgiI7O
         Tgvsv/j3AeNwC0YOvKrBLaiDE+FUTv3+zC1fDKx2KiXFWe2zZz3aREIoLhmpNNIx67zN
         tgacgWgHUwMVTIk+0p9mp+A6L0LNWoHSLepZyzQP56pdjgnpR29YLDJUFLlsWE5F3g8o
         RAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JccB23TS0/KWTmAaso9Rq5suOvDS6HlaZd7+/LF1Vkw=;
        b=AnBPgRleo8L61h8SZodmNhuwP6PHoOYE2mnf/fb+10fXTkwI0V5xrn/WsIdcEQdzcP
         ZZTs+yCmH95kKLhAmJA3NL7HvPJW1EwyvffZZkKyD0w+tuOP64uQR1SdahgoshbbTGp2
         q1OuvaFJRiesDa1QaLv8WXhhdlinX7+f7frArTc9M3cJAQy1JTIG5qN97Z0z7BeRUMRw
         phZTeHSsvEu62viL//N7McdssqOfpv1PUP1sToDoAs9kFbRSlKBxa6tsXHscalXBSAVz
         1WkD1lhi8k2/448g0hxW5ZbmF75Qt9Xoqh27Ym32FZSd+rjfkzxYt5Bk0pZKnBgTNYt9
         zTsw==
X-Gm-Message-State: AO0yUKUlUQeYlu0p7bwYZ/NIubfSWHSPWBgHcrqhM6UONxHg36cByopX
        scf3NaTMeEBnUsIlzOA9QAOhyRMUWJ3sPMaDux2Ptg==
X-Google-Smtp-Source: AK7set/dLpJNgzL9xXAJBfuyOSZj0MVUxK8kDY+ZIgX2NTS+3vDslis5aE4+oLKIsG3RRa0YnZr2ZJcm86bKrsu0guo=
X-Received: by 2002:a05:6122:2498:b0:3e8:a035:4860 with SMTP id
 by24-20020a056122249800b003e8a0354860mr2503258vkb.7.1675160467019; Tue, 31
 Jan 2023 02:21:07 -0800 (PST)
MIME-Version: 1.0
References: <cover.1675111415.git.andreyknvl@google.com> <632393332c364171c69b7c054b3b2233acbfa996.1675111415.git.andreyknvl@google.com>
In-Reply-To: <632393332c364171c69b7c054b3b2233acbfa996.1675111415.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 11:20:30 +0100
Message-ID: <CAG_fn=XJBf3JCwwpc+ykMt2KqyA=rfw_AMU7yW67KGc-UicC-Q@mail.gmail.com>
Subject: Re: [PATCH 02/18] lib/stackdepot: put functions in logical order
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 9:49 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Put stack depot functions' declarations and definitions in a more logical
> order:
>
> 1. Functions that save stack traces into stack depot.
> 2. Functions that fetch and print stack traces.
> 3. stack_depot_get_extra_bits that operates on stack depot handles
>    and does not interact with the stack depot storage.
>
> No functional changes.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
