Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0C66ADA4F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjCGJ1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjCGJ1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:27:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A545574E2;
        Tue,  7 Mar 2023 01:27:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2666B61262;
        Tue,  7 Mar 2023 09:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C08C4339C;
        Tue,  7 Mar 2023 09:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678181252;
        bh=Y1wO9oyGOSoofQ+B6ReYbPkZ/JSfM2RwGWgXk9Jh9AM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Cggu/d8vcWHQiltg+nKRjw6VxDmxBQRFjl2rHa7lDd0gzcM9tA/ixssnMOfSZtiyz
         YWr+7XVLXD53p2Q2YNPMJbbjLTBV7z4bz8TLG4dJwmjpKFdN7hvtps93kZfEv70p+x
         jvwBeU1cslNeexQ6c0JU/t0k3z/imCT1Foh6cO9bKC/8x/JLOTDVZsV+rrJ54Rwvbj
         3l0Qnt0SpPRxJRpGOd4hahR3FmUPi1rQESDYf9ZVKGJcwoApgW3+GxzG7FK+rsFv+t
         Q/hjmMpQnM5u8ZxCaAfLjh0JeZ953VCHouI4x7GAvNOu9CbmO81apE6lmY9BUd6sSO
         liTlLabbeEb6w==
Received: by mail-ot1-f52.google.com with SMTP id 32-20020a9d0323000000b0069426a71d79so6786987otv.10;
        Tue, 07 Mar 2023 01:27:32 -0800 (PST)
X-Gm-Message-State: AO0yUKWCx0QZIbCftcAXezruUnp99tPh8RWCwMXTq0EOLOBFE5Urg+Mb
        iaIA27JeMCLYz/G0BY6p5awyr10NULGYEuRnSEA=
X-Google-Smtp-Source: AK7set99YRWc7F27t1s7ITL0T0UyGgOArsSheBJP8nzUhluqwNnk8V6eP4k0OIg+KXiNkd6fE7POYk+LauXaXHWTsLo=
X-Received: by 2002:a05:6830:3378:b0:68d:48f0:9bad with SMTP id
 l56-20020a056830337800b0068d48f09badmr4545160ott.7.1678181251654; Tue, 07 Mar
 2023 01:27:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:67ca:0:b0:4c2:5d59:8c51 with HTTP; Tue, 7 Mar 2023
 01:27:31 -0800 (PST)
In-Reply-To: <48975544-9b5f-eb2a-e2a2-f0ffa537aa1c@huawei.com>
References: <20230302135804.2583061-1-chenxiaosong2@huawei.com> <48975544-9b5f-eb2a-e2a2-f0ffa537aa1c@huawei.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 7 Mar 2023 18:27:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-3t6W1fv128D7LDcusZcabJdq3D6eq3ndE9_gP+PsVqg@mail.gmail.com>
Message-ID: <CAKYAXd-3t6W1fv128D7LDcusZcabJdq3D6eq3ndE9_gP+PsVqg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix possible refcount leak in smb2_open()
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     sfrench@samba.org, stfrench@microsoft.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-03-07 17:52 GMT+09:00, ChenXiaoSong <chenxiaosong2@huawei.com>:
> Hi Namjae and Steve:
Hi Chen,
>
> Do you have any suggestions for this patch?
Sorry, It was in the spam box...
I have sent ack. Thanks for noticing.
>
> =E5=9C=A8 2023/3/2 21:58, ChenXiaoSong =E5=86=99=E9=81=93:
>> Reference count of acls will leak when memory allocation fails. Fix this
>> by adding the missing posix_acl_release().
>>
>> Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
>> Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
>> ---
>>   fs/ksmbd/smb2pdu.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
>> index 0685c1c77b9f..f04d810a2588 100644
>> --- a/fs/ksmbd/smb2pdu.c
>> +++ b/fs/ksmbd/smb2pdu.c
>> @@ -2977,8 +2977,11 @@ int smb2_open(struct ksmbd_work *work)
>>   							sizeof(struct smb_acl) +
>>   							sizeof(struct smb_ace) * ace_num * 2,
>>   							GFP_KERNEL);
>> -					if (!pntsd)
>> +					if (!pntsd) {
>> +						posix_acl_release(fattr.cf_acls);
>> +						posix_acl_release(fattr.cf_dacls);
>>   						goto err_out;
>> +					}
>>
>>   					rc =3D build_sec_desc(idmap,
>>   							    pntsd, NULL, 0,
>>
>
