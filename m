Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5B46E5806
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 06:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjDRETm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 00:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjDRETk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 00:19:40 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7390730EB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:19:39 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso422970b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 21:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681791579; x=1684383579;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w86gJAhoELPWbQ0kBXqbW1Hm3r2Lz92kBgyMVlQb8Ss=;
        b=Bfz2EbDY99QT7EWm8oPKuvrZRJ43BXybqqoSqz0EJbihjVWpBxJV7dDvMteaRjCUt9
         vOv3vAW11Tod+BIoEb6ck24vXPZI5dJlBExyMLkiOvI1PdHoPAPPlA6P8uE02gUK0I4Q
         vk0OeGmQGPyKb5Lw34xEnOsWtk32qAR6BXTWDXl6SVhX5pQV18n/+i6lJj1ewYwoqpYQ
         RvZmrBfGHyBpMebGoLXYPDEVP1NPaALkc9kswr/4gA5mK+aZz2fskqISCM9DSRgXYB/r
         fFl1fsToBAdnM94XbYsAEBpOtiRwFIwXZC01LF9/eD90kMpyzfrrnNZDelXydOuaHBpP
         GzNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681791579; x=1684383579;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w86gJAhoELPWbQ0kBXqbW1Hm3r2Lz92kBgyMVlQb8Ss=;
        b=ClAVU9nq8kMi/c5Y2ju5dMGzafRIXyHOUce7Q3Y+EYHi8JLdxl8l2vpHt6+ORg90aV
         ZIF8PS6D3ZmY4I/hwCqocnDhYCerWwaOvl6T2+ELcy/S8NYvsu4o2nL7V/coLNV+vMmD
         8j8ZeiCFyH7moX9TqqQupdmZODen66AU/N4e2nMCRQ6QSBHwfDdiOGP4YafOqU2l0g7s
         BlsFU/yyq3OBcI0or/Y3hnHceOIe/9+3dvGzKqJ5d46+4yTRQ6Hie5Rz7HnCXxALzWw/
         q7VcrUxd3JarCZGwtwh2WsqEu8g4XDLiKnoC1I9hJ6teZggWM5NjpvwH6B5kMoCKoeq6
         oyFw==
X-Gm-Message-State: AAQBX9dA08wwWkcnBiBqMByWaup9mHJCanTwCQOR+OFD5Sb/CrkOZvET
        mcncv/+q6/ozF9zdhlZAhJtw6A==
X-Google-Smtp-Source: AKy350ZeReyCH1wIPZxgVhnXkJZIZJmmc7+mlLTGdyROo0IgG247CGqE/6SZtiXGoBNvoBZXpB9gbw==
X-Received: by 2002:a05:6a00:1892:b0:63b:859f:f094 with SMTP id x18-20020a056a00189200b0063b859ff094mr13974233pfh.20.1681791578849;
        Mon, 17 Apr 2023 21:19:38 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id a2-20020aa78642000000b00632bb373949sm8311895pfo.158.2023.04.17.21.19.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 21:19:38 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
From:   Li Feng <fengli@smartx.com>
In-Reply-To: <8310edb2-84cf-6211-f37d-d8f3df1e2320@nvidia.com>
Date:   Tue, 18 Apr 2023 12:21:31 +0800
Cc:     Sagi Grimberg <sagi@grimberg.me>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C13EBEE0-787E-44CF-8531-B4C39C3E10CC@smartx.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
 <8310edb2-84cf-6211-f37d-d8f3df1e2320@nvidia.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> 2023=E5=B9=B44=E6=9C=8818=E6=97=A5 =E4=B8=8A=E5=8D=8811:58=EF=BC=8CChait=
anya Kulkarni <chaitanyak@nvidia.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
>=20
>> - It is not backed by performance improvements, but more importantly
>> does not cover any potential regressions in key metrics (bw/iops/lat)
>> or lack there of.
>>=20
>=20
> I've already asked for this, without seeing performance numbers
> and any regression for general usecase it is hard to justify this.
>=20
> -ck
>=20
>=20
Hi ck,
Thanks for your comment.

In the previous mail, just paste the 256k read result(1GB/s to 1.4GB/s), =
I will add
more io pattern result asap when the machine environment is available.=
