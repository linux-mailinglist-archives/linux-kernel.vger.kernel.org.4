Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66E56943C9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBMLE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbjBMLER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:04:17 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33314691
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:04:14 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id bl9so4321572iob.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NYx2AyPU7S06WvalHgphXS88wTsCd0bUzbIYrlIqVZc=;
        b=j4ZA5Qa3HBuJDnuS3BIhYWxTSQ0G8BigeWlM/UGuXFspIEHa/EhA4sD2fdEK3SxEVO
         3CjQI6d+pShg6Ai0+dEDidMiB2gOdAUThhaULzgv26CNcZByKNJ6FlnbNi/vMRcBJUAA
         boECQ5jgiZghhC+otn3eCIkTTl7ROgQAnXTQFWxZD3mi0MHc5rFPyj4wdTvKAa6Pm5Ml
         1gMN4iXV5sE/I19Os9vulAX6dZM6Xj7H4Iz7rq/Rw57sOwBOEshJeE9EgkG+meRKHz84
         LEZhaEo3yvxRjrh/r1Ve5cQzBBRfn6AnFNmhpMY+WMJwIMR3LDbSrUexjnVg7yRXBU99
         kVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NYx2AyPU7S06WvalHgphXS88wTsCd0bUzbIYrlIqVZc=;
        b=3CATENgVzHCQSidSHhg7voV3nh+g9QQFOvWLboSJ6vqAkjIfgW2FpcYhcYvn16cFeR
         whlNNyc3aDlUa2GTIU1wLUa2OM7UShx4prK7V8Jo9NCXnx28ZOfBp/7rX9EE18cPSXXi
         aDcBZQk6yfwu/BnH1ThCxEvsK8ooYbdeJtOM4UjArkzzX+TnBlJrZFE3H9JZvNOcI0A6
         vceUqCSf0R5Afnht22HVsMbc/6g1hmDBlrAIJPkc0YsAbzvmiyP4Jn1jUVwnfYQ17ny/
         iVkWC+1rX5/3Ko4rFdZ6N9qusfnU59ylr7EQuQfHlMiqmGXJhJDF0QnPfAnv0W9fnFOO
         tzQw==
X-Gm-Message-State: AO0yUKW4rLZUX/zqffLYx+583EQ0mXD/P8pwYTNPPvejsCKG7z+pEFUA
        seO+bHBghoq2twoBV3y+2Bk4wyekQxEV9+RG4H8HIA==
X-Google-Smtp-Source: AK7set8Qh/DGdvxd4bpiG1wb/ltPuFD5pb3Sk4w8im377pG5vnagqX8FCB4QXIOQ6F2/ypfqFqOt4n5FPKT92cng2mk=
X-Received: by 2002:a02:a794:0:b0:3ad:3cae:6378 with SMTP id
 e20-20020a02a794000000b003ad3cae6378mr12249003jaj.16.1676286254268; Mon, 13
 Feb 2023 03:04:14 -0800 (PST)
MIME-Version: 1.0
References: <cover.1676063693.git.andreyknvl@google.com> <f80b02951364e6b40deda965b4003de0cd1a532d.1676063693.git.andreyknvl@google.com>
In-Reply-To: <f80b02951364e6b40deda965b4003de0cd1a532d.1676063693.git.andreyknvl@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 13 Feb 2023 12:03:35 +0100
Message-ID: <CAG_fn=VbGHm7WFqvauZ6-RnjUuk6pZQb0Ac61bKshQSRDujv6Q@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] lib/stackdepot: annotate depot_init_pool and depot_alloc_stack
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

On Fri, Feb 10, 2023 at 10:18 PM <andrey.konovalov@linux.dev> wrote:
>
> From: Andrey Konovalov <andreyknvl@google.com>
>
> Clean up the exisiting comments and add new ones to depot_init_pool and
> depot_alloc_stack.
>
> As a part of the clean-up, remove mentions of which variable is accessed
> by smp_store_release and smp_load_acquire: it is clear as is from the
> code.
>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

Thanks for the cleanup!
