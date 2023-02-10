Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BFD069276F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjBJTxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:53:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjBJTw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:52:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29AC7EFC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676058729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrfOu3qaR69ccH7DuaoAFvxzQf97CmjDnDorDQCgmI4=;
        b=EN2aWXhyZ/BzOz6sxPF2KHLs3DEeP8E+eANTCBF/YdnyGtpNtb1O4tMmcxiG0CTYGn9GG+
        EC3Lm4nKK4N98lv1226H/ft881UDS8U1bum0XI5mN7AHTDYzLGF7gwQU6AEB3ep1omf67Q
        OCYtz17roxXjFLtxLzE9sOoWdCYZ4Eg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-630-xPgxqDhVPay38Q46Vb3B7w-1; Fri, 10 Feb 2023 14:41:22 -0500
X-MC-Unique: xPgxqDhVPay38Q46Vb3B7w-1
Received: by mail-ed1-f71.google.com with SMTP id g25-20020aa7c859000000b004a3fe4cbb0cso4134905edt.17
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:41:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lrfOu3qaR69ccH7DuaoAFvxzQf97CmjDnDorDQCgmI4=;
        b=vrXBCgXtfEFfknM1uixbHwYQGl9rMcc+wj34XvJJqRyAyxqi6QWSbCmHgw0JpVM8Ia
         VfZpjclRpxrsK+tYsqRjRkaEMgwvDy/k8bXV+R0xUTTBgL6d88kni4PX4aOTUoeejnRl
         JzmvW7wBnggWjKLXHuN6PHwdp3r/lk2VwuymDqYGjMPwI8fgm+0R8ieh+rYBPrRGM4UF
         hjXp2YSxOidjEjY+fUc7ycu6D9rveMNsWIj+ZseOjLCTI5VuaLXAZYZzNbrDCrkf3Qoo
         9e2smUN8SV4gz6mOesfIsDNHJUX6gXpBsuPxKwNR1pGu00Rn1nQL3efyi2fEHr4lt9yt
         IIPQ==
X-Gm-Message-State: AO0yUKUGho3WJ8bfrzZeXVElzFiviuX9Bl0vFv4hor6pRzPBzUjeFZdz
        hAiaJvsm3e0mgjbCuWUNkBwZ6VwaZixpnbNLrQwENUH2ktLZiUklWVqEfqFkjXiYSshy1QdRO5o
        ody7qDU9UM3y+OUj4Buld8TJ01fpxzQ==
X-Received: by 2002:a17:907:9484:b0:878:509f:798c with SMTP id dm4-20020a170907948400b00878509f798cmr20702875ejc.4.1676058081357;
        Fri, 10 Feb 2023 11:41:21 -0800 (PST)
X-Google-Smtp-Source: AK7set8TTPRmaKf4d7r24Su7XzcDrt+64y6chZ0ujIOQt9F+tOX9hkZWuSzrrt1tNe/19CqcVroqsA==
X-Received: by 2002:a17:907:9484:b0:878:509f:798c with SMTP id dm4-20020a170907948400b00878509f798cmr20702858ejc.4.1676058081200;
        Fri, 10 Feb 2023 11:41:21 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906150c00b00888d593ce76sm2789667ejd.72.2023.02.10.11.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 11:41:20 -0800 (PST)
Message-ID: <f4992ffa-68db-7f8c-b92d-a0e1348a7839@redhat.com>
Date:   Fri, 10 Feb 2023 20:41:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 2/9] apple-gmux: consolidate version reading
Content-Language: en-US, nl
To:     Orlando Chamberlain <orlandoch.dev@gmail.com>,
        platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
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
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Evan Quan <evan.quan@amd.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
 <20230210044826.9834-3-orlandoch.dev@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230210044826.9834-3-orlandoch.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/10/23 05:48, Orlando Chamberlain wrote:
> Read gmux version in one go as 32 bits on both indexed and classic
> gmux's.
> 
> Classic gmux's used to read the version as
> 
> major = inb(base + 0x4);
> minor = inb(base + 0x5);
> release = inb(base + 0x6);
> 
> but this can instead be done the same way as indexed gmux's with
> gmux_read32(), so the same version reading code is used for classic
> and indexed gmux's (as well as mmio gmux's that will be added to this
> driver).
> 
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> ---
>  drivers/platform/x86/apple-gmux.c | 14 ++++++--------
>  include/linux/apple-gmux.h        |  6 +-----
>  2 files changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index e8cb084cb81f..67628104f31a 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -580,15 +580,13 @@ static int gmux_probe(struct pnp_dev *pnp, const struct pnp_device_id *id)
>  	if (indexed) {
>  		mutex_init(&gmux_data->index_lock);
>  		gmux_data->indexed = true;
> -		version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
> -		ver_major = (version >> 24) & 0xff;
> -		ver_minor = (version >> 16) & 0xff;
> -		ver_release = (version >> 8) & 0xff;
> -	} else {
> -		ver_major = gmux_read8(gmux_data, GMUX_PORT_VERSION_MAJOR);
> -		ver_minor = gmux_read8(gmux_data, GMUX_PORT_VERSION_MINOR);
> -		ver_release = gmux_read8(gmux_data, GMUX_PORT_VERSION_RELEASE);
>  	}
> +
> +	version = gmux_read32(gmux_data, GMUX_PORT_VERSION_MAJOR);
> +	ver_major = (version >> 24) & 0xff;
> +	ver_minor = (version >> 16) & 0xff;
> +	ver_release = (version >> 8) & 0xff;
> +
>  	pr_info("Found gmux version %d.%d.%d [%s]\n", ver_major, ver_minor,
>  		ver_release, (gmux_data->indexed ? "indexed" : "classic"));
>  

The problem with this is that there is nothing (no known register)
at address base + 7 and now you are reading from address base + 7
here where before the code was not, we have no idea how the hw
will respond to this.  This should be pretty innocent but still ...

> diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
> index 1f68b49bcd68..eb2caee04abd 100644
> --- a/include/linux/apple-gmux.h
> +++ b/include/linux/apple-gmux.h
> @@ -67,7 +67,6 @@ static inline bool apple_gmux_is_indexed(unsigned long iostart)
>   */
>  static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
>  {
> -	u8 ver_major, ver_minor, ver_release;
>  	struct device *dev = NULL;
>  	struct acpi_device *adev;
>  	struct resource *res;
> @@ -95,10 +94,7 @@ static inline bool apple_gmux_detect(struct pnp_dev *pnp_dev, bool *indexed_ret)
>  	 * Invalid version information may indicate either that the gmux
>  	 * device isn't present or that it's a new one that uses indexed io.
>  	 */
> -	ver_major = inb(res->start + GMUX_PORT_VERSION_MAJOR);
> -	ver_minor = inb(res->start + GMUX_PORT_VERSION_MINOR);
> -	ver_release = inb(res->start + GMUX_PORT_VERSION_RELEASE);
> -	if (ver_major == 0xff && ver_minor == 0xff && ver_release == 0xff) {
> +	if (!(~inl(res->start + GMUX_PORT_VERSION_MAJOR))) {

Assuming we can get this tested well enough that I'm ok with the change in general
please write this as:

	if (inl(res->start + GMUX_PORT_VERSION_MAJOR) == 0xffffffff) {

Which I believe is what you are trying to achieve here ?

Regards,

Hans



>  		indexed = apple_gmux_is_indexed(res->start);
>  		if (!indexed)
>  			goto out;

