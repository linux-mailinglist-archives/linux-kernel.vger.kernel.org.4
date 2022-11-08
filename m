Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438136218A1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234436AbiKHPlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234424AbiKHPlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:41:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32F95C751;
        Tue,  8 Nov 2022 07:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667922112; x=1699458112;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Fj2cRf0yfLP9Hty6jDMoaxrwsB/IsUZhdIEv+NMr+lk=;
  b=WJCQ17IGIH0C/eLm+QAik0jtkVN2S7YfJVpUalNQfjx2/xNPmMfVCTiZ
   ppg1EorRy7HsyGn20Ly00AvEnSqD9wyzpYfQZZC2u/DsCAEgFHUMgNyQu
   1zxtMvshpKBJvE0IqcGbZAGOYaD95kx4ZT6d4F2dM9QKDSzVMdkfA9vBI
   glur8/yq53SojqKajMS09TV2lY4yCzkCLt8cRPYaS+G6OQYJzDH2JkFZR
   gY9iKSpnXFCGic50UE6e78vMwqivZa3H+FMudHxAkBfA2OhRE/b3RfhSW
   IvfYrOQR0z4TfA0UCqu2O/tcWLzyFsmJTkDXC9JaZW0NV7VgN57outFLf
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="290445132"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="290445132"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 07:41:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="669591064"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="669591064"
Received: from liuc3-mobl1.ccr.corp.intel.com ([10.254.214.201])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 07:41:49 -0800
Message-ID: <0ab36c3ac0841296227b96ec0a5cadca0c4ac2ed.camel@intel.com>
Subject: Re: [PATCH v1 1/5] rtc: rtc-cmos: Call cmos_wake_setup() from
 cmos_do_probe()
From:   Zhang Rui <rui.zhang@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-rtc@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date:   Tue, 08 Nov 2022 23:41:47 +0800
In-Reply-To: <CAJZ5v0gavPhs5wqhE0VOrhydbqVgC4BSRxN-aGPmAP2a2k_WhA@mail.gmail.com>
References: <2276401.ElGaqSPkdT@kreacher> <1850290.tdWV9SEqCh@kreacher>
         <b369e6d44b01e0ccc653e333bc2def556b17bbb3.camel@intel.com>
         <CAJZ5v0gavPhs5wqhE0VOrhydbqVgC4BSRxN-aGPmAP2a2k_WhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-11-08 at 14:09 +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 8, 2022 at 3:31 AM Zhang Rui <rui.zhang@intel.com> wrote:
> > On Mon, 2022-11-07 at 20:59 +0100, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > 
> > > Notice that cmos_wake_setup() is the only user of acpi_rtc_info
> > > and
> > > it
> > > can operate on the cmos_rtc variable directly, so it need not set
> > > the
> > > platform_data pointer before cmos_do_probe() is called.  Instead,
> > > it
> > > can be called by cmos_do_probe() in the case when the
> > > platform_data
> > > pointer is not set to implement the default behavior (which is to
> > > use
> > > the FADT information as long as ACPI support is enabled).
> > > 
> > 
> > ...
> > 
> > > @@ -827,19 +829,27 @@ cmos_do_probe(struct device *dev, struct
> > >               if (info->address_space)
> > >                       address_space = info->address_space;
> > > 
> > > -             if (info->rtc_day_alarm && info->rtc_day_alarm <
> > > 128)
> > > -                     cmos_rtc.day_alrm = info->rtc_day_alarm;
> > > -             if (info->rtc_mon_alarm && info->rtc_mon_alarm <
> > > 128)
> > > -                     cmos_rtc.mon_alrm = info->rtc_mon_alarm;
> > > -             if (info->rtc_century && info->rtc_century < 128)
> > > -                     cmos_rtc.century = info->rtc_century;
> > > +             cmos_rtc.day_alrm = info->rtc_day_alarm;
> > > +             cmos_rtc.mon_alrm = info->rtc_mon_alarm;
> > > +             cmos_rtc.century = info->rtc_century;
> > > 
> > >               if (info->wake_on && info->wake_off) {
> > >                       cmos_rtc.wake_on = info->wake_on;
> > >                       cmos_rtc.wake_off = info->wake_off;
> > >               }
> > > +     } else {
> > > +             cmos_wake_setup(dev);
> > >       }
> > > 
> > > 
> > 
> > Previously, before commit a474aaedac99 ("rtc-cmos: move wake setup
> > from
> > ACPI glue into RTC driver"), dev->platform_data is set in
> > drivers/acpi/glue.c, and the above commit moves it to
> > cmos_wake_setup()
> > in this file.
> > 
> > Now, with this patch, my understanding is that dev->platform_data
> > is
> > never set, thus we can remove the 'info' variable and the
> >         if (info)
> > check above.
> 
> There are other users of this driver which can be found by grepping
> for cmos_rtc_board_info.
> 
> They create platform device objects with platform_data set which are
> then bound to by this driver.

yeah, I overlooked this.

thanks,
rui

