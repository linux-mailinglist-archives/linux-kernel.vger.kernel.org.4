Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FE464E0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiLOSfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:35:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbiLOSen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:34:43 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9A252A5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671129155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iB3EgU//2XXLYrZd0Up3941soIDemxGFb1c6VyqrhV8=;
        b=bFYX+6ASE9kjni+P2E9VBw6Iy8FYXQlOo/ogH0gVKk87yqMkbBy8fGdSnBw8Bj9aFLgRqG
        NHxHoI36vXECXWn5rZCST68Wvs/IR9RXbWsXCmX2Xkxceg8FB+APEcyC3cgTBziID3IBT0
        qv8996ZfKOGz+sGgX4WWn9xbYu/LI3Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-B9FOM99MNcOwDuIX1PyPwg-1; Thu, 15 Dec 2022 13:32:34 -0500
X-MC-Unique: B9FOM99MNcOwDuIX1PyPwg-1
Received: by mail-wm1-f70.google.com with SMTP id c126-20020a1c3584000000b003cfffcf7c1aso1494210wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:32:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iB3EgU//2XXLYrZd0Up3941soIDemxGFb1c6VyqrhV8=;
        b=YEqiS184FBWV6M39qcUhTPsNVi/en4HZUFxXyKc40KJ3/6wX4bqQGMrZN4uZjcqhoF
         pGfVLXNmQqbUqxZNvIGL+KlpSpmBUQiP1GWCgjBO3eGEuZ2iNi4bPeDvxfw+xGcmwbS0
         5kLc45SDq1Hu6o+PV3/3GXsljduFDScl6J0GqlC61UdwXWhgbBoaraZOCpL9TFMnDx2e
         9sCBAA7P53/HcKgFnN26Bp/5UYBpB4QrbvfUugVcjHUolipY8oGB75bh8b2YoxIv1unh
         toECEfOmp45saRVp60pPXpLeUBSxMrj9J7z1LwnUR90xaZV3oRdipNXEhTDx86QpBWTF
         7ukw==
X-Gm-Message-State: ANoB5pk8yBGYxagv7v6Vlz+YemdxLNwjjg3WHPm32RW4XgT2/md1B0bV
        1jf/OOMVnAkR0ppAYyLoCx18aXTFzIZzR55fdy69/VuoSJibLbUDlEetG6N7H2arhN3qgqlv9CI
        8TDga6i/nVsf57HK80gYMYJu8
X-Received: by 2002:adf:e9c1:0:b0:243:2077:8d3b with SMTP id l1-20020adfe9c1000000b0024320778d3bmr19522863wrn.5.1671129152203;
        Thu, 15 Dec 2022 10:32:32 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7p7q5OcjcrxTVQnr8+ucXYoXYB16s894QRntB9KrPkkH8ifQeQZ51M19MCeGUhhusF1pllBA==
X-Received: by 2002:adf:e9c1:0:b0:243:2077:8d3b with SMTP id l1-20020adfe9c1000000b0024320778d3bmr19522854wrn.5.1671129152010;
        Thu, 15 Dec 2022 10:32:32 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id x18-20020adfec12000000b00236488f62d6sm92212wrn.79.2022.12.15.10.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 10:32:31 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] lib/cpumask: update comment for cpumask_local_spread()
In-Reply-To: <Y5n+V0bLGKko8vOR@yury-laptop>
References: <20221213043248.2025029-1-yury.norov@gmail.com>
 <xhsmh359i71vg.mognet@vschneid.remote.csb> <Y5n+V0bLGKko8vOR@yury-laptop>
Date:   Thu, 15 Dec 2022 18:32:30 +0000
Message-ID: <xhsmhtu1w5xhd.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/12/22 08:48, Yury Norov wrote:
> On Wed, Dec 14, 2022 at 09:47:47AM +0000, Valentin Schneider wrote:
>> On 12/12/22 20:32, Yury Norov wrote:
>> > Now that we have an iterator-based alternative for a very common case
>> > of using cpumask_local_spread for all cpus in a row, it's worth to
>> > mention it in comment to cpumask_local_spread().
>> >
>> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
>> > ---
>> >
>> > Hi Tariq, Valentin,
>> >
>> > I rebased your iterators patches on top of cpumask_local_spread() rework.
>> > (Rebase is not plain simple.) The result is on bitmap-for-next branch,
>> > and in -next too.
>> >
>>
>> I had a look, LGTM.
>
> Does it mean reviewed-by? If so - for the whole cpumask_local_spread()
> series, or for the last patch?

Ah sorry, I meant I had a look at your branch for the result of the rebase
which looks sane to me.

Feel free to add
  Reviewed-by: Valentin Schneider <vschneid@redhat.com>
for this patch.

