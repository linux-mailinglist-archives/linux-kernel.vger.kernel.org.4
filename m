Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACE3750B43
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjGLOor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232927AbjGLOon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:44:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B39C1998
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689173035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C34WsFlKYjYWkTFb9HgsWdoRE76RVrfdGiTYT+vpVqI=;
        b=gfWUPjjl+cxln4qi/dVrXBYB8tEIaeAo8fgjFWVykJV3EP5RbnGwORQ26j7b4pXtZ+TgiV
        JfOjbpHd+FESBWiNuLwHAG+af0gbDlojcH1rntulDtzEIOqTNaqe2b6RIEXlp7n3kq/SGR
        INvqElybSshW4KMN72uYKVLEzgRbOOU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-GDEssEVIObSjFK9mCmq9HA-1; Wed, 12 Jul 2023 10:43:53 -0400
X-MC-Unique: GDEssEVIObSjFK9mCmq9HA-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-51e10b6148cso1162539a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173032; x=1691765032;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C34WsFlKYjYWkTFb9HgsWdoRE76RVrfdGiTYT+vpVqI=;
        b=g5oswi78Q5ZkhK+HtXFwsSJTbUEAUyQy3d0R6k3waehKFvNyyo87VJrFL7qV2GLMUG
         mxQuQGv4s2fLQMGaTdYZ7xgjuQBQIaOPn9DnzEkyBplcmVgJZGO0NcIXD47BAphNbTRL
         zReZ9RtouUZVPadvv3lvEnN53EhKs3wRkrUTDAeeBRrwYzTQXufqiEHFMGrFfHLO/19c
         Oso/LCnZ2P/LnfNg8V75MtZkfTrJXSe2OLdk5uP75cfhutlywvIelyUP5bjFqTGTd662
         VyOXVHRHtqyfB5eLRYgTzyYHruqldHqYtIrh/cKQOoY2y2r3FaN7y+uI9Dp5PqC6OVZe
         CmVw==
X-Gm-Message-State: ABy/qLatYxpSi8x/9hLXWsTxOEmXuszlQsgTM165ebk1SMhKwnuxRTp0
        ZREzmuaQG9uS7GaSqcUnJebXr27GcSREnWkJ+UdZ+AB6GKG/vop0bYjkrJJXfefmQpEwoMgslgX
        7Mm+cjqOVfPjOHwIlk1Zxz1RNqXZF4Rqd
X-Received: by 2002:a05:6402:5245:b0:51f:c6a1:4355 with SMTP id t5-20020a056402524500b0051fc6a14355mr3025299edd.4.1689173032283;
        Wed, 12 Jul 2023 07:43:52 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEa35eKJ9IGbLw5gzEbWDSaeBN07RQx+T2XC+mOrnyClSMdlCkLN6eYHK5OBBuZ4tkrEJMU7Q==
X-Received: by 2002:a05:6402:5245:b0:51f:c6a1:4355 with SMTP id t5-20020a056402524500b0051fc6a14355mr3025281edd.4.1689173032056;
        Wed, 12 Jul 2023 07:43:52 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u7-20020aa7d0c7000000b0051a2d2f82fdsm2877251edo.6.2023.07.12.07.43.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:43:51 -0700 (PDT)
Message-ID: <0f50cb97-0507-bcbb-03c6-e3394690ae80@redhat.com>
Date:   Wed, 12 Jul 2023 16:43:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 5/8] platform/x86: asus-wmi: don't allow eGPU switching
 if eGPU not connected
Content-Language: en-US, nl
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net
References: <20230630053552.976579-1-luke@ljones.dev>
 <20230630053552.976579-6-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230630053552.976579-6-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/30/23 07:35, Luke D. Jones wrote:
> Check the ASUS_WMI_DEVID_EGPU_CONNECTED method for eGPU connection
> before allowing the ASUS_WMI_DEVID_EGPU method to run.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> ---
>  drivers/platform/x86/asus-wmi.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 0c8a4a46b121..821addb284d7 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -693,6 +693,15 @@ static ssize_t egpu_enable_store(struct device *dev,
>  	if (enable > 1)
>  		return -EINVAL;
>  
> +	err = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_EGPU_CONNECTED);
> +	if (err < 0)
> +		return err;
> +	if (err < 1) {
> +		err = -ENODEV;
> +		pr_warn("Failed to set egpu disable: %d\n", err);
> +		return err;
> +	}
> +
>  	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_EGPU, enable, &result);
>  	if (err) {
>  		pr_warn("Failed to set egpu disable: %d\n", err);

