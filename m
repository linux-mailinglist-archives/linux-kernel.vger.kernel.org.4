Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE26672D3AD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237100AbjFLV6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjFLV6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:58:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA551E41
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:58:10 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-54fb1bbc3f2so357801a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686607090; x=1689199090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/5eEw1L+15ry6U4Pjjiy2xa5UbjIi1vlwGFKCgVY01g=;
        b=od+5GOwqnjdySkprgJDd461UY1jYfkrNx5K228+Gm0JYXuxu5dRXnEhs2uqKBoau/P
         Cnq+b3yUVsuK6WbjZ+UEbxhf59qXkV1gnRojP5Sxt0PGau7jRFUHXQTSVYW8vvPoeRZM
         oqzbZfL/e+WKNREciEdqjHl36r3nMByViRTDVUBp07MvCTa486Fm3u6uzTW761CeAryj
         GBf6ClEl2/kHdm16qbSqlp+h22aXjW7d5wqaWtSwRmb8ZNP+kplXWdEdKO1pXRmMNsLG
         UqXHaMUXNTu7gF8XPb71bC7cKl849Swbo69Mz7bZEUffE5TJe8ozck/4nZdv974RQAYA
         1UXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686607090; x=1689199090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/5eEw1L+15ry6U4Pjjiy2xa5UbjIi1vlwGFKCgVY01g=;
        b=J7IjEVzi9Kd+brMR/tTnElgoqUCTOJ/sdm0x903an4TOY1cI7ngE8GQxtQ1gIrXjvD
         g3pK+23VvWm539rP71VsbKLT0KuRvrFHfhxDTT375Fvvg/4/MWVEEiCFZaNgB76hHH5N
         RhtfmtkS9+Os4j0e7J4eU5nDK8uhjLcoy55ksiKKRZga/8+OwdhkQnxgmgPZaE5Dcwge
         GRXJjA1d85nEVQ+LsWYgAIboXue4lQR6Qf3P7Q4CUoXxfD0yR0wwE3vhkieVUtNK9o1w
         B8HY71YxyDBBzC+WquOsvLSSjiNPgiv5bsqeNSnF8o4mqcy/zsyTY5b5QRxRFx+ILaO9
         gkSQ==
X-Gm-Message-State: AC+VfDwW/eSCqymUOzIpiqRgsbqoOc5auZXMcDqGD59Mn6Gow1Egkdvo
        O9rR5nUjuXA6nQUkd4f8M1FxImCqXVtTr1GM7jE=
X-Google-Smtp-Source: ACHHUZ79QtDxan/84RbUmRYJUrtnUMHFsswon5Y2H4Adu7u5YDjKAIXJ7GM6bZX6u/HGGeikemCFg5ReKX41QDldP+k=
X-Received: by 2002:a17:90a:1a05:b0:255:8fd0:fbf4 with SMTP id
 5-20020a17090a1a0500b002558fd0fbf4mr9578415pjk.5.1686607090068; Mon, 12 Jun
 2023 14:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230610034114.981861-1-linmiaohe@huawei.com>
In-Reply-To: <20230610034114.981861-1-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 12 Jun 2023 14:57:58 -0700
Message-ID: <CAHbLzkpnkZwmbigEp19dH+Q1tH_VWs6fuivKY=nNY7aUmTfEsg@mail.gmail.com>
Subject: Re: [PATCH] memory tier: remove unneeded !IS_ENABLED(CONFIG_MIGRATION)
 check
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 9, 2023 at 8:41=E2=80=AFPM Miaohe Lin <linmiaohe@huawei.com> wr=
ote:
>
> establish_demotion_targets() is defined while CONFIG_MIGRATION is
> enabled. There's no need to check it again.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/memory-tiers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index dd04f0ce5277..a516e303e304 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -366,7 +366,7 @@ static void establish_demotion_targets(void)
>
>         lockdep_assert_held_once(&memory_tier_lock);
>
> -       if (!node_demotion || !IS_ENABLED(CONFIG_MIGRATION))
> +       if (!node_demotion)
>                 return;
>
>         disable_all_demotion_targets();
> --
> 2.27.0
>
>
