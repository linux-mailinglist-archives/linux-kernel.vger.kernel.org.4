Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2A974C032
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 02:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjGIAk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 20:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGIAk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 20:40:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE78198;
        Sat,  8 Jul 2023 17:40:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A580960B50;
        Sun,  9 Jul 2023 00:40:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B875C433C7;
        Sun,  9 Jul 2023 00:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688863255;
        bh=KWpxpNQo+2byrd2KGGBbuZGpodW4wrvCveqWOHgsQt4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=sMLZXLXe3e4RgENUHt0Ecwo3NgZYQ0PGe82lva4Y/l62//gRbZJmvsOAFZflvAOCZ
         yvfFvjwcvGgbt9u8NJTTTrYfGtKjt0CRm3KhINOEcSr48eRN+Yj1pXUWnpv8U+MSBT
         pSNSuIhWorvAoG+aDQ8q3o8nxRVzQUJcqgc1YKpvFyh5Jn7bi6x/yCi2R1tkt6XxoL
         zS3wqngnQy5r0bWGlCEzaHjTw8vRW3Y4plQ6SklrEp3K7aEVN227UTgNwhuj6XRta0
         Q4nELNC+BqN/nYynXNfH11Q1Zck0W0FoLOCa5yKUP4EWUEDO2aknhC8lkj8n0RGm8e
         WRRsvKl6m2A9Q==
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6b91e21365aso1009666a34.1;
        Sat, 08 Jul 2023 17:40:54 -0700 (PDT)
X-Gm-Message-State: ABy/qLYsjQS4PoCvsYCnbWJijsCscHdlBITVhAGC42VBXicDD66ebO+F
        Y0E/cIYW1obUZT18i5p6sWAOKsJKjwVP+VKr6bs=
X-Google-Smtp-Source: APBJJlGlo4zJHRJACYghPZr+CipHbVKjMI3FQTPJG0qd/b3Q8AsURiFe3bND7qhgCuH5lkTNBNWcI33VbGo+xN03yX0=
X-Received: by 2002:a05:6808:1490:b0:3a3:7eb8:bbb with SMTP id
 e16-20020a056808149000b003a37eb80bbbmr8435569oiw.47.1688863254118; Sat, 08
 Jul 2023 17:40:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:7814:0:b0:4e8:f6ff:2aab with HTTP; Sat, 8 Jul 2023
 17:40:53 -0700 (PDT)
In-Reply-To: <d5fbf1cc-9b79-5fbb-a109-87679caffcc4@talpey.com>
References: <20230704074057.1162-1-machel@vivo.com> <CAKYAXd85gpb2xzPEm8BJV6gsff3p-8b4Aj_rOaEvU=+n43SgBQ@mail.gmail.com>
 <d5fbf1cc-9b79-5fbb-a109-87679caffcc4@talpey.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sun, 9 Jul 2023 09:40:53 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_0NyHYEKvsh5RSLQMsLFBRddaSJzGFBi9veh3qoCp4tQ@mail.gmail.com>
Message-ID: <CAKYAXd_0NyHYEKvsh5RSLQMsLFBRddaSJzGFBi9veh3qoCp4tQ@mail.gmail.com>
Subject: Re: [PATCH v1] fs:smb:Fix unsigned expression compared with zero
To:     Tom Talpey <tom@talpey.com>
Cc:     Wang Ming <machel@vivo.com>, Steve French <sfrench@samba.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
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

2023-07-04 22:58 GMT+09:00, Tom Talpey <tom@talpey.com>:
> On 7/4/2023 4:58 AM, Namjae Jeon wrote:
>> 2023-07-04 16:40 GMT+09:00, Wang Ming <machel@vivo.com>:
>>> The return value of the ksmbd_vfs_getcasexattr() is signed.
>>> However, the return value is being assigned to an unsigned
>>> variable and subsequently recasted, causing warnings. Use
>>> a signed type.
>>>
>>> Signed-off-by: Wang Ming <machel@vivo.com>
>> Acked-by: Namjae Jeon <linkinjeon@kernel.org>
>>
>> Thanks for your patch!
>>
>
> FYI, this is missing my previous Acked-by. The updated changelog
> otherwise looks good.
Applied it with your acked-by tag to #ksmbd-for-next-next.

Thanks!
>
> Tom.
>
