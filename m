Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0EB67FE3C
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 11:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjA2Ki5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 05:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjA2Ki4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 05:38:56 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB51212AC
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:38:54 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id mf7so5665668ejc.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 02:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mo6UoLuPpvDAcVZW976qJnSrSh2b2XaKR2JsuYWWcL4=;
        b=VBP9p/zRwuDha3IzuQH8A7bXSeLC17Xa4ADKPQJn1iJMBsfrTIvmfEORI0aZMar0WJ
         2rfHtyiWuQT+JGnocEG7a6htEZbZA5jHDx/6CEYE85DEc1QuGPO2KMl0sBwLAMLL5eHB
         nGNctwUGsgMkp+KJvpvHrzKrmAE+vtXw34HNFLxjoAELxlxCxc4x3V70LpQu31HXXOl6
         TFfqkeiSw5t4BdQHyKSrF0uvtIyFoq1UI3R/RGWobquBIZM79AsyQbtSzEhTMTan975y
         AWRnnUGUeEQqaik2dmH4hwgoLdylljLRPmjoyhNKayJnq0v87W1wuvU3ge0l7UsLDOxh
         P7KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mo6UoLuPpvDAcVZW976qJnSrSh2b2XaKR2JsuYWWcL4=;
        b=HOPSIgOzjrIzt4sj00ttAbyoDfp4WGcEvF/aOnk2zaJK1NWQWPO31Ev30boN8aiovU
         cHp0hHYpq7GbMcAyVUlQ9WTVDCHbmrG/VArmQq8FCaSrivvJhkvCJuMJaaES4PBIFRVr
         GM1/6mEuHwWIsGIDMgHMglariUAcqyjLy3rEolK+0UWTWEgnZZLoDLviuJM5I9W5QEKb
         fFyPeLVUO0/uSECHiqArMtaedZheCWLVFjJW7w/7oBSF97+MzUhKOdoCGJ/L0oXDjtA6
         BHAP0DHm9TygQvIU0l+ebn9S4Tki/cZves0rFRm7lCExKe0BSeDKvo/TUD1DO1KWRQGj
         t1Kg==
X-Gm-Message-State: AO0yUKUYM1K6IaoQbKTvpcLA5HCE9oqN3W747ZBpOyf0G4u0h/qCft0B
        TPnOssBpgrAMFdPK2EahZJU=
X-Google-Smtp-Source: AK7set/ZDhGrbXITiEV9Ze5gR+OyP95/bqDkGPX1/gL+3O3hHd0CyFA2YXe06PogdszeMMJ9dYEvbw==
X-Received: by 2002:a17:906:d0c2:b0:878:5fdc:3850 with SMTP id bq2-20020a170906d0c200b008785fdc3850mr14561653ejb.48.1674988733394;
        Sun, 29 Jan 2023 02:38:53 -0800 (PST)
Received: from sakura.myxoz.lan (90-224-45-44-no2390.tbcn.telia.com. [90.224.45.44])
        by smtp.gmail.com with ESMTPSA id g25-20020a170906595900b00877ef618b35sm5182750ejr.145.2023.01.29.02.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 02:38:52 -0800 (PST)
Message-ID: <27176f7a24fb37e5f011c7fa451bec7ba324e668.camel@gmail.com>
Subject: Re: [PATCH resend] mm: memcg: fix NULL pointer in
 mem_cgroup_track_foreign_dirty_slowpath()
From:   mikoxyzzz@gmail.com
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ma Wupeng <mawupeng1@huawei.com>
Date:   Sun, 29 Jan 2023 11:38:51 +0100
In-Reply-To: <20230129040945.180629-1-wangkefeng.wang@huawei.com>
References: <20230129024451.121590-1-wangkefeng.wang@huawei.com>
         <20230129040945.180629-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.module_f37+15877+cf3308f9) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-01-29 at 12:09 +0800, Kefeng Wang wrote:
> As commit 18365225f044 ("hwpoison, memcg: forcibly uncharge LRU
> pages"),
> hwpoison will forcibly uncharg a LRU hwpoisoned page, the folio_memcg
> could be NULl, then, mem_cgroup_track_foreign_dirty_slowpath() could
> occurs a NULL pointer dereference, let's do not record the foreign
> writebacks for folio memcg is null in
> mem_cgroup_track_foreign_dirty()
> to fix it.
>=20
> Reported-by: Ma Wupeng <mawupeng1@huawei.com>
> Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty
> flushing")
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
> resend: correct function name
> =C2=A0include/linux/memcontrol.h | 5 ++++-
> =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index eb6e5b18e1ad..35478695cabf 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1688,10 +1688,13 @@ void
> mem_cgroup_track_foreign_dirty_slowpath(struct folio *folio,
> =C2=A0static inline void mem_cgroup_track_foreign_dirty(struct folio
> *folio,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 st=
ruct
> bdi_writeback *wb)
> =C2=A0{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mem_cgroup *memcg;
> +
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (mem_cgroup_disabled()=
)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(&folio_memcg(foli=
o)->css !=3D wb->memcg_css))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcg =3D folio_memcg(folio);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(memcg && &memcg->=
css !=3D wb->memcg_css))
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0mem_cgroup_track_foreign_dirty_slowpath(folio, wb);
> =C2=A0}
> =C2=A0

Might want to Cc linux-stable.
Tested-by: Miko Larsson <mikoxyzzz@gmail.com>

--
~miko
