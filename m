Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54062644336
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 13:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbiLFMdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 07:33:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbiLFMc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 07:32:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C0182937F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 04:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670329918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHp3x7R/guV3hbeucoqTiz42buTvLFKB8vI9+m0vRAc=;
        b=D8IwG+S5zN1MXxryo/fCbh6Ukt/pyOIUP5D5x14+YyEC+gihSMfWQRGJ+dyT5pZ/BwytnZ
        cZcJS2nok0YWsMYa/Kn+uhFHXv2E+yFCzZ3ztYkBchEgJT6oTltkhSC71I/3u+Se9aYeTm
        SyIz9epZnF7Flo1uPGBcLpx9QaBryKA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-16-lxacUxHPOuucCBWP_VAHDw-1; Tue, 06 Dec 2022 07:31:57 -0500
X-MC-Unique: lxacUxHPOuucCBWP_VAHDw-1
Received: by mail-wr1-f69.google.com with SMTP id w11-20020adfbacb000000b002418a90da01so3147729wrg.16
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 04:31:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DHp3x7R/guV3hbeucoqTiz42buTvLFKB8vI9+m0vRAc=;
        b=KR8kvcOHUboXz3GA8eeJoLWJPNOByY2uEt53yXW4nzWTQqPmbDy0aA+/SDPN9k+I+E
         NudbXnGhwT2KX8K51+VdfXRwRy0I9T/kCbB4/4lD7TZ1fYoCRWlzKhUDD0GECQFjofHa
         WV3Xia8uS581cGiLRRRySGckiIvMdINiMCahLmj+XO4KNhaTH98GSbDKFNPX/pH5S2fZ
         lsSIan/IGVnQgM9WX0dwwyRHjXwgjII55v0w8gy8FHDA8FNlGFHPXGKNPkUo8tw3CPZm
         2Y0ifGc0VB1ImHMdbYrfj/T6oV8xHea5shSjt3Q/cnMobnckt6R/gEErRcmUeO342k+H
         OsbQ==
X-Gm-Message-State: ANoB5pmTDtrmhxf/i4o3xQPtFcszXI2Tyl5wWSZo9LLlIYvhtQ+v9DME
        RtkpNWFeSi3cdHAqueEC481n1qLGIO6ima4L+ZSqQIKW6OtcYyKNdDo7U05m2UOvzBzAATwHBrO
        dPYcEn0uKA74V7+rY3SxRzvdp
X-Received: by 2002:adf:db85:0:b0:241:bfd7:de7 with SMTP id u5-20020adfdb85000000b00241bfd70de7mr50298110wri.254.1670329915715;
        Tue, 06 Dec 2022 04:31:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7/qzzr0VuvbP4qZ7Yd3q9rLNeZH+c2AL9jutLoNZnaid8y/nFTvCdzJr8fgsaFlM4wi8oyFQ==
X-Received: by 2002:adf:db85:0:b0:241:bfd7:de7 with SMTP id u5-20020adfdb85000000b00241bfd70de7mr50298102wri.254.1670329915442;
        Tue, 06 Dec 2022 04:31:55 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-106-100.dyn.eolo.it. [146.241.106.100])
        by smtp.gmail.com with ESMTPSA id r2-20020a056000014200b002422bc69111sm20743265wrx.9.2022.12.06.04.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 04:31:55 -0800 (PST)
Message-ID: <256f533f019b6392b41701707eb7aa056b2f16c0.camel@redhat.com>
Subject: Re: [PATCH net-next v3 1/4] net: microchip: vcap: Add vcap_get_rule
From:   Paolo Abeni <pabeni@redhat.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        Steen.Hegelund@microchip.com, lars.povlsen@microchip.com,
        daniel.machon@microchip.com, richardcochran@gmail.com,
        UNGLinuxDriver@microchip.com, olteanv@gmail.com
Date:   Tue, 06 Dec 2022 13:31:53 +0100
In-Reply-To: <20221203104348.1749811-2-horatiu.vultur@microchip.com>
References: <20221203104348.1749811-1-horatiu.vultur@microchip.com>
         <20221203104348.1749811-2-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sat, 2022-12-03 at 11:43 +0100, Horatiu Vultur wrote:
> @@ -632,32 +264,22 @@ static int vcap_show_admin(struct vcap_control *vctrl,
>  			   struct vcap_admin *admin,
>  			   struct vcap_output_print *out)
>  {
> -	struct vcap_rule_internal *elem, *ri;
> +	struct vcap_rule_internal *elem;
> +	struct vcap_rule *vrule;
>  	int ret = 0;
>  
>  	vcap_show_admin_info(vctrl, admin, out);
> -	mutex_lock(&admin->lock);
>  	list_for_each_entry(elem, &admin->rules, list) {

Not strictly related to this patch, as the patter is AFAICS already
there in other places, but I'd like to understand the admin->rules
locking schema.

It looks like addition/removal are protected by admin->lock, but
traversal is usually lockless, which in turn looks buggy ?!?

Note: as this patch does not introduce the mentioned behavior, I'm not
going to block the series for the above.

Thanks,

Paolo
> -		ri = vcap_dup_rule(elem);
> -		if (IS_ERR(ri)) {
> -			ret = PTR_ERR(ri);
> -			goto err_unlock;
> +		vrule = vcap_get_rule(vctrl, elem->data.id);
> +		if (IS_ERR_OR_NULL(vrule)) {
> +			ret = PTR_ERR(vrule);
> +			break;
>  		}
> -		/* Read data from VCAP */
> -		ret = vcap_read_rule(ri);
> -		if (ret)
> -			goto err_free_rule;
> +
>  		out->prf(out->dst, "\n");
> -		vcap_show_admin_rule(vctrl, admin, out, ri);
> -		vcap_free_rule((struct vcap_rule *)ri);
> +		vcap_show_admin_rule(vctrl, admin, out, to_intrule(vrule));
> +		vcap_free_rule(vrule);
>  	}
> -	mutex_unlock(&admin->lock);
> -	return 0;
> -
> -err_free_rule:
> -	vcap_free_rule((struct vcap_rule *)ri);
> -err_unlock:
> -	mutex_unlock(&admin->lock);
>  	return ret;
>  }

