Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BF362258A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiKIIem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKIIej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:34:39 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3465313D0D;
        Wed,  9 Nov 2022 00:34:38 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id z192so20258684yba.0;
        Wed, 09 Nov 2022 00:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G64WdZsGUMFmhvKtUXCONGN5yZ/sRIqlIyHpLHBy668=;
        b=cD/mHQekl5FpFm7VgGBcT0KcL9P1+BDF6rIQ0hI0+iZiLkUDMrluWZInedlyhbCGiK
         +sZU2CNPiyN0P+3XDihhe/0eKC5QnPcLVKhQOMasYdxQ2hLmskElOulE7x4EgvoezLZs
         /ZeV1MV9p3XerHT9BBQr/YyPg7aOzub3Bwzg6ji1KRnBQTQC5vEUFH5CspB0xx+cLzwj
         BtJpLljoB9N55b+fmUu/zrlHlOsYp7PHsjbUGbrH0G+xJjU/1vZweH4MJUvh+MvB4oda
         y4Nkc3N8p21Sm+qP2YG3OBGbE9rU1jTmpDj2JdnzrVTtdPONTMfM+2hdeIl08KYDcO7x
         lGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G64WdZsGUMFmhvKtUXCONGN5yZ/sRIqlIyHpLHBy668=;
        b=fCymDqBa0/HGyu2G2C+gHXgLGrklnPJyl5Jztw/PnWAd+Q4VRPEumbuQrqshfZNic1
         A+obDJKLm7Hi9s/F56e+AF5kRFHa9yuvbkyDZW5awBwAyNJ5nRcdH3FaAIxjcvifk3q+
         a9unbnqt1c2MA+Ehde5fNSYSA2hJzVZpM70KKaPSxY6qdoAq/t8fobcFSgK1NwkKK288
         MjH8qA3RAn6V8mcQocfBwnwrUsAW9d0UP8gzJVGwa/0dTl9LcZthbA6xemUtv8L4cE0K
         Q57wm1gzZ/be8cdfImeXNWXl5STByrO97tL8+UzrsE5xeA0Ay90WN/fAGeeFmXsw8w8F
         DkHQ==
X-Gm-Message-State: ACrzQf12hyrvuQNBi1xD+FNs0n+sfC6kPN/2oui93XbL2/2AYpk9BKWa
        T18NFtesHBcoZbggV0mdvkqWtMgE5xXNmZeSW6g=
X-Google-Smtp-Source: AMsMyM6Gcl+es/qsSNp7iHsVZsAdM++KIa1nE3IfPww8znseA00qC+XdhJVWeyqVAuhcUQJsSMew0u2u1aYzP9JQ1QQ=
X-Received: by 2002:a25:e303:0:b0:66e:36bc:54c5 with SMTP id
 z3-20020a25e303000000b0066e36bc54c5mr57124095ybd.483.1667982877427; Wed, 09
 Nov 2022 00:34:37 -0800 (PST)
MIME-Version: 1.0
References: <CACMswuMd18=nhvLK2Tw3H84GnDPnhuS_YRNFEDZ5T4B5DJQtBQ@mail.gmail.com>
 <87wn858bgp.fsf@wdc.com>
In-Reply-To: <87wn858bgp.fsf@wdc.com>
From:   Dennis Dai <dzy.0424thu@gmail.com>
Date:   Wed, 9 Nov 2022 16:34:26 +0800
Message-ID: <CACMswuNanu1k4WREBDMvweiQsSfdtT9OiafV271USTaExDgnkg@mail.gmail.com>
Subject: Re: nvme driver: possible missing `unregister_irq`
To:     Andreas Hindborg <andreas.hindborg@wdc.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        "baijiaju1990@gmail.com" <baijiaju1990@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I missed that point.
Now I do got it!

Thank you very much for the detailed explanation!

Best regards,
Dennis Dai

On Wed, Nov 9, 2022 at 3:58 AM Andreas Hindborg
<andreas.hindborg@wdc.com> wrote:
>
>
> Dennis Dai <dzy.0424thu@gmail.com> writes:
>
> > I was inspecting the rust nvme driver [1] and would like know if the following
> > code contains a missing unregister or I missed anything
> >
> > // nvme.rs:180, in NvmeDevice::setup_io_queues
> >         admin_queue.register_irq(pci_dev)?;
> > // nvme.rs:186, in NvmeDevice::setup_io_queues
> >         let q_depth = core::cmp::min(...).try_into()?;
> > // nvme.rs:190, in NvmeDevice::setup_io_queues
> >         let tagset = mq::TagSet::try_new(...)?; //TODO: 1 or 3 on
> > demand, depending on polling enabled
> >
> > Line 186 and 190 could abort the execution of
> > NvmeDevice::setup_io_queues without calling `unregister_irq`.
> > In the end this could result in an `request_threaded_irq` without a
> > pairing `free_irq` on failure.
> > Or is the job done by Rust by auto dropping?
>
> In line with my reply to the other potential sleep bug you reported,
> teardown is not properly implemented yet, and I did not review the
> teardown code that is already in place.
>
> But, if you look at the `register_irq()` and `unregister_irq()`
> functions of `NvmeQueue` you can see that the registrations are stored
> in an `Option` within the `NvmeQueue` structure. So when the `NvmeQueue`
> struct is dropped, the registration will be dropped. Also, if we call
> `register_irq()` twice and forget to unregister the first one, it will
> be unregistered when we register the second one (because we call
> Option::replace()).
>
> So as long as the `NvmeQueue` structs are dropped, we will not leak
> IRQs. In case of one of the lines you point to return an `Err`, the ref
> count of the `kernel::device::Data` allocated in `probe()` would go to
> zero and it would be dropped and thus the IRQs would be unregistered.
>
> So yes, it is handled by destructors that run on drop.
>
> Best regards,
> Andreas
