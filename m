Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1002C6775CC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 08:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjAWHtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 02:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjAWHtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 02:49:36 -0500
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE74EB5C
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 23:49:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1674460170; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=RTxESemQIBdB/vCeI1XAU0uzFUOirIKyt6ETh0OEaVDImmNShFxSWyLXLasnvWHGvl5/07gOuFKsCuR8j8+GngLEr72BADleEZkwnCalKI0uQg8hpJWy0ZW4fIojBgfsJwVtPiyHsMIlPV1G7blbnkv22VCFjHQlj+dNZJf8AQE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1674460170; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=AdAQHBgh92BmGKcOYUV3872Rywh4hI6DQSTytonZ+dI=; 
        b=X69cUIQle/cwcYTBBdVHf41VT5/HRwbM2LciTTqUbGsBnqbx8v40tSwaZsXIMTdOvT4QhQcnwU2tMR7+7msCet54UWXKmsdDCdYvIWPRmpWzWBvLR4kFyjTbIH8nD9fXq8QrvMEz7R4vx4XLv7x/qLPK9VR7VZdDRjffzhrXoFg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1674460170;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=AdAQHBgh92BmGKcOYUV3872Rywh4hI6DQSTytonZ+dI=;
        b=ORplW25AOxo+R65Fdyd4L4gF7Nde5reODy5nylGNXZSdhLpUf7JM6LsIk0H3PJQ3
        KWUoyzZx2cCMoelCw5VKscj8OjgC2oTO0gjcmARiKSSlY7KxzcCS0mv3TzHk83vFsZT
        zSjKOMAevpEmTOSutFO26AfUO7cFzbMTjpiQULj8=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1674460169506567.6772663530393; Sun, 22 Jan 2023 23:49:29 -0800 (PST)
Date:   Mon, 23 Jan 2023 15:49:29 +0800
From:   Li Chen <me@linux.beauty>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "rafael j. wysocki" <rafael@kernel.org>,
        "li chen" <lchen@ambarella.com>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <185dd9a850f.103424a4c958820.1375066060155911709@linux.beauty>
In-Reply-To: <Y76UBsukAz+yQ9bW@kroah.com>
References: <20230111072130.3885460-1-me@linux.beauty>
 <Y75odDyZXMzigoaL@kroah.com>
 <1859ff0ddb8.d9ed321d977156.553326609923116766@linux.beauty> <Y76UBsukAz+yQ9bW@kroah.com>
Subject: Re: [PATCH v2] debugfs: allow to use regmap for print regs
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
 ---- On Wed, 11 Jan 2023 18:48:38 +0800  Greg Kroah-Hartman  wrote --- 
 > On Wed, Jan 11, 2023 at 04:27:20PM +0800, Li Chen wrote:
 > > Hi Greg,
 > >  ---- On Wed, 11 Jan 2023 15:42:44 +0800  Greg Kroah-Hartman  wrote --- 
 > >  > On Wed, Jan 11, 2023 at 03:21:29PM +0800, Li Chen wrote:
 > >  > > From: Li Chen lchen@ambarella.com>
 > >  > > 
 > >  > > Currently, debugfs_regset32 only contains void __iomem *base,
 > >  > > and it is not friendly to regmap user.
 > >  > > 
 > >  > > Let's add regmap to debugfs_regset32, and add debugfs_print_regmap_reg32
 > >  > > to allow debugfs_regset32_show handle regmap.
 > >  > > 
 > >  > > Signed-off-by: Li Chen lchen@ambarella.com>
 > >  > 
 > >  > Do you have an actual in-kernel user for this new function?  We can't
 > >  > accept new apis without users for obvious reasaons.
 > > 
 > > Actually, both the old debugfs_print_regs32 and the new debugfs_regmap_print_regs32
 > > have only one user: debugfs_regset32_show located inside debugfs/file.c.
 > 
 > Yes, but that function is used by lots of drivers in the kernel today,
 > which is fine.
 > 
 > > The difference is currently all users(device drivers) only use debugfs_regset32->base,
 > > and none of them use debugfs_regset32->regmap, which is provided by this patch.
 > > 
 > > I'm not sure whether it violates the kernel's "no user, no new function" ruler or not.
 > 
 > Yes, you would have to have a user for this functionality for us to be
 > able to take the change.
 > 
 > > I use this regmap locally on our SoC driver, but it is still not ready to upstream, really sorry for it,
 > > and it is not a good idea to change existing non-regmap users to regmap haha.
 > >  
 > > If you think it does matter, please tell me and I will upload v3 with our SoC driver in the future.
 > 
 > Please add it to your SoC driver patch series instead and I will be glad
 > to review it at that point in time.  But for now, this shouldn't be
 > needed.
 
This patch is integrated into this series now: http://lists.infradead.org/pipermail/linux-arm-kernel/2023-January/804858.html

and its user is inside the first patch of the series, please help review it, thanks a lot!

Regards,
Li
