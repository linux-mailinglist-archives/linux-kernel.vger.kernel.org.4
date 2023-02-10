Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C807692B64
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjBJXhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjBJXhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:37:36 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C36840CB;
        Fri, 10 Feb 2023 15:37:12 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 78so4816300pgb.8;
        Fri, 10 Feb 2023 15:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWl59Xq4HhZJNA/74ztn8Fz0mUv6Fs/PnU96YJviPtI=;
        b=eWV0M6rGtsHugvA38QqBpUL6jZ4y3mJzobxzFGiKGdTQNp2DYSntYK8fNimGGqSQG3
         v1URcOI0nGZ1/5TGJU4dqMNN0DJxIJ0uM4RokG2TRfHGuj5xlO84qXVGFdSjO+O54Geg
         7GsOk6Yj8pJaVWTcJG1de4lfsJ3gH1OShZrBNpbODHTlSWXeMhbmu3f65mM1QZYVFCIv
         4hvVqBnxmKH6VZ+tNP3BQHxQ0KIlFS7H1alY+jmoagEd/KhnLzqQ0toWliT5JA9sK9sa
         yQjxaTUBmPu4eclYjhf0zO5B1fdePRn/78QzQnXl3qUDNnYPDxsp/AtjsBh4MZEVPZro
         QMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWl59Xq4HhZJNA/74ztn8Fz0mUv6Fs/PnU96YJviPtI=;
        b=KJ+ptmnuHu01Uug8wA+cjlyMffhRPpHhqE/SwKdKhyvu0NIXt5cJWyAKER6TmI7IOH
         PXxvbvLYrRy6zPtfOo9xZ8gzSuKtqK6grJoyd7ip0LxR8+cGSRoJTqp7zVn2W6bsEouN
         mA/vk5iFxVTg9DxK8AD80sda3L4KF+S+qT8O5WYHkjuUtnLhm9TTpg28Mn86vCmipuaL
         aUjPExYeEa566ltOBAPCWSOb22lxc4pVNx7splYcogX8IGbbyBcsGcY+PTwcqndLU2K7
         jbBDOJMtk8acB4T3B74XtkaPEibcIdRW9DE8eIzrpfly0or+sHfmKl4jIX7RSD9TXCxT
         8obQ==
X-Gm-Message-State: AO0yUKX7ZKB1rNBHQZ/WM2sy7WnkVNdo3XfW12uxD1mIxeQde3o0vpMS
        a11PJmyk4p+vyGC9TZtsEfBlmMNpIWPNPQ==
X-Google-Smtp-Source: AK7set8/KTxG0Ml6oxWb6/Y9VAH38w4uk9BRJXkFZ7hYp7F15/mhAqCM06D1a5AHUz8YnhSy937ZjA==
X-Received: by 2002:aa7:93c2:0:b0:5a8:4459:384d with SMTP id y2-20020aa793c2000000b005a84459384dmr8724287pff.3.1676072231023;
        Fri, 10 Feb 2023 15:37:11 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id f16-20020aa782d0000000b00587fda4a260sm3776296pfn.9.2023.02.10.15.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 15:37:10 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:36:57 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Evan Quan <evan.quan@amd.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>
Subject: Re: [RFC PATCH 2/9] apple-gmux: consolidate version reading
Message-ID: <20230211103657.53108b64@redecorated-mbp>
In-Reply-To: <f4992ffa-68db-7f8c-b92d-a0e1348a7839@redhat.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
        <20230210044826.9834-3-orlandoch.dev@gmail.com>
        <f4992ffa-68db-7f8c-b92d-a0e1348a7839@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 20:41:19 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/10/23 05:48, Orlando Chamberlain wrote:
