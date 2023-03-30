Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73136CFA6D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjC3Exu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjC3Exr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:53:47 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 981AB5FF9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 21:53:39 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Pn9zg43vWz9sRK;
        Thu, 30 Mar 2023 06:53:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1680152015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YWgtpd4fPVhiIFkjr04jTbq0IIVxM0oReji2cEeLfdU=;
        b=0OB7M/a5iFHbPqjPbr/ZjCY8Co+ka63KsdbxBGmim5q3SJGAxJrjlZOvtpdXteJCpTqDYP
        0OOlps4JPQbBO/CbC6lQoajGKnh12+sqBzuE+GBW7jynF5voI9hZCzdHeQRqYzZwlXkHSQ
        BW7FTkkCcX/VpeyrTrIHCgivtVEyx62TQqar4gg7BhgvCYTiqqYOIJP3GF5bfE8VltFQAw
        iznGEjhyjpCgmwz16H0nJEIKeKUbVI4JMs0aLhIVrKT+S0ndzjum1BfoJ/k+LpeKdwMdZK
        zEB9GhNUp5sxl/hg92tDlHj+FG24O6BZWEX7OLZ+bO6qUU3nd6SUWKtBoytN4g==
References: <20230320161636.24411-1-romanberanek@icloud.com>
 <87wn356ni4.fsf@oltmanns.dev> <20230327202045.ceeqqwjug4ktxtsf@penduick>
 <CRHKFX934UA0.1MCKCD8SJSPIE@iMac.local>
 <20230329195802.veybo3367zifw77n@penduick>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Roman Beranek <romanberanek@icloud.com>
Cc:     Maxime Ripard <maxime@cerno.tech>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: uncouple DSI dotclock divider from
 TCON0_DCLK_REG
Date:   Thu, 30 Mar 2023 06:45:22 +0200
In-reply-to: <20230329195802.veybo3367zifw77n@penduick>
Message-ID: <877cuyon5e.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roman,

On 2023-03-29 at 21:58:02 +0200, Maxime Ripard <maxime@cerno.tech> wrote:
> On Tue, Mar 28, 2023 at 01:48:33AM +0200, Roman Beranek wrote:
>> On Mon Mar 27, 2023 at 10:20 PM CEST, Maxime Ripard wrote:
>> >
>> > On Sat, Mar 25, 2023 at 12:40:04PM +0100, Frank Oltmanns wrote:
>> > > Claiming to set the divider to a different value (bpp / lanes) than =
what we=E2=80=99re actually using in
>> > > the end (SUN6I_DSIO_TCON_DIV) is somehow bugging me. I feel like the=
 proposal that I submitted is
>> > > more direct: <https://lore.kernel.org/all/20230319160704.9858-2-fran=
k@oltmanns.dev/>
>> >
>> > Yeah, this patch looks better to me too: it's simpler, more straightfo=
rward. If Roman can confirm it
>> > works with his testing, I'll be happy to merge it.
>> >
>>
>> So I've just found out that my understanding of what sun4i_dotclock is
>> was wrong the whole time. I treated it as a virtual clock representing
>> the true CRTC pixel clock and only coincidentally also matching what
>> A64 Reference Manual labels as TCON0 data clock (a coincidence to which
>> DSI is an exception).
>>
>> Now that I finally see dotclock as 'what could dclk be an abbreviation
>> to', I to agree that it's not only straightforward but also correct to
>> keep the divider at 4 and adjust the rate as is done it the patch Frank
>> submitted.
>>
>> In order to preserve semantic correctness however, I propose to preface
>> the change with a patch that renames sun4i_dotclock and tcon-pixel-clock
>> such that dot/pixel is replaced with d/data. What do you think?
>
> I don't think it's exposed to the userspace in any way so it makes sense =
to me

Roman, will you please submit a V2 of the patch I submitted then? Or do
you want me to do it?

Thanks,
  Frank

>
> Maxime
>


--
