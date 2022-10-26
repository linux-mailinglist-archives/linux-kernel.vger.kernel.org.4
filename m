Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86D9960DFA0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 13:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233317AbiJZLfD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 26 Oct 2022 07:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233067AbiJZLe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 07:34:58 -0400
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8906E4C02C;
        Wed, 26 Oct 2022 04:34:56 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id f22so9613880qto.3;
        Wed, 26 Oct 2022 04:34:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBNLraN5ZlPas7mvwACMcqvSkECOIdd8sfrQyWAPSsg=;
        b=vaNuE258lTBtrpW8aVyPyqCXzj7dOJ7ZJobFAYPhXHXOu5qDNiwmhdZEE1wNY8AkhW
         cmBsxX0S/gu7uQDowJRr+N0m3nEXt8b7G0l8A7paFjnkqMj5vs7L3KaKUnXQZQicaHJi
         w4I3dQym2S9wy9y3J0vOe1Z7/sRx1Xf6+BhByMZiDTAy7osNwCNVW2nSU9L+9p9uCetr
         GEYCE/a1VKbCQOzkiR6RtpA/z8suArySa5UyNQKPrNdhxUKYfPeNa4OBHLNUzf3iGhKV
         W3GDQjqWRJNcIGpUWbmp4wFT6cycpmAOLSuB51nkKXHikLWdI2XZxjNcySEd7cbgj//2
         q2Bw==
X-Gm-Message-State: ACrzQf1FcuU3gUiNXeeAZMt1tsMgoNaTl4eW+l6oVed65Fqdk1uube9Y
        3cNpSN9AH8OGlCUlliJ/hSoXxuHqFQmmWzHDSwc=
X-Google-Smtp-Source: AMsMyM4p50UTl+SzytrbMsqd/XhFdffQ0DVxtyH7IZtlFq0RFEnSOKxw8IKoA39eUN3Vd9JFqDi0seHxCCfCBaYpSkY=
X-Received: by 2002:a05:622a:1a25:b0:39c:b862:7318 with SMTP id
 f37-20020a05622a1a2500b0039cb8627318mr36095197qtb.147.1666784095620; Wed, 26
 Oct 2022 04:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <20221017182035.3g67uudttl6k5gag@bogus> <20221017184338.64152-1-pmanank200502@gmail.com>
 <b936b12e-8b2c-4583-1c71-1f914d0fdb82@huawei.com>
In-Reply-To: <b936b12e-8b2c-4583-1c71-1f914d0fdb82@huawei.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Oct 2022 13:34:43 +0200
Message-ID: <CAJZ5v0jyt5fd8v9O8U9t=TXdMgKQAX9Si0j0yN+62q6HxL2Vow@mail.gmail.com>
Subject: Re: [PATCH v2] "ACPI: PCC: Fix unintentional integer overflow"
To:     "lihuisong (C)" <lihuisong@huawei.com>,
        Manank Patel <pmanank200502@gmail.com>
Cc:     lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 3:13 AM lihuisong (C) <lihuisong@huawei.com> wrote:
>
>
> 在 2022/10/18 2:43, Manank Patel 写道:
> > Fixed unintentional u32 overflow by changing PCC_CMD_WAIT_RETRIES_NUM to 500ULL
> >
> > Fixes: 91cefefb6991 ("ACPI: PCC: replace wait_for_completion()")
> >
> > Signed-off-by: Manank Patel <pmanank200502@gmail.com>
> > Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> >
> > ---
> > Thank you so much @sudeep for your clarifications!
> >
> > Changelog:
> > v1->v2:
> >          Change the macro itself to ULL instead of typecasting in the
> >          code
> >
> >   drivers/acpi/acpi_pcc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
> > index ee4ce5ba1fb2..3e252be047b8 100644
> > --- a/drivers/acpi/acpi_pcc.c
> > +++ b/drivers/acpi/acpi_pcc.c
> > @@ -27,7 +27,7 @@
> >    * Arbitrary retries in case the remote processor is slow to respond
> >    * to PCC commands
> >    */
> > -#define PCC_CMD_WAIT_RETRIES_NUM     500
> > +#define PCC_CMD_WAIT_RETRIES_NUM     500ULL
> >
> >   struct pcc_data {
> >       struct pcc_mbox_chan *pcc_chan;
>
> Acked-by: Huisong Li <lihuisong@huawei.com>

Applied as 6.1-rc material, thanks!
