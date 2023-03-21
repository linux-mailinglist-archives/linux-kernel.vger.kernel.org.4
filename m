Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15D36C3BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjCUUbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjCUUbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:31:41 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CB21E9F0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 13:31:37 -0700 (PDT)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Ph3D35wsCz9sJB;
        Tue, 21 Mar 2023 21:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1679430691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EI5/y4CkeUNPmFzU1WxwnwF9KrIdum2QGMnmVmYyGcA=;
        b=ZWa4V3Z8E37AtZWzuoa765w3O+EbcbsjORlzxFQ303NssHQP/4F4nxS3Bf5Iy3GkO3FfQs
        mO4NdgckVtiK8J7lsQLun16oIBolSsFXsD/FvIe0DLOCnEdoLQXdSFGGc1WN2DPTJT8r2M
        UmRjE2Mgj16nMpWrErfWfy7Q2vU2iU1waTn2c5oERGNdlJ0fqVNvcZqbJTAbg0PQ5IZ4Dp
        zy9s4CuheqrjcxG+FBsWqfrrB936qfhFnoBykVNAOEcP9rTpTX5hVZAWn0qKjmEb/5BPaH
        dudgZKxdGnduwCjuGBnY6g6CfuzkeO7VwsU06XizmQQWNJ03jrHA5eyTg3fL6g==
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     jagan@amarulasolutions.com, michael@amarulasolutions.com,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Allwinner sunXi SoC support" 
        <linux-sunxi@lists.linux.dev>,
        open list <linux-kernel@vger.kernel.org>,
        Roman Beranek <romanberanek@icloud.com>
Subject: Re: [PATCH 1/1] drm/sun4i: tcon: Fix setting PLL rate when using DSI
Date:   Tue, 21 Mar 2023 20:55:32 +0100
Message-ID: <87a605hmo5.fsf@oltmanns.dev>
References: <20230319160704.9858-1-frank@oltmanns.dev>
 <20230319160704.9858-2-frank@oltmanns.dev>
 <20230321145739.jlpbzplsc27dlh7v@houat>
In-reply-to: <20230321145739.jlpbzplsc27dlh7v@houat>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Rspamd-Queue-Id: 4Ph3D35wsCz9sJB
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On 2023-03-21 at 15:57:39 +0100, Maxime Ripard <maxime@cerno.tech> wrote:
> Hi,
>
> On Sun, Mar 19, 2023 at 05:07:04PM +0100, Frank Oltmanns wrote:
>> Set the required PLL rate by adjusting the dotclock rate when calling
>> clk_set_rate() when using DSI.
>>
>> According to the Allwinners A64=E2=80=99s BSP code, a TCON divider of 4 =
has to
>> be used and the PLL rate needs to be set to the following frequency when
>> using DSI:
>>     PLL rate =3D DCLK * bpp / lanes
>>
>> After this change the common mode set function would only contain
>> setting the resolution. Therefore, dissolve the function and transfer
>> the functionality to the individual mode set functions.
>>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>
> This is similar to:
> <https://lore.kernel.org/all/20230320161636.24411-1-romanberanek@icloud.c=
om/>
>
> What=E2=80=99s the story there?

Sorry, as Roman wrote in the other thread, I submitted the patch after not =
hearing back from him for a week. My apologies, I wasn=E2=80=99t patient en=
ough. So now there are two submissions to consider. FWIW, I think this patc=
h is a bit more straightforward than the other one.

Best regards,
  Frank

> Maxime
>

--=-=-=--
