Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33BA6D76F9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 10:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237512AbjDEIbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjDEIbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 04:31:42 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D731FF6;
        Wed,  5 Apr 2023 01:31:39 -0700 (PDT)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5E4551BF20E;
        Wed,  5 Apr 2023 08:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680683498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dfpX8n3KjmDuOMM79pUj2UNu0NextAFw1gDVBnHMLw4=;
        b=bCcuC7sWRQhfy48p+yKdWbEIRlhTIKVTe01b/RtLxDpwYXkNTNSsthBgWlrM5AyYCFAD9V
        bPZAeDNTSMUdLU6TH3O9/wHuQedepqeKZFAePw42KIr3UlWGLsObQHIx8FRA/Yzo/Hpwas
        1oMfM22Ru1auoLd8ys6PHjyeEs1k+RTPAgcCt6EDnt1ohR6x/rMuXDzlORw7UkENAYfwpS
        Bgqu7CtMjURcHeXgjEMd0FKRfuuPeaa635UVKIvKX9q7NrF+b0gicCAXGtd9tGp3oRRUos
        YgHaBQkht/RyoSHfYHY0w8lMSHHsAAkY1nM7AiJntPvjMh+FRmG6op0Q0JlDlQ==
Date:   Wed, 5 Apr 2023 10:31:34 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [RESEND PATCH v4 03/21] staging: media: tegra-video: fix
 .vidioc_enum_fmt_vid_cap to return all formats
Message-ID: <20230405103134.2ae10766@booty>
In-Reply-To: <20230405023048.GD9915@pendragon.ideasonboard.com>
References: <20230309144320.2937553-1-luca.ceresoli@bootlin.com>
        <20230309144320.2937553-4-luca.ceresoli@bootlin.com>
        <85268d69-3d3b-2c0f-ba26-073f09052362@xs4all.nl>
        <20230404161251.272cc78b@booty>
        <20230405023048.GD9915@pendragon.ideasonboard.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

On Wed, 5 Apr 2023 05:30:48 +0300
Laurent Pinchart <laurent.pinchart@ideasonboard.com> wrote:

> Hi Luca,
> 
> On Tue, Apr 04, 2023 at 04:12:51PM +0200, Luca Ceresoli wrote:
> > On Wed, 29 Mar 2023 13:16:22 +0200 Hans Verkuil wrote:
> >   
> > > Hi Luca,
> > > 
> > > I finally found the time to test this series. It looks OK, except for this patch.  
> > 
> > Thank you very much for taking the time!
> >   
> > > The list of supported formats really has to be the intersection of what the tegra
> > > supports and what the sensor supports.
> > > 
> > > Otherwise you would advertise pixelformats that cannot be used, and the application
> > > would have no way of knowing that.  
> > 
> > As far as I understand, I think we should rather make this driver fully
> > behave as an MC-centric device. It is already using MC quite
> > successfully after all.
> > 
> > Do you think this is correct?  
> 
> Given the use cases for this driver, I agree.

Ok, thanks for the feedback. I will send a v5 with this change.

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
