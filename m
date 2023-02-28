Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1733C6A6072
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 21:34:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjB1UeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 15:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjB1UeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 15:34:00 -0500
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB33B15891;
        Tue, 28 Feb 2023 12:33:56 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id ee7so45370015edb.2;
        Tue, 28 Feb 2023 12:33:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677616435;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NbNBo0Ls3oKuJjUOllfEZ1/w9byTGW4gyiykg0SP6Q=;
        b=Z4vsJA1VMiKQyoGdIR61SR6ISj8waZD6/Vq5j17hvUfiDTdToqbcCQrSgVCztRdAAI
         SxKXH2Kr06gIey+kMMB/ZIgs8bUbIvMG6YRUD8flf/tiTjEDhWPZqIC0suZs+N2HbPHX
         VKh5G4cHEZOTahQ/Fo4pPM9llto6KXnIj626Pihh1A6lWs8YCrtoWrH2ZM3TKC+ntmKM
         5mAFkUsedl535XnKFgMNTQ0HWSqUsk4fnbPX0gToRF4HTyt9MFMUIQMrb04aMt2Dn4qy
         Njc/HxSkka8Xv6yFPwoJneoQjpS3hWuD3jtasnoRTigylWKwHQ8Pv3rqG7a/pXDLglQ0
         3sPQ==
X-Gm-Message-State: AO0yUKWfzVeima3F8qZdV/S76pV1QEr1jdDTkoX0/7BDkE4PQUPzvc1B
        5d8MRb5UvfVn+q7zdi+1n+5Sl8PAZYJAu8EqZg0=
X-Google-Smtp-Source: AK7set/sWo26Ng/Rx1w9Od31hmcehJvkRAfvh64BBS0QvfL7sdibRTgDJtiw9DKjXL2LHxawLrU8gXDJ9xWNAz1zeI0=
X-Received: by 2002:a50:875e:0:b0:4ac:b7c1:9109 with SMTP id
 30-20020a50875e000000b004acb7c19109mr2442283edv.6.1677616435284; Tue, 28 Feb
 2023 12:33:55 -0800 (PST)
MIME-Version: 1.0
References: <20230228130215.289081-1-nick.alcock@oracle.com> <20230228130215.289081-7-nick.alcock@oracle.com>
In-Reply-To: <20230228130215.289081-7-nick.alcock@oracle.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 28 Feb 2023 21:33:44 +0100
Message-ID: <CAJZ5v0iBzs_DdVLH3j2EX1jk=6N3bzUipnRZX-_Apgmu2f0gCA@mail.gmail.com>
Subject: Re: [PATCH 06/20] powercap: remove MODULE_LICENSE in non-modules
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 2:03 PM Nick Alcock <nick.alcock@oracle.com> wrote:
>
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
>
> So remove it in the files in this commit, none of which can be built as
> modules.
>
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-pm@vger.kernel.org
> ---
>  drivers/powercap/powercap_sys.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/powercap/powercap_sys.c b/drivers/powercap/powercap_sys.c
> index 1f968353d4799..df806a788a02d 100644
> --- a/drivers/powercap/powercap_sys.c
> +++ b/drivers/powercap/powercap_sys.c
> @@ -675,4 +675,3 @@ fs_initcall(powercap_init);
>
>  MODULE_DESCRIPTION("PowerCap sysfs Driver");
>  MODULE_AUTHOR("Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>");
> -MODULE_LICENSE("GPL v2");
> --

Applied as 6.3-rc material, thanks!
