Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 799E86A4339
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjB0Nsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjB0Nsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:48:43 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73FE91
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:48:40 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7000B56A;
        Mon, 27 Feb 2023 14:48:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1677505718;
        bh=F8CyeyPGkCIl/FLhycUgDR7ud4z/pDvsDnR0xMYzry0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JaweAXVN7b7r0ZYBcEo19FWbyU77LPJWU08bFoOL8sbWkQQ2XkxJjrEvTU1neHl9K
         nT+qKC1wQZbNwx4G4bnuafXk1jKydYxqBqHrnckPRXy133wkTQE518GmxQxhl/VyQK
         Rv/0yFBoJ84plAQVLLAl+g/ZdkUM+RsWQIp7nYWE=
Message-ID: <4dfc277b-fcca-1f85-777a-3a09cd230727@ideasonboard.com>
Date:   Mon, 27 Feb 2023 15:48:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm: omapdrm: Do not use helper unininitialized in
 omap_fbdev_init()
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Nathan Chancellor <nathan@kernel.org>, airlied@gmail.com,
        daniel@ffwll.ch, javierm@redhat.com
Cc:     ndesaulniers@google.com, trix@redhat.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        kernel test robot <lkp@intel.com>
References: <20230224-omapdrm-wsometimes-uninitialized-v1-1-3fec8906ee3a@kernel.org>
 <21c1675f-4184-e6f9-c9da-06722d6d7a12@suse.de>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <21c1675f-4184-e6f9-c9da-06722d6d7a12@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 11:01, Thomas Zimmermann wrote:
> Hi
> 
> Am 24.02.23 um 18:25 schrieb Nathan Chancellor:
>> Clang warns (or errors with CONFIG_WERROR):
>>
>>    ../drivers/gpu/drm/omapdrm/omap_fbdev.c:235:6: error: variable 
>> 'helper' is used uninitialized whenever 'if' condition is true 
>> [-Werror,-Wsometimes-uninitialized]
>>            if (!fbdev)
>>                ^~~~~~
>>    ../drivers/gpu/drm/omapdrm/omap_fbdev.c:259:26: note: uninitialized 
>> use occurs here
>>            drm_fb_helper_unprepare(helper);
>>                                    ^~~~~~
>>    ../drivers/gpu/drm/omapdrm/omap_fbdev.c:235:2: note: remove the 
>> 'if' if its condition is always false
>>            if (!fbdev)
>>            ^~~~~~~~~~~
>>    ../drivers/gpu/drm/omapdrm/omap_fbdev.c:228:30: note: initialize 
>> the variable 'helper' to silence this warning
>>            struct drm_fb_helper *helper;
>>                                        ^
>>                                         = NULL
>>    1 error generated.
>>
>> Return early, as there is nothing for the function to do if memory
>> cannot be allocated. There is no point in adding another label to just
>> emit the warning at the end of the function in this case, as memory
>> allocation failures are already logged.
>>
>> Fixes: 3fb1f62f80a1 ("drm/fb-helper: Remove drm_fb_helper_unprepare() 
>> from drm_fb_helper_fini()")
>> Link: https://github.com/ClangBuiltLinux/linux/issues/1809
>> Link: 
>> https://lore.kernel.org/oe-kbuild-all/202302250058.fYTe9aTP-lkp@intel.com/
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> 
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> 
>> ---
>> This is currently showing in mainline so I believe this should go to
>> drm-misc-next-fixes.
> 
> This tree is only active from -rc6 to sometime during the merge window. 
> I'll add your patch to drm-misc-fixes ASAP.

If it's not too late:

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

