Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932037333F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345540AbjFPOtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345713AbjFPOtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:49:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B441A2D73;
        Fri, 16 Jun 2023 07:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 428D063DE2;
        Fri, 16 Jun 2023 14:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83C47C433C9;
        Fri, 16 Jun 2023 14:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686926967;
        bh=PpvVp7yyDQOIU09JMBq0XFKGWFo4ig5UBnsewUfXeNA=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=GPnzL50RS1+D0LSYwSZZG4pgHNaZOWDRhOWPLxC2v+obTqMbZDRlNYd6mRZUh95lw
         /MViQ2NXSjOIoqNgFX0d4vdNGJ6QExTbvzdxcrFM3CfUOcKzVq2zRGCYIJKwQnugdR
         ps5U8Q32qCPaCP4muIPy7aSv7Zz1zQAfcTYC5f3n2Dy3e7HFn9aPYnITYxQOfcdPUF
         QxKbcUrNysLFA+NmgGdxKT6DRj7oDNE/+YYkdoW+iGMYX8yC8YWTlMmGKEeal3sKSE
         AvNtRQdKdXZ4w8l3l5/9qMTv4bsBvRc2+gKw55M9TJ2DNVJg21vxUoncRyV50jaBJM
         8WFlBglwuox4A==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1a2c9f087f0so921863fac.3;
        Fri, 16 Jun 2023 07:49:27 -0700 (PDT)
X-Gm-Message-State: AC+VfDw7Q04A4eDPzUeBum4YWdvjybDtBg+3O+dmePkn/tGe30GlsQYE
        96CMEfQNMF7a6jScUxUltCIfFmxgoLO4JegEOJA=
X-Google-Smtp-Source: ACHHUZ5Qh3zWWQYdcYt7lpa65mCYb8r6eF4mr0xQqer2K4/526o+mfkB5ppZcUdY6ITLJY5R4SshkagJHs6LG3DUhb4=
X-Received: by 2002:a05:6870:a2c4:b0:1a6:c968:4a15 with SMTP id
 w4-20020a056870a2c400b001a6c9684a15mr2132567oak.4.1686926966551; Fri, 16 Jun
 2023 07:49:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:7cb:0:b0:4df:6fd3:a469 with HTTP; Fri, 16 Jun 2023
 07:49:26 -0700 (PDT)
In-Reply-To: <6742b2ce-02f1-43c1-811f-de7fd0a74f6a@app.fastmail.com>
References: <20230616090749.2646749-1-arnd@kernel.org> <CAKYAXd-j6mJ91hZUZi86HnGJahekHHgYz4ngWfF81QmYigGqVw@mail.gmail.com>
 <6742b2ce-02f1-43c1-811f-de7fd0a74f6a@app.fastmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 16 Jun 2023 23:49:26 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8v8CAccMb-2KM5P0yds_8wU-9k+n4QmatFe6Hwz1TYhw@mail.gmail.com>
Message-ID: <CAKYAXd8v8CAccMb-2KM5P0yds_8wU-9k+n4QmatFe6Hwz1TYhw@mail.gmail.com>
Subject: Re: [PATCH] smb: avoid field overflow warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Steve French <sfrench@samba.org>,
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

2023-06-16 23:42 GMT+09:00, Arnd Bergmann <arnd@arndb.de>:
> On Fri, Jun 16, 2023, at 16:40, Namjae Jeon wrote:
>> 2023-06-16 18:07 GMT+09:00, Arnd Bergmann <arnd@kernel.org>:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> clang warns about a possible field overflow in a memcpy:
>>>
>>> In file included from fs/smb/server/smb_common.c:7:
>>> include/linux/fortify-string.h:583:4: error: call to
>>> '__write_overflow_field' declared with 'warning' attribute: detected
>>> write
>>> beyond size of field (1st parameter); maybe use struct_group()?
>>> [-Werror,-Wattribute-warning]
>>>                         __write_overflow_field(p_size_field, size);
>>>
>>> It appears to interpret the "&out[baselen + 4]" as referring to a single
>>> byte of the character array, while the equivalen "out + baselen + 4" is
>>> seen as an offset into the array.
>>>
>>> I don't see that kind of warning elsewhere, so just go with the simple
>>> rework.
>>>
>>> Fixes: e2f34481b24db ("cifsd: add server-side procedures for SMB3")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  fs/smb/server/smb_common.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
>>> index a7e81067bc991..e3273fa640b07 100644
>>> --- a/fs/smb/server/smb_common.c
>>> +++ b/fs/smb/server/smb_common.c
>>> @@ -536,7 +536,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn,
>>> const char *longname,
>>>  	out[baselen + 3] = PERIOD;
>>>
>>>  	if (dot_present)
>>> -		memcpy(&out[baselen + 4], extension, 4);
>>> +		memcpy(out + baselen + 4, extension, 1);
>> Is there any reason to change copy bytes from 4 bytes to 1 byte?
>>
>
> No, that was an accident, this patch is wrong.
>
> I have to revisit this one and check if my change actually still works
> after I change it back to the correct length.
Okay:)
Thanks for your check!
>
>       Arnd
>