> > Read gmux version in one go as 32 bits on both indexed and classic
> > gmux's.
> > 
> > Classic gmux's used to read the version as
> > 
> > major = inb(base + 0x4);
> > minor = inb(base + 0x5);
> > release = inb(base + 0x6);
> > 
> > but this can instead be done the same way as indexed gmux's with
> > gmux_read32(), so the same version reading code is used for classic
> > and indexed gmux's (as well as mmio gmux's that will be added to
> > this driver).
> > 
> > Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > ---
> >  drivers/platform/x86/apple-gmux.c | 14 ++++++--------
> >  include/linux/apple-gmux.h        |  6 +-----
> >  2 files changed, 7 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/platform/x86/apple-gmux.c
> > b/drivers/platform/x86/apple-gmux.c index
> > e8cb084cb81f..67628104f31a 100644 ---
> > a/drivers/platform/x86/apple-gmux.c +++
> > b/drivers/platform/x86/apple-gmux.c @@ -580,15 +580,13 @@ static
> > int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
> > if (indexed) { mutex_init(&gmux_data->index_lock);
> >  		gmux_data->indexed = true;
> > -		version = gmux_read32(gmux_data,
> > GMUX_PORT_VERSION_MAJOR);
> > -		ver_major = (version >> 24) & 0xff;
> > -		ver_minor = (version >> 16) & 0xff;
> > -		ver_release = (version >> 8) & 0xff;
> > -	} else {
> > -		ver_major = gmux_read8(gmux_data,
> > GMUX_PORT_VERSION_MAJOR);
> > -		ver_minor = gmux_read8(gmux_data,
> > GMUX_PORT_VERSION_MINOR);
> > -		ver_release = gmux_read8(gmux_data,
> > GMUX_PORT_VERSION_RELEASE); }
> > +
> > +	version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
> > +	ver_major = (version >> 24) & 0xff;
> > +	ver_minor = (version >> 16) & 0xff;
> > +	ver_release = (version >> 8) & 0xff;
> > +
> >  	pr_info("Found gmux version %d.%d.%d [%s]\n", ver_major,
> > ver_minor, ver_release, (gmux_data->indexed ? "indexed" :
> > "classic")); 
> 
> The problem with this is that there is nothing (no known register)
> at address base + 7 and now you are reading from address base + 7
> here where before the code was not, we have no idea how the hw
> will respond to this.  This should be pretty innocent but still ...

That makes sense, hopefully someone will be able to test it.

> 
> > diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
> > index 1f68b49bcd68..eb2caee04abd 100644
> > --- a/include/linux/apple-gmux.h
> > +++ b/include/linux/apple-gmux.h
> > @@ -67,7 +67,6 @@ static inline bool apple_gmux_is_indexed(unsigned
> > long iostart) */
> >  static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool
> > *indexed_ret) {
> > -	u8 ver_major, ver_minor, ver_release;
> >  	struct device *dev = NULL;
> >  	struct acpi_device *adev;
> >  	struct resource *res;
> > @@ -95,10 +94,7 @@ static inline bool apple_gmux_detect(struct
> > pnp_dev *pnp_dev, bool *indexed_ret)
> >  	 * Invalid version information may indicate either that
> > the gmux
> >  	 * device isn't present or that it's a new one that uses
> > indexed io. */
> > -	ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
> > -	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
> > -	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
> > -	if (ver_major == 0xff && ver_minor == 0xff && ver_release
> > == 0xff) {
> > +	if (!(~inl(res->start + GMUX_PORT_VERSION_MAJOR))) {  
> 
> Assuming we can get this tested well enough that I'm ok with the
> change in general please write this as:
> 
> 	if (inl(res->start + GMUX_PORT_VERSION_MAJOR) == 0xffffffff) {
> 
> Which I believe is what you are trying to achieve here ?

Yes that is a neater way of doing what I was trying to do, I'll use
that in v2.

> 
> Regards,
> 
> Hans
> 
> 
> 
> >  		indexed = apple_gmux_is_indexed(res->start);
> >  		if (!indexed)
> >  			goto out;  
> 

