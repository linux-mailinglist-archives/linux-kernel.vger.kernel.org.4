Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207426739EB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 14:22:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjASNW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 08:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbjASNWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 08:22:25 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ED98A43;
        Thu, 19 Jan 2023 05:22:24 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-4e4a6af2d99so26604877b3.4;
        Thu, 19 Jan 2023 05:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G4fZ9zBI53tAb3LwiJE/Rf4i55bprLCIO2PumR6qd/k=;
        b=Yqpo72Dt0Vy3DBQ0lbnuCkjZROFPgsp9fKyaptY11lCxfcX1+y3mnoFub2Lg0mjIhB
         LsUtFhxslYZp22POlouANUCr0z6FYkYavenLzlTDBh8JGOMJc/I+OXbbqWBp3Ga0a6iA
         E8CiJv0znZqAb7H5Vd9D3YaXfGxGu6iu+aggVyMlPTEGSySEtYN0sI38ZxiRayEfD284
         4h3joigVuGUlquNB2o9kJwpvPGp0FCOfwqeQs9oKtbUVoHYA1XmbwXERc0PJM3ZpYwm4
         XDFyp+cDMnPCxMGTe+B7ij//uVhyaxUhAsqCoe+O+p3ipLlUB6CQX5l6pNzyKtoFQEK1
         laCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G4fZ9zBI53tAb3LwiJE/Rf4i55bprLCIO2PumR6qd/k=;
        b=jtk2uq/l7MGPVx1OxiYjOadT8NQNNABlKhsdr5cR717dI/+7nxSFpiCXRUp97qzvOM
         tQM7yO1xu4fnH0zJ7kprXVKFWxuh/xPZ++U/seOxObxYWM3MFABGNOUGTpez2FVPIrYt
         qyx+39VX5PZ8Sf366yZLnoNto2XJcKZKWHNpE+EKlTC4zklrs2ilqkwd7yjPeoihfUhC
         3qqIl70CdxtdDO+szDl3GndfYcoRTCt7dE4fCjz+/rx3Xs73lndHJl23s+jLmVKHSo3+
         Gadq1WyTj1H9M39j3v+4b+HGkLHhIwfWnCCsnDKRv7PITSQKOr8MTF+4k1hvnIiDHJ7a
         1/QQ==
X-Gm-Message-State: AFqh2kqv2juaDVL2L5HjIY4ASO6E5WjMj4T8K2yvIFWKYs//3l/LER8W
        4l7jX7V6ZULCa7FNvL4z+jc=
X-Google-Smtp-Source: AMrXdXsyWixdXkY4yqV98IMqp19Qw0xGQkiTvoR5q1FyXSVIOgU5JoCEx5kkhcVMtB9LIzOaNpvozg==
X-Received: by 2002:a81:9b51:0:b0:47e:f5c4:2bda with SMTP id s78-20020a819b51000000b0047ef5c42bdamr8610330ywg.12.1674134543260;
        Thu, 19 Jan 2023 05:22:23 -0800 (PST)
Received: from p200300f6ef015700e657423a1f156bec.dip0.t-ipconnect.de (p200300f6ef015700e657423a1f156bec.dip0.t-ipconnect.de. [2003:f6:ef01:5700:e657:423a:1f15:6bec])
        by smtp.gmail.com with ESMTPSA id bq35-20020a05620a46a300b0070209239b87sm4475647qkb.41.2023.01.19.05.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 05:22:22 -0800 (PST)
Message-ID: <93c5f822dd332c188e05da2d7e7eb1ac72cc6067.camel@gmail.com>
Subject: Re: [PATCH v1 1/2] iio: core: Replace
 iio_sysfs_match_string_with_gaps() by __sysfs_match_string()
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Date:   Thu, 19 Jan 2023 14:24:07 +0100
In-Reply-To: <Y8koLwGVjyrDb66P@smile.fi.intel.com>
References: <20230118074828.66155-1-andriy.shevchenko@linux.intel.com>
         <5f9b713b-9c71-7da6-e674-b6ebd28dc5d5@metafoo.de>
         <Y8gVDs0UoiHqCRsM@smile.fi.intel.com>
         <64406c4f-c9da-b434-360b-1050ff685d2d@metafoo.de>
         <bb2e8b7b4ca894ed53d70bf04e2d52bed2553105.camel@gmail.com>
         <Y8koLwGVjyrDb66P@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2023-01-19 at 13:23 +0200, Andy Shevchenko wrote:
> On Thu, Jan 19, 2023 at 09:00:45AM +0100, Nuno S=C3=A1 wrote:
> > On Wed, 2023-01-18 at 08:37 -0800, Lars-Peter Clausen wrote:
> > > On 1/18/23 07:49, Andy Shevchenko wrote:
> > > > On Wed, Jan 18, 2023 at 07:22:30AM -0800, Lars-Peter Clausen
> > > > wrote:
> > > > > On 1/17/23 23:48, Andy Shevchenko wrote:
> > > > > > None of the current users is using gaps in the list of the
> > > > > > items.
> > > > > > No need to have a specific function for that, just replace
> > > > > > it
> > > > > > by
> > > > > > library available __sysfs_match_string().
> > > > > Hm, I specifically remember adding this for a driver where
> > > > > there
> > > > > were gaps.
> > > > > One of the DACs. But it might be that the driver itself never
> > > > > made it
> > > > > upstream.
> > > > I have checked all modules that have struct iio_enum and/or
> > > > ("or"
> > > > probably may
> > > > not happen) IIO_ENUM() in them.
> > > >=20
> > > > It might be that I missed something.
> > > I checked too, I can't find it either. The driver probably never
> > > made
> > > it=20
> > > upstream.
> >=20
> > Yeah, I also did a quick check and I could find it in one adc (most
> > likely we have more downstream users of this) that did not make it
> > upstream. Eventually, we want to have it upstream but the ABI using
> > the
> > gaps can arguably be dropped...
> >=20
> > Anyways, from my side I'm fine with this change. We can revert it
> > if we
> > ever have a real user for this. I'll just have to be careful when
> > updating ADI tree (but that is our problem :)).
>=20
> We usually do not keep a dead code in the kernel, and handling gaps
> is a dead code.

Yes, I know... That is why I cannot really complain about this
change :)

- Nuno S=C3=A1

