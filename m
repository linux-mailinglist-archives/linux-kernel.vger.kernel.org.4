Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F1D5B7D18
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 00:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiIMWbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 18:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiIMWbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 18:31:09 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4C761111
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:31:04 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q9so3503277pgq.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=t2Q9w3JUYdWVYE8i7yIKCVCQoxRVkYxv3+zuzR+3R4k=;
        b=bUuKMnuCiSUWwwU8rNuIjMU0LRTgjgntVnFdOWsxbjCeDn+EcRNepT6WjT2lp+2Nyb
         gKuwPFctibylIkt6QnSr+5GThNKc/myfmZMC19zMlkIJV4ykS+1YpesI7tEbMu5ZlaQt
         HxkJDZt8OuCwKCkrPgGUnw319ujOsxdl/dAYQg2t4T/BEBmemqYrdAquhRjVOYNoMpqv
         SFe+8BminF9p3VG4D1tRo64oqjV5MObUswJCKq1fZtxpGTq0UuXzk2IL7kd4Cfke31+G
         Ii+wqGgpoDbiRj1/r8hnBbNaOupH7yYgSCMTMGGD1THNioq6eJ9/KoVnRZu7A2fdCc28
         Pf3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=t2Q9w3JUYdWVYE8i7yIKCVCQoxRVkYxv3+zuzR+3R4k=;
        b=TzWxNcFM4ZRQpw57h1FR8YtJmmBl3SboqugoWH0luABb5GdpoQexNprG5ES3YfspKq
         ahTEWPsdBVRE402wQB3pA3rncaWdB1X3a0Oh0+p5f629gXk3An09OL8hjZG7aYRTVf6Y
         B1hJ2BeiOl5WyCSpLhCHjwYLIyDie5jhI2Za39fYhWlBS4jvl+vOUKPO+I7NIoMHQv86
         ZIdaPCbqdTCKyYc88yslHhKoaJNVe8IjyLG09vj4V0B5lY1mnEnFeUsK54XTsrhXLYmf
         OD1Rr74OVnvj0fMT6ZnZEaJqszo26iNQd6FewG289sQaKkKQ9ISDfKehCkNIsJBa34Xl
         +DQg==
X-Gm-Message-State: ACgBeo091xid7CvtqIBDpt3urnSSsVEoIatAFBtwkwa4+zmJ1Fr75xNr
        0EIx0KlBheknxroabCMFUvzqvNRpptzRVDGg4XcShw==
X-Google-Smtp-Source: AA6agR5ZgUCizkeUDu4rS2h4s/T8Z1OGQrw6I+5Nd0UfywFDe+Y5Kd0wCw4irGfTnINQoS7iHOcpNAMZWxJXA7pDGDc=
X-Received: by 2002:a63:7984:0:b0:439:57e4:97a2 with SMTP id
 u126-20020a637984000000b0043957e497a2mr2538999pgc.191.1663108264083; Tue, 13
 Sep 2022 15:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <1663058433-14089-1-git-send-email-wangyufen@huawei.com>
In-Reply-To: <1663058433-14089-1-git-send-email-wangyufen@huawei.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 13 Sep 2022 15:30:53 -0700
Message-ID: <CAKH8qBsoc8Upz=NvOtD=SOfVPcEnW-2wghbM1zYBacBwmGNvAQ@mail.gmail.com>
Subject: Re: [bpf-next v2] bpf: use kvmemdup_bpfptr helper
To:     Wang Yufen <wangyufen@huawei.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 1:29 AM Wang Yufen <wangyufen@huawei.com> wrote:
>
> Use kvmemdup_bpfptr helper instead of open-coding to
> simplify the code.
>
> Signed-off-by: Wang Yufen <wangyufen@huawei.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  kernel/bpf/syscall.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 4fb08c4..f862406 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1416,19 +1416,14 @@ static int map_update_elem(union bpf_attr *attr, bpfptr_t uattr)
>         }
>
>         value_size = bpf_map_value_size(map);
> -
> -       err = -ENOMEM;
> -       value = kvmalloc(value_size, GFP_USER | __GFP_NOWARN);
> -       if (!value)
> +       value = kvmemdup_bpfptr(uvalue, value_size);
> +       if (IS_ERR(value)) {
> +               err = PTR_ERR(value);
>                 goto free_key;
> -
> -       err = -EFAULT;
> -       if (copy_from_bpfptr(value, uvalue, value_size) != 0)
> -               goto free_value;
> +       }
>
>         err = bpf_map_update_value(map, f, key, value, attr->flags);
>
> -free_value:
>         kvfree(value);
>  free_key:
>         kvfree(key);
> --
> 1.8.3.1
>
