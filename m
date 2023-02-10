Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A48869275E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 20:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjBJTrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 14:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjBJTrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 14:47:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F657812A1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676058242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LqEMVOprqbRcgnb26iJyeC9PYlAfqxHL1qiXDXu+U9A=;
        b=Yi8jga6vVTeH8KDmFU3fYyjh38a0kQ16NQnJiNLT6u6UkYkge8x1VqfWzI4sALclmqNuEF
        DhEVy/EQSnfTFedqfEp/vQBO5n397RwGSD+xepMSCXCcNeJ4btI/RCex3dsgIJd5N2Q2BW
        poUfP99khFTPQ9hrwme6+uRzbvq2JEk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-qmreCKTPNVe9Hy2xnzDt_g-1; Fri, 10 Feb 2023 14:44:00 -0500
X-MC-Unique: qmreCKTPNVe9Hy2xnzDt_g-1
Received: by mail-ed1-f69.google.com with SMTP id g19-20020a056402115300b004a26cc7f6cbso4172525edw.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 11:44:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LqEMVOprqbRcgnb26iJyeC9PYlAfqxHL1qiXDXu+U9A=;
        b=YF/cyzgC2EYaLmBABGSxDedZ1wWe1AM9RLk+fsGz2H2EjLR6hD7ze1VSBXQH00+Wyl
         H6m1U9FRRe+adrqOYrNTjRpaOwF6OCZrieDvQ9EkJ6So5Ytvv2G3U3G1omd/pfMQ9ol2
         TrljE/Zn669rz/EITe2qaqCDQZyL7ueHfigMWLfXCaV7Y7A+cijQXEldilPQd5WdHkd7
         oV5Qz32Vt7dQv47mcTu85R8M2btN8E7m4WxDxOVzNzibz/270d1PVEnf33DZTiCn92oo
         OaWM4ZOEGr4jydi+2J3a88nAEF/CTPs7UX+nAW4oc2UnHZU8wsmu0JTKTWBIUWxsqPTF
         j8Iw==
X-Gm-Message-State: AO0yUKXwK7J9jCA2GPKXS88zEK2J2Pr9Oudppr841rOtXLLPxf0omlFH
        EecZwgMp5CAHMIiQiPEYBOn+8JaUldpSGo6SNyADfWyl48jGe3pOPt/KFeWz9JVXdPdDrpLrrMo
        +BZeN6bvnKmwK92MYqM3iNR30
X-Received: by 2002:a17:906:a1d3:b0:878:7cf3:a9e7 with SMTP id bx19-20020a170906a1d300b008787cf3a9e7mr14861836ejb.65.1676058239627;
        Fri, 10 Feb 2023 11:43:59 -0800 (PST)
X-Google-Smtp-Source: AK7set9tc5ya+xq3T9ohLhPWkzaq1RTuRLg/Wi00GiP7Oc96aPjNzatgLBaKs4/WUVNxcjQaldtHxA==
X-Received: by 2002:a17:906:a1d3:b0:878:7cf3:a9e7 with SMTP id bx19-20020a170906a1d300b008787cf3a9e7mr14861809ejb.65.1676058239467;
        Fri, 10 Feb 2023 11:43:59 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id f20-20020a170906c09400b00872c0bccab2sm2786828ejz.35.2023.02.10.11.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 11:43:58 -0800 (PST)
Message-ID: <ee952253-9ee4-aa81-fefa-609cbf6e1e2b@redhat.com>
Date:   Fri, 10 Feb 2023 20:43:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 5/9] apple-gmux: Use GMSP acpi method for interrupt
 clear
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
 <20230210044826.9834-6-orlandoch.dev@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230210044826.9834-6-orlandoch.dev@gmail.com>
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
> This is needed for interrupts to be cleared correctly on MMIO based
> gmux's. It is untested if this helps/hinders other gmux types, but I
> have seen the GMSP method in the acpi tables of a MacBook with an
> indexed gmux.
> 
> If this turns out to break support for older gmux's, this can instead
> be only done on MMIO gmux's.
> 
> There is also a "GMLV" acpi method, and the "GMSP" method can be called
> with 1 as its argument, but the purposes of these aren't known and they
> don't seem to be needed.
> 
> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> ---
>  drivers/platform/x86/apple-gmux.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
> index 760434a527c1..c605f036ea0b 100644
> --- a/drivers/platform/x86/apple-gmux.c
> +++ b/drivers/platform/x86/apple-gmux.c
> @@ -494,8 +494,29 @@ static const struct apple_gmux_config apple_gmux_index = {
>   * MCP79, on all following generations it's GPIO pin 6 of the Intel PCH.
>   * The GPE merely signals that an interrupt occurred, the actual type of event
>   * is identified by reading a gmux register.
> + *
> + * On MMIO gmux's, we also need to call the acpi method GMSP to properly clear
> + * interrupts. TODO: Do other types need this? Does this break other types?
>   */
>  
> +static int gmux_call_acpi_gmsp(struct apple_gmux_data *gmux_data, int arg)
> +{
> +	acpi_status status = AE_OK;
> +	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
> +	struct acpi_object_list arg_list = { 1, &arg0 };
> +
> +	arg0.integer.value = arg;
> +
> +	status = acpi_evaluate_object(gmux_data->dhandle, "GMSP", &arg_list, NULL);
> +	if (ACPI_FAILURE(status)) {
> +		pr_err("GMSP call failed: %s\n",
> +		       acpi_format_exception(status));
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}
> +
>  static inline void gmux_disable_interrupts(struct apple_gmux_data *gmux_data)
>  {
>  	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_ENABLE,
> @@ -519,7 +540,10 @@ static void gmux_clear_interrupts(struct apple_gmux_data *gmux_data)
>  
>  	/* to clear interrupts write back current status */
>  	status = gmux_interrupt_get_status(gmux_data);
> -	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> +	if (status) {
> +		gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> +		gmux_call_acpi_gmsp(gmux_data, 0);

Ugh no, please don't go around calling random ACPI methods from untested
firmware revisions / device models.

ACPI code (even Apple's I have learned) tends to be full of bugs. If we
did not need to call GMSP before then please lets keep not calling it
on the older models. Just because it is there does not mean that calling
it is useful, it might even be harmful.

Regards,

Hans






> +	}
>  }
>  
>  static void gmux_notify_handler(acpi_handle device, u32 value, void *context)

