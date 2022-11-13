Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2517627020
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 16:06:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiKMPF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 10:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiKMPFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 10:05:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1F8CE19
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 07:05:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D546CB80C73
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 15:05:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8164EC43470
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668351948;
        bh=JZYZkvOzwHauWn7NPk94KVzI+xuZbvY7xNa3vWZqcTY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ht67YbC0+NKcw7pvSLBppZ5KtTa70JZZ9GkqaDWoUzEZ0RgtJ7i1ND33JmKOv0M/e
         cwlZ+PK74tNTMENBhN5A1TCiDOR5rWwfat0fRDM/evdiSIvnhLpZOp6xuthGoZqH27
         z4xS+NawYISjLJGVMsI1zmdsXiz8KrlKvTWuWf8si396Zf3k/oTD8DhncF7PhXgv/N
         CATLxaK5v6EcjzlsSUlj+k5YGmB0nkK5afZafmqjBly1iv91hEu8whz0g+NMo8A9Wc
         EaMjldPJIWuskV5D1jEQlKn9ToymQMO3tjzG3uabDZWN413InDsRAOi1Vgv7lfeFpk
         tOvtTtcBsQHyQ==
Received: by mail-yb1-f169.google.com with SMTP id o70so10821698yba.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 07:05:48 -0800 (PST)
X-Gm-Message-State: ANoB5pklrN7kSzl44kuiMTKDDchNRhZ+luLr6FH0JmDEcCIKlEDR1CFn
        XL7Byr4c5rs6GWKkXQ9anw+UDh5RmZ208BXP9TY=
X-Google-Smtp-Source: AA0mqf7fFjG5yqktGJvQQkKH+rMMhMyOkIsHqbAQZkDpy1F1y6SqmlUMzkIPTmxOYQZFPHngI/sIYwr7HccFuUnpZiU=
X-Received: by 2002:a5b:b8d:0:b0:6d4:d047:5d2f with SMTP id
 l13-20020a5b0b8d000000b006d4d0475d2fmr9081375ybq.443.1668351947433; Sun, 13
 Nov 2022 07:05:47 -0800 (PST)
MIME-Version: 1.0
References: <20221106210225.2065371-1-ogabbay@kernel.org> <CAF4BF-Qo_3ZE+hwF2e-gfrQHXpZU+uyyxaOf29YLcp7wh_eCFg@mail.gmail.com>
In-Reply-To: <CAF4BF-Qo_3ZE+hwF2e-gfrQHXpZU+uyyxaOf29YLcp7wh_eCFg@mail.gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 13 Nov 2022 17:05:21 +0200
X-Gmail-Original-Message-ID: <CAFCwf10oi_g-jJU0CPYA7-s7+Nb3vGfcEZEc3ngxf77FdXH+FA@mail.gmail.com>
Message-ID: <CAFCwf10oi_g-jJU0CPYA7-s7+Nb3vGfcEZEc3ngxf77FdXH+FA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/3] new subsystem for compute accelerator devices
To:     Christopher Friedt <chrisfriedt@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Jiho Chu <jiho.chu@samsung.com>,
        Daniel Stone <daniel@fooishbar.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Maciej Kwapulinski <maciej.kwapulinski@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>, cfriedt@meta.com,
        Dan Williams <dan.j.williams@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        antonio.j.hasbun.marin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2022 at 12:04 AM Christopher Friedt
<chrisfriedt@gmail.com> wrote:
>
> Hi Oded,
>
> On Sun, Nov 6, 2022 at 4:03 PM Oded Gabbay <ogabbay@kernel.org> wrote:
> > The patches are in the following repo:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git/log/?h=accel_v3
> >
> > As in v2, The HEAD of that branch is a commit adding a dummy driver that
> > registers an accel device using the new framework. This can be served
> > as a simple reference. I have checked inserting and removing the dummy driver,
> > and opening and closing /dev/accel/accel0 and nothing got broken :)
> >
> > v1 cover letter:
> > https://lkml.org/lkml/2022/10/22/544
> >
> > v2 cover letter:
> > https://lore.kernel.org/lkml/20221102203405.1797491-1-ogabbay@kernel.org/T/
>
> I was in the room at Plumbers when a lot of this was discussed (in
> 2022 and also 2019), but I haven't really had an opportunity to
> provide feedback until now. In general, I think it's great and thanks
> for pushing it forward and getting feedback.
>
> The v1 cover letter mentioned RAS (reliability, availability,
> serviceability) and Dave also mentioned it here [1]. There was a
> suggestion to use Netlink. It's an area that I'm fairly interested in
> because I do a lot of development on the firmware side (and
> specifically, with Zephyr).
>
> Personally, I think Netlink could be one option for serializing and
> deserializing RAS information but it would be helpful for that
> interface to be somewhat flexible, like a void * and length, and to
> provide userspace the capability of querying which RAS formats are
> supported.
>
> For example, AntMicro used OpenAMP + rpmsg in their NVMe accelerator,
> and gave a talk on it at ZDS and Plumbers this year [2][3].
>
> In Zephyr, the LGPL license for Netlink might be a non-starter
> (although I'm no lawyer). However, Zephyr does already support
> OpenAMP, protobufs, json, and will soon support Thrift.
>
> Some companies might prefer to use Netlink. Others might prefer to use
> ASN.1. Some companies might prefer to use key-value pairs and limit
> the parameters and messages to uint32s. Some might handle all of the
> RAS details in-kernel, while others might want the kernel to act more
> like a transport to firmware.
>
> Companies already producing accelerators may have a particular
> preference for serialization / deserialization in their own
> datacenters.
>
> With that, it would be helpful to be able to query RAS capabilities via ioctl.
>
> #define ACCEL_CAP_RAS_KEY_VAL_32 BIT(0)
> #define ACCEL_CAP_RAS_NETLINK BIT(1)
> #define ACCEL_CAP_RAS_JSON BIT(2)
> #define ACCEL_CAP_RAS_PROTOBUF BIT(3)
> #define ACCEL_CAP_RAS_GRPC BIT(4)
> #define ACCEL_CAP_RAS_THRIFT BIT(5)
> #define ACCEL_CAP_RAS_JSON BIT(6)
> #define ACCEL_CAP_RAS_ASN1 BIT(7)
>
> or something along those lines. Anyway, just putting the idea out there.
>
> I'm sure there are a lot of opinions on this topic and that there are
> a lot of implications of using this or that serialization format.
> Obviously there can be security implications as well.
>
> Apologies if I've already missed some of this discussion.
>
> Cheers,
>
> C
>
> [1] https://airlied.blogspot.com/2022/09/accelerators-bof-outcomes-summary.html
> [2] https://zephyr2022.sched.com/event/10CFD/open-source-nvme-ai-accelerator-platform-with-zephyr-karol-gugala-antmicro
> [3] https://lpc.events/event/16/contributions/1245/

Hi Christopher,
Thanks for all this information.
At this stage, I'm mainly trying to gather information on RAS current
status in the OCP (Open Compute Project) and Linux kernel, so your
email was on point :)
It seems to me that this topic is broader than just accelerators or
GPUs, because there are other device types that are implementing some
kind of RAS (e.g. NIC).
My gut feeling is that the end solution would be some kind of generic
kernel driver/framework that will expose RAS to userspace for any
device type, but it's too early to tell.
I'll update once I have the full picture.

Thanks,
Oded
