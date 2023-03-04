Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738DC6AAD84
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 00:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCDXhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 18:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDXhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 18:37:32 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F72712077
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 15:37:31 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id k10so518688edk.13
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 15:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1677973049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+/lbf3pRH4GEnXXO6XgzXlucudkUa6edzWyNE+Dnks=;
        b=XZhnPUxDdrVyuhYQGEvuqFyLspoLTzdRrYf9kmy9BUAB1BSurTrpDbdw+/DcTzlHx4
         GLva4noO4jKZUtwiHdx0f6D+q0CXBPZymx7+AnMhZEcvVsXoUirURjHz9N6mssGungAD
         Pks23WRVCYI7d3e9+a5FePAut1FivnfaQU030=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677973049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+/lbf3pRH4GEnXXO6XgzXlucudkUa6edzWyNE+Dnks=;
        b=3Gj6TXAOQQVl4LMn7lre3hW6B14VxDBaze4a8SYuvt7+DuQ8f8Mp2ym6e1n2yBexam
         k/inYWLF7j0BvnCWLNrEjokIWY81kUmFxXwCJZqwenYwaw4lGom/7A7vm7cJ1o/tMAfd
         8KX5GMbTErsuy6kdIUfkV+k+Ow4BU03snYLClMuBJI1S0dRF+M1dkI4v0eGb1TUOrk5i
         2jPdMv2WhaaKmIGia3ery3X+IuumqedaLfzCh4T0+Q6uw2z0nHn4HYh8DGalyG5XWzkG
         d2+0uEG3m0dyvRmRJUmNu/7j2Ncz3BdYr2cSA+r+aZU2S23wrDpMP3EZfQEzkCDTFZQm
         GE7A==
X-Gm-Message-State: AO0yUKUoPQ0HMBC0TrVmvIC7IsP0bXecTQu0416sCdUGtbmxUvyicOOo
        dhEI6HIvPPSOlWPpL005rOynTNv6FpYBfZnaBiyk5g==
X-Google-Smtp-Source: AK7set/t/ssYlKOH37D4BZrP0r+yFa59vYeKtgm1zXGgFe3T//uCPo1jUz3FUH0PhmZOGrIOuqvlAA==
X-Received: by 2002:a17:907:7604:b0:8de:e66a:ece9 with SMTP id jx4-20020a170907760400b008dee66aece9mr5191295ejc.24.1677973049338;
        Sat, 04 Mar 2023 15:37:29 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id op28-20020a170906bcfc00b008e309da3253sm2508080ejb.202.2023.03.04.15.37.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Mar 2023 15:37:28 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id u9so24492746edd.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 15:37:28 -0800 (PST)
X-Received: by 2002:a17:906:2bc2:b0:8f1:4cc5:f14c with SMTP id
 n2-20020a1709062bc200b008f14cc5f14cmr2954554ejg.0.1677973048247; Sat, 04 Mar
 2023 15:37:28 -0800 (PST)
MIME-Version: 1.0
References: <20230304131528.4645d19a2ab897fb7518159e@linux-foundation.org>
 <CAHk-=wj9guryjifHyr26w73ta+kNeoHtGde682Z5N6OSjKu4UQ@mail.gmail.com> <20230304152058.de91bf7abf424383ce31d500@linux-foundation.org>
In-Reply-To: <20230304152058.de91bf7abf424383ce31d500@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 4 Mar 2023 15:37:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHX2NQiVH8uQZ_U8vB=qnzmQHauGAqAkC=4ZWp95ya8w@mail.gmail.com>
Message-ID: <CAHk-=wiHX2NQiVH8uQZ_U8vB=qnzmQHauGAqAkC=4ZWp95ya8w@mail.gmail.com>
Subject: Re: [GIT PULL] hotfixes for 6.3-rc1
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sat, Mar 4, 2023 at 3:21=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> Ah. Ying did it this way:

Yeah, I saw that patch flying past, but I actually think that it only
silences the warning almost by mistake. There's nothing fundamental in
there that a compiler wouldn't just follow across two assignments, and
it just happens to now not trigger any more.

Assigning to a union entry is a more fundamental operation in that
respect. Not that the compiler still doesn't see that it's assigning a
value that in the end is not really type compatible, so a different
version of gcc could still warn, but at that point I feel like it's
more of an actual compiler bug than just "oh, the compiler didn't
happen to follow the cast through a temporary".

            Linus
