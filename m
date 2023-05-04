Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1AB6F656C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjEDHFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjEDHFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:05:51 -0400
X-Greylist: delayed 657 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 May 2023 00:05:48 PDT
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CBDD11731
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:05:48 -0700 (PDT)
Received: from [192.168.178.88] (p57bc9658.dip0.t-ipconnect.de [87.188.150.88])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 7F2DA28054E;
        Thu,  4 May 2023 06:54:49 +0000 (UTC)
Message-ID: <81a2e61f-5b30-06c9-6773-70c89c836fa7@zonque.org>
Date:   Thu, 4 May 2023 08:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] sound: caiaq: input: Add error handling for unsupported
 input methods in `snd_usb_caiaq_input_init`
To:     Ruliang Lin <u202112092@hust.edu.cn>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Karsten Wiese <fzu@wemgehoertderstaat.de>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230504065054.3309-1-u202112092@hust.edu.cn>
Content-Language: en-US
From:   Daniel Mack <daniel@zonque.org>
In-Reply-To: <20230504065054.3309-1-u202112092@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 08:50, Ruliang Lin wrote:
> Smatch complains that:
> snd_usb_caiaq_input_init() warn: missing error code 'ret'
> 
> This patch adds a new case to handle the situation where the 
> device does not support any input methods in the 
> `snd_usb_caiaq_input_init` function. It returns an `-EINVAL` error code 
> to indicate that no input methods are supported on the device.
> 
> Fixes: 523f1dce3743 ("[ALSA] Add Native Instrument usb audio device support")
> Signed-off-by: Ruliang Lin <u202112092@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>

Acked-by: Daniel Mack <daniel@zonque.org>



> ---
> The issue is found by static analyzer. The patched code has passed
> Smatch checker, but remains untested on real device.
> ---
>  sound/usb/caiaq/input.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
> index 1e2cf2f08eec..84f26dce7f5d 100644
> --- a/sound/usb/caiaq/input.c
> +++ b/sound/usb/caiaq/input.c
> @@ -804,6 +804,7 @@ int snd_usb_caiaq_input_init(struct snd_usb_caiaqdev *cdev)
>  
>  	default:
>  		/* no input methods supported on this device */
> +		ret = -EINVAL;
>  		goto exit_free_idev;
>  	}
>  

