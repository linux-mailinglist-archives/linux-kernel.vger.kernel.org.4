Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31C06D64F4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235081AbjDDONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbjDDONl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:13:41 -0400
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ACB558F;
        Tue,  4 Apr 2023 07:13:08 -0700 (PDT)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3D7E6100005;
        Tue,  4 Apr 2023 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680617587;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zl7MLykOKA8UlNhyqu3tWD/vjZRODEGN3E9wOmRfmr8=;
        b=HERL1THee0w4ARcbmdqBbW9M2FrPt7M+4Zaeh/18I2OVyQ3MM0Usdk7NaPHFHD9vHrkI+I
        e6Rw2Qo8DqxzMLNRPH7tdMTM4sXVOKb3byVmNQw1hU9hyte98VxCkOevjiFKXUjndP7l0o
        fQXdMmYky22zAt7WMMTqJNETXimQFN7kaXSK2gu+vzkgvcXwnoMVA+S4byJsnO9o0TyEdL
        NTpBE/7o4qGE7Tm1KSr5epsIsp2X3gs1bhxOKwvfmoWs1fJ9uXdwMxKdp72zRd/W2yJ+BC
        2f5+NrOZt/WcDePLlFvQ+Cr+DbQfAOEuR513WeF4ixVoJRbe1FkVNLOkeaT62Q==
Date:   Tue, 4 Apr 2023 16:12:51 +0200
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
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
        Richard Leitner <richard.leitner@skidata.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [RESEND PATCH v4 03/21] staging: media: tegra-video: fix
 .vidioc_enum_fmt_vid_cap to return all formats
Message-ID: <20230404161251.272cc78b@booty>
In-Reply-To: <85268d69-3d3b-2c0f-ba26-073f09052362@xs4all.nl>
References: <20230309144320.2937553-1-luca.ceresoli@bootlin.com>
        <20230309144320.2937553-4-luca.ceresoli@bootlin.com>
        <85268d69-3d3b-2c0f-ba26-073f09052362@xs4all.nl>
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

Hello Hans,

On Wed, 29 Mar 2023 13:16:22 +0200
Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote:

> Hi Luca,
> 
> I finally found the time to test this series. It looks OK, except for this patch.

Thank you very much for taking the time!

> The list of supported formats really has to be the intersection of what the tegra
> supports and what the sensor supports.
> 
> Otherwise you would advertise pixelformats that cannot be used, and the application
> would have no way of knowing that.

As far as I understand, I think we should rather make this driver fully
behave as an MC-centric device. It is already using MC quite
successfully after all.

Do you think this is correct?

If you do, then I think the plan would be:

 - Add the V4L2_CAP_IO_MC flag
 - As the mbus_code in get_format appropriately
 - Leave the changes in this patch unmodified otherwise

Best regards,
Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
