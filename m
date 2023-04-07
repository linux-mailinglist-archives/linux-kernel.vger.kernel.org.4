Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31866DAF5D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240795AbjDGPHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240758AbjDGPGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:06:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFA8BDE1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 08:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680879815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cuQoojtyUSJETR2nd2K1fNz+7Y625dx15WLZe51OqG8=;
        b=gbIN/Hc+n3+MvZreT9bdKp3v7PEapMHFwog4AanIwNqx9yv+o4t8jYbc8fC/Y5at2bISLS
        OXGYuRX4Mp2jUJneHvZosJv+2rbn9EY1q9OWMH8jIzRisZlfAGcMZs3CIqJo5VHt3ArYyx
        E4SvrdxW57f5uSwq1kZoG3Xv5xFv0oY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-q8L6o_Z3O9ObYMM6ClAAug-1; Fri, 07 Apr 2023 11:03:34 -0400
X-MC-Unique: q8L6o_Z3O9ObYMM6ClAAug-1
Received: by mail-wm1-f69.google.com with SMTP id iv10-20020a05600c548a00b003ee112e6df1so19840072wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 08:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680879812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuQoojtyUSJETR2nd2K1fNz+7Y625dx15WLZe51OqG8=;
        b=SeLT7Ksfha8Y4OVTBDJB2sh9eDiX3dY1tKh60sx0n+LpKSNaqtLTy0IAOKmLv60oga
         BbWY1u/PKpiQDfNYcye4hIruHHqVObJbSorn6MD9YDBKDwfSbr4ErDEWR56ecCdj+fYu
         7qCYHA0ankwUX0cSKkirM/xE9djLrW8OVSUqdWFMzpyZhdhebENLo0ZEcesQmHFjmifv
         aukLhL3DnzfFRqSVGnbiy9jIS34bT3bUbLQaI8BYD+cDQf4jp6K6YBw+Uf5exAXDkyf4
         7ksV9JZNYHZgbpG8uExIWqbSpzXMhgP9frIA/dOPyuqXiNuCdOcClpUpX4ycCjBVF9N5
         RG0w==
X-Gm-Message-State: AAQBX9dz3+GA1MGkkwLsudjtLsy5vxJcZxZvRebo1Prh7GorxUbR0hIo
        zGVuiT3PTSijsHtb7rQPG0DR3bcNl6IyXl03E+WU0BD0jeR8qJo6YBPLt3RIfAyRO0xe9wlbPIG
        rmtbstJH89w/JnbhdZjbBgcKI
X-Received: by 2002:a1c:f310:0:b0:3ee:282d:1016 with SMTP id q16-20020a1cf310000000b003ee282d1016mr1909988wmq.25.1680879812622;
        Fri, 07 Apr 2023 08:03:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350YlKD1jBpgyeO97TrwIhBOy+olr/w0iTAY7aZtpV6/1SMgATNnjbyQV6aZgywuB2M7d+lyLKA==
X-Received: by 2002:a1c:f310:0:b0:3ee:282d:1016 with SMTP id q16-20020a1cf310000000b003ee282d1016mr1909963wmq.25.1680879812300;
        Fri, 07 Apr 2023 08:03:32 -0700 (PDT)
Received: from redhat.com ([2a06:c701:742d:fd00:c847:221d:9254:f7ce])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c511600b003ef5bb63f13sm8759938wms.10.2023.04.07.08.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 08:03:31 -0700 (PDT)
Date:   Fri, 7 Apr 2023 11:03:28 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH] vdpa: solidrun: constify pointers to hwmon_channel_info
Message-ID: <20230407110308-mutt-send-email-mst@kernel.org>
References: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230407150130.79917-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 05:01:30PM +0200, Krzysztof Kozlowski wrote:
> Statically allocated array of pointed to hwmon_channel_info can be made
> const for safety.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

sure, merge it as appropriate
Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
> This depends on hwmon core patch:
> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
> 
> Therefore I propose this should also go via hwmon tree.
> 
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> ---
>  drivers/vdpa/solidrun/snet_hwmon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/solidrun/snet_hwmon.c b/drivers/vdpa/solidrun/snet_hwmon.c
> index e695e36ff753..65304354b34a 100644
> --- a/drivers/vdpa/solidrun/snet_hwmon.c
> +++ b/drivers/vdpa/solidrun/snet_hwmon.c
> @@ -159,7 +159,7 @@ static const struct hwmon_ops snet_hwmon_ops = {
>  	.read_string = snet_hwmon_read_string
>  };
>  
> -static const struct hwmon_channel_info *snet_hwmon_info[] = {
> +static const struct hwmon_channel_info * const snet_hwmon_info[] = {
>  	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_LABEL,
>  			   HWMON_T_INPUT | HWMON_T_CRIT | HWMON_T_LABEL),
>  	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT | HWMON_P_LABEL),
> -- 
> 2.34.1

