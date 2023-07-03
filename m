Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00CF4745CEB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 15:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjGCNNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 09:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjGCNND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 09:13:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA9E91;
        Mon,  3 Jul 2023 06:13:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1458160F2F;
        Mon,  3 Jul 2023 13:13:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9EAC433C9;
        Mon,  3 Jul 2023 13:12:56 +0000 (UTC)
Message-ID: <d78e6ec3-a531-8fd4-a785-29b6712f83ae@xs4all.nl>
Date:   Mon, 3 Jul 2023 15:12:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/6] media: v4l2: Add audio capture and output support
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.de>
Cc:     Shengjiu Wang <shengjiu.wang@gmail.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Shengjiu Wang <shengjiu.wang@nxp.com>, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
        Jacopo Mondi <jacopo@jmondi.org>
References: <1688002673-28493-1-git-send-email-shengjiu.wang@nxp.com>
 <1688002673-28493-2-git-send-email-shengjiu.wang@nxp.com>
 <ZJ6o5fT4V4HXivFa@valkosipuli.retiisi.eu>
 <CAA+D8AND1yZ7eZLjBGxVF=i3hLMecUm-j7AVHN9npJi-4=3VrA@mail.gmail.com>
 <87h6ql5hch.wl-tiwai@suse.de>
 <43f0ecdf-7454-49ae-96b3-2eae5487e9a5@sirena.org.uk>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <43f0ecdf-7454-49ae-96b3-2eae5487e9a5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2023 14:53, Mark Brown wrote:
> On Mon, Jul 03, 2023 at 02:07:10PM +0200, Takashi Iwai wrote:
>> Shengjiu Wang wrote:
> 
>>> There is no such memory to memory interface defined in ALSA.  Seems
>>> ALSA is not designed for M2M cases.
> 
>> There is no restriction to implement memory-to-memory capture in ALSA
>> framework.  It'd be a matter of the setup of PCM capture source, and
>> you can create a corresponding kcontrol element to switch the mode or
>> assign a dedicated PCM substream, for example.  It's just that there
>> was little demand for that.
> 
> Yeah, it's not a terrible idea.  We might use it more if we ever get
> better support for DSP audio, routing between the DSP and external
> devices if driven from the CPU would be a memory to memory thing.
> 
>> I'm not much against adding the audio capture feature to V4L2,
>> though, if it really makes sense.  But creating a crafted /dev/audio*
>> doesn't look like a great idea to me, at least.
> 
> I've still not looked at the code at all.

My main concern is that these cross-subsystem drivers are a pain to
maintain. So there have to be good reasons to do this.

Also it is kind of weird to have to use the V4L2 API in userspace to
deal with a specific audio conversion. Quite unexpected.

But in the end, that's a decision I can't make.

So I wait for that feedback. Note that if the decision is made that this
can use V4L2, then there is quite a lot more that needs to be done:
documentation, new compliance tests, etc. It's adding a new API, and that
comes with additional work...

Regards,

	Hans
