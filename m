Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8AA6CA210
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjC0LFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbjC0LFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:05:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417974214
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:05:46 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id q7-20020a05600c46c700b003ef6e809574so1685655wmo.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679915144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ehsWNKlF0rOfJEhYzl+s3Qt/MT/o/tgkdKM9etceMxA=;
        b=b/cIc4MbvLRHtWGN8L21g5I7bfjRqRPmXfvJ5KTWHCnLw8UXIlmBZHx74R2EuC41SX
         BU5/k7qgGe6KTX+mOQSZgmSUY8qN3XV/kOsgbfhCnkjwOTv8O/s6iis7WFXDksbsOThe
         NpwlLU3jAYgz9qCzwNT0MyJwDc2VzbNbi2EyxZZsgCbYg2dzWwEG7H/2BtafYrWZWUir
         /9L60TnHoUgdSiwNcoZrgLf2VSMmuldh0VgSII5pck847xYccV2a5EC2mviciUa9U2NR
         pmYtCfK4qoINZoy1IbtKBZo/d67bkov1ndzKao8Qv3edhm1vAn5DwIpxLLTioKG/q9IH
         E8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679915144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ehsWNKlF0rOfJEhYzl+s3Qt/MT/o/tgkdKM9etceMxA=;
        b=dGoOEB0Vb29ez60wbYfEp6TuERB4rAGFGmpUjgMccuLVp9qk49B79QTFVi01WVHLFQ
         nZoh4LhZDuNAEVE+Qk+ZZnG+iH18A0W+mzYHTqWWe6gqqzu9uZWSTEZL5rtAPmmEQDc2
         csfing1RIy6lOeatVQStrroHJdGVPzwhj3cBuFmB5R2zHEgxhq8yYw0EFoPn6qWcvpm1
         Qk9xP5uBeXTrAJt0GMrkmJ7Oj4dk/0328T3d9RkTdRuCEb2pEIZ/r244s5f7Cdz0Aesk
         yrkSL+IBGgLj1YuRlZOXfnOw9ILMKE3v60UFBNHdIcNejPYsEbRk5VEo800YSXx75nnV
         XePg==
X-Gm-Message-State: AO0yUKV+ggoa1jVgwIU3EQ9mjZ49Mn7I2LvXYFmrbBT4kOxAg4hyMK8d
        VBRBhoh1QG2ajXkiWeC1lO1js1WdGZAvbwjopqbwLw==
X-Google-Smtp-Source: AK7set8A0Txc1zlj45/dH5R295Jf5SnDiewPZOSCHPNeQ+47JZZhHBFGkkabaqFtS4EbNLIYmqVtZmN7+bFxB6wTMiU=
X-Received: by 2002:a7b:c3c7:0:b0:3ed:fddf:b771 with SMTP id
 t7-20020a7bc3c7000000b003edfddfb771mr8982017wmj.12.1679915144600; Mon, 27 Mar
 2023 04:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230327034149.942-1-thunder.leizhen@huawei.com>
In-Reply-To: <20230327034149.942-1-thunder.leizhen@huawei.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 27 Mar 2023 13:05:07 +0200
Message-ID: <CAG_fn=VeP9HbpwEY3wYCrb7cMaLbX7-VFxPdM9zN1dSQ09A8Mw@mail.gmail.com>
Subject: Re: [PATCH] kmsan: fix a stale comment in kmsan_save_stack_with_flags()
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 5:45=E2=80=AFAM Zhen Lei <thunder.leizhen@huawei.co=
m> wrote:
>
> After commit 446ec83805dd ("mm/page_alloc: use might_alloc()") and
> commit 84172f4bb752 ("mm/page_alloc: combine __alloc_pages and
> __alloc_pages_nodemask"), the comment is no longer accurate.
> Flag '__GFP_DIRECT_RECLAIM' is clear enough on its own, so remove the
> comment rather than update it.
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

>
>         nr_entries =3D stack_trace_save(entries, KMSAN_STACK_DEPTH, 0);
>
> -       /* Don't sleep (see might_sleep_if() in __alloc_pages_nodemask())=
. */
> +       /* Don't sleep. */

Thanks for spotting this!
