Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AC56B8120
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 19:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjCMStD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 14:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCMSs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 14:48:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36EE1A480;
        Mon, 13 Mar 2023 11:48:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5210CB81058;
        Mon, 13 Mar 2023 18:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3EEC4339B;
        Mon, 13 Mar 2023 18:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678733258;
        bh=UnCeqr8mDd2UsVSwVD6PiahSrZX0mTWDtCkcUqH8XWc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XTMw2+ABGjOb7lrxfURY/q3fVE/JTlJFyymDn1yNK0BpL4Vh8fQplpf6BEZDhBFvW
         2Gsqw9YHnjnZJcDDWN/5Y99KF7rooeRAv6r8ZfXRBjBxzM39uRPpchfQ/jHkc20qJM
         +63wXXkvW6rNhEaLg1VfMs1VbItK0dtcdkqwpbS5abSxthr52rqHVD8/Wp6Cca+8BE
         gmDqV3c0bQzacyhEX46auW+nGDHOL/vIZwzBpcOlNNmQH42pW0cl+JXoSyk4xQ9bLa
         CkKOor/wr7YG59oksK/hceTc3qCvAo8w3herMI5MqsMQGwwNea49oprjT22eVJldVk
         woUdakD5p6zkg==
Received: by mail-oi1-f176.google.com with SMTP id bi17so10159884oib.3;
        Mon, 13 Mar 2023 11:47:38 -0700 (PDT)
X-Gm-Message-State: AO0yUKWn1PhdTILPoDdAHEg1ZxL9ZraGmQG20Pj5uyGUwkVYcpTGtXxN
        dJgiUSJ7bzwvnRVOQSUo5PGHs1w6AV3JiCw52DI=
X-Google-Smtp-Source: AK7set8t+jiZpFR9yBH09fsprFP5s4ObQLwdFBMfsTbX84Ss3edSdGLbc/2MExedtcSMd/4G8pxoxuVuJRitNn7MTfQ=
X-Received: by 2002:aca:1812:0:b0:36e:f6f5:8475 with SMTP id
 h18-20020aca1812000000b0036ef6f58475mr10574885oih.11.1678733257396; Mon, 13
 Mar 2023 11:47:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230307194039.8825-1-jura@vukad.in>
In-Reply-To: <20230307194039.8825-1-jura@vukad.in>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Mar 2023 03:47:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNASuP4L3gNyHvx7xVe3hG0sqQjB5eidq=9zs+20Ce09GEA@mail.gmail.com>
Message-ID: <CAK7LNASuP4L3gNyHvx7xVe3hG0sqQjB5eidq=9zs+20Ce09GEA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Update config changed flag before calling callback
To:     Jurica Vukadin <jura@vukad.in>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 4:40=E2=80=AFAM Jurica Vukadin <jura@vukad.in> wrote=
:
>
> Prior to commit 5ee546594025 ("kconfig: change sym_change_count to a
> boolean flag"), the conf_updated flag was set to the new value *before*
> calling the callback. xconfig's save action depends on this behaviour,
> because xconfig calls conf_get_changed() directly from the callback and
> now sees the old value, thus never enabling the save button or the
> shortcut.
>
> Restore the previous behaviour.
>
> Fixes: 5ee546594025 ("kconfig: change sym_change_count to a boolean flag"=
)
> Signed-off-by: Jurica Vukadin <jura@vukad.in>


Applied to linux-kbuild.
Thanks.


> ---
>  scripts/kconfig/confdata.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> index b7c9f1dd5e42..992575f1e976 100644
> --- a/scripts/kconfig/confdata.c
> +++ b/scripts/kconfig/confdata.c
> @@ -1226,10 +1226,12 @@ static void (*conf_changed_callback)(void);
>
>  void conf_set_changed(bool val)
>  {
> -       if (conf_changed_callback && conf_changed !=3D val)
> -               conf_changed_callback();
> +       bool changed =3D conf_changed !=3D val;
>
>         conf_changed =3D val;
> +
> +       if (conf_changed_callback && changed)
> +               conf_changed_callback();
>  }
>
>  bool conf_get_changed(void)
> --
> 2.39.2
>


--=20
Best Regards
Masahiro Yamada
