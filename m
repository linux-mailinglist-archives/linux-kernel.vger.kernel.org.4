Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11FC6EE1D0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 14:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjDYM03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 08:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbjDYM01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 08:26:27 -0400
X-Greylist: delayed 2012 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 25 Apr 2023 05:26:23 PDT
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9691FCC2A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 05:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LKJ66zAjbuXplPzSu3tI/DMl4yefA+smD0GUzn2LWn8=; b=SdL4pGFWhzmcVtzO9QhWzrDNub
        8XcJuFCAL/zIUydQM2phnTX3XX8MC1FKcVEbCOc32UPOrdf2c5YhOA6T95vYOA65Sdle73KZ92U+X
        r0EnOPobVqbnxQg6F78YB+k9wDYM3bpStjhHGC41ApsNRpvOJwZDV9P34GojgPmu8n7E=;
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.96)
        (envelope-from <kilobyte@angband.pl>)
        id 1prHDO-00HQPu-35;
        Tue, 25 Apr 2023 13:52:10 +0200
Date:   Tue, 25 Apr 2023 13:52:10 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: Re: [PATCH] mei: make hdcp and pxp depend on X86 && PCI
Message-ID: <20230425115210.GA4151911@angband.pl>
References: <20230423135124.55196-1-kilobyte@angband.pl>
 <MN2PR11MB409305D13E46C371321AC2F0E5649@MN2PR11MB4093.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR11MB409305D13E46C371321AC2F0E5649@MN2PR11MB4093.namprd11.prod.outlook.com>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 04:39:23AM +0000, Winkler, Tomas wrote:
> What is the exact issue you are experiencing, can you add the error message this fixes? 

The problem doesn't trigger in mainline, as DRM_I915 can't be enabled on
!X86; https://github.com/kilobyte/linux branch i915 has a WIP port.  Some
unrelated piece (I suspect ACPI changes, didn't bother to investigate) has
in the meantime grown enough bits to enable prerequsites that trigger:

WARNING: unmet direct dependencies detected for INTEL_MEI_ME
  Depends on [n]: X86 && PCI [=y]
  Selected by [y]:
  - INTEL_MEI_HDCP [=y] && DRM_I915 [=y]
  - INTEL_MEI_PXP [=y] && DRM_I915 [=y]

This doesn't cause an actual build failure, as drivers/misc/Makefile has
> obj-$(CONFIG_INTEL_MEI)         += mei/
which won't try to build mei/hdcp nor mei/pxp despite them being enabled
in the config.

Of all the settings in drivers/misc/mei/Kconfig, only these two (that
reside in their own subdirectories) lack this stanza.  You'd want to
deduplicate the selects one day -- but alas, "select" relations are not as
straightforward as "depends", thus I only did the same as for all other
settings in drivers/misc/mei/Kconfig.

Should I quote this warning in full in the commit message?  I thought that
"make ... depend on ..." already explains enough.

Also, as this lack of dependency is an obvious and self-contained change,
I decided to submit it directly via mei, rather than ask for an ACK then
spam you with every iteration of the patchset.  Should it go via drm/i915
instead?

(I'd also like to apologize for sitting on this patchset so long, my
brain's firmware is faulty :/ ).

> > From: Adam Borowski <kilobyte@angband.pl>
> > 
> > All other MEI configs do so already.  This fixes a Kconfig gripe if I915 gets
> > ported to other archs (such as RISC-V in Intel Horse Creek...).
> > 
> > Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> > ---
> >  drivers/misc/mei/hdcp/Kconfig | 1 +
> >  drivers/misc/mei/pxp/Kconfig  | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/misc/mei/hdcp/Kconfig b/drivers/misc/mei/hdcp/Kconfig
> > index 54e1c9526909..83e67771ac6b 100644
> > --- a/drivers/misc/mei/hdcp/Kconfig
> > +++ b/drivers/misc/mei/hdcp/Kconfig
> > @@ -4,6 +4,7 @@
> >  config INTEL_MEI_HDCP
> >  	tristate "Intel HDCP2.2 services of ME Interface"
> >  	select INTEL_MEI_ME
> > +	depends on X86 && PCI
> >  	depends on DRM_I915
> >  	help
> >  	  MEI Support for HDCP2.2 Services on Intel platforms.
> > diff --git a/drivers/misc/mei/pxp/Kconfig b/drivers/misc/mei/pxp/Kconfig
> > index 4029b96afc04..95f2c2470d28 100644
> > --- a/drivers/misc/mei/pxp/Kconfig
> > +++ b/drivers/misc/mei/pxp/Kconfig
> > @@ -5,6 +5,7 @@
> >  config INTEL_MEI_PXP
> >  	tristate "Intel PXP services of ME Interface"
> >  	select INTEL_MEI_ME
> > +	depends on X86 && PCI
> >  	depends on DRM_I915
> >  	help
> >  	  MEI Support for PXP Services on Intel platforms.
> > --
> > 2.40.0

Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ Q: Is it ok to combine wired, wifi, and/or bluetooth connections
⢿⡄⠘⠷⠚⠋⠀    in wearable computing?
⠈⠳⣄⠀⠀⠀⠀ A: No, that would be mixed fabric, which Lev19:19 forbids.
