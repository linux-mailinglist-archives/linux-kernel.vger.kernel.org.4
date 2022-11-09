Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67AE6226D5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbiKIJYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiKIJYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:24:17 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8971C904
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:24:16 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id v81so18181775oie.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9aoSzj5gFxWAAaDB9wA+hoVy7J4arsSLOOrNC4UGVPg=;
        b=opMudCvE/uIcxq/mbzLqp6Usd8n7tmy8E0goFgUu1BbD32iPe2CKZjwkTqAy7o1BCd
         8EzTT7m5Ouxrlf1jH8qJcOeiEybtjjXDCzzbcDSosBMzhV/dH0AsPUvMbMLixIXP1BKF
         F3IHse1rYDvu0U9A9vKndRo8384wJIUpdZuE+DngltUsVnHJ2+vjBSPC3JkmIFYT5BIl
         7ygUfcxHSpEQPFTu4ArGfKKkqtkigq2xFUlczC/1EEoi3Wu0N3Q/TjyYUX4aSmY6NbYG
         ykenkvWEgSzbVwhJotI0hPJ/bzSxggLipq87CHL/tQ8FbFioei4J1zjCIZmqTp4RtKBx
         lmjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9aoSzj5gFxWAAaDB9wA+hoVy7J4arsSLOOrNC4UGVPg=;
        b=GBLSXhE4OtThWztkRXX2xYsQwIgX8+UInFjYLFPowOfd9y5Je4I3+PRoznOVmRD7VS
         I/KVp7j+lPKbkbW2CPp4A9TsYtrwx3dB+2D7R+ciB4/r9qx7Pst9aNIIJQF33M4BeQMa
         cO3rnJB7Wwb5O7PClQ7urpX6i1emyub5QI5jxmsmLbVyh/CV86JG/fUrMNYRncAN6F+W
         x6PUG2z0Azo0bh1tkBH9uAMM+S5QDlKD46x3nl+onK2ocLK2tqkAgf0p7djYuDBOsqhO
         ryOQMwVgV61/A4qMqJaO7FgnfBHlmWKoiNwlHzR5LE2G10/Kei3NxSeX4htpt6CJE4Rg
         NHYw==
X-Gm-Message-State: ACrzQf0w+XDxVU2MN6CrbEC4wfdzmm88kJqFcjv3Y6BxUhXO8LxF4H5G
        puoKoNdcf4xQRp8TxJEHzGXAjTuOeQVzrJO5rnM=
X-Google-Smtp-Source: AMsMyM666Vl2iG/RCacDGcDpyIKxeGR42x8l3wbaEqUxXZXwmG4k8d3KEDmqlQ1ad4SknwzzmeqVXFoDw+JUINcqNmc=
X-Received: by 2002:aca:e108:0:b0:345:a189:fea9 with SMTP id
 y8-20020acae108000000b00345a189fea9mr32923011oig.129.1667985856146; Wed, 09
 Nov 2022 01:24:16 -0800 (PST)
MIME-Version: 1.0
References: <20221109084142.226960-1-zyytlz.wz@163.com> <Y2to4/kH6Gu+ykpk@kroah.com>
In-Reply-To: <Y2to4/kH6Gu+ykpk@kroah.com>
From:   Zheng Hacker <hackerzheng666@gmail.com>
Date:   Wed, 9 Nov 2022 17:24:05 +0800
Message-ID: <CAJedcCwzQj7pLzejX01PeuwL3a-DwRFmAEBLR-CR3_bAc0tx1g@mail.gmail.com>
Subject: Re: [PATCH v6 RESEND] misc: sgi-gru: fix use-after-free error in
 gru_set_context_option, gru_fault and gru_handle_user_call_os
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Zheng Wang <zyytlz.wz@163.com>, zhengyejian1@huawei.com,
        dimitri.sivanich@hpe.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, alex000young@gmail.com,
        security@kernel.org, sivanich@hpe.com, lkp@intel.com
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

Greg KH <gregkh@linuxfoundation.org> =E4=BA=8E2022=E5=B9=B411=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=B8=89 16:46=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed, Nov 09, 2022 at 04:41:42PM +0800, Zheng Wang wrote:
> > Gts may be freed in gru_check_chiplet_assignment.
> > The caller still use it after that, UAF happens.
> >
> > Fix it by introducing a return value to see if it's in error path or no=
t.
> > Free the gts in caller if gru_check_chiplet_assignment check failed.
> >
> > Fixes: 55484c45dbec ("gru: allow users to specify gru chiplet 2")
> > Reported-by: Zheng Wang <hackerzheng666@gmail.com>
> > Reported-by: kernel test robot <lkp@intel.com>
> >
>
> Why the blank line?

> Sorry for the spelling problem, fixed it next version

> And the kernel test robot didn't find this issue, right?
>

Yes, it helped with the test and found an unused variable. I added
this line as the mail suggested
("If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>").

Should I remove it?

> > Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
> > Acked-by: Dimitri Sivanich <sivanich@hpe.com>
>
> You can not have a reported-by and a signed-off-by for the same person
> with different email addresses.  You do not need both if it is you, just
> use the signed-off-by line.
>

Thanks very much for your explaination. I'll send another patch as
soon as possible.

Best Regards,
Zheng Wang
