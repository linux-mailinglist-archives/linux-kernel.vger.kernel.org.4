Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745536D4CC7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 17:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbjDCP4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 11:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjDCPzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 11:55:51 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AD030DD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 08:55:21 -0700 (PDT)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4PqwT337Nzz9sSn;
        Mon,  3 Apr 2023 17:55:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1680537303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fVP0qrByRoh/sDbYz3vxEjtA0pFI+Fsrhbe/3Y6bLB0=;
        b=bZ0L9oNzOADkEHZGmSgPP69X6mxaO0xn4fTHsMTuWEHKGFXn+Hhx9RepiPO0xwTfjSPKil
        LottxSqjTIv8qYS+cf+HS6w5QLIvpQPiyWBA3DCCrc2/uNni9mwzHaZJm3fb7RJmvTKu+2
        BXJ9ajv2ZGjT3ble6tDiTyMWR6wePaYQiHkNNMuPBA0K5MMfdUluVnauYLsWD+HNgonxum
        3YNzo+RBjUgl3CKS3ASiBDXsnCMxQHYblImZahIV5lJpgRe8BsSO4etSdiX8flSggjckuP
        owNNJPnhvQz5AllCKv7pDu3Nhh3aXk1hW29QAZZqDxops1hy9tLxpRR1Uscrbg==
References: <20230331110245.43527-1-me@crly.cz>
 <20230331110245.43527-4-me@crly.cz> <87h6tya70h.fsf@oltmanns.dev>
 <CRN65FVKWIUG.1VSDAH8INXQMT@iMac.local>
From:   Frank Oltmanns <frank@oltmanns.dev>
To:     Roman Beranek <me@crly.cz>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm: sun4i: calculate proper DCLK rate for DSI
Date:   Mon, 03 Apr 2023 17:08:33 +0200
In-reply-to: <CRN65FVKWIUG.1VSDAH8INXQMT@iMac.local>
Message-ID: <87pm8lj709.fsf@oltmanns.dev>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4PqwT337Nzz9sSn
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-04-03 at 15:52:36 +0200, "Roman Beranek" <me@crly.cz> wrote:
> On Sun Apr 2, 2023 at 12:49 PM CEST, Frank Oltmanns wrote:
>>
>> When apply this to drm-next my panel stays dark. I haven't figured out
>> yet why, though. The other two patches in this series work fine, i.e.
>> they have no effect as they are just a refactoring.
>>
>> I'm testing this on my pinephone. It's the same with the patch I
>> submitted. For whatever reason, it no longer works on drm-next.
>
> I've reproduced the issue on my PinePhone and noticed that tcon0 had set
> pll-video0-2x as its parent instead of pll-mipi. Having tried a whole
> range of pll-video0 rates, I'm now convinced that DSI only works when
> tcon0 has pll-mipi as its parent.
>
> As little a change as setting .clock in the default mode of PP's panel
> to 73500 can fix it. Better yet, dropping pll-video0-2x from the set
> of acceptable parents for tcon0 fixes it universally. And that's what
> megi's kernel does, though the measure was introduced with a different
> rationale:
> <https://github.com/megous/linux/commit/7374d5756aa0cc3f11e494e3cbc54f6c7c01e1a8>

For sake of completeness, the patch you referenced builds on this patch:
https://github.com/megous/linux/commit/45e0aa8d9e34

Are you saying that your other boards and panels work without these
patches?

Best regards,
  Frank

>
> Roman
