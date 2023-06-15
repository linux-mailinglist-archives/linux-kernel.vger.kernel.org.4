Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A871730E75
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 07:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbjFOE77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 00:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243103AbjFOE7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 00:59:53 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0BF2103
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 21:59:52 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f9b7de94e7so144621cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 21:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686805192; x=1689397192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KnSTeR3wugqfczOIo0WVbaWFbXtLzRyoPYMenUB46Z0=;
        b=5OjI0opU3eK26QBayVjzyad7e3zQbSFETTyJ8gesBTqvWCouRMUcqWOb9hmlwB+hG0
         jPD7ZGihijI+AMvu2gP/fe4g8lh9DmonCbi3qwKm5UcLUr3Dqfcql5moAMOE1wOnwoUp
         1ZfcdmgLaTxjmfJLtWw5tTnxnoaucjOpBn7IYXpAFZJCcvzeSMqml0lU24fuEw8vQpo4
         onBXPGIhtGvDWiO8MOG4bS/THLU+e95uzJzS6/vSVhO1kC2VW/C3XPYI8hSog6QBs92G
         ySMbz8dV7JjQ6FA9WfPtZD8tukhSP7pWK9TtFy8wf/9xwsegh9hbvrnh/cAIe6h+TlOV
         8wcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686805192; x=1689397192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KnSTeR3wugqfczOIo0WVbaWFbXtLzRyoPYMenUB46Z0=;
        b=B1amoG/XBH0tT7dFV+Jjr5/UEROJzTUaq2V/HI5Ad4M8SeL8ddMKO19MEvKb0ltdvp
         th6D/5F1FEr66PwZRVG/mz2DZ3zE/acg1/1HLUUapjqo0K+73kasOaTHM0uzDP9POE0v
         ysmH/jTy7HvlP3GKtyMNEVjwBsVfDdru/99hjAjWANXRfZRC8KPSUMArfTAcsdcBbCI5
         atyBvC0dZz3bMTI/ZC/P4PvElzsEjmS6tRrzUJiAor28cHHJ2wQi5w2I6BOMy4higmV2
         Fe3MisNP7W+YOh8lZbuyB+yCkFSiej+jafgRlYMWec2WOSfvw7rLHTvimiK8uzMaWQmW
         yv2g==
X-Gm-Message-State: AC+VfDzrvwZZRshA9O5Cxn5aCKJx0kJpt5P1Tv6FzNQTCM0zSexeEFWg
        +c1NcLUXT8w9eQKFmRsOH3eEgtMhz2rfP8gL3EK0Bg==
X-Google-Smtp-Source: ACHHUZ61RHaTwcXA7SxcW9tOHyDHq6/O4mrfOyD00XOAdsiYes1CNQm70NgDMAabZum3DNA7kXrc7QvcZ6/LvcwY3OU=
X-Received: by 2002:ac8:7f8c:0:b0:3f8:6685:c944 with SMTP id
 z12-20020ac87f8c000000b003f86685c944mr80467qtj.14.1686805191933; Wed, 14 Jun
 2023 21:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
In-Reply-To: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Wed, 14 Jun 2023 22:59:15 -0600
Message-ID: <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] zram: charge the compressed RAM to the page's memcgroup
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Fabian Deutsch <fdeutsch@redhat.com>
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

On Wed, Jun 14, 2023 at 9:48=E2=80=AFPM Zhongkun He
<hezhongkun.hzk@bytedance.com> wrote:
>
> The compressed RAM is currently charged to kernel, not to
> any memory cgroup, which is not satisfy our usage scenario.
> if the memory of a task is limited by memcgroup, it will
> swap out the memory to zram swap device when the memory
> is insufficient. In that case, the memory limit will have
> no effect.
>
> So, it should makes sense to charge the compressed RAM to
> the page's memory cgroup.

We used to do this a long time ago, but we had per-memcg swapfiles [1[
to prevent compressed pages from different memcgs from sharing the
same zspage.

Does this patchset alone suffer from the same problem, i.e., memcgs
sharing zspages?

[1] https://lwn.net/Articles/592923/
