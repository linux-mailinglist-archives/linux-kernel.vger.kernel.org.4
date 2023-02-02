Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E2F6884CE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbjBBQv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:51:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjBBQv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:51:26 -0500
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024436D5FA
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:50:40 -0800 (PST)
Received: by mail-qt1-f171.google.com with SMTP id cr22so2497668qtb.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1tztcBchRZ+ahQ+Rv8slGEZ3rlEReGoboay+wBElNpk=;
        b=m98LH0AV15WrlnFA8xo2kN/meupVPh8QKKgBdgQl/o50luIDPmi0Fb+hEfw6LmuV2y
         qmjy4JR9cM/WhCZ1wEwHSKojtexLY3MToupYpHDo/waocs3tUKOeXH3GRMoCjQc5lr+h
         SyzkKCDC0ga2W9HW0280Ljx6+bYnwJhpKUHvPUATztZ2SzBxeQuou+s05nBpY2SxgsXz
         NO2sIA5kgczX4q9BspwKVE4EKBaecj6QlFpvRtSdSzYOgMVOUV2q3DXLFfXlrweu3X7K
         QrS35tXzTRMdWMGwZxX01TF9WvTlIbwigKGNNmww3piQ/RIsM7/NPI4av5h/7IHdVj9p
         MNTA==
X-Gm-Message-State: AO0yUKVPHq0m7uC2i/SLfFt7gSUbsY3q+G85bN1p9MH+lEzXhExCnoyT
        1Kqx3Me6NKBGaG7Ud2XmYH4+Hsk+9KfSUVs=
X-Google-Smtp-Source: AK7set+4Pyeb5ompgmUg0JYUv54bCb2ceknHgU0XW/UAy594tQAOCFstY5279x2+bA/W3Ae7xhvLGQ==
X-Received: by 2002:a05:622a:1788:b0:3b8:2ea9:a093 with SMTP id s8-20020a05622a178800b003b82ea9a093mr13141578qtk.1.1675356639078;
        Thu, 02 Feb 2023 08:50:39 -0800 (PST)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id t9-20020a05620a034900b0071eddd3bebbsm31687qkm.81.2023.02.02.08.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 08:50:38 -0800 (PST)
Date:   Thu, 2 Feb 2023 11:50:37 -0500
From:   Mike Snitzer <snitzer@kernel.org>
To:     Demi Marie Obenour <demi@invisiblethingslab.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>,
        Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?= 
        <marmarek@invisiblethingslab.com>, Juergen Gross <jgross@suse.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, dm-devel@redhat.com
Subject: Re: [RFC PATCH 0/7] Allow race-free block device handling
Message-ID: <Y9vp3XDEQAl7TLND@redhat.com>
References: <20230126033358.1880-1-demi@invisiblethingslab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230126033358.1880-1-demi@invisiblethingslab.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25 2023 at 10:33P -0500,
Demi Marie Obenour <demi@invisiblethingslab.com> wrote:

> This work aims to allow userspace to create and destroy block devices
> in a race-free and leak-free way,

"race-free and leak-free way" implies there both races and leaks in
existing code. You're making claims that are likely very specific to
your Xen use-case.  Please explain more carefully.

> and to allow them to be exposed to
> other Xen VMs via blkback without leaks or races.  It’s marked as RFC
> for a few reasons:
> 
> - The code has been only lightly tested.  It might be unstable or
>   insecure.
> 
> - The DM_DEV_CREATE ioctl gains a new flag.  Unknown flags were
>   previously ignored, so this could theoretically break buggy userspace
>   tools.

Not seeing a reason that type of DM change is needed. If you feel
strongly about it send a separate patch and we can discuss it.

> - I have no idea if I got the block device reference counting and
>   locking correct.

Your headers and justifcation for this line of work are really way too
terse. Please take the time to clearly make the case for your changes
in both the patch headers and code.

Mike
