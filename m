Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD41691D42
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 11:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjBJKvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 05:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbjBJKvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 05:51:51 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194E77DBF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:51:50 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o13so4842652pjg.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 02:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAe6FMbvvgCZ9LFy/itKsYUmSI1WNnMDPVCSVx+rDow=;
        b=Tvxd4zxoZyfpdlowYgF35Gh/x92a8dVJG7H2Vhaf/t0SUxAGX+0fe1qwtPnX2TuHCn
         4c5LMj4TXx7wUkMoMSKKTgDrvNxqYLPHzLJfIUOMg+LvjwwYmoMftAZ/OmMdNFqQxLN2
         z8+WdFTuFBVSOIRkPiky/tM7TXXiXsuhFTJ+ck0+vB4GdXnYA7ssxP8TMWOxV+UtJDl2
         fGu7VYvpqJIC8W+yTptgC16lw/Pxc3Zp4n+OiKSSh3AgiyEtaIBgMyLy5rtLOZI3clOM
         Z0dpD5xq1wCFtUk1Ly0xYLXuMGZRAAfM/SDaT4pIVpe+aLazFcfLNCCU8+wrdZZu+zDk
         ADzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAe6FMbvvgCZ9LFy/itKsYUmSI1WNnMDPVCSVx+rDow=;
        b=vD3LZ+KKIN68mCiohWsZtlZlUIloPCwdx5kKY+ZAFR5IP0YcUUlxpS8sgJH0es5UIA
         6EnNTopwuUkOK8R9CqMyjkBpWEA0Zv0huPmkfP1qRLr/8MI/E8XxQRqFeGJGQWbKycp+
         FmISUPYaCZA/lF+YUXxr4Wgwsi3vZK090XMM9pDInzw5lmDby8YsO+mb1N+FuhcPc4rp
         MyH44+asCxz3bf78CZ/DDhEa+hpBFBLCrM2tBCI9Iuf3fnXr63FZDQ+4QNcGOYYox5s0
         WhQp55H/9vRKJuRKogvONT1WmqS81pdG3/KPuA7du/EW0RiI5aDlQwZOoksFRjGnydMt
         m8uA==
X-Gm-Message-State: AO0yUKURJ0HX6HWde6efF1/ly9M/6Ky1bdhn/hPKlgGnfNfjYj9PwlXh
        lLQi+GLGS+k6Bbn258mrDZsrPytr2Ce6UezQD1SQeQ==
X-Google-Smtp-Source: AK7set8bewvYWPQfIW2SF+/Phcqe1GJBmCNY6jecikuEuhNmaDsr403UhuJvHNT2SGYDPF6o/rGevKcjXLcdcbtk0iU=
X-Received: by 2002:a17:90a:16d6:b0:230:8005:5c05 with SMTP id
 y22-20020a17090a16d600b0023080055c05mr2487473pje.33.1676026309439; Fri, 10
 Feb 2023 02:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20230209152123.3186930-1-jaz@semihalf.com> <20230209152123.3186930-2-jaz@semihalf.com>
 <87ttzu1zqi.ffs@tglx>
In-Reply-To: <87ttzu1zqi.ffs@tglx>
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
Date:   Fri, 10 Feb 2023 11:51:38 +0100
Message-ID: <CAH76GKMFd+kdca39nVtZG4xKqp6kL5RDZ24-NHqufZAXDzdhoA@mail.gmail.com>
Subject: Re: [RESEND RFCv2 1/1] platform/x86: Add virtual PMC driver used for S2Idle
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, rafael@kernel.org, dmy@semihalf.com,
        tn@semihalf.com, dbehr@google.com,
        zide.chen@intel.corp-partner.google.com, seanjc@google.com,
        upstream@semihalf.com, hdegoede@redhat.com, markgross@kernel.org,
        dtor@google.com, mario.limonciello@amd.com,
        linux-pm@vger.kernel.org, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 9 lut 2023 o 19:05 Thomas Gleixner <tglx@linutronix.de> napisa=C5=82(=
a):
>
> On Thu, Feb 09 2023 at 15:21, Grzegorz Jaszczyk wrote:
> > +
> > +static struct acpi_s2idle_dev_ops amd_pmc_s2idle_dev_ops =3D {
>
> What is AMD specific about this?

Nothing, my bad - I will remove the 'amd' prefix.

>
> > +     .check =3D virt_pmc_s2idle_notify,
> > +};
>
> ...
>
> > +
> > +MODULE_DESCRIPTION("Virtual PMC Driver");
>
> Lacks MODULE_LICENSE("GPL")

Sure,
Thank you

>
> Thanks,
>
>         tglx
