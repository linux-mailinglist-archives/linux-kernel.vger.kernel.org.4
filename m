Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1765688315
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbjBBPv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:51:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjBBPvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:51:20 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761B71287B
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 07:51:04 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id v24-20020a05683011d800b0068bdd29b160so557306otq.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 07:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHdnGHGya01Jv0VuLki3dw4SIg6d4Y5ozkEOLFh106s=;
        b=H1C4HgP0+4cLGdmQvHXhQ3i0Vkr9SlgDZWxF4hOHH2AGXebPuzKKwW99Yh4YTpP1eP
         DCo9lGGq4Uaskn0A/qpE/587NZUAp8TpYnHQptkb3vr98DKbUSc+S/gjs8EDUgMqdMHC
         1Fm21hBVnVxea7Mamzac0GhsUcc4/b/0FRcOgoa6X0FSffmLYIv39p8fwlSC5D69msYa
         xm8OYvlbzvhjK8bwQpPhDpTZYnNrDa8XACIuBaI1w171jbOli829AYrvjq6Xtlcaq53+
         SXOJsABhmccDXYVkDBtb974H/G2+nxW5DmGQV2vzaHBDw9bstdCiYf0YqeEz0HgTT7SN
         7cEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHdnGHGya01Jv0VuLki3dw4SIg6d4Y5ozkEOLFh106s=;
        b=H+5SWEm/Eetbeit33foVvd7g5pVTfOXAznjnenVeLUQ80JCufVnkPRkfcCxtLE4z2+
         vCOvNgrgENrc9lKhM47JvHpxMLmV5q5pXoodQzKhHrGxwhzxeSVbWH8UqnfRGC8eY3zr
         xKlRDh8m/z1r0lA3/JRu4WR6jJWeCSsBufRBo79z+S6Z2hLSnKNPSAj6NkmTGLQJX3lk
         eD3ch1ggOygisoHSTcOf7xjcsQl9OjOjHjXNSQRWSS7k8WVov8tefRDqOlLUchr/pMkS
         xQ0nomk7uJxAY3m8P4HMpDhGUJvwdA2SQZS6ojzY7/hQi0ImLZgVLJmRgSqD5yaEMGxx
         //UA==
X-Gm-Message-State: AO0yUKVyvKR3624JZdColqjM1FSF77OUsAk1b4YCF8f2JoOsit0lbb/G
        2d26f2nSi2Xmv6StPyHiIFc=
X-Google-Smtp-Source: AK7set8yIDY8bSn1xg+ZZWxJIPoyhQiBcGeEppFiitpyMYHL/QXHUa0PabTEfahvJWo8bR0FD9YgLw==
X-Received: by 2002:a05:6830:1686:b0:68b:d347:2457 with SMTP id k6-20020a056830168600b0068bd3472457mr3411625otr.21.1675353063689;
        Thu, 02 Feb 2023 07:51:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s10-20020a9d58ca000000b006865223e532sm3173925oth.51.2023.02.02.07.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 07:51:03 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 2 Feb 2023 07:51:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     David Rau <david.rau.zg@renesas.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: da7219: Fix pole orientation detection on OMTP
 headsets when playing music
Message-ID: <20230202155101.GB1373010@roeck-us.net>
References: <20221121050744.2278-1-david.rau.zg@renesas.com>
 <20230117195645.GA83401@roeck-us.net>
 <OS3PR01MB66416CEF9F6E5AE62D194BACCDC49@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <20230119161221.GA981953@roeck-us.net>
 <OS3PR01MB66416C10BF8E6400C84DAD02CDD09@OS3PR01MB6641.jpnprd01.prod.outlook.com>
 <38f09c4d-70d1-f65f-6e9b-4ad84eda4059@roeck-us.net>
 <Y9kE1cSUg2CQM5vq@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9kE1cSUg2CQM5vq@sirena.org.uk>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 12:08:53PM +0000, Mark Brown wrote:
> On Mon, Jan 30, 2023 at 10:16:06PM -0800, Guenter Roeck wrote:
> > On 1/30/23 19:58, David Rau wrote:
> 
> > > Thanks for the kind feedback.
> > > Would you please let me know what kinds of environment such error appears you ever meet?
> > > Ex: da7219_aad->gnd_switch_delay = ?
> 
> > We are seeing the problem on various Chromebooks.
> 
> > Never mind, though. I really don't have time to keep arguing about this.
> > I would have assumed that it is obvious that a long msleep() in an
> > interrupt handler is not appropriate, but obviously I was wrong.
> 
> This is a threaded interrupt handler so it's a bit less clear that it's
> meaningfully different to just disabling the interrupt for debounce or
> whatever.  Not to say it's ideal.
> 
> > I'll see if I can implement a downstream fix.
> 
> If you implement something I don't see a reason not to post it upstream.

I had a look into the code, and concluded that it is too complex for anyone
who doesn't know it to find a proper fix. For example, for an outsider it
is not conceivable (or explained) why the ground switch is enabled only
to be disabled immediately afterwards if a jack was removed.

This is now the top crash reason on affected Chromebooks (so far I
identified Asus C424, HP SeaStar, and HP StingRay) with this patch
applied. I am inclined to revert it from all ChromeOS kernel branches.
At least for us the cure for the problem is much worse than the problem
itself.

Guenter
