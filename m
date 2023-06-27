Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D4B73EFC3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 02:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjF0Afs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 20:35:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjF0Afq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 20:35:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE351716;
        Mon, 26 Jun 2023 17:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D6FF60FBC;
        Tue, 27 Jun 2023 00:35:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4338C433C9;
        Tue, 27 Jun 2023 00:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687826143;
        bh=ri8Lw0btK8xU98fieJeNgDYMq7tpyggvX0fT3i8LXvU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Y5byjoU8crCZ5+nUd5ao0pSbq5PDEH2HLWApGVhYwd5n072gix8PNM7837Pw3Jz/3
         T3/HYrcYbw85FAxa852NPTyGg+/OIyksq1BQu4ywgbjQD9zdWxTeNoCVP6H3esfjoX
         3wTEUeBRt67vDxrhnB7Dx0vhI1e5qAh29YjAfcsIe3LKD5zR8M6l9HE9cuSeXuY8Q1
         tdA9oJw1U3GIX3dJxO+7FXf3O7k26sgh23Tz9o0gKzu49W5RaKFGwzvX5xPV5v6eTH
         b1QBQPaEZPzMJHGCzDUgHw7Adq/uAKO/nZ4e6g/sph00uMADLLtq5KrlzS8Qkg6g/X
         dgZGnVbkTfZVg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-4fafe87c6fbso2951236e87.3;
        Mon, 26 Jun 2023 17:35:43 -0700 (PDT)
X-Gm-Message-State: AC+VfDxoj79OZYxy/3J6ZALLABTHLarBVa8fQ9fk1qH/XXfUALPxqKYZ
        zoeiUSPyHAW8r6/IaeO160XGJ1TM2G9otQLpjJY=
X-Google-Smtp-Source: ACHHUZ6r6mwH6YsL2/0Z1A3dZTnXXWmub0BcbTsy21tD6ta5oIOu7Om/p7EXVx74EOcnySCJTXFUzRYUwTD6GVIoG0k=
X-Received: by 2002:a19:6555:0:b0:4f8:5f32:b1da with SMTP id
 c21-20020a196555000000b004f85f32b1damr15112836lfj.24.1687826141758; Mon, 26
 Jun 2023 17:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230623180523.1901230-1-jbaron@akamai.com>
In-Reply-To: <20230623180523.1901230-1-jbaron@akamai.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 26 Jun 2023 17:35:29 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4xyxS=oYmeaF2Jze76WC-e2p_dQNos+QDnFX6nr5AOCw@mail.gmail.com>
Message-ID: <CAPhsuW4xyxS=oYmeaF2Jze76WC-e2p_dQNos+QDnFX6nr5AOCw@mail.gmail.com>
Subject: Re: [PATCH] md/raid0: add discard support for the 'original' layout
To:     Jason Baron <jbaron@akamai.com>
Cc:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        NeilBrown <neilb@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 11:05=E2=80=AFAM Jason Baron <jbaron@akamai.com> wr=
ote:
>
> We've found that using raid0 with the 'original' layout and discard
> enabled with different disk sizes (such that at least two zones are
> created) can result in data corruption. This is due to the fact that
> the discard handling in 'raid0_handle_discard()' assumes the 'alternate'
> layout. We've seen this corruption using ext4 but other filesystems are
> likely susceptible as well.
>
> More specifically, while multiple zones are necessary to create the
> corruption, the corruption may not occur with multiple zones if they
> layout in such a way the layout matches what the 'alternate' layout
> would have produced. Thus, not all raid0 devices with the 'original'
> layout, different size disks and discard enabled will encounter this
> corruption.
>
> The 3.14 kernel inadvertently changed the raid0 disk layout for different
> size disks. Thus, running a pre-3.14 kernel and post-3.14 kernel on the
> same raid0 array could corrupt data. This lead to the creation of the
> 'original' layout (to match the pre-3.14 layout) and the 'alternate' layo=
ut
> (to match the post 3.14 layout) in the 5.4 kernel time frame and an optio=
n
> to tell the kernel which layout to use (since it couldn't be autodetected=
).
> However, when the 'original' layout was added back to 5.4 discard support
> for the 'original' layout was not added leading this issue.
>
> I've been able to reliably reproduce the corruption with the following
> test case:
>
> 1. create raid0 array with different size disks using original layout
> 2. mkfs
> 3. mount -o discard
> 4. create lots of files
> 5. remove 1/2 the files
> 6. fstrim -a (or just the mount point for the raid0 array)
> 7. umount
> 8. fsck -fn /dev/md0 (spews all sorts of corruptions)
>
> Let's fix this by adding proper discard support to the 'original' layout.
> The fix 'maps' the 'original' layout disks to the order in which they are
> read/written such that we can compare the disks in the same way that the
> current 'alternate' layout does. A 'disk_shift' field is added to
> 'struct strip_zone'. This could be computed on the fly in
> raid0_handle_discard() but by adding this field, we save some computation
> in the discard path.
>
> Note we could also potentially fix this by re-ordering the disks in the
> zones that follow the first one, and then always read/writing them using
> the 'alternate' layout. However, that is seen as a more substantial chang=
e,
> and we are attempting the least invasive fix at this time to remedy the
> corruption.
>
> I've verified the change using the reproducer mentioned above. Typically,
> the corruption is seen after less than 3 iterations, while the patch has
> run 500+ iterations.
>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Song Liu <song@kernel.org>
> Fixes: c84a1372df92 ("md/raid0: avoid RAID0 data corruption due to layout=
 confusion.")
> Signed-off-by: Jason Baron <jbaron@akamai.com>

 Looks good to me! Applied to md-next.

Since this will be released with 6.6, we should have a smaller and safer fi=
x
before that. Would you mind create a patch that ignores all discards to
orig_layout and not the first zone? We will roll that to 6.5 and back port =
to
stable. Then this version will be shipped to 6.6+.

Thanks,
Song
