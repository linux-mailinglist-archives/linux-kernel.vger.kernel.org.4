Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0EA630C65
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 07:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiKSGUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 01:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKSGUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 01:20:34 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7433B7EC8B;
        Fri, 18 Nov 2022 22:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=GWI3tHIEFUoKRvzS0Oizyv0BLbzzh/6tf/RAcYC6Iro=; b=G3KxCV2rb5mZfvvznp/9CC+EBM
        KcD+vP36I5TzIJhXtU9IVoOtRT6L8qz/QgF0XyX2kTWrJpX9rG5F2QQVvUDuWEXF2FpnhGWWMrRkf
        +Ha8WFAf/r9qx3aOzCNInuywFLiebucR8zYtFRPANgQwVvhvwltkqP6FONTeu6PoHh82awA/J7q2t
        WGErOJl064QxGyos8yxqX6wsDEvWsXlyjuze8KlYJDm6XDNh7l2Fhkyaco6oSG4/SYmsPrPiUE3fe
        h9I0/q0/tazRyiclDDKIQj8evtGN9oDUHEIZjmGH+PEyS9al61jda18owK2RlX4OFTGWy7W2/Ctqw
        /cVj6wDg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owHDL-00BaOP-Da; Sat, 19 Nov 2022 06:20:31 +0000
Message-ID: <b8191c01-4d78-537b-9650-a783e14e5997@infradead.org>
Date:   Fri, 18 Nov 2022 22:20:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: build failure in linux-next: offb missing fb helpers
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-kbuild@vger.kernel.org
References: <20221118150351.GV28810@kitsune.suse.cz>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20221118150351.GV28810@kitsune.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

[adding Masahiro-san]


On 11/18/22 07:03, Michal Suchánek wrote:
> Hello,
> 
> I am seeing these errors:
> 
> [ 3825s]   AR      built-in.a
> [ 3827s]   AR      vmlinux.a
> [ 3835s]   LD      vmlinux.o
> [ 3835s]   OBJCOPY modules.builtin.modinfo
> [ 3835s]   GEN     modules.builtin
> [ 3835s]   GEN     .vmlinux.objs
> [ 3848s]   MODPOST Module.symvers
> [ 3848s]   CC      .vmlinux.export.o
> [ 3849s]   UPD     include/generated/utsversion.h
> [ 3849s]   CC      init/version-timestamp.o
> [ 3849s]   LD      .tmp_vmlinux.btf
> [ 3864s] ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x58): undefined
> reference to `cfb_fillrect'
> [ 3864s] ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x60): undefined
> reference to `cfb_copyarea'
> [ 3864s] ld: drivers/video/fbdev/offb.o:(.data.rel.ro+0x68): undefined
> reference to `cfb_imageblit'
> 
> cfb_fillrect is provided by drivers/video/fbdev/core/cfbfillrect.c
> 
> It is compiled when CONFIG_FB_CFB_FILLRECT
> drivers/video/fbdev/core/Makefile:obj-$(CONFIG_FB_CFB_FILLRECT)  += cfbfillrect.o
> 
> drivers/video/fbdev/Makefile:obj-$(CONFIG_FB_OF)               += offb.o
> is compiled when CONFIG_FB_OF
> 
> It selects CONFIG_FB_CFB_FILLRECT
> config FB_OF
>         bool "Open Firmware frame buffer device support"
>         depends on (FB = y) && PPC && (!PPC_PSERIES || PCI)
>         select APERTURE_HELPERS
>         select FB_CFB_FILLRECT
>         select FB_CFB_COPYAREA
>         select FB_CFB_IMAGEBLIT
>         select FB_MACMODES
> 
> The config has FB_OF built-in and FB_CFB_FILLRECT modular
> config/ppc64le/vanilla:CONFIG_FB_CFB_FILLRECT=m
> config/ppc64le/vanilla:CONFIG_FB_CFB_COPYAREA=m
> config/ppc64le/vanilla:CONFIG_FB_CFB_IMAGEBLIT=m
> config/ppc64le/vanilla:CONFIG_FB_OF=y
> 
> It only depends on FB which mut be built-in for FB_OF
> config FB_CFB_FILLRECT
>         tristate
>         depends on FB
> 
> Is select in kconfig broken?
> 
> Attachnig the config in question.

The symbol info from xconfig says:

Symbol: FB_CFB_FILLRECT [=m]
Type : tristate
Defined at drivers/video/fbdev/Kconfig:69
Depends on: HAS_IOMEM [=y] && FB [=y]
Selected by [m]:
[deleted]
- FB_OF [=y] && HAS_IOMEM [=y] && FB [=y]=y && PPC [=y] && (!PPC_PSERIES [=y] || PCI [=y]) && !DRM_OFDRM [=m]

I don't see why the 'select' from (bool) FB_OF would leave FB_CFB_FILLRECT (and the others)
as =m instead of =y.

Hopefully Masahiro can shed some light on this.

-- 
~Randy
