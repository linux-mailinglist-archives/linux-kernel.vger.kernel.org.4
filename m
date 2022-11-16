Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702EB62C79E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 19:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiKPS2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 13:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233205AbiKPS2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 13:28:41 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30022391E2;
        Wed, 16 Nov 2022 10:28:40 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id s8so13769685lfc.8;
        Wed, 16 Nov 2022 10:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SaUwZWGzJJ1Lp4N1+t6rbLaZmBRDQDLgc44MZWkfSlA=;
        b=PvwaWTcGbS+vSRmoDoFJEVax8j5icW23HNgH4TXBKd348S7cJZtyYQCgOIlypt1bJb
         +Amq0mHuuHfvyomxOCHoDZBF53tiairPCihc0spc8jdR8wjfGLu9+HBmjXo9UmVBCuYE
         VyNmUvxMFEDnoFZEsdD0BwypFrTJpQ2fWfPQah/wOPWdN1eP1Lmubf8KHJXetc1/p3nN
         uErQO+uWLr2LRlDzlzAFYP7fPCqSposoRjuglQvJ5mZqSLId2FpGVCgejoF1z6aqKsNP
         es6n1AHY7ZXO974JB3HqHyDk3cENtI3tDsB0nbugIX9HePrGaO8C3JQUXHr8TFOZ9nmA
         UvTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaUwZWGzJJ1Lp4N1+t6rbLaZmBRDQDLgc44MZWkfSlA=;
        b=UHDjKIqD+LzzvPidzlQ9KJ7i4SEeAuHIre38ROSiis85dZaMImHoPfhmafoCiprHeK
         kXVgU7QnEADM0UQuuAJipUHj/szwbDyLQj5hgo7mUEOAiT7utRwKaobrzQrZWEmoT6ZC
         w0wGrac7xPBn0Josq63ZrU+NjDL62Ga3n/Sturpcdvyk6uKsUdNnhX9s9j7E9ft/mdGH
         LCMF95NKHB5dc2/O0hG2y/A4dwlSB7YhORYD/ZD71YrwrmX6sX0lETY1HuV6+o7m9G/0
         o0zrQTJsrzIZT4IbY301S3k7yWA5xbyLi5rOOGew9+KtWH3K1gM9nqbbxNWCY8jJE1At
         SYig==
X-Gm-Message-State: ANoB5pmZE/8bLsv1SrB2gw4XJ//yAqGQb+pmB1pdL25gb70L2cm9lLPk
        YB/fvQYZc1eeYxBhBDOat91ds5TuVd14GYoNWpM=
X-Google-Smtp-Source: AA0mqf4XAj8KhiMXEUh3kTVoZTHiB6PysvJJIUmhvFuRbnqAPxGcPIr/D7q1zdvmFUDba6t+gl/bVLhJ1Fc4aHjtEII=
X-Received: by 2002:a05:6512:3910:b0:4b0:a51e:2b3 with SMTP id
 a16-20020a056512391000b004b0a51e02b3mr8760830lfu.636.1668623318329; Wed, 16
 Nov 2022 10:28:38 -0800 (PST)
MIME-Version: 1.0
References: <20221116141027.10947-1-abelova@astralinux.ru>
In-Reply-To: <20221116141027.10947-1-abelova@astralinux.ru>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 16 Nov 2022 12:28:26 -0600
Message-ID: <CAH2r5murCb6icxS4YbguNbhKLsrrw9FR-p6vW-3njCtMDw3yrw@mail.gmail.com>
Subject: Re: [PATCH] cifs: add check for returning value of SMB2_set_info_init
To:     Anastasia Belova <abelova@astralinux.ru>
Cc:     Steve French <sfrench@samba.org>, Paulo Alcantara <pc@cjr.nz>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

merged into cifs-2.6.git for-next

On Wed, Nov 16, 2022 at 8:26 AM Anastasia Belova <abelova@astralinux.ru> wrote:
>
> If the returning value of SMB2_set_info_init is an error-value,
> exit the function.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 0967e5457954 ("cifs: use a compound for setting an xattr")
>
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>  fs/cifs/smb2ops.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> index 880cd494afea..c77e49b3fcc6 100644
> --- a/fs/cifs/smb2ops.c
> +++ b/fs/cifs/smb2ops.c
> @@ -1116,6 +1116,8 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
>                                 COMPOUND_FID, current->tgid,
>                                 FILE_FULL_EA_INFORMATION,
>                                 SMB2_O_INFO_FILE, 0, data, size);
> +       if (rc)
> +               goto sea_exit;
>         smb2_set_next_command(tcon, &rqst[1]);
>         smb2_set_related(&rqst[1]);
>
> --
> 2.30.2
>


-- 
Thanks,

Steve
