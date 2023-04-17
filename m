Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B40D6E4715
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjDQMDD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjDQMDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FE765AF
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681732863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2LRp3zjh0DOhKKwcTJt+220dZY+oP35RdJVHgXAQvQE=;
        b=D0p9hffpr7Xeolr36BHrIuSoscnEuTY5KIyW9Dvka5g3IZV04rFiL4+Qh6GR1z5s7wGYal
        PKMaa0TXD8d5S/E+goXrbS/NeocUNOOiIby6GJk+LD75aceKNZ1ab2Zn9mMxJDsqyBi7NA
        WH3N2cvm65nfdosn8eE7OaBPDXnSLYg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-gmexpUbVNQauECkjwQoiVQ-1; Mon, 17 Apr 2023 07:57:29 -0400
X-MC-Unique: gmexpUbVNQauECkjwQoiVQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a34e35f57so284958666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 04:57:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681732649; x=1684324649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LRp3zjh0DOhKKwcTJt+220dZY+oP35RdJVHgXAQvQE=;
        b=OlImrRLbSLbXZtYasLhGvnnQjyxg+I4lmFi3YP29toC5aaoILMmdOqGGrUSEKPS8wX
         7YdMwDxXOOMS32Ii6/AkaPNA3OEbhX1YPX0PXus+ufUCUo6KdsH+voFZyj6xrtRnr1Aa
         MO35X3bHGQU0Od+7SKl6qWcZPN9OpneCqaEWkp6HbCHplcOVdl8MF+GddjL+SMUcqxSR
         AKlHr6CE2DRjknwKLFwIcbD6w6m0JPwGdKdmxZol9q37ocYdBWJCnY0eHPZdSQuBrr/I
         je2SrZXpf1CQwjFSrtgToLSYGLdM00tcJBAxjUM0gDiCAw7la9u3UfnwCGKIDt7VbFCe
         MTSQ==
X-Gm-Message-State: AAQBX9d43Q6Et51vk5cZQ3ur4+l9A5/zK+c3LJBZaKCsn1Ay5P2UZSrM
        4RYdeYe0cTIY/+R0XxExJEyOe9jTyqdaqBcHZEV/WXVDKTh5HpS23jba+ZSFSrB1DZ3jq3iS1H8
        o0GqlUOv5r47gJ2jQIymBSqxX
X-Received: by 2002:a05:6402:1154:b0:506:83f7:157b with SMTP id g20-20020a056402115400b0050683f7157bmr10206151edw.10.1681732648814;
        Mon, 17 Apr 2023 04:57:28 -0700 (PDT)
X-Google-Smtp-Source: AKy350aNKgY4zPoooD46Q25GLFK8yAqcM6inydsLa/BdAONuep0Wjoauz5/ie895Qh5ZYK7I0H0Nfg==
X-Received: by 2002:a05:6402:1154:b0:506:83f7:157b with SMTP id g20-20020a056402115400b0050683f7157bmr10206139edw.10.1681732648606;
        Mon, 17 Apr 2023 04:57:28 -0700 (PDT)
Received: from redhat.com ([2.52.136.129])
        by smtp.gmail.com with ESMTPSA id n23-20020a056402061700b005068f46064asm3426009edv.33.2023.04.17.04.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 04:57:28 -0700 (PDT)
Date:   Mon, 17 Apr 2023 07:57:24 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230417075645-mutt-send-email-mst@kernel.org>
References: <20230417021725-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723B8489F8F9AE547393697D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417023911-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237BFB8BB3A3606CE6A408D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417030713-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723F3E6AE381AEC36D1AEFED49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:51:22AM +0000, Alvaro Karsz wrote:
> > > I see your point.
> > > Regardless, we'll need to fail probe in some cases.
> > > ring size of 1 for example (if I'm not mistaken)
> > 
> > Hmm. We can make it work if we increase hard header size, then
> > there will always be room for vnet header.
> > 
> > > control vq even needs a bigger ring.
> > 
> > Why does it?
> 
> At the moment, most of the commands chain 3 descriptors:
> 1 - class + command
> 2 - command specific
> 3 - ack
> 
> We could merge 1 and 2 into a single one, both are read only for the device, so I take it back, it won't need a bigger ring.
> But it will need 2 descriptors at least(1 read only for the device and 1 write only for the device), so we still need to fail probe sometimes.
> 

Yes that makes sense, it's architetural. We can disable ctrl vq though.

-- 
MST

