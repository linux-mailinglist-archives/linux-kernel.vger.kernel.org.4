Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4F86F465E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 16:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjEBOwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 10:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjEBOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 10:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8215D19AC;
        Tue,  2 May 2023 07:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 206A96228E;
        Tue,  2 May 2023 14:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C544C433EF;
        Tue,  2 May 2023 14:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683039109;
        bh=J+ew9hMgs9WohOp8pQurJdXVNAtdA3K9ozUlYGq/D7c=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=YnQDMJI5X2Gj3HTToS5ANeHlgJRsis6aEiWWyBIIK38BbA471B56BqehBgLZwsZBn
         efhOeeWIs0QrTJUy01/MimnNI365lvCQ0VU/nCR2S2395yuA8HTHLxn+uz1InWse33
         FTSZL1ntMLgcWd35DnIUSydp+8SKjHgU/+ZA44nD+oKL/J1A4nu0p61OzvjFW/ljj+
         HGF2flMHLjDMSYfGinHyQuNg2YPKgqVOB/9iIaC6oxYsXm93m6NLylqJNSMH8Pj9A/
         gMQ/xOj821d8KXPgPeU+CtsOyiztUXHQxuCFYMP2M340iL8tEifSG8o4FhG/ST8RgQ
         A7EEC3Q31Xx8g==
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6a5f7341850so2856432a34.2;
        Tue, 02 May 2023 07:51:49 -0700 (PDT)
X-Gm-Message-State: AC+VfDz1SpQ49UtFWOkc439GCtvStZ+Kyzb279xYrNBa8m3oL75lcx5n
        ssvPRKNzwqnnJR45/sgnaEi2botYWHxo7VqWN70=
X-Google-Smtp-Source: ACHHUZ6bDPEpyhNC0XRtf3AqJ7LstTvdhAez7GSZQv6bvRBZSVBR2f9qlH3DfvpYno8y8SXYo27WuqCni+7LxL+Etao=
X-Received: by 2002:a4a:4f81:0:b0:54c:b507:2616 with SMTP id
 c123-20020a4a4f81000000b0054cb5072616mr1017978oob.3.1683039108652; Tue, 02
 May 2023 07:51:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1086:0:b0:4d3:d9bf:b562 with HTTP; Tue, 2 May 2023
 07:51:48 -0700 (PDT)
In-Reply-To: <CAAn9K_u5OFb5Fv-2_3v9=VZ-WCcRaBmPMyYRkJ5UTCazkDa=8w@mail.gmail.com>
References: <20230502080254.51928-1-cc85nod@gmail.com> <CAAn9K_u5OFb5Fv-2_3v9=VZ-WCcRaBmPMyYRkJ5UTCazkDa=8w@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 2 May 2023 23:51:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_nhyS1JF++OEM38TyM7-5KYG1OwV+WRAkf2G+2R+at+A@mail.gmail.com>
Message-ID: <CAKYAXd_nhyS1JF++OEM38TyM7-5KYG1OwV+WRAkf2G+2R+at+A@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix null-ptr-deref in smb2_get_info_filesystem
To:     =?UTF-8?B?5by15pm66Ku6?= <cc85nod@gmail.com>
Cc:     sfrench@samba.org, senozhatsky@chromium.org, tom@talpey.com,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-05-02 17:30 GMT+09:00, =E5=BC=B5=E6=99=BA=E8=AB=BA <cc85nod@gmail.com>=
:
> Sorry, I missed to add the curly brackets, I will resend new commit.
This issue was reported and it's already been fixed.

Thanks.
>
> Pumpkin <cc85nod@gmail.com> =E6=96=BC 2023=E5=B9=B45=E6=9C=882=E6=97=A5 =
=E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:03=E5=AF=AB=E9=81=93=EF=BC=9A
>
>> We do not assign path for those shares which have KSMBD_SHARE_FLAG_PIPE
>> flag, so we need to check if path is NULL before use it.
>>
>> [    8.067958]
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> [    8.068413] BUG: KASAN: null-ptr-deref in strlen+0xa/0x40
>> [    8.068747] Read of size 1 at addr 0000000000000000 by task
>> kworker/0:2/45
>> ...
>> [    8.070638] Call Trace:
>> [    8.070797]  <TASK>
>> [    8.070931]  dump_stack_lvl+0x33/0x50
>> [    8.071351]  kasan_report+0xae/0xe0
>> [    8.071766]  strlen+0xa/0x40
>> [    8.071948]  getname_kernel+0x10/0x1a0
>> [    8.072182]  kern_path+0x10/0x40
>> [    8.072385]  smb2_get_info_filesystem+0xf9/0xc70
>> [    8.076519]  smb2_query_info+0x36b/0x1fd0
>> [    8.079913]  handle_ksmbd_work+0x274/0x810
>> [    8.080165]  process_one_work+0x419/0x760
>> [    8.080421]  worker_thread+0x2a2/0x6f0
>> [    8.080916]  kthread+0x160/0x190
>> [    8.081423]  ret_from_fork+0x1f/0x30
>> [    8.081648]  </TASK>
>>
>> Signed-off-by: Pumpkin <cc85nod@gmail.com>
>> ---
>>  fs/ksmbd/smb2pdu.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
>> index aa823b13d..798b193cf 100644
>> --- a/fs/ksmbd/smb2pdu.c
>> +++ b/fs/ksmbd/smb2pdu.c
>> @@ -4906,6 +4906,9 @@ static int smb2_get_info_filesystem(struct
>> ksmbd_work *work,
>>         int rc =3D 0, len;
>>         int fs_infoclass_size =3D 0;
>>
>> +       if (share->path =3D=3D NULL)
>> +               return -EIO;
>> +
>>         rc =3D kern_path(share->path, LOOKUP_NO_SYMLINKS, &path);
>>         if (rc) {
>>                 pr_err("cannot create vfs path\n");
>> --
>> 2.39.2 (Apple Git-143)
>>
>>
>
