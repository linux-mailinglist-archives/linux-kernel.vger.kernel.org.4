Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC456365EA
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 17:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbiKWQfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 11:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235641AbiKWQft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 11:35:49 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C15E23BD7;
        Wed, 23 Nov 2022 08:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=3h/VgEw0Wflfm9bqnZb5OvyNPIn+ZE40wg6eS0dcqRM=; b=fT8osm953AWBxu8+52OtN4myCG
        neTJeoJChBklml5lCWyNy25CDFeCueojHw+n+N61xIYLuxt1T0p6PxZVBJjwjMV0ldvrUH2A9OPYR
        itmfGGiLDmlnZXP36gb1owvtUQvHzf7Bhp4BKeaTXV8RUlfIwfnhhKdkNzQb/KSsUKO3ko7L9q+nJ
        z57ddCke4H/HGWjrZM2F76zLg2jda4Ljv9btOrm663EPRkvBCTE7sGeyjzbaVMz4F2QkOJyvsyHfj
        pxSBJRnkJQvI0qSzv+OzdDFYLi0au9aheuskBtF1H6aN58aWr8WzoD5HTnMtiM9Xxtyo+Is5iBpQ2
        DOF4RH5A==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oxsix-000tzy-65; Wed, 23 Nov 2022 16:35:47 +0000
Message-ID: <fcdb5238-5977-526a-4752-fa82893a580e@infradead.org>
Date:   Wed, 23 Nov 2022 08:35:44 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH -next] fbdev: offb: allow build when DRM_OFDRM=m
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Michal Suchanek <msuchanek@suse.de>,
        linuxppc-dev@lists.ozlabs.org, Helge Deller <deller@gmx.de>
References: <20221123031605.16680-1-rdunlap@infradead.org>
 <4b10b87d-f255-4839-8700-858d98ffb801@app.fastmail.com>
 <25c22370-b67a-33a6-f1e6-abf70760d866@infradead.org>
In-Reply-To: <25c22370-b67a-33a6-f1e6-abf70760d866@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/22 02:02, Randy Dunlap wrote:
> Hi Arnd,
> 
> On 11/23/22 01:08, Arnd Bergmann wrote:
>> On Wed, Nov 23, 2022, at 04:16, Randy Dunlap wrote:
>>> Fix build when CONFIG_FB_OF=y and CONFIG_DRM_OFDRM=m.
>>> When the latter symbol is =m, kconfig downgrades (limits) the 'select's
>>> under FB_OF to modular (=m). This causes undefined symbol references:
>>>
>>> powerpc64-linux-ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x58): 
>>> undefined reference to `cfb_fillrect'
>>> powerpc64-linux-ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x60): 
>>> undefined reference to `cfb_copyarea'
>>> powerpc64-linux-ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x68): 
>>> undefined reference to `cfb_imageblit'
>>>
>>> Fix this by allowing FB_OF any time that DRM_OFDRM != y so that the
>>> selected FB_CFB_* symbols will become =y instead of =m.
>>>
>>> In tristate logic (for DRM_OFDRM), this changes the dependency from
>>>     !DRM_OFDRM	== 2 - 1 == 1 => modular only (or disabled)
>>> to (boolean)
>>>     DRM_OFDRM != y == y, allowing the 'select's to cause the
>>> FB_CFB_* symbols to =y instead of =m.
>>>
>>
>> Is it actually a useful configuration to have OFDRM=m and
>> FB_OF=y though? I would expect in that case that the OFDRM
>> driver never binds to a device because it's already owned
>> by FB_OF.
>>
>>> diff -- a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
>>> --- a/drivers/video/fbdev/Kconfig
>>> +++ b/drivers/video/fbdev/Kconfig
>>> @@ -455,7 +455,7 @@ config FB_ATARI
>>>  config FB_OF
>>>  	bool "Open Firmware frame buffer device support"
>>>  	depends on (FB = y) && PPC && (!PPC_PSERIES || PCI)
>>> -	depends on !DRM_OFDRM
>>> +	depends on DRM_OFDRM != y
>>>  	select APERTURE_HELPERS
>>
>> I would instead make this 'depends on DRM_OFDRM=n', which
>> completely eliminates configs that have both driver enabled.
> 
> Yep, that works for me. Thanks.
> 
> Thomas, Michal, are you OK with that change?
> 
>> A nicer change would be to make FB_OF a tristate symbol,
>> which makes it possible to load one of the two modules if
>> both are enabled =m, while only allowing one of them to
>> be =y if the other is completely disabled. It looks like
>> offb was originally written to be usable as a loadable module,
>> but Kconfig has prevented this since at least the start of
>> the git history.

ISTM that a distro would prefer to have both DFM_OFDRM and
FB_OF as tristate symbols that could both be built as loadable
modules, as Arnd describes above.
I'll look into that.

-- 
~Randy
