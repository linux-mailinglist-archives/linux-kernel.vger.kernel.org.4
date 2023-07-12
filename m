Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F7074FF82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 08:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjGLGkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 02:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGLGkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 02:40:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4010DC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 23:40:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D733F2F4;
        Tue, 11 Jul 2023 23:41:19 -0700 (PDT)
Received: from [10.163.48.19] (unknown [10.163.48.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DEBF3F67D;
        Tue, 11 Jul 2023 23:40:36 -0700 (PDT)
Message-ID: <b910cd19-9dd2-662d-f258-91719b9906ce@arm.com>
Date:   Wed, 12 Jul 2023 12:10:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] drm/arm/komeda: Remove component framework and add a
 simple encoder
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Liviu Dudau <liviu.dudau@arm.com>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230621084116.26882-1-faiz.abbas@arm.com>
 <ZJ1UJaNJese6g2Ia@e110455-lin.cambridge.arm.com>
 <90f386c3-b2bb-b876-80df-c67005e89a66@arm.com>
 <20230704165654.GA940443@ravnborg.org>
From:   Mohammad Faiz Abbas Rizvi <faiz.abbas@arm.com>
In-Reply-To: <20230704165654.GA940443@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On 7/4/2023 10:26 PM, Sam Ravnborg wrote:
> Hi Mohammed,
> 
> On Tue, Jul 04, 2023 at 07:19:04PM +0530, Mohammad Faiz Abbas Rizvi wrote:
>> Hi Liviu,
>>
>> On 6/29/2023 3:21 PM, Liviu Dudau wrote:
>>> Hi Faiz,
>>>
>>> Thanks for the patch and for addressing what was at some moment on my "nice to
>>> improve / cleanup" list. Sorry for the delay in responding, I had to revive
>>> the bits of an old setup to be able to test this properly, with 2 encoders
>>> attached.
>>>
>>> On Wed, Jun 21, 2023 at 02:11:16PM +0530, Faiz Abbas wrote:
>>>> The Komeda driver always expects the remote connector node to initialize
>>>> an encoder. It uses the component aggregator framework which consists
>>>> of component->bind() calls used to initialize the remote encoder and attach
>>>> it to the crtc. This is different from other drm implementations which expect
>>>> the display driver to supply a crtc and connect an encoder to it.
>>> I think both approaches are valid in DRM. We don't want to remove the component
>>> framework because it is doing the wrong thing, but because we cannot use it
>>> with drivers that implement the drm_bridge API. Given that we usually pair with
>>> a component encoder that also implements a drm_bridge, dropping support for
>>> component framework should not affect the users of the driver.
> 
> Glad to see the patch - I think this is moving things in the right
> direction.
> 
> 
> While at it do you plan to support DRM_BRIDGE_ATTACH_NO_CONNECTOR?
> 
> I did not read the patch carefully but noticed this call with no flags:
> 
>> drm_bridge_attach(&kcrtc->encoder, bridge, NULL, 0);
> 
> To add support for DRM_BRIDGE_ATTACH_NO_CONNECTOR you may need to verify
> that all relevant bridge drivers supports the flag.
> You will be told at runtime but only if the relevant bridge driver is
> used.

Just from reading the documentation on this (https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/drm_bridge.c#L439) I gather this is useful for chains of multiple bridges where the connector is discovered at runtime? I'm not sure if we have a configuration like this with komeda here.

Also I'm not sure what it means for the CRTC driver to "support" this flag. Do I always call drm_bridge_attach() with it?

> 
> It can be done later and is obviously a separate patch.
> 

Sure though I cannot promise I can look into it anytime soon.

Thanks,
Faiz
