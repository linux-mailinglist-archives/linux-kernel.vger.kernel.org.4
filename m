Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC0373C6A2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 05:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjFXDu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 23:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjFXDuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 23:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81427270B;
        Fri, 23 Jun 2023 20:50:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE82461B77;
        Sat, 24 Jun 2023 03:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BE14C433C8;
        Sat, 24 Jun 2023 03:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687578619;
        bh=MyBtPKk4KOyFw5C/OgQkSW8V2NEdsbLSXKVKvWnowSM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=rtJ9UzDljxVadtP6yqMSv7OvrbhmnM1FdlO1eka/rUKlWdVA1Tj9zOh7d1JyoEnv+
         uUNNSRtZNZYy3W7yobWE6lbC7pWkYpNSB9BMh9w87m/WcVdLNxjpBNqtrSadmGn0O1
         e0CydK1v9m4tWac9kgsOqZwKPiwGCWw8esp92DdCyeJqunNWkS7BUbbcYi7ejVA6s0
         SemEKfVCPHuNcb50ZHCBjzUKXiEzB2Wig9Yb2GHlcwDMoUI9X9CnifcRFpgp9IhkAF
         3R1B3sbcZbB+nvxdjMNlet68B2qFd77Rzk2EUjaBcQwNSQy7iEV8RayzvwIAzyDfw0
         omrAjKXFAkHhQ==
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5619d718602so912776eaf.1;
        Fri, 23 Jun 2023 20:50:19 -0700 (PDT)
X-Gm-Message-State: AC+VfDw/RttZzeKQy7zz1lI6+cpsBJeUe9tHjVORlo5VlxOfxd3eXCdb
        IgSovHMpJThird9h0PTYHyEoJ444mqG14PdEEgw=
X-Google-Smtp-Source: ACHHUZ5esk0p9KprkiG98kjDECgj8+SXORUXUa68zUtml3S1mOlk9KCzF6Wx052Qzux+YAtpo4OummVBL0ouxFJnKdY=
X-Received: by 2002:a4a:c703:0:b0:563:21bd:3809 with SMTP id
 n3-20020a4ac703000000b0056321bd3809mr331956ooq.2.1687578618402; Fri, 23 Jun
 2023 20:50:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5e18:0:b0:4df:6fd3:a469 with HTTP; Fri, 23 Jun 2023
 20:50:18 -0700 (PDT)
In-Reply-To: <ZJNrsjDEfe0iwQ92@work>
References: <ZJNrsjDEfe0iwQ92@work>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 24 Jun 2023 12:50:18 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-2qCGwrH34bASRY0DkffO+L=-RE5fYzR23Z_iEmW8x6g@mail.gmail.com>
Message-ID: <CAKYAXd-2qCGwrH34bASRY0DkffO+L=-RE5fYzR23Z_iEmW8x6g@mail.gmail.com>
Subject: Re: [PATCH][next] ksmbd: Use struct_size() helper in ksmbd_negotiate_smb_dialect()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-06-22 6:29 GMT+09:00, Gustavo A. R. Silva <gustavoars@kernel.org>:
> Prefer struct_size() over open-coded versions.
>
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Applied it with reviewed/acked-by tags  to #ksmbd-for-next-next.

Thanks.
