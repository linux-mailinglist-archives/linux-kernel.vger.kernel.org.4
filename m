Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D107404FD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 22:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjF0U20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 16:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjF0U2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 16:28:24 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96A6D1BD1;
        Tue, 27 Jun 2023 13:28:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b7ffab9454so16619235ad.3;
        Tue, 27 Jun 2023 13:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687897703; x=1690489703;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1vPucO0ah2tzqliaea+4BxYPUmdSJl3E6NC0kkOLyyk=;
        b=GcPz2MczXgU6SpJzyuUl5ZD4eFfWwa6lXpX3o8lJFATWNOCXX6DanvxQuaugiOtK2e
         7V/sQ2zJd4ziSFffOMg4pakURS6v8zqidYS048F6K8nwifBE0+qmkl2a5P0AAV2pUo13
         QQ+bejyQT+XW3VHHULhOtYoDbHAPlman2IckwsYp8YN2V+RedkMOTMi+SLRC+/wfJfvg
         hLedKXJ8X2wJ8G/aFduDmroJmXuHEjMuwXHniE7IDuYLVdO0fb/zlUtj+AaMBY48FllB
         4vZ2Y6Q+NfmkDj7flIxL9a2lC8lEjs3yAc5v07Wt9NAlZ/RWfSPLEL3CYhX8w5TtbKtA
         /fKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687897703; x=1690489703;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vPucO0ah2tzqliaea+4BxYPUmdSJl3E6NC0kkOLyyk=;
        b=jb8zfblovPtxrW9SpvBllChF92dWwrP4eEXxSOLREe/iy2pgWQLEj/JgiANe0Osb1Q
         Wbr8uJMcGYQIuya01e5WN0kMfF8ZvRuyF1CjQJVHYKUVz0XoPQwzGt8MZc2esOyWUttg
         Q2PLYWmEtIqixU4njrFyslcNHPWpM69eexR3fAnzYBJEbJpg+TOX5JvNfVrqWuRj4ohv
         ETOP9WUAY4BT7WKDDgGSG/2aIKZ4Ku5t3Chrbo+wzo319OHjRPjPtIxurZfXK1r5aBEp
         6QJP/MeoEDAiktw2JXsjQawR9rp/Rx7XNxlR+hpMjRmjExOt2pQPO5muzjEdgPCNQ2qT
         OQOg==
X-Gm-Message-State: AC+VfDwpWssMKDfugdot0Avo0mdhGnFn+9q6brYktKCkXEbyucqIgj0g
        oqvA1Kv9SkZ2FTgL3Qx8Vnw=
X-Google-Smtp-Source: ACHHUZ77hfIbpGXcAKSEQbUd/TPPDZ3S/WB6KmkpZA5rDwH82R6v0wU0/s+a9C+d8VxfMQky+5c0eg==
X-Received: by 2002:a17:902:6ac3:b0:1b8:d90:d20f with SMTP id i3-20020a1709026ac300b001b80d90d20fmr4043915plt.3.1687897702939;
        Tue, 27 Jun 2023 13:28:22 -0700 (PDT)
Received: from smtpclient.apple ([2620:15c:2c0:5:9d65:e705:252e:8337])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902a5ca00b001b53c8659fesm6338819plq.30.2023.06.27.13.28.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2023 13:28:22 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: support pmsg record size larger than kmalloc limitation
From:   Yuxiao Zhang <yuxiaozh.zhang@gmail.com>
In-Reply-To: <2023062702-frosty-winking-9257@gregkh>
Date:   Tue, 27 Jun 2023 13:28:11 -0700
Cc:     Yuxiao Zhang <yuxiaozhang@google.com>, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com,
        linux-hardening@vger.kernel.org,
        William Kennington <wak@google.com>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D4435632-785B-43AC-AE21-EC9797458F42@gmail.com>
References: <CAOOoKeQ=b4u1C_FZ-OFHSfVt5Z9xw1KtpJ4316zubt46Tny41Q@mail.gmail.com>
 <2023062715-eldercare-washed-3c29@gregkh>
 <CAOOoKeSxJzJEwX2aVsn_jcqK7gsgEVpB3VdhoKjJPCJgdNf9Mg@mail.gmail.com>
 <2023062702-frosty-winking-9257@gregkh>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the pointer, the document is very helpful. Seems that I =
cannot use gmail to send patches. I sent it again by git send-email. I =
also tested myself that the patch is well-formatted. Hopefully this time =
it works.

> On Jun 27, 2023, at 10:35 AM, Greg KH <gregkh@linuxfoundation.org> =
wrote:
>=20
> On Tue, Jun 27, 2023 at 10:05:04AM -0700, Yuxiao Zhang wrote:
>>  kfree(record->priv);
>>  kfree(record);
>>  if (rc !=3D -EEXIST || !quiet)
>> diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
>> index ade66dbe5f39..296465b14fa9 100644
>> --- a/fs/pstore/ram.c
>> +++ b/fs/pstore/ram.c
>> @@ -20,6 +20,7 @@
>> #include <linux/compiler.h>
>> #include <linux/of.h>
>> #include <linux/of_address.h>
>> +#include <linux/mm.h>
>>=20
>> #include "internal.h"
>> #include "ram_internal.h"
>> @@ -268,7 +269,7 @@ static ssize_t ramoops_pstore_read(struct
>> pstore_record *record)
>>  /* ECC correction notice */
>>  record->ecc_notice_size =3D persistent_ram_ecc_string(prz, NULL, 0);
>>=20
>> - record->buf =3D kmalloc(size + record->ecc_notice_size + 1, =
GFP_KERNEL);
>> + record->buf =3D kvmalloc(size + record->ecc_notice_size + 1, =
GFP_KERNEL);
>>  if (record->buf =3D=3D NULL) {
>>  size =3D -ENOMEM;
>>  goto out;
>=20
> Please try emailing a patch to yourself and see if you can apply it
> afterwards.  The kernel documentation has a section for how to handle
> email clients, perhaps you should read it?
>=20
> thanks,
>=20
> greg k-h

