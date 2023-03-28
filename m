Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31606CC616
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbjC1PWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbjC1PW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:22:29 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CF46FF1B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:20:52 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id r187so15528702ybr.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680016826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONZYLiGDk21RMFgMpaXH7s4UWxHkNsJ+wUGHRFEkuCc=;
        b=c8ynwXPsqcK1BZ6E1vrYfDJcqWTKC225pVcmZQQIcGa+4WzKkC/FwoXCPTIZP0uqNW
         jalQxGai5+TUgtreV4lGVmixYr6hAEF97bJP6udFm1yicUDr3KPFXDmLE2aJHchJhqAj
         7J4XebvBwK691HXXFYm5J21xAY8msOd5k/OOZSjNYpGC2QnLfu+09Jc4Pbhux+Hpz5l/
         35fyjYPGGFQ/WwDLWWO9LuBpYSShrGA9j+zLmlaXc44UkvAaGsRQX8zqrH4aOojgeFnH
         DBkes4tXkEWXNeFd/n9ARofjF5njrlz0PZjoz9j8BGF67LqPGhfa7EH16H69NZfFsNx5
         Xcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680016826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ONZYLiGDk21RMFgMpaXH7s4UWxHkNsJ+wUGHRFEkuCc=;
        b=Z04gITWSKym/WFPRlK3aTb2kx4pOBMbV7jD4H+AP/0cabuKKD1yUgWbLiMGOJhd6/o
         ualkmtz7pVrFANI7p4GTJM1FnZhNjFp0NRVhmZyXCNSlroV9Tt0tJ6jz2VUeXRjJcv8x
         0UaCvGvpxVRmgyjqxYmjZKcltKr/sCDTZhVAqI1wBe1Yx2KVj47atBnqD6vt4Ihxf8UX
         KrUAI7mRFZRzT6JyQqZzyyMEE/0P7nR9STWI6b7ey0N+hpfSHDV5hbbxHqpg22sE5uRq
         HwqqyJUwpv9GkRiga0Ndezh1cXBS0dFzrCdCCSc6By1IdmDbW9sRZPRdev+vlvqL/K7+
         3GJg==
X-Gm-Message-State: AAQBX9enkBRok2xy8h+DvEpZXzHqk2HQr6BVFgglGuGUJthFd6o3jPmL
        nohsXWULjNiIRVgBo9VcEcVaWpCIu9kTAVMqeXtWmQ==
X-Google-Smtp-Source: AKy350Z1lvsH1c3O1jHKo+DM2HBpLRhmt4Hwp7gRiZRJb5+27sNfylAL7/FK3qaRf4mMZ9UmJB/3uw0wBUSKxNqtrno=
X-Received: by 2002:a05:6902:154e:b0:b77:d2db:5f8f with SMTP id
 r14-20020a056902154e00b00b77d2db5f8fmr9838517ybu.12.1680016826025; Tue, 28
 Mar 2023 08:20:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230328061638.203420-1-yosryahmed@google.com> <20230328061638.203420-10-yosryahmed@google.com>
In-Reply-To: <20230328061638.203420-10-yosryahmed@google.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 28 Mar 2023 08:20:15 -0700
Message-ID: <CALvZod4boccrKxrCm9aDBCupror1zC0J3spHeidSiAZgei_r9Q@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] memcg: do not modify rstat tree for zero updates
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Tejun Heo <tj@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Vasily Averin <vasily.averin@linux.dev>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org
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

On Mon, Mar 27, 2023 at 11:17=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> In some situations, we may end up calling memcg_rstat_updated() with a
> value of 0, which means the stat was not actually updated. An example is
> if we fail to reclaim any pages in shrink_folio_list().
>
> Do not add the cgroup to the rstat updated tree in this case, to avoid
> unnecessarily flushing it.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
