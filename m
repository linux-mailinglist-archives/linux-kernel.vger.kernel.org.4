Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394DA6342F7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234633AbiKVRsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:48:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbiKVRqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:46:46 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626B485140;
        Tue, 22 Nov 2022 09:45:22 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s12so21648046edd.5;
        Tue, 22 Nov 2022 09:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kvyvrTAV03KH98x7yl5DC5qgb1BxRhc/RtXT1WiA70=;
        b=pIuZMaX2Jd4Bw2gypcQR7WA13ZnhbEqJYrk++MybA3dC0e4Itx/IJ12B2i6PyRZFc0
         p2+fswIc+6CFcrfqV0VZtglngibHruTu2tr0dV8XOfJMwpZrlXKZsq5YsSyhSZ+onlum
         4g6YbScJJnhf2c0N/+9AQcLkxGqcKf2Ghg1NnkCiT6P5fcCS5mYLZ0aZltwv50ahhXxs
         6ueqPQDgNfiuR/Spxn6y2PAcOpaikjL1Wxcqqe9TyBj1ab5uK10etMDz3IYxgVqXrh6f
         nBQATcXE4ZzyeN2m4NQYOGdasJgZgWhO9VWX1qKH5P11FxhbGzVRV0JSIZLkewURwfuH
         z+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1kvyvrTAV03KH98x7yl5DC5qgb1BxRhc/RtXT1WiA70=;
        b=6MAtMccgG58HiLJdx51URsSi+CS5b6CA9BJBArPcydyPNo7sGqAIY79Xr4a+UYVf8D
         Xi6pMOEauECyHO/EObrTm1OjipyMw3CWVtkwk0lYY1aY2Bi19+maszYtIjwMmhdeNZNr
         XMvoXdJz8zNAo7V7kBNfwqQOeCSJ2FhViOnJ6Im2HDuJxzFVxsqv10D3TiCnBLlygo8r
         z3OFTUUQ7FOMaBc5hjXH3mW8WBm4mFykqWuluYMblHY7wrn818Eb+D4UCBOb+KYcgW92
         zc7ylrbEdBbUyPuAEBm4uV5ex2OS/UxhMNLb9z5S7E+fYv2tzRA5pNcB8Igrv/9k+AGD
         Q5VA==
X-Gm-Message-State: ANoB5pmrGENhQRbuRUAPIX3Ek/AYgeioUIjBMT9FJLV47UhNEI3jxF1o
        Dgrv7CKDxXlQJ1OmR6qPkgC+Um3M10HJoX/GPzU=
X-Google-Smtp-Source: AA0mqf6dJW3ChCPPweQE2YWTi2TVUhpIDsuR+7bEvATh41AM5qFCSfIyeMkCvx2USRII3EWwgspuxz9BH4JnzRKuvtM=
X-Received: by 2002:a05:6402:4a:b0:461:aa10:cb0c with SMTP id
 f10-20020a056402004a00b00461aa10cb0cmr22258618edu.383.1669139121338; Tue, 22
 Nov 2022 09:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20221122213040.4128105-1-haowenchao@huawei.com> <11003745-2b2d-30cf-bf87-798f5175ae09@oracle.com>
In-Reply-To: <11003745-2b2d-30cf-bf87-798f5175ae09@oracle.com>
From:   Wenchao Hao <haowenchao22@gmail.com>
Date:   Wed, 23 Nov 2022 01:45:08 +0800
Message-ID: <CAOptpSO23ex6p=AOvjC1h1xc1ZxznLt211hufVrrS8NDVbHjrw@mail.gmail.com>
Subject: Re: [PATCH] scsi:iscsi: Record session's startup mode in kernel
To:     Mike Christie <michael.christie@oracle.com>
Cc:     Wenchao Hao <haowenchao@huawei.com>, Lee Duncan <lduncan@suse.com>,
        Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, liuzhiqiang26@huawei.com,
        linfeilong@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 1:27 AM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 11/22/22 3:30 PM, Wenchao Hao wrote:
> > There are 3 iscsi session's startup mode which are onboot, manual and
> > automatic. We can boot from iSCSI disks with help of dracut's service
> > in initrd, which would set node's startup mode to onboot, then create
> > iSCSI sessions.
> >
> > While the configure of onboot mode is recorded in file of initrd stage
> > and would be lost when switch to rootfs. Even if we update the startup
> > mode to onboot by hand after switch to rootfs, it is possible that the
> > configure would be covered by another discovery command.
> >
> > root would be mounted on iSCSI disks when boot from iSCSI disks, if the
> > sessions is logged out, the related disks would be removed, which would
> > cause the whole system halt.
>
> The userspace tools check for this already don't they? Running iscsiadm
> on the root disk returns a failure and message about it being in use.
>

It seems we did not check.

> Userspace can check the session's disks and see if they are mounted and
> what they are being used for.

It's hard to check if iSCSI disk is in used. If iSCSI disk is used to
build multipath device mapper,
, and lvm is built on these dm devices, the root is mounted on these
lvm devices, like following:

sde                                       8:64   0   60G  0 disk
=E2=94=94=E2=94=80360014051a174917ce514486bca53b324 253:4    0   60G  0 mpa=
th
  =E2=94=9C=E2=94=80lvm-root                     253:0    0 38.3G  0 lvm   =
/
  =E2=94=9C=E2=94=80lvm-swap                   253:1    0  2.1G  0 lvm   [S=
WAP]
  =E2=94=94=E2=94=80lvm-home                  253:2    0 18.7G  0 lvm   /ho=
me

It's too coupling to check these dm devices.
