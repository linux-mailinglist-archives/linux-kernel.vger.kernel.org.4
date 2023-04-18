Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159DF6E57DF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 05:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDRDh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 23:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjDRDhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 23:37:53 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D70EE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:37:52 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a686260adcso17669995ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 20:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20221208.gappssmtp.com; s=20221208; t=1681789072; x=1684381072;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8R9fWFJhveC/Tr0RG2k1o1szZvo2X4mY6UFtCHNecA4=;
        b=TiBaw0C02hiWWWnFfMJGa8x8t4qCby25ACAe4YTvnv6zis2gvWgwgtZDhLkEml71yJ
         0u66HGnVAbXOCcGFcf1vzcSIf6m0cwx5qxv2q7sf7aQxpwF9Q5Zj3GneQP/Ux+YT3U85
         bf7CEuHjj1Va3XXJMEroA6De1hq7jshxC6mklyeu9Tqk0yRI1KX/c/bUJkYYhaBFgfQK
         PNA8oohB7ohZ0WrQNjTyzzNbGER3vvrmU+RucR7Bao0i6TJc+/Uv6wePJr3kzabQzfDM
         c/KEeSQ2Dv5gYSvC7eKtemVukFk4JZ7mb5DyVi++DpRCobkYzjcBH9tvT9VX/yBzWwNB
         zExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681789072; x=1684381072;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8R9fWFJhveC/Tr0RG2k1o1szZvo2X4mY6UFtCHNecA4=;
        b=QwmjjAhj5rl5dtzQ2Bvgrl2Vli2xbOuSGFrA82VqLtfqryyLqU9BDpT9EAjg31ZHxE
         AKrXtncxtMOUnEk7BPkDC0niPkGP+Pb7FL2BgZdKhBgZB/LIS5jgn70hZmb1NPEhrrXa
         ASaeI9QmbpSYu2/h1IQPq0WtPWjNBiyCm4VFsu6/FTWvB+wuvd0Eon5uq+wzx1WT671W
         wk0RZMp0xmAj113iAnqqtIlo8qpWzpRlaZIdH8UBE92l83BLcxIiUw1XYPrhOplO7p2c
         x9k8A8dkE+rXW7AFUQAH6PhoQoPf4gDtp/46RCM9cpxkNVDzhDYJNO5SGgOLjshsyts2
         x9dA==
X-Gm-Message-State: AAQBX9cToX5PRU7rzTN4nQXW6SpEt8DoPj9lH5J7/4U3os11vap80p5m
        ATX76MxwPykiwOjbowqyPFtZGA==
X-Google-Smtp-Source: AKy350a1DgwXpeNPHmKni7wCqPet2VBfggUBSuCDkIxFKwsEcN77o8gWXf/QAaRY1a9AKQSHYEleFA==
X-Received: by 2002:a17:903:1208:b0:19c:fc41:2dfd with SMTP id l8-20020a170903120800b0019cfc412dfdmr871408plh.29.1681789071554;
        Mon, 17 Apr 2023 20:37:51 -0700 (PDT)
Received: from smtpclient.apple ([47.75.78.161])
        by smtp.gmail.com with ESMTPSA id jw18-20020a170903279200b001a6d4ffc760sm3074921plb.244.2023.04.17.20.37.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Apr 2023 20:37:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] nvme/tcp: Add support to set the tcp worker cpu affinity
From:   Li Feng <fengli@smartx.com>
In-Reply-To: <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
Date:   Tue, 18 Apr 2023 11:39:49 +0800
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E23A9D5C-35CF-412C-AE35-37389242BC71@smartx.com>
References: <20230413062339.2454616-1-fengli@smartx.com>
 <20230413063317.2455680-1-fengli@smartx.com>
 <7f553d34-9ada-426c-4847-c7cd1aba64a8@grimberg.me>
To:     Sagi Grimberg <sagi@grimberg.me>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sagi,

> 2023=E5=B9=B44=E6=9C=8817=E6=97=A5 =E4=B8=8B=E5=8D=889:45=EF=BC=8CSagi =
Grimberg <sagi@grimberg.me> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Hey Li,
>=20
>> The default worker affinity policy is using all online cpus, e.g. =
from 0
>> to N-1. However, some cpus are busy for other jobs, then the nvme-tcp =
will
>> have a bad performance.
>> This patch adds a module parameter to set the cpu affinity for the =
nvme-tcp
>> socket worker threads.  The parameter is a comma separated list of =
CPU
>> numbers.  The list is parsed and the resulting cpumask is used to set =
the
>> affinity of the socket worker threads.  If the list is empty or the
>> parsing fails, the default affinity is used.
>=20
> I can see how this may benefit a specific set of workloads, but I have =
a
> few issues with this.
>=20
> - This is exposing a user interface for something that is really
> internal to the driver.
>=20
> - This is something that can be misleading and could be tricky to get
> right, my concern is that this would only benefit a very niche case.
Our storage products needs this feature~
If the user doesn=E2=80=99t know what this is, they can keep it default, =
so I thinks this is
not unacceptable.
>=20
> - If the setting should exist, it should not be global.
V2 has fixed it.
>=20
> - I prefer not to introduce new modparams.
>=20
> - I'd prefer to find a way to support your use-case without =
introducing
> a config knob for it.
>=20
I=E2=80=99m looking forward to it.
=20
> - It is not backed by performance improvements, but more importantly
> does not cover any potential regressions in key metrics (bw/iops/lat)
> or lack there of.

I can do more tests if needed.

Thanks,
Feng Li

