Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A77973A7D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbjFVR6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjFVR6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:58:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8662C2105;
        Thu, 22 Jun 2023 10:58:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1A9046188D;
        Thu, 22 Jun 2023 17:58:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BBDC433C0;
        Thu, 22 Jun 2023 17:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687456683;
        bh=Jve0JXuUNEDhINVuwULP+VQmXRRWVYgAlHyNdpfaxzg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Os/eOnhVqUemxJ5rZo6K9mQ6Z+zXKEmp1QCvl5y0+Pry6fwv4M3GzPIHPYTwqN+mF
         VOiPvqI3gVsgnzHhFYpPhK9q24YHg2QgBrGIzKXtt7QNGtjIMruwi6lNKreB+Toly7
         rCKfAm5aYYQw05+2qX4pneam+GjueKTZq2vFpT04kdAm9eKbAATNbs/0MrKD6DDGwk
         IUZjwekdgIDDbeBVHVLZq1XlUY09+1Ziicp6RrzQP+C99p0ho9C8PlG9rJ1rzMB8wj
         edWXeG/gzDwT6hPyl2SxVde/c3KKKL0/zOg4JNATBiFNmHEXZ2BW4SbR8PeSf/faj4
         LyFzLQXlcPnJQ==
Date:   Thu, 22 Jun 2023 10:58:01 -0700
From:   Kees Cook <kees@kernel.org>
To:     Isaac Manjarres <isaacmanjarres@google.com>,
        Kees Cook <keescook@chromium.org>
CC:     John Stultz <jstultz@google.com>, Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        Mukesh Ojha <mojha@codeaurora.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        kernel-team@android.com, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_pstore/ram=3A_Add_support_for_dy?= =?US-ASCII?Q?namically_allocated_ramoops_memory_regions?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZJSES98P+zzrhBI5@google.com>
References: <20230622005213.458236-1-isaacmanjarres@google.com> <CANDhNCrEhx4LUPaz-FHZZJMG2yX670hk-vGTZs=HxiGR18zm5A@mail.gmail.com> <202306212212.5E53607@keescook> <ZJSES98P+zzrhBI5@google.com>
Message-ID: <3A2CFB4D-27D0-4FEB-93B4-2F888305DE5A@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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

On June 22, 2023 10:26:35 AM PDT, Isaac Manjarres <isaacmanjarres@google=2E=
com> wrote:
>On Wed, Jun 21, 2023 at 10:15:45PM -0700, Kees Cook wrote:
>> On Wed, Jun 21, 2023 at 09:47:26PM -0700, John Stultz wrote:
>> > > The reserved memory region for ramoops is assumed to be at a fixed
>> > > and known location when read from the devicetree=2E This is not des=
irable
>> > > in environments where it is preferred for the region to be dynamica=
lly
>> > > allocated early during boot (i=2Ee=2E the memory region is defined =
with
>> > > the "alloc-ranges" property instead of the "reg" property)=2E
>> > >
>> >=20
>> > Thanks for sending this out, Isaac!
>> >=20
>> > Apologies, I've forgotten much of the details around dt bindings here=
,
>> > so forgive my questions:
>> > If the memory is dynamically allocated from a specific range, is it
>> > guaranteed to be consistently the same address boot to boot?
>> >=20
>> > > Since ramoops regions are part of the reserved-memory devicetree
>> > > node, they exist in the reserved_mem array=2E This means that the
>> > > of_reserved_mem_lookup() function can be used to retrieve the
>> > > reserved_mem structure for the ramoops region, and that structure
>> > > contains the base and size of the region, even if it has been
>> > > dynamically allocated=2E
>> >=20
>> > I think this is answering my question above, but it's a little opaque=
,
>> > so I'm not sure=2E
>>=20
>> Yeah, I had exactly the same question: will this be the same
>> boot-to-boot?
>
>Hi Kees,
>
>Thank you for taking a look at this patch and for your review! When the
>alloc-ranges property is used to describe a memory region, the memory
>region will always be allocated within that range, but it's not
>guaranteed to be allocated at the same base address across reboots=2E
>
>I had proposed re-wording the end of the commit message in my response
>to John as follows:
>
>"=2E=2E=2Eand that structure contains the address of the base of the regi=
on
>that was allocated at boot anywhere within the range specified by the
>"alloc-ranges" devicetree property=2E"
>
>Does that clarify things better?

I am probably misunderstanding something still, but it it varies from boot=
 to boot, what utility is there for pstore if it changes? I=2Ee=2E the thin=
gs written during the last boot would then no longer accessible at the next=
 boot? E=2Eg=2E:

Boot 1=2E
Get address Foo=2E
Crash, write to Foo=2E
Boot 2=2E
Get address Bar, different from Foo=2E
Nothing found at Bar, so nothing populated in pstorefs; crash report from =
Boot 1 unavailable=2E

I feel like there is something I don't understand about the Foo/Bar addres=
ses in my example=2E

-Kees



--=20
Kees Cook
