Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD3173143D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 11:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbjFOJmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 05:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239432AbjFOJmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 05:42:04 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 666E9106
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:42:03 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-543cc9541feso4232390a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 02:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686822123; x=1689414123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LhHgU0htfcEZegQLvMMbdN+7PkWoV2NblFl1xaYHhc=;
        b=DM8x4/O0ziIHI7SYSjKBV+43aQclHgBx14ooy2XuzhkLVd0H9Wutpds5L/ZZjc5Nus
         euBeh/yleX6DK+kHl9qvF6wUgtf2KjxR3g/xXEQcPeIbyJHQF0LdPg+9V3mzdRh4V85s
         F9XIFCIog5W9k6vRoqZf7yq79b/zxl5e452Zr0u4GB5Npxpdy6V0l2k5AYyMPe9Isp0/
         DUGvrBDoFJ7i6f3YAG9ERUlHsOWcOQNS7+6ujzZ+w/EurokFvpciI6hv7FnQJBMXf5m6
         gXG7zntjgTy246SHD0HnSz6iMe5fAGW57jn9Dv7EwvNTcArD3FIRMa94p1yYqEZJZJvq
         ombw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686822123; x=1689414123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LhHgU0htfcEZegQLvMMbdN+7PkWoV2NblFl1xaYHhc=;
        b=YcEH1/CSSmWRmN4Trzs3Nm6epjVlnY4aT5qovwYZMdLnAXxgjgJf5hiEiAAZV+M71v
         QTf7mYd7SYL5APzQ4GHpcYlUNWG3EPZ3EmmdIcUlQ61IyGUenrTXU3NiXPRVOZvvxwiq
         +CHIB+u0OEMJAhE12rlkCDxEgB3BByaigntV0+BRvIZEAUKeUL7+bDQkMf2++yEGNEh6
         ZFd3jxz6D6eS3E5bYffnXYHgaJppyu6LiMccvsqaExP9xxNo78/OaORzenHnwLrb8ibs
         kC8opyhqO0pwpr65icuoJH8cwDn7Wg6F4587dmF9ZU+t0u6T/q/e1bn2AddRzAwXUhhd
         pEIw==
X-Gm-Message-State: AC+VfDxf53dHkX0ko8i1WJYzJOjsMe/CFc62LhnrWzp/lAXh3Tieu/rk
        s32lfFyeMluBOHOJXEbicC+rpbWc595b9k7GZGZozA==
X-Google-Smtp-Source: ACHHUZ51pZEl0JQDEL1sW10nfK/FHBUaXHVMlhrla2T/tvh1xrT23yACaEzBf6HmbL7gYm99a/KUseHOGk+boST0cKg=
X-Received: by 2002:a17:90a:d804:b0:25d:eca9:1621 with SMTP id
 a4-20020a17090ad80400b0025deca91621mr3109787pjv.6.1686822122928; Thu, 15 Jun
 2023 02:42:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com> <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com>
In-Reply-To: <CAOUHufZBUEm1P7gm0nFkPSFkNg2fPbs3v3qhL-R9m5yFNoW2YA@mail.gmail.com>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Thu, 15 Jun 2023 17:41:51 +0800
Message-ID: <CACSyD1OFOz8F+2+mUxqLAMXx1p_Zv88iqrrDMd4kb9nYWE_FJA@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
To:     Yu Zhao <yuzhao@google.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Fabian Deutsch <fdeutsch@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 1:00=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Wed, Jun 14, 2023 at 9:48=E2=80=AFPM Zhongkun He
> <hezhongkun.hzk@bytedance.com> wrote:
> >
> > The compressed RAM is currently charged to kernel, not to
> > any memory cgroup, which is not satisfy our usage scenario.
> > if the memory of a task is limited by memcgroup, it will
> > swap out the memory to zram swap device when the memory
> > is insufficient. In that case, the memory limit will have
> > no effect.
> >
> > So, it should makes sense to charge the compressed RAM to
> > the page's memory cgroup.
>
> We used to do this a long time ago, but we had per-memcg swapfiles [1[
> to prevent compressed pages from different memcgs from sharing the
> same zspage.
>
> Does this patchset alone suffer from the same problem, i.e., memcgs
> sharing zspages?
>
> [1] https://lwn.net/Articles/592923/

Thanks for your reply. Yes, different memcgs may share the same zspages.
