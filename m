Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5E8704620
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjEPHSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjEPHSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949114230
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684221432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lhuSrwd9fgN2JCGIYbu47UG4UUxhirjw8ksWArcDvyM=;
        b=JMrHWsiFVbM6EIv5J7RSKhRlBsaNPe+RN1S2HAc5/UUaxHHd+pYunAdkd3skpQAxHkxoE0
        gVR11ENanKL9qyt1bTdx5QqIRPxWhkroHfR08zdT2moQNcxPKEgWTw1BRT1TRwb30ba1/u
        twmRahwqSe2dbIWpVjGgIrUNNdV2R/k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-jKS-foEENou9gV8TnEURcw-1; Tue, 16 May 2023 03:17:11 -0400
X-MC-Unique: jKS-foEENou9gV8TnEURcw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f508c2b301so2783655e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 00:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221430; x=1686813430;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lhuSrwd9fgN2JCGIYbu47UG4UUxhirjw8ksWArcDvyM=;
        b=lpAExmtSydsLWtji/LyvcSNqeUnFNdOhsyg2MpSbh9ISQ2fvxuFW2zFJmNxbwaTvOo
         NQ1m9+6boBAzXH/mR59uq4Ug9qb05XPhxqT7PgPXjS9qP+RiGIu9icJ6LyjOLzFNGB7T
         E8ks0Vzxmqy5O85S4JEYYEZgMk2bKNIz69xy70RALoEiCiFsxoVL/Qx3no6K+VtzLcem
         BWtaotS/gYAaZRh2ap1IgvY1tOjwcrBPu3pG3yUPNfuqhN30moQgnGj9ESLGUbikR63y
         ks8sGT+RKI0BXgr2S+i/yg8NgIH2Oq03pdvu0o1qy8qZ9IPlTBQhTTisrhGj/xdLbMkj
         KNiA==
X-Gm-Message-State: AC+VfDzwqJ603xzoLJrSecjZqCLp7mk9EvySoFtKx24eQ/RI8SPHABRV
        TplYFWNK2Y8n3IF4gKNpGmZ+yuWxA2Pr0E7vkxVMP07FeLIatUpvs+4oen/pFJJbdn9Gh8B+kop
        I95qxAFHFSppF5EufGV6a8HEW
X-Received: by 2002:a1c:7319:0:b0:3f4:e86b:798 with SMTP id d25-20020a1c7319000000b003f4e86b0798mr1688867wmb.1.1684221430501;
        Tue, 16 May 2023 00:17:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6HzhNEoB7+RJp5aRv8QSWui09/dclQsgOPQMK3YAPqH47hSvw0jUumKqlLGJC/WlClcF4fow==
X-Received: by 2002:a1c:7319:0:b0:3f4:e86b:798 with SMTP id d25-20020a1c7319000000b003f4e86b0798mr1688842wmb.1.1684221430173;
        Tue, 16 May 2023 00:17:10 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-225-74.dyn.eolo.it. [146.241.225.74])
        by smtp.gmail.com with ESMTPSA id t22-20020a7bc3d6000000b003f427cba193sm1208635wmj.41.2023.05.16.00.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:17:09 -0700 (PDT)
Message-ID: <d84a75724637a58d25ecbc35316b6b11a979e923.camel@redhat.com>
Subject: Re: [PATCH net-next 4/7] net: lan966x: Add support for offloading
 dscp table
From:   Paolo Abeni <pabeni@redhat.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        UNGLinuxDriver@microchip.com
Date:   Tue, 16 May 2023 09:17:08 +0200
In-Reply-To: <20230514201029.1867738-5-horatiu.vultur@microchip.com>
References: <20230514201029.1867738-1-horatiu.vultur@microchip.com>
         <20230514201029.1867738-5-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-05-14 at 22:10 +0200, Horatiu Vultur wrote:
> @@ -117,12 +164,16 @@ static int lan966x_dcb_ieee_setapp(struct net_devic=
e *dev, struct dcb_app *app)
>  	if (prio) {
>  		app_itr =3D *app;
>  		app_itr .priority =3D prio;
> -		dcb_ieee_delapp(dev, &app_itr);
> +		lan966x_dcb_ieee_delapp(dev, &app_itr);
>  	}
> =20
> -	err =3D dcb_ieee_setapp(dev, app);
> +	if (app->selector =3D=3D IEEE_8021QAZ_APP_SEL_DSCP)
> +		err =3D lan966x_dcb_ieee_dscp_setdel(dev, app, dcb_ieee_setapp);
> +	else
> +		err =3D dcb_ieee_setapp(dev, app);
> +
>  	if (err)
> -		goto out;
> +		return err;

As Piotr suggested, please drop the out: label altogether, replacing
even the other 'goto out;' statement with a plain return. Additionally
you can replace the final:

	return err;

in this function with:

	return 0;

Thanks,

Paolo

