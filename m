Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A754D636761
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 18:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbiKWRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 12:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238503AbiKWRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 12:39:05 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5014898DA;
        Wed, 23 Nov 2022 09:39:04 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id s5so25794170edc.12;
        Wed, 23 Nov 2022 09:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kY1l32BjvmTEjJLwJuMtTS3l+ptPCvj6BygkCcwmqdA=;
        b=FydYzUivVhWzTDIFaXUTJQlHJ+RXRHhbd6TAM7hKoDPhbDMhxSutKnKJaDNkrCJ6mq
         SxKqG+Gm/HYNo2YpWD6E/QayLjEaU8UIyiUtcWtXcEYxQtPVWfMG36DpDy4zGHvaVzmw
         IK2GD3H1OTOOy4ApHBk3lACJbLztCIFu0URTfjBl/Y0Yj4YMLQsf59VSVF9wqc4DM0Je
         IGWpws3Muv7yQA5dDP7nmP7+KjMRuWfaZ8+JVQ9nyiqK2TolF8US0sJ1HS9OLWIKrW23
         KIIMW1Vfwg3Gloq166cQI1vFdUK0uOgR+JSwsYkpJz9W6VCnm2tOpxUjmvgCJo1N75Xz
         Gu5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kY1l32BjvmTEjJLwJuMtTS3l+ptPCvj6BygkCcwmqdA=;
        b=tCGFNg4DymVx3e5431XPcTbXO/aqqFCEVe8SziXBn/ly5/C6EeEElxbSWB61OWJI+a
         u1osQ9tP9VQV9SavDDs8wD52URBJO7atn2i36QNt5IjIkxwAka8DfVt0g30mJ7e/4BjB
         Lieh8GauiI54aIXguYWTQyAfLaWZxz5FnpUwxnk0TS8WVdH4nC6V/gGcXHX+0Gx5928s
         LiO8EKdJuBqO5tcFDniW1zfz0X8oZLyamLJe+tPv/0URqHJOBQXRs6reoqzr3P9EfLGu
         ebxBQvdJjOeICHLWltDQvuZj3Kl4OBKplrjqS7JUkh49nPyalGdEadDxkXRhXFYzOi3s
         7SvA==
X-Gm-Message-State: ANoB5pkB0X2x4BPrvQXH8b0oEEzBZvB/dvTj3luyd/XlFDH3va6x7LIW
        B4zXk727JosnVfWAbv/h70O4u2UEUHzXeDcfoH0=
X-Google-Smtp-Source: AA0mqf45GjSHrPoTrfxcuwQC8LmpekL9dlSnJfrFJnQjoraO9pYapCJIbdfySrra661SWHZQzcVWPogwQrjzWuyLeIU=
X-Received: by 2002:a05:6402:10c4:b0:467:7827:232 with SMTP id
 p4-20020a05640210c400b0046778270232mr27594712edu.268.1669225143120; Wed, 23
 Nov 2022 09:39:03 -0800 (PST)
MIME-Version: 1.0
References: <20221122213040.4128105-1-haowenchao@huawei.com>
 <4d21f806-6653-5457-918c-563a3032d128@suse.com> <00f11c61-a53f-c48a-017f-4c06055ea708@huawei.com>
 <717da158-5a7e-b478-61d3-3753b0b00e01@oracle.com>
In-Reply-To: <717da158-5a7e-b478-61d3-3753b0b00e01@oracle.com>
From:   Wenchao Hao <haowenchao22@gmail.com>
Date:   Thu, 24 Nov 2022 01:38:51 +0800
Message-ID: <CAOptpSMO5+Orp20S=WD-SezVOBEwJyKJSMjaCENN+4jXMX2X-A@mail.gmail.com>
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 1:29 AM Mike Christie
<michael.christie@oracle.com> wrote:
>
> On 11/22/22 10:41 PM, Wenchao Hao wrote:
> > Sorry I did not highlight the key points. The root reason we need to record
> > node_startup mode in kernel is userspace's node_startup mode is unreliable in
> > some scenarios:
> >
> > 1. iscsi node and session is created in initrd, the configure files of these
> >    nodes would be lost after we switch to rootfs
> > 2. someone do iscsiadm -m discovery but did not specify the operation mode,
> >    the iscsi node's node_startup would be updated to which specified in iscsid.conf
> > 3. someone do iscsiadm -m node -o update to update nodes' configure
> >
> > What's more, it seems "iscsiadm/iscsid" only refuse to logout of an ONBOOT
> > session when logout is specificed by "--logoutall". We still can logout an
> > ONBOOT session with "iscsiadm -m node -u comamnd".
>
> logout_by_startup does go by the startup setting, but I think you missed the
> session_in_use related code. It checks the mounts and holders already. Just
> change it for whatever you need. I think your lvm use case should be covered
> by the holder check. If not, add it.

I did not enable the iscsid.safe_logout in iscsid.conf, so the session
still could be logged out.
If tested with iscsid.safe_logout set to "Yes", the issue is solved.

Thanks a lot
