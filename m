Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F41073930D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 01:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjFUXhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 19:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjFUXhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 19:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BD61BD1;
        Wed, 21 Jun 2023 16:37:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BD2FB616E4;
        Wed, 21 Jun 2023 23:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFE2C433C0;
        Wed, 21 Jun 2023 23:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687390668;
        bh=VP8eLETNVwAQLt9TRTo8wYBeDNkQHL/7nKQlqfTCOeE=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=n12EE7MigKB29jYdnpziPZdBmQHzPY6IihIjPZDi0jy7CfeWD+olZaK64IRcvGwpI
         TlK44zrvAlIX5ktSrLzlmYJBeXaNr6Y/by0Ycllvu9cgm8Vs51kzKSU7PkhPVh/bVH
         HoNAOJAigycRwyJk1HhBPM6FyKMTK0ZMwU6lVtoxJe+4u3bEvp4oRFX4hhKj5qtdNf
         QHFbuDJYowpfB3vSjbsgzyQUdP4Shp5YyLOWBLqFNQdfeYErqMh+JyV2jwbiipNBM4
         lnRl6E5rn1DrjHZ/1AQZVNazuq5TnGfvwCylrJYAmA/987ChibNgq7SbHdTTNThDX6
         9vPB+4KKmS8ag==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-560bcee2aa1so690858eaf.3;
        Wed, 21 Jun 2023 16:37:48 -0700 (PDT)
X-Gm-Message-State: AC+VfDzz5tkFD17/ok2Ep+sAf+dsNSUjyiFze+AWvhEmbErC9aWdka5i
        VwPwuExI4CBukyKOa24v/AvlxvdeOJuNx5E/gAg=
X-Google-Smtp-Source: ACHHUZ5U8gWGFhuQgf+cIJa+/a08pge8ufuJKUNl7vzDgZsECMa+2yCmUKn0ivrmY70hJs5A6MDHEefStfFwkDVK0WE=
X-Received: by 2002:a4a:d451:0:b0:558:b424:8c31 with SMTP id
 p17-20020a4ad451000000b00558b4248c31mr6112071oos.0.1687390667383; Wed, 21 Jun
 2023 16:37:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:5e18:0:b0:4df:6fd3:a469 with HTTP; Wed, 21 Jun 2023
 16:37:46 -0700 (PDT)
In-Reply-To: <ZJNrsjDEfe0iwQ92@work>
References: <ZJNrsjDEfe0iwQ92@work>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 22 Jun 2023 08:37:46 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-E0Tc2BKV8sdtLp64WWnmt-hwgqyYPv+PScQwtOpUVnQ@mail.gmail.com>
Message-ID: <CAKYAXd-E0Tc2BKV8sdtLp64WWnmt-hwgqyYPv+PScQwtOpUVnQ@mail.gmail.com>
Subject: Re: [PATCH][next] ksmbd: Use struct_size() helper in ksmbd_negotiate_smb_dialect()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
