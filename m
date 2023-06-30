Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488F2744181
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 19:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjF3Rmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 13:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjF3Rmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:42:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EFF1FF2;
        Fri, 30 Jun 2023 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688146962; x=1719682962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6ISUeTd0XhjdV8+62msVXrrY1/WzccMTu3hMk/d62SY=;
  b=eUiMJSrFu+hpssucqKqLf+CkFN/0vQsAwZvogeltSJs7MuR2K3xtuC1R
   avUgqqhldIHPgf7MhwMoaHggahW+gY9Kq6F4hpZiVfhiZZRwQq41rhlXa
   mhIIbW0gXWp5rzwgxYrmIrznv4fmAYoGf4z+B/Rb7tmQ/SfHdufGMVXLu
   QqGmdqc0X8HqgjaHIpwwDVYnk193YyXBmE7R1FEePOmRSKH1hcQf5Bp23
   2qJmSCckBY/lD/BsH4BE2HTG5gUxV8U8PaxeVXY3Y+yg3TyxJPWAocmUP
   idYZR1LecotWq/6yGijn+wKn2tXe+J0a68rC2Ou+sEvuPMYzLVM5/DGbW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="428497331"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="428497331"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 10:42:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="964480373"
X-IronPort-AV: E=Sophos;i="6.01,171,1684825200"; 
   d="scan'208";a="964480373"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2023 10:42:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qFI8T-001AUw-09;
        Fri, 30 Jun 2023 20:42:21 +0300
Date:   Fri, 30 Jun 2023 20:42:20 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 0/2] Allow disabling all native fbdev drivers and only
 keeping DRM emulation
Message-ID: <ZJ8T/Fexkr9wEZoP@smile.fi.intel.com>
References: <20230629225113.297512-1-javierm@redhat.com>
 <ZJ8RY7ZUlryrPB50@smile.fi.intel.com>
 <878rc0etqe.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rc0etqe.fsf@minerva.mail-host-address-is-not-set>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023 at 07:38:01PM +0200, Javier Martinez Canillas wrote:
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
> > On Fri, Jun 30, 2023 at 12:51:02AM +0200, Javier Martinez Canillas wrote:
> >> This patch series splits the fbdev core support in two different Kconfig
> >> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
> >> be disabled, while still having the the core fbdev support needed for the
> >> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
> >> disabling all fbdev drivers instead of having to be disabled individually.
> >> 
> >> The reason for doing this is that now with simpledrm, there's no need for
> >> the legacy fbdev (e.g: efifb or vesafb) drivers anymore and many distros
> >
> > How does simpledrm works with earlycon=efi?
> >
> 
> simpledrm isn't for earlycon. For that you use a different driver (i.e:
> drivers/firmware/efi/earlycon.c). I'm just talking about fbdev drivers
> here that could be replaced by simpledrm.

So, efifb can't be replaced. Please, fix your cover letter to reduce false
impression of the scope of usage of the simpledrm.

-- 
With Best Regards,
Andy Shevchenko


