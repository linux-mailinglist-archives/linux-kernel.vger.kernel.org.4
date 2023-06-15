Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B888731645
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 13:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbjFOLQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 07:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240927AbjFOLQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 07:16:23 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3629D272E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:15:54 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-543b599054dso508495a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 04:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686827753; x=1689419753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9lHDb9N6AqLDS19hviwF7XoFhOr7rPI5scCdJmAq+lg=;
        b=BOo6oN5VI0ErhAlYi4Wi4Au8oJLOfHtJAP4VzkFXvxWVq3kZjhMEjOLw/Q/AuGWfMz
         uROdcb+6SeZx19Jl7KzgN3dvjklrs9JF7rvZdrt6hwMSVmRxVg/M6OER1Bt/Lm4P/uxl
         BFGBupBB/QyRXPmAkxKmccacnEC7gZTIZiVqbuQn4mpZDDCMrUbPcZrv8gQAFpSefMju
         yeR57yuVKPTof1euT2nyDiMZ92nwNyOiIIci45MY+QlHSiK3B5VxjIXrhg1Kp9mz1MR5
         Gnqdr9G1xwlJmQRXdya0kMabA9Zz55PaFgDhuqda/awAcxpGdl7+Pa3rlkL6e+tCUtrN
         7zWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686827753; x=1689419753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9lHDb9N6AqLDS19hviwF7XoFhOr7rPI5scCdJmAq+lg=;
        b=OPRC9BsmKVgNZFRmFF8H9FFWv3WeR2x1rIf7isJKfayQPrYSz289Ek9QDiLhigmNTl
         WXHR1zzltr8n4lAdlduV1PIgnCqwat9Lqgpz9BtwDnZe1bfjoJ+KGHPoZ7ivbuhQvy1X
         /0KQvspjjXRhjf4+dmRUccQ0gyjHOpfCZJnDzqaBR8qtI37rL8AvAFPcsE1gKMWMdG1O
         ZYjoNeJc5ofvzA1eMaxKQb4b1jOgxzow0Snr1nLtg2nzLJJVIbpsLViEhR0ROxGNF8yM
         Y7UTl2KT+lzo6IC/G/iEZvU6Agva9qy+DMJrR2vlGI0iUy5DvfJlZ4YK0nGbhTRID2V+
         IFkw==
X-Gm-Message-State: AC+VfDxXdfsfZDDt08Ye0Nd9h84dyITS99Qyg5X+kTO5XyCjNbC43FJG
        TncDcGJD5oCQIVyOr2EKoIRUCcXLyxLbOCPxZ1RIswb7a0oNCnFMVEw=
X-Google-Smtp-Source: ACHHUZ4hjQuX78MVw9gdpGr7KgKHa7DkozWlw4hgtDHwWzBo8RjjRow2Kv8LIsqJH2Q+0k94Mh+kfdHR1kiwsMXvxRs=
X-Received: by 2002:a17:90a:400c:b0:25b:e25e:9bd7 with SMTP id
 u12-20020a17090a400c00b0025be25e9bd7mr5802625pjc.1.1686827753629; Thu, 15 Jun
 2023 04:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com> <d9b22eaa-00a1-6c5c-99a0-126b085f7cb0@redhat.com>
In-Reply-To: <d9b22eaa-00a1-6c5c-99a0-126b085f7cb0@redhat.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Thu, 15 Jun 2023 19:15:41 +0800
Message-ID: <CACSyD1NxcYn_Uy2DUk1ywSyWsxFzq4H+poaWvF55SZZz5W-uRw@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     David Hildenbrand <david@redhat.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 5:27=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> Interesting. When looking at possible ways to achieve that in a clean
> way, my understanding was that the page might not always be accounted to
> a memcg (e.g., simply some buffer?). Besides the swap->zram case I was
> thinking about other fs->zram case, or just a straight read/write to the
> zram device.
>
> The easiest way to see where that goes wrong I think is
> zram_bvec_write_partial(), where we simply allocate a temporary page.
>
> Either I am missing something important, or this only works in some
> special cases.
>
> I came to the conclusion that the only reasonable way is to assign a
> complete zram device to a single cgroup and have all memory accounted to
> that cgroup. Does also not solve all use cases (especially the
> swap->zram case that might be better offjust using zswap?) but at least
> the memory gets accounted in a more predictable way.
>
> Happy to learn more.
>
> --
> Cheers,
>
> David / dhildenb
>

Hi david, thanks for your reply. This should be my mistake, I didn't
describe the
problem clearly.

The reason for the problem is not the temporary page allocated at the begin=
ning
of zram_bvec_write_partial() and released at the end,but the compressed mem=
ory
allocated by zs_malloc() in zram_write_page().

So, it may not meet the need to  assign a complete zram device to a
single cgroup.
we need to charge the compressed memory to the original page's memory cgrou=
p,
which is not charged so far.
