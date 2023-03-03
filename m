Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12ADD6A9FA0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjCCSyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbjCCSye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:54:34 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DFD1421B;
        Fri,  3 Mar 2023 10:54:32 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id a2so3736252plm.4;
        Fri, 03 Mar 2023 10:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677869672;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZN9HFXEA9zbJwH0Fq5wKiQwubJ7uIu4eSgEnheP9zqU=;
        b=e4yo/I/BfwPB6yRvxw0xvmaRoz9s7apX7mwbs5SIn6g966pEn5wFOGKT8sQ4jENWJu
         rWbrNFVaPtf8IQC9BdoqrbrVcfR9G0VsVI7Nqcp//7tqCCRgfvRcWCLRNUt7KylBxH1d
         AjoG9X1OwNWmBXZaFlFiZDPum7vfKrRB2zQ6uxa9vTIiD8fktfk7XfKwgoKcrxDGG8pj
         Tu6GFsAY8tvRoP/kCfRV7lYTsZm6EbohJgTNs76pGbqBPz9QWNBvzbphV8NuiC4vcKCL
         Hsrv5Ll7eHiGIW2a+xVxCE3Q5LUWnA9zPdwn9CaPo7OBIBN9nLkGTbXRxu0bYSLlvSrP
         mOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677869672;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZN9HFXEA9zbJwH0Fq5wKiQwubJ7uIu4eSgEnheP9zqU=;
        b=utslvSVC5EFKFeREZBzdm4CNWmYQuitUEHDk4oOIRNVcX1jNpUOLFBVlQMZ4z8eRSR
         rS9M31w+kL7HHtLLjG9Ib6D9f1PyPpEd/CFx9iDlY9F+s5pjWszuHjlhkiV3ossd362e
         9eifeqDtsKjjnvs0h1ouCmO/2AOGvAYz+MjLgLANcO6rfwSanV/DoeXGqQzQtlbqzLtH
         4EeJ8Xc/Cpgri1RjATrJvyFvp0755uJs1jPxu6qyQNEQu+xkPlw+PRhUXwyFsytRBu5C
         v/ozUCM1qRech7ftsLJ2LltAGnsJcjTwALihdHqUCoKp00TCFt7bc8D9sFyKhuL2eQqR
         9U4w==
X-Gm-Message-State: AO0yUKV6RbhhZP8MByagPti8IxqlQG3FM6LkYqEMzV9PiIv+5bE6jsM9
        KUpVjKRbuEiSpPtJBqsPBXM=
X-Google-Smtp-Source: AK7set9Y8CTpwSm1HI+IqBC9E1Nad8r6qM/YT6DW4gKxOL1Mii3jhSZIzxecsEiTfpCLSu86LLTcWw==
X-Received: by 2002:a05:6a20:4a08:b0:cc:f7ad:eb6f with SMTP id fr8-20020a056a204a0800b000ccf7adeb6fmr2672373pzb.53.1677869672299;
        Fri, 03 Mar 2023 10:54:32 -0800 (PST)
Received: from smtpclient.apple ([2601:1c0:4d7f:138e::3])
        by smtp.gmail.com with ESMTPSA id h70-20020a638349000000b00478ca052819sm1941066pge.47.2023.03.03.10.54.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Mar 2023 10:54:32 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.400.51.1.1\))
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
From:   Lee Duncan <leeman.duncan@gmail.com>
In-Reply-To: <88927435-ae58-c24b-e7b7-b675985de433@leemhuis.info>
Date:   Fri, 3 Mar 2023 10:54:21 -0800
Cc:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Duncan <lduncan@suse.com>, Martin Wilck <mwilck@suse.com>,
        Hannes Reinecke <hare@suse.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <86D685F2-D411-460B-A09B-6BE942372F0A@gmail.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
 <88927435-ae58-c24b-e7b7-b675985de433@leemhuis.info>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
