Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B30B70F80A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235486AbjEXNv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbjEXNvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:51:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0166AA9;
        Wed, 24 May 2023 06:51:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92D6763385;
        Wed, 24 May 2023 13:51:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D27C433EF;
        Wed, 24 May 2023 13:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684936313;
        bh=4GshjE8EW0mcvOVEahGR8w89BqqKhoLGoZQ3w7o8H08=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=qb7DMQdqOOKgXs40GCoO7DiAHU3CqIJUwI6k/zcLHnFlxV0vPhuZ+ABymC3UdvBc+
         jDVceNK4HT6uiJurdC9kJGtaCi53cui792N3JJezYf27fShgJO1/R1tJ27DiEicmWT
         98Vetx7LGHGulW+FsTonnfiibRJ18SgXV9nmJ6AImrarvRLfbdO1sXrI5w/SUUUXVv
         f21t9Wz93Fl1AGuXVRxb8JbTECtyCYNV9xUdqtZwAz5cUge9EhdX6C+MwIswLWw30W
         r9mAc9oxqwQoPxAF0Adx59N5sFnSISZyikjIoXpZYrGFaVKJQlgVjOIwP9SiQd2/Vr
         JQVfl7gpDNkaw==
Date:   Wed, 24 May 2023 06:51:52 -0700
From:   Kees Cook <kees@kernel.org>
To:     =?ISO-8859-1?Q?Daniel_D=EDaz?= <daniel.diaz@linaro.org>,
        Vlastimil Babka <vbabka@suse.cz>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        ndesaulniers@google.com, rientjes@google.com,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: =?US-ASCII?Q?Re=3A_Stable_backport_request=3A_skbuff=3A_Pro?= =?US-ASCII?Q?actively_round_up_to_kmalloc_bucket_size?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAEUSe794ifGiY9tsXfnqDsDSJ+UOOB1kJrm1Jb8kZ5fsoBZ5Sg@mail.gmail.com>
References: <CAEUSe78ip=wkHUSz3mBFMcd-LjQAnByuJm1Oids5GSRm-J-dzA@mail.gmail.com> <e2f5ed62-eb6b-ea99-0e4d-da02160e99c8@suse.cz> <CAEUSe794ifGiY9tsXfnqDsDSJ+UOOB1kJrm1Jb8kZ5fsoBZ5Sg@mail.gmail.com>
Message-ID: <5A79C566-3213-456A-8CA3-8F0F1A2D9781@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 23, 2023 8:52:53 PM PDT, "Daniel D=C3=ADaz" <daniel=2Ediaz@linaro=2E=
org> wrote:
>Hello!
>
>On Tue, 23 May 2023 at 00:28, Vlastimil Babka <vbabka@suse=2Ecz> wrote:
>> On 5/22/23 20:23, Daniel D=C3=ADaz wrote:
>> > Hello!
>> >
>> > Would the stable maintainers please consider backporting the followin=
g
>> > commit to the 6=2E1? We are trying to build gki_defconfig (plus a few
>> > extras) on Arm64 and test it under Qemu-arm64, but it fails to boot=
=2E
>> > Bisection has pointed here=2E
>>
>> You mean the bisection was done to find the first "good" commit between=
 6=2E1
>> and e=2Eg=2E 6=2E3?
>>
>> As others said, this commit wasn't expected to be a fix to a known bug=
=2E
>> Maybe you found one that we didn't know of, or it might be accidentaly
>> masking some other bug=2E
>
>How interesting! Yes, we happened to run a bisection between v6=2E1 and
>v6=2E3 and we found where it started working with the following
>configuration:
>  https://storage=2Etuxsuite=2Ecom/public/linaro/daniel/builds/2QA2CHQUpq=
Ke27FyMZrBNILVwXi/config

Ah yes, from CONFIG_UBSAN_BOUNDS=3Dy and CONFIG_UBSAN_TRAP=3Dy

This was a known issue in upstream, oddly only exposed on arm64=2E Somethi=
ng re-broke with __alloc_size after commit 93dd04ab0b2b had tried to work a=
round it=2E I didn't think any kernel released with this broken, though, so=
 perhaps what broke it got added to -stable?

>With that patch on top of v6=2E1=2E29 it boots fine under Qemu-arm64; as
>v6=2E1=2Ey stands, it panics with this:

It should be fine to backport the patch, IMO=2E


--=20
Kees Cook
