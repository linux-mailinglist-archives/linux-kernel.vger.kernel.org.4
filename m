Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8A46A4EE0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:47:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjB0Wry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:47:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjB0Wrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:47:51 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CD92A6C7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:47:22 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cy6so32337525edb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0RXLSQC7Iu4CGC+S5N03E14QHE8XVJvWIp6IPdBPR8k=;
        b=SXSmeX5N7YRzY/Riw5fOZdxkWfy/qLjp5eW9ruFC10w4FdOxLWxCF0zxJ5BaouNlTl
         pYkzLN2qZHAqqR3aC5pY/tCh75R4TBshWx2LiX4NMjuMM+WrFM5EeCUmkz3ng956gKhX
         nIq8wP2kT51eTydlhR3xaw6rC26SavejaCJ5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0RXLSQC7Iu4CGC+S5N03E14QHE8XVJvWIp6IPdBPR8k=;
        b=5rKM1oPoIMqu5wuxhqcmxGBBMhrTTqisc6hu2X5Xbsvcu4zGo3kYfO4MDE+RlJOTfp
         ZVD2/TerZJRLNK6h97vrF5PfSNlsik0BIxQv4JmVx3TPmLIn+k0tO7Lk3lW4tvcp7QWs
         mS/4hVnfKH53a8UE78hvsRfu03DpRVfAclyFO6wHJtkR9phe3Nq1UlW5O7LoifrBar7B
         ryAoBw39lM+V7K9uh2tbsa5UhP5ODo34nUKld/+AlVgNVCNkysrQBKSJUkfSozfTotj4
         FhNA1hJ5lRBUf/Vs1eZ/UjIp9VD+Lx5tPQXfjxaLoSmi7p/mfMNHjfgsoZftouiZ59HM
         nFYg==
X-Gm-Message-State: AO0yUKVjMCoXIKBCovM50W7m1Ib8ozY7gVAK4KafL1QEBOLcVKVpIjIe
        hbxNOXnVSEFFv0x5fwPFnjg/IEoa9dMHPDLFHLU=
X-Google-Smtp-Source: AK7set9AnZorDfAWLd+KMY8JeOhAwg5u8enLSbUtxvpEQnGG7I1fuirDLg+iMApbCK449bE44HshiA==
X-Received: by 2002:a17:907:a090:b0:8a5:3d1e:6302 with SMTP id hu16-20020a170907a09000b008a53d1e6302mr534623ejc.56.1677538040146;
        Mon, 27 Feb 2023 14:47:20 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id ky7-20020a170907778700b008db605598b9sm3794585ejc.67.2023.02.27.14.47.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 14:47:19 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id s26so32174080edw.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:47:18 -0800 (PST)
X-Received: by 2002:a17:906:7c96:b0:878:561c:6665 with SMTP id
 w22-20020a1709067c9600b00878561c6665mr195508ejo.0.1677538038528; Mon, 27 Feb
 2023 14:47:18 -0800 (PST)
MIME-Version: 1.0
References: <Y/iywbFbiUAA6ZD3@kroah.com> <CAHk-=whhFCeeuo6vTEmNSx6S-KKkugxgzN_W5Z6v-9yH9gc3Zw@mail.gmail.com>
 <CAHk-=wjyFhdR-M7H6JpH7zF0k_z5xj8+qERaHsh5+0c4uOmv+g@mail.gmail.com>
 <Y/qcXOxTVHTNDQbY@mit.edu> <CAHk-=wjPrei8BkaJ3wjGF_fTsehhQZVZppzqYrt76oc+oYXk8w@mail.gmail.com>
 <Y/u59FFG+ID0OAbg@mit.edu> <Y/0vrqZjKcAnaZAH@smile.fi.intel.com>
In-Reply-To: <Y/0vrqZjKcAnaZAH@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Feb 2023 14:47:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj83jsF+4L9Sa2Cm3DutatL0xNhHYSvF3d_QZeekkGeWA@mail.gmail.com>
Message-ID: <CAHk-=wj83jsF+4L9Sa2Cm3DutatL0xNhHYSvF3d_QZeekkGeWA@mail.gmail.com>
Subject: Re: [GIT PULL] TTY/Serial driver updates for 6.3-rc1
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 2:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Some of the "new" (not really, the split of the 8250_pci) drivers
> I made in the past inherited that so user won't see the change
> (sudden disappearance of the console w/o touching defconfig).

Ack. That's when 'default XYZ' should actually happen, in order to
people not miss old functionality that was split up into new config
options.

Which has definitely happened too. Then you spend an embarrassing
amount of time looking for "what broke for this device to not work",
when the answer was "that driver isn't built any more, even though the
config didn't change".

Ask me how I know.

         Linus
