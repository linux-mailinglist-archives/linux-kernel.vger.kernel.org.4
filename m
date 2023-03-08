Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0824A6AFB9B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCHAzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:55:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCHAzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:55:51 -0500
X-Greylist: delayed 886 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Mar 2023 16:55:49 PST
Received: from a27-22.smtp-out.us-west-2.amazonses.com (a27-22.smtp-out.us-west-2.amazonses.com [54.240.27.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8A29AFE1;
        Tue,  7 Mar 2023 16:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=s25kmyuhzvo7troimxqpmtptpemzlc6l; d=exabit.dev; t=1678235640;
        h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:Mime-Version:Content-Type:Content-Transfer-Encoding;
        bh=hByjQKgqwH57WOIPZC7o+pxFfUYAeO+49C7DJJ1GLFg=;
        b=cla1TKtKRJlLNHsclYB6ouf58iP213dERQku7qUDNb99l6+1ojWseCYpQtgzRUqj
        WVu1msPYYPc1sne/Mck5YzOyzjugqXi/ew3lF4pwRQmrctL3zER392MztS0rhF4w7CS
        DvuDjWo6fEtr3NVuGoto0U70wGfTuBxigOCcB0Sf5olKOtL8BnxBojyvj70tE99Rj+U
        Ilc066Zp2hXpH552xfR64zpc4p4hyj+ZzODbFupoAaNcMF4dvlurLlvG9WwK0eMRiyc
        35+6MjkJEvo6YEHH4qvgosIh9GjSXaO0tS5sk0Tt2h4/R1N8+EPTdXLYq9izphQkuKm
        CqW961Hfig==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1678235640;
        h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:Mime-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=hByjQKgqwH57WOIPZC7o+pxFfUYAeO+49C7DJJ1GLFg=;
        b=JwoYJ7oqGdOXLAyST48LCg5VhHIPmUZqxUaIHd+jr2C47JOaUT2AqLmkK/uG2AVt
        jeNygHV/az/u5WqnszR90X3BdKn2ac6TfvPSdnLStkUKdvpEYhAYHfadihg1viRNfnI
        VUWkAg537oGvqNuo9Q4MvsPdl++Kd/ZI8OT1VSzc=
Date:   Wed, 8 Mar 2023 00:33:59 +0000
Message-ID: <01010186bea3a046-f1f68507-2d3c-41c3-9066-44199e2ce071-000000@us-west-2.amazonses.com>
To:     bjorn3_gh@protonmail.com
Cc:     daniel.almeida@collabora.com, wedsonaf@gmail.com, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kernel@collabora.com
Subject: Re: [PATCH] rust: virtio: add virtio support
From:   FUJITA Tomonori <tomo@exabit.dev>
In-Reply-To: <OBVROfBri9SuVdfyos-71URYovcNLhbDb_50cECWMwhycY2sHH90w28f0qlJ_q_dMuCnOD_4nQCVUnwOkgyCEH1298nsVLW0YFuuiIlLPow=@protonmail.com>
References: <20230307130332.53029-1-daniel.almeida@collabora.com>
        <OBVROfBri9SuVdfyos-71URYovcNLhbDb_50cECWMwhycY2sHH90w28f0qlJ_q_dMuCnOD_4nQCVUnwOkgyCEH1298nsVLW0YFuuiIlLPow=@protonmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Feedback-ID: 1.us-west-2.j0GTvY5MHQQ5Spu+i4ZGzzYI1gDE7m7iuMEacWMZbe8=:AmazonSES
X-SES-Outgoing: 2023.03.08-54.240.27.22
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Mar 2023 17:09:27 +0000
Bj=F6rn Roy Baron <bjorn3_gh@protonmail.com> wrote:

> On Tuesday, March 7th, 2023 at 14:03, Daniel Almeida <daniel.almeida@=
collabora.com> wrote:
> =

>> This patch adds virtIO support to the rust crate. This includes the
>> capability to create a virtIO driver (through the module_virtio_driv=
er
>> macro and the respective Driver trait) as well as initial virtqueue
>> support.
>> =

>> A sample virtIO module is included for conveninence.
>> =

>> Signed-off-by: Daniel Almeida daniel.almeida@collabora.com
>> =

>> ---
>> =

>> Ok so this is my first Rust contribution here. It's part of a virtIO=

>> driver I was originally writing. Both the probing and the virtqueue
>> support in here were confirmed as working in said prototype driver, =
and
>> the pieces were picked separately into this patch.
>> =

>> Feel free to point me to the best practices around Rust patch
>> submission, as the C stuff like checkpatch etc probably does not app=
ly
>> yet. I did take care to run clippy though.
>> =

> =

> Great to see Rust support for the driver side of VirtIO! I've got a c=
ouple of review comments, but I don't see any big issues. Maybe you cou=
ld write an actual driver which uses add_sgs though? It doesn't have to=
 be complicated, but just something to show how it will work. That may =
help with checking if the api is usable. You might try something like v=
irtio-console or virtio-entropy I think.

There was an attempt to implement virtio-net, which might be useful:

https://github.com/Rust-for-Linux/linux/pull/886

C versions of virtio-console, virtio-rng, and virtio-net exists. Both
C and Rust versions in mainline?

Are there guidelines on pushing a Rust driver in mainline?
