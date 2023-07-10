Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99EBC74D324
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbjGJKRJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjGJKQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:16:53 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DC8E7D;
        Mon, 10 Jul 2023 03:16:29 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4452fe640fbso488937137.0;
        Mon, 10 Jul 2023 03:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688984189; x=1691576189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzWFsqoe/v6zSf+Upw+SNFQ6NrSy8Ce/GjnyKdu6vQk=;
        b=aVCPEK61dljR5uzJMRK3Wv1AlsHllj4aC/RZOqqJ/SrYFxoRQAb7TyeyOM1MDRZAem
         VDTcwv6HRLb/pD85hxjIh27u4ebYfMOSZcS2DMWYaYqnSSUCHDidj8P4/iij50jyBJq6
         odKQdVvU/x8oXreEKAaFI9zNvPLvj+2rB5AeO13nqv0HI8XsOuWIVn4IfkBnKYiBdOt3
         g/1CtOIX2405bjBXs3Ot+vp4HQ7xp1QHY2Gq7yTNHXwVuwfd72BPYTlp9D1cKzxlTpXE
         YoBt9sJXwKfIjosP0VTAi07XikVkSmInJygBJHEYATrJGBHMXThJ6AvSjnrPgqFyzZmo
         qgtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688984189; x=1691576189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LzWFsqoe/v6zSf+Upw+SNFQ6NrSy8Ce/GjnyKdu6vQk=;
        b=AFYqQW7o97yerhZWAjUtQ8uf61umzYJP3L3ToJrqoTWNiOi7FBWEFtdq8eDSOI8JYV
         lcVJAwNlR84zELrhyDpp+qhOvTOFiA7Qz+Hwosp7mHhVD6KDUO9x/8FswypsO9i0SRpa
         MahyLq+pIAOajq4ypcFk/nioubYAczWZ0bW5EYw3Yzoa/sBktTYpHp/b+vn9JkJ0hRrS
         HDZsARUkNd6FwpAjpvQRnHWkBCr0u2jGlSUb97s1+/MQiCmxjUX/Nnb8QPsCw4HCAeqw
         5S23EOm/D1z5SO/nW8sAXsA3pjIqW+ytx4iz+gyG9lR4tD65Z5Y+e28VRQMacL++r7WB
         vbEA==
X-Gm-Message-State: ABy/qLa33YHMzrOvIxXXc7Lbf9HYBSNRJ5pajA/pX+Yy307fvxGiacPL
        NKnEHl3x1h2mALDFthRrPHv0LfG5u0dxiGUWgAY=
X-Google-Smtp-Source: APBJJlG4I9tVvLXnSxYL9jvsaXKYazWNuZRHN1x2UL7e+8MRHM8teg5dqRCNtwNZRXsCsa2n6w7nRP8w9HJR/tmcYTs=
X-Received: by 2002:a67:f446:0:b0:444:bb70:db73 with SMTP id
 r6-20020a67f446000000b00444bb70db73mr3105959vsn.28.1688984188693; Mon, 10 Jul
 2023 03:16:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230709181323.12085-2-johannes@sipsolutions.net> <19f7bc7f43922c257238127d5fe84ea01cf2be79.camel@intel.com>
In-Reply-To: <19f7bc7f43922c257238127d5fe84ea01cf2be79.camel@intel.com>
From:   Jeff Chua <jeff.chua.linux@gmail.com>
Date:   Mon, 10 Jul 2023 18:16:17 +0800
Message-ID: <CAAJw_Zuo1L3yTP-PVgdW74uYg=R7YxXF0hA5s0Gfm1bCqC90RQ@mail.gmail.com>
Subject: Re: [RFC PATCH] wifi: iwlwifi: remove 'use_tfh' config to fix crash
To:     "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "Berg, Johannes" <johannes.berg@intel.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Networking <netdev@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 9:53=E2=80=AFAM Zhang, Rui <rui.zhang@intel.com> wr=
ote:
>
> On Sun, 2023-07-09 at 20:13 +0200, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> >
> > This is equivalent to 'gen2', and it's confusing to have two
> > of the same configs. The split config patch actually had been
> > originally developed after this, and didn't add the use_tfh
> > in the new configs because they were copied to the new files
> > after ...
> >
> > There's clearly still an unwind error in iwl_txq_gen2_init()
> > since it crashes if something fails there, but the reason it
> > fails in the first place is due to the gen2/use_tfh confusion.
> >
> > Reported-by: Jeff Chua <jeff.chua.linux@gmail.com>
> > Reported-by: "Zhang, Rui" <rui.zhang@intel.com>
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217622
> > Link:
> > https://lore.kernel.org/all/9274d9bd3d080a457649ff5addcc1726f08ef5b2.ca=
mel@xry111.site/
> > Link:
> > https://lore.kernel.org/all/CAAJw_Zug6VCS5ZqTWaFSr9sd85k%3DtyPm9DEE%2Bm=
V%3DAKoECZM%2BsQ@mail.gmail.com/
> > Fixes: 19898ce9cf8a ("wifi: iwlwifi: split 22000.c into multiple
> > files")
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>
> Hi, Johannes,
>
> Thanks for the patch. It fixes the problem on my side.
>
> Tested-by: Zhang Rui <rui.zhang@intel.com>
>
> thanks,
> rui


Johannes,

Fixed as well! Thank you!

cc to those I've posted before as well.

Jeff
