Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550D77333CD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbjFPOkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjFPOkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:40:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F7012700;
        Fri, 16 Jun 2023 07:40:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13CA062CD6;
        Fri, 16 Jun 2023 14:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 173E8C43395;
        Fri, 16 Jun 2023 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686926406;
        bh=LmQ0A+9O9O846YKQ9SkKO3tmg56GUE4m1YrLD2TzUKQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=EvENScLdZ2899SCUlEib3TpooSqIrCtaEXZzsD1BE1WIVTLGsud+qlbOU2R/70Chw
         bVtUjCBmb7msknzEaW5MevV/CFQBx0qFRiOjHZ7CLLp6nRCMzbAkHeuh6tz3C2YY2x
         gIPd8Ozt7OMBe8OvEmFvRWqIo8oO+gSq03PszmfHZhd30q64iQBjFNq2/q+OytalAv
         89Yj9aC0EDcLz2ksTAkRNCavGQCS4CT6Zn+JEC2/FeT7DRLqhsDxjePTfnOboQJCY4
         FL153lVpC1R36Ndn/6pkh46PQAEh9VehBT00JaOqO+u50SDTRyCIZaq2RfKwpp7kQC
         6T4vx1n6+9VDg==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-555508fd7f9so467618eaf.3;
        Fri, 16 Jun 2023 07:40:06 -0700 (PDT)
X-Gm-Message-State: AC+VfDwXTp9v3gcRYNvmkt2AA3QpQbA+LYFsgjeaStH8Gsd+4miorLM4
        QBB/n3xQD5PFiwbG50j05SKNCN2X1FwSPrGW0HA=
X-Google-Smtp-Source: ACHHUZ6z8GA1qZV8cYgrktvFU8j0O2B9+u9zyzznMrSz3BZZRqGJ81uDTG5XgaLcvQipbezYj8K+9eZ0Q4y7eufjbkk=
X-Received: by 2002:a4a:d786:0:b0:558:bb12:da9f with SMTP id
 c6-20020a4ad786000000b00558bb12da9fmr1811379oou.2.1686926405144; Fri, 16 Jun
 2023 07:40:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:7cb:0:b0:4df:6fd3:a469 with HTTP; Fri, 16 Jun 2023
 07:40:04 -0700 (PDT)
In-Reply-To: <20230616090749.2646749-1-arnd@kernel.org>
References: <20230616090749.2646749-1-arnd@kernel.org>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 16 Jun 2023 23:40:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-j6mJ91hZUZi86HnGJahekHHgYz4ngWfF81QmYigGqVw@mail.gmail.com>
Message-ID: <CAKYAXd-j6mJ91hZUZi86HnGJahekHHgYz4ngWfF81QmYigGqVw@mail.gmail.com>
Subject: Re: [PATCH] smb: avoid field overflow warning
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Steve French <sfrench@samba.org>, Arnd Bergmann <arnd@arndb.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tom Talpey <tom@talpey.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

2023-06-16 18:07 GMT+09:00, Arnd Bergmann <arnd@kernel.org>:
> From: Arnd Bergmann <arnd@arndb.de>
Hi Arnd,

>
> clang warns about a possible field overflow in a memcpy:
>
> In file included from fs/smb/server/smb_common.c:7:
> include/linux/fortify-string.h:583:4: error: call to
> '__write_overflow_field' declared with 'warning' attribute: detected write
> beyond size of field (1st parameter); maybe use struct_group()?
> [-Werror,-Wattribute-warning]
>                         __write_overflow_field(p_size_field, size);
>
> It appears to interpret the "&out[baselen + 4]" as referring to a single
> byte of the character array, while the equivalen "out + baselen + 4" is
> seen as an offset into the array.
>
> I don't see that kind of warning elsewhere, so just go with the simple
> rework.
>
> Fixes: e2f34481b24db ("cifsd: add server-side procedures for SMB3")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/smb/server/smb_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
> index a7e81067bc991..e3273fa640b07 100644
> --- a/fs/smb/server/smb_common.c
> +++ b/fs/smb/server/smb_common.c
> @@ -536,7 +536,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn,
> const char *longname,
>  	out[baselen + 3] = PERIOD;
>
>  	if (dot_present)
> -		memcpy(&out[baselen + 4], extension, 4);
> +		memcpy(out + baselen + 4, extension, 1);
Is there any reason to change copy bytes from 4 bytes to 1 byte?

Thanks!
>  	else
>  		out[baselen + 4] = '\0';
>  	smbConvertToUTF16((__le16 *)shortname, out, PATH_MAX,
> --
> 2.39.2
>
>
