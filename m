Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E826EBF15
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 13:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjDWLJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 07:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDWLJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 07:09:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A3E10E2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 04:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682248112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YJ86ZVDYRM9CotkEiqPEtZYHk4qaL2Mn/oKfEYumLFI=;
        b=f5SAWhttc4AiAw759Ji7WL4BpPSZ7VbyQfikV3oYvT3O1euRyjVpZReRgpa5K2vIyk9h17
        9m5KIC4UOF7qCzjE/eqXcC6EJJzeTQlddoL0JJGQ5s+iBSwaRUCciYRtojIvHw+4cgDErv
        f8BZoIrYHwUM6SKFAdEDa2isDKQ3SGU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-wVDm5j4oP3-y8qVww0HYAQ-1; Sun, 23 Apr 2023 07:08:31 -0400
X-MC-Unique: wVDm5j4oP3-y8qVww0HYAQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f08900db79so11202525e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 04:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682248110; x=1684840110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YJ86ZVDYRM9CotkEiqPEtZYHk4qaL2Mn/oKfEYumLFI=;
        b=YeqHUEY+oFf0Uv/G/6954WI5rdPm66YIG3etzMmHBjXmb6zlRJD1DR1S4P1+ZUCCQr
         8WR2a7akaMtHsQZb+LxG1ibjH/j3pWw+tqATjfcZxoRj3B2xVNfp1m4HCtsrl+qDNWGN
         Hygr8TJAEj5bgMs7hcScQ5Vk08uULcwI8TE0ipNslfmuTT8mH8ZUZHLewTeuOHS0GjSW
         E3Grhm6aLQLj5jUS7sbU+Mw6DL/hgDrzwhosAbP7AiHqqYTidVSS67OQP3TgGfV9nZiu
         LDFI3bSqnjhgnLLysZG4kgseR9gQJ1mD1T0l3zsxNNoU0ekQppm5vYw8j4rm02BJL42u
         4v1A==
X-Gm-Message-State: AAQBX9eOxQXrlPP8LisbKPXb/uEIfywY2TKx1p8TTadLZLFGZKCMUXpz
        3teQIHDbIesMIrbgjOIVvKk+yWsofncuYDyallhNxlB1AoC/eWvXpZJutzRXJ0NqRdBa7hsPRsC
        FsrtIGDbP16isuwXJhRKoc6DwKqrcDQMw
X-Received: by 2002:a7b:c393:0:b0:3f1:6458:99a7 with SMTP id s19-20020a7bc393000000b003f1645899a7mr5314662wmj.38.1682248109914;
        Sun, 23 Apr 2023 04:08:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z/eTtNo8BI6gHMtlywU6k2jFJAtKMz2XjK/PppbaZmNDeKGTzU6hmsHxo9LguBSKtEf649Aw==
X-Received: by 2002:a7b:c393:0:b0:3f1:6458:99a7 with SMTP id s19-20020a7bc393000000b003f1645899a7mr5314651wmj.38.1682248109608;
        Sun, 23 Apr 2023 04:08:29 -0700 (PDT)
Received: from redhat.com ([2.55.61.39])
        by smtp.gmail.com with ESMTPSA id k36-20020a05600c1ca400b003f1733feb3dsm12878417wms.0.2023.04.23.04.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 04:08:29 -0700 (PDT)
Date:   Sun, 23 Apr 2023 07:08:25 -0400
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
Message-ID: <20230423070705-mutt-send-email-mst@kernel.org>
References: <20230417030713-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723F3E6AE381AEC36D1AEFED49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423031308-mutt-send-email-mst@kernel.org>
 <AM0PR04MB472392318BC9A36CBA7AF19AD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB472392318BC9A36CBA7AF19AD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 08:01:35AM +0000, Alvaro Karsz wrote:
> We could add a new virtio_config_ops: peek_vqs.
> We can call it during virtnet_validate, and then fixup the features in case of small vrings.
> 
> If peek_vqs is not implemented by the transport, we can just fail probe later in case of small vrings.
> 

Nope, we can't. Driver is not supposed to discover vqs before
FEATURES_OK, the vq size might depend on features.

