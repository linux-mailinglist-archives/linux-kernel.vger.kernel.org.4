Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D351D698D87
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:01:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjBPHBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:01:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBPHBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:01:40 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F90CDE9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:01:39 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id gs13so293471ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 23:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DyK7iJx8J6FEmEVQUzEANSgyA5JGTxNtNfBjhWHxRQA=;
        b=XzSqmmZrftYp9T+u9YShuR5nZTnfD4iuTGrh4fXPaTYH18HXnOTflWtyUhZqcNKq84
         cBvAuAE4Eu3BTrT+MD/eckBmSf6WbCOxRJ28wJ2vGB/xJzu0iJDnqQA75ZWEfQgd06y+
         mnN6BAgC9kz3bVEIvEYKGBjOKOxzReVftE2u6q8hTW013WKFasQrbq89TjQuqe/Dnohg
         DOCR7yaPEdW6Qjhy/xDN4gKhghhkKMUaPupcKOT1v6CMyjaSyAekBwJ9QWTqY4D/fVrH
         wTB0mFqr29CaAzDPV9nwbnROuFLyv+GKe/D3O+fyVhZ6bLXAqSiR3PiS7fE1ArbwgMYK
         +Kjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyK7iJx8J6FEmEVQUzEANSgyA5JGTxNtNfBjhWHxRQA=;
        b=FFnbB5S6V5/1FW5piuAWS3hR+eCc4MM+yeVyx8a9DnYOmP9wes9mjwt+9oMDSyWKRK
         AqdzWFjpFBA4Id66Kufi3JRZR8KJdCdUhEQzrrBfqqeGlBHAOGai/rK5JwZmj7wxUu3p
         OlhbHZImPDF7FTPWBijNbJE4gHG3g2HFJdsOhQ0LIettoKojxolkR97ZUey8QKwH7DLp
         73It7LqqVbha1AoY8wXiKEltYXDL6la61xEVOWEQPSIVFQv3lEQem10raiCIx8w1Fr2S
         76jMhgr936vHJZYqHcanLSAnL2ENXMTS4UxuViEj/V+6N2DDtLwI34MrywZIJgRbgo9T
         Zu2Q==
X-Gm-Message-State: AO0yUKWIHfsPA1Dv1zhbWJU3GV4lRV8OsrfGgU2xRDmmOqRLS6SG5qi6
        wwIA9W3oCLyBxP/Ta/oeJXc=
X-Google-Smtp-Source: AK7set+mqaTDfU9RIA4qnmexEtHbH+213JmKJf2bZyFft7p1mZA5i1nytm832ECd3WjAMv9wyFyinQ==
X-Received: by 2002:a17:906:9e22:b0:879:2a5:dc40 with SMTP id fp34-20020a1709069e2200b0087902a5dc40mr4567522ejc.76.1676530897763;
        Wed, 15 Feb 2023 23:01:37 -0800 (PST)
Received: from sakura.myxoz.lan (81-230-97-204-no2390.tbcn.telia.com. [81.230.97.204])
        by smtp.gmail.com with ESMTPSA id gy26-20020a170906f25a00b008b14cbb46e2sm392145ejb.145.2023.02.15.23.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 23:01:37 -0800 (PST)
Message-ID: <49fe0a38e1340987be9c898fa806ce5776cba639.camel@gmail.com>
Subject: Re: [PATCH v2] f2fs: fix uninitialized skipped_gc_rwsem
From:   Miko Larsson <mikoxyzzz@gmail.com>
To:     yonggil.song@samsung.com, Chao Yu <chao@kernel.org>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>
Date:   Thu, 16 Feb 2023 08:01:36 +0100
In-Reply-To: <20230216025743epcms2p31d1bde5cfb315d13231010b0a46fbec4@epcms2p3>
References: <CGME20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6@epcms2p3>
         <20230216025743epcms2p31d1bde5cfb315d13231010b0a46fbec4@epcms2p3>
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

On Thu, 2023-02-16 at 11:57 +0900, Yonggil Song wrote:
> When f2fs skipped a gc round during victim migration, there was a bug
> which
> would skip all upcoming gc rounds unconditionally because
> skipped_gc_rwsem
> was not initialized. It fixes the bug by correctly initializing the
> skipped_gc_rwsem inside the gc loop.
>=20
> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>
>=20
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index b22f49a6f128..81d326abaac1 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -1786,8 +1786,8 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct
> f2fs_gc_control *gc_control)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0prefree_segments(sbi));
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0cpc.reason =3D __get_cp_r=
eason(sbi);
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sbi->skipped_gc_rwsem =3D 0;
> =C2=A0gc_more:
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sbi->skipped_gc_rwsem =3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (unlikely(!(sbi->sb->s=
_flags & SB_ACTIVE))) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0ret =3D -EINVAL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto stop;

Might want to Cc the stable mailing list.
--=20
~miko