X-Mailer: Apple Mail (2.3731.400.51.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 3, 2023, at 1:02 AM, Linux regression tracking (Thorsten =
Leemhuis) <regressions@leemhuis.info> wrote:
>=20
> Hi, this is your Linux kernel regression tracker.
>=20
> On 28.09.22 20:13, Lee Duncan wrote:
>> From: Lee Duncan <lduncan@suse.com>
>>=20
>> Some storage, such as AIX VDASD (virtual storage) and IBM 2076
>> (front end) do not like the recent commit:
>>=20
>> commit c92a6b5d6335 ("scsi: core: Query VPD size before getting full =
page")
>>=20
>> That commit changed getting SCSI VPD pages so that we now read
>> just enough of the page to get the actual page size, then read
>> the whole page in a second read. The problem is that the above
>> mentioned hardware returns zero for the page size, because of
>> a firmware error. In such cases, until the firmware is fixed,
>> this new black flag says to revert to the original method of
>> reading the VPD pages, i.e. try to read as a whole buffer's
>> worth on the first try.
>=20
> As this is a fix for a regression (one that Srikar Dronamraju recently
> ran into as well and bisected again :-/ ), please allow me to ask:
>=20
> James, Martin, what is needed to get this or some other solution for =
the
> regression finally mainlined?
>=20
> FWIW, the thread afaics accumulated three Reviewed-by an one Tested-by
> in the meantime.
>=20
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' =
hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>=20
> #regzbot poke

Martin:

I know you had reservations about this approach, but the fact that =
another
case has shown up where this patch helps means this isn=E2=80=99t just a =
one-off
problem.

I know the alternative was to have the code that reads mode pages just
automatically handle all cases where the size was returned to zero, but
I really prefer specifically listing =E2=80=9Coffending=E2=80=9D =
hardware, rather than
automatically covering for it.

Please let me know if you still have reservations. If not, I could =
rebase
and resubmit this, if you like.

Thanks.

>=20
>> Fixes: c92a6b5d6335 ("scsi: core: Query VPD size before getting full =
page")
>> Reported-by: Martin Wilck <mwilck@suse.com>
>> Suggested-by: Hannes Reinecke <hare@suse.de>
>> Signed-off-by: Lee Duncan <lduncan@suse.com>
>> ---
>> drivers/scsi/scsi.c         | 14 +++++++++++---
>> drivers/scsi/scsi_devinfo.c |  3 ++-
>> drivers/scsi/scsi_scan.c    |  3 +++
>> include/scsi/scsi_device.h  |  2 ++
>> include/scsi/scsi_devinfo.h |  6 +++---
>> 5 files changed, 21 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
>> index c59eac7a32f2..f2db4b846190 100644
>> --- a/drivers/scsi/scsi.c
>> +++ b/drivers/scsi/scsi.c
>> @@ -321,11 +321,19 @@ static int scsi_vpd_inquiry(struct scsi_device =
*sdev, unsigned char *buffer,
>> return get_unaligned_be16(&buffer[2]) + 4;
>> }
>>=20
>> -static int scsi_get_vpd_size(struct scsi_device *sdev, u8 page)
>> +static int scsi_get_vpd_size(struct scsi_device *sdev, u8 page, int =
buf_len)
>> {
>> unsigned char vpd_header[SCSI_VPD_HEADER_SIZE] __aligned(4);
>> int result;
>>=20
>> + /*
>> + * if this hardware is blacklisted then don't bother asking
>> + * the page size, since it will repy with zero -- just assume it
>> + * is the buffer size
>> + */
>> + if (sdev->no_ask_vpd_sz_first)
>> + return buf_len;
>> +
>> /*
>> * Fetch the VPD page header to find out how big the page
>> * is. This is done to prevent problems on legacy devices
>> @@ -367,7 +375,7 @@ int scsi_get_vpd_page(struct scsi_device *sdev, =
u8 page, unsigned char *buf,
>> if (!scsi_device_supports_vpd(sdev))
>> return -EINVAL;
>>=20
>> - vpd_len =3D scsi_get_vpd_size(sdev, page);
>> + vpd_len =3D scsi_get_vpd_size(sdev, page, buf_len);
>> if (vpd_len <=3D 0)
>> return -EINVAL;
>>=20
>> @@ -402,7 +410,7 @@ static struct scsi_vpd *scsi_get_vpd_buf(struct =
scsi_device *sdev, u8 page)
>> struct scsi_vpd *vpd_buf;
>> int vpd_len, result;
>>=20
>> - vpd_len =3D scsi_get_vpd_size(sdev, page);
>> + vpd_len =3D scsi_get_vpd_size(sdev, page, SCSI_VPD_PG_LEN);
>> if (vpd_len <=3D 0)
>> return NULL;
>>=20
>> diff --git a/drivers/scsi/scsi_devinfo.c =
b/drivers/scsi/scsi_devinfo.c
>> index c7080454aea9..d2b2e841e570 100644
>> --- a/drivers/scsi/scsi_devinfo.c
>> +++ b/drivers/scsi/scsi_devinfo.c
>> @@ -134,7 +134,7 @@ static struct {
>> {"3PARdata", "VV", NULL, BLIST_REPORTLUN2},
>> {"ADAPTEC", "AACRAID", NULL, BLIST_FORCELUN},
>> {"ADAPTEC", "Adaptec 5400S", NULL, BLIST_FORCELUN},
>> - {"AIX", "VDASD", NULL, BLIST_TRY_VPD_PAGES},
>> + {"AIX", "VDASD", NULL, BLIST_TRY_VPD_PAGES | =
BLIST_NO_ASK_VPD_SIZE},
>> {"AFT PRO", "-IX CF", "0.0>", BLIST_FORCELUN},
>> {"BELKIN", "USB 2 HS-CF", "1.95",  BLIST_FORCELUN | =
BLIST_INQUIRY_36},
>> {"BROWNIE", "1200U3P", NULL, BLIST_NOREPORTLUN},
>> @@ -188,6 +188,7 @@ static struct {
>> {"HPE", "OPEN-", "*", BLIST_REPORTLUN2 | BLIST_TRY_VPD_PAGES},
>> {"IBM", "AuSaV1S2", NULL, BLIST_FORCELUN},
>> {"IBM", "ProFibre 4000R", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
>> + {"IBM", "2076", NULL, BLIST_NO_ASK_VPD_SIZE},
>> {"IBM", "2105", NULL, BLIST_RETRY_HWERROR},
>> {"iomega", "jaz 1GB", "J.86", BLIST_NOTQ | BLIST_NOLUN},
>> {"IOMEGA", "ZIP", NULL, BLIST_NOTQ | BLIST_NOLUN},
>> diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
>> index 5d27f5196de6..b67743e32089 100644
>> --- a/drivers/scsi/scsi_scan.c
>> +++ b/drivers/scsi/scsi_scan.c
>> @@ -1056,6 +1056,9 @@ static int scsi_add_lun(struct scsi_device =
*sdev, unsigned char *inq_result,
>> else if (*bflags & BLIST_SKIP_VPD_PAGES)
>> sdev->skip_vpd_pages =3D 1;
>>=20
>> + if (*bflags & BLIST_NO_ASK_VPD_SIZE)
>> + sdev->no_ask_vpd_sz_first =3D 1;
>> +
>> transport_configure_device(&sdev->sdev_gendev);
>>=20
>> if (sdev->host->hostt->slave_configure) {
>> diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
>> index 2493bd65351a..5d15784ccefc 100644
>> --- a/include/scsi/scsi_device.h
>> +++ b/include/scsi/scsi_device.h
>> @@ -145,6 +145,7 @@ struct scsi_device {
>> const char * model; /* ... after scan; point to static string */
>> const char * rev; /* ... "nullnullnullnull" before scan */
>>=20
>> +#define SCSI_VPD_PG_LEN 255 /* default SCSI VPD page size (max) */
>> struct scsi_vpd __rcu *vpd_pg0;
>> struct scsi_vpd __rcu *vpd_pg83;
>> struct scsi_vpd __rcu *vpd_pg80;
>> @@ -214,6 +215,7 @@ struct scsi_device {
>> * creation time */
>> unsigned ignore_media_change:1; /* Ignore MEDIA CHANGE on resume */
>> unsigned silence_suspend:1; /* Do not print runtime PM related =
messages */
>> + unsigned no_ask_vpd_sz_first:1; /* Do not ask for VPD size first */
>>=20
>> unsigned int queue_stopped; /* request queue is quiesced */
>> bool offline_already; /* Device offline message logged */
>> diff --git a/include/scsi/scsi_devinfo.h =
b/include/scsi/scsi_devinfo.h
>> index 5d14adae21c7..ec12dbaff0e8 100644
>> --- a/include/scsi/scsi_devinfo.h
>> +++ b/include/scsi/scsi_devinfo.h
>> @@ -32,7 +32,8 @@
>> #define BLIST_IGN_MEDIA_CHANGE ((__force blist_flags_t)(1ULL << 11))
>> /* do not do automatic start on add */
>> #define BLIST_NOSTARTONADD ((__force blist_flags_t)(1ULL << 12))
>> -#define __BLIST_UNUSED_13 ((__force blist_flags_t)(1ULL << 13))
>> +/* do not ask for VPD page size first on some broken targets */
>> +#define BLIST_NO_ASK_VPD_SIZE ((__force blist_flags_t)(1ULL << 13))
>> #define __BLIST_UNUSED_14 ((__force blist_flags_t)(1ULL << 14))
>> #define __BLIST_UNUSED_15 ((__force blist_flags_t)(1ULL << 15))
>> #define __BLIST_UNUSED_16 ((__force blist_flags_t)(1ULL << 16))
>> @@ -74,8 +75,7 @@
>> #define __BLIST_HIGH_UNUSED (~(__BLIST_LAST_USED | \
>>       (__force blist_flags_t) \
>>       ((__force __u64)__BLIST_LAST_USED - 1ULL)))
>> -#define __BLIST_UNUSED_MASK (__BLIST_UNUSED_13 | \
>> -     __BLIST_UNUSED_14 | \
>> +#define __BLIST_UNUSED_MASK (__BLIST_UNUSED_14 | \
>>     __BLIST_UNUSED_15 | \
>>     __BLIST_UNUSED_16 | \
>>     __BLIST_UNUSED_24 | \

