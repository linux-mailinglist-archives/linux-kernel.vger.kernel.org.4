Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB1270EA04
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbjEXAHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEXAHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:07:19 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E578B5;
        Tue, 23 May 2023 17:07:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1CFA11042;
        Tue, 23 May 2023 17:08:03 -0700 (PDT)
Received: from slackpad.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 168633F67D;
        Tue, 23 May 2023 17:07:15 -0700 (PDT)
Date:   Wed, 24 May 2023 01:06:45 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Shengyu Qu <wiagn233@outlook.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        wens@csie.org, lgirdwood@gmail.com, broonie@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        conor.dooley@microchip.com,
        Martin Botka <martin.botka@somainline.org>,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v3 2/3] mfd: axp20x: Add support for AXP15060 PMIC
Message-ID: <20230524010645.0f3cf2a2@slackpad.lan>
In-Reply-To: <TY3P286MB2611E4814895D1F6CBD127E198789@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
References: <20230421150816.10513-1-wiagn233@outlook.com>
        <TY3P286MB261162D57695AC8164ED50E298609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
        <20230426142740.GN50521@google.com>
        <20230503120759.6fd6a7a9@donnerap.cambridge.arm.com>
        <19bccb62-b7e0-855d-fb5f-4fd3dde4f6f0@linaro.org>
        <20230515105229.GI8963@google.com>
        <20230515161940.3bcbe932@donnerap.cambridge.arm.com>
        <20230515152829.GW10825@google.com>
        <TY3P286MB2611E4814895D1F6CBD127E198789@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.31; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 23:44:03 +0800
Shengyu Qu <wiagn233@outlook.com> wrote:

Hi Shengyu,

> Please ping me if your new version of axp313a series is sent, I would update
> mine as soon as possible.

as you have probably seen, I have just sent out a new version, and
included the one remaining patch from your series. So there is no
need from your side for any further post. I'd just be grateful if you
could test the final result.

Cheers,
Andre

> > On Mon, 15 May 2023, Andre Przywara wrote:
> >  
> >> On Mon, 15 May 2023 11:52:29 +0100
> >> Lee Jones <lee@kernel.org> wrote:
> >>  
> >>> On Thu, 04 May 2023, Krzysztof Kozlowski wrote:
> >>>  
> >>>> On 03/05/2023 13:07, Andre Przywara wrote:  
> >>>>> On Wed, 26 Apr 2023 15:27:40 +0100
> >>>>> Lee Jones <lee@kernel.org> wrote:
> >>>>>
> >>>>> Hi Lee,
> >>>>>
> >>>>> I see this patch in Linus' tree, but something must have gone wrong here,
> >>>>> can you please check? See below ...
> >>>>>      
> >>>>>> On Fri, 21 Apr 2023, Shengyu Qu wrote:
> >>>>>>     
> >>>>>>> The AXP15060 is a PMIC chip produced by X-Powers, and could be connected
> >>>>>>> via an I2C bus.
> >>>>>>>
> >>>>>>> Describe the regmap and the MFD bits, along with the registers exposed
> >>>>>>> via I2C. Eventually advertise the device using a new compatible string
> >>>>>>> and add support for power off the system.
> >>>>>>>
> >>>>>>> The driver would disable PEK function if IRQ is not configured in device
> >>>>>>> tree, since some boards (For example, Starfive Visionfive 2) didn't
> >>>>>>> connect IRQ line of PMIC to SOC.
> >>>>>>>
> >>>>>>> GPIO function isn't enabled in this commit, since its configuration
> >>>>>>> operation is different from any existing AXP PMICs and needs
> >>>>>>> logic modification on existing driver. GPIO support might come in later
> >>>>>>> patches.
> >>>>>>>
> >>>>>>> ---  
> >>>>>> You must not use these above the tags or Git will drop them.
> >>>>>>     
> >>>>>>> Changes since v2:
> >>>>>>>   - Rebase to AXP313a series v10 [1] + newest (20230420) -next branch  
> >>>>> So this patch was based on the AXP313a series, but I don't see that in
> >>>>> Linus' tree (or in any of your trees, if I have checked correctly).
> >>>>> There must have been a conflict, as this [PATCH v3 2/3] diff actually lists
> >>>>> the axp313a entry in the context lines.
> >>>>>      
> >>>>>>>   - Add axp_regulator_only_cells rather than directly using axp806_cells
> >>>>>>>     for cases that IRQ line isn't connected.
> >>>>>>>
> >>>>>>> Changes since v1:
> >>>>>>>   - Nothing
> >>>>>>>
> >>>>>>> [1] https://lore.kernel.org/linux-sunxi/20230401001850.4988-1-andre.przywara@arm.com/
> >>>>>>>
> >>>>>>> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
> >>>>>>> ---  
> >>>>>> Put change-logs here instead.
> >>>>>>     
> >>>>>>>   drivers/mfd/axp20x-i2c.c   |   2 +
> >>>>>>>   drivers/mfd/axp20x.c       | 107 +++++++++++++++++++++++++++++++++++++
> >>>>>>>   include/linux/mfd/axp20x.h |  85 +++++++++++++++++++++++++++++
> >>>>>>>   3 files changed, 194 insertions(+)  
> >>>>>> I manually added the missing tags for this and the DT patch and applied.  
> >>>>> So this patch doesn't list any tags aside from Shengyu's
> >>>>> Signed-off-by. The patch in Linus' tree list a Reviewed-by: from
> >>>>> Krzysztof, which I don't see anywhere in the thread, he just reviewed the
> >>>>> binding patch, AFAICT.  
> >>>> Yep, I never reviewed this.
> >>>>      
> >>>>> I see your tentative R-b: on v2, but with the
> >>>>> request to rebase and resend, which he did with v3. The applied patch
> >>>>> looks like v3, but not on the base commit this was send against.
> >>>>>
> >>>>> So I am slightly confused, and am also wondering what happened to the
> >>>>> AXP313a patches? I see the binding patch merged, but not the MFD part,
> >>>>> even though you replied saying so.  
> >>>> Because the patch #1 was broken, see:
> >>>> https://lore.kernel.org/all/TY3P286MB261177CF7AA2959BD9517DA998609@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM/
> >>>>
> >>>> The SoB and Reviewed-by were after --- and apparently b4 understood it
> >>>> as cover letter and applied everywhere.
> >>>>
> >>>> Lee,
> >>>> Do you have the latest b4? If yes, this should be reported as b4 bug,
> >>>> assuming you used it.  
> >>> I am using b4, although the version I'm using is quite old (0.9.0).
> >>>
> >>> Also, this was quite some time ago - I have slept since applying this
> >>> and do not distinctly remember doing so.  Thus, the application of your
> >>> R-b may well have been a mistake on my part.  I'll keep an eye for such
> >>> things in the future and if I see (and remember) an issue, I'll report
> >>> it.  
> >> So what are we going to do about the two series now? I guess it's not
> >> worthwhile to revert Shengyu's patch, just for the wrong R-b: tag?  
> > No, I won't be reverting any patches.
> >  
> >> So does this mean both series should be rebased on top of that and re-sent?  
> > Yes please.
> >  

