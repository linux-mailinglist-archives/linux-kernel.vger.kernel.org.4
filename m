Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C586E3FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 08:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDQGVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 02:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjDQGVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 02:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1153A80
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681712425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ePbMyRA1sPZRgCUtm4jF6vrpMcXUEcAn5cv4sWSGRdg=;
        b=HU61dzEjIQnANKsvWxGQlo6ir/zpRY2bcJxc5TTk24/IpWiksNa113SzycV01+hfS4ssai
        QBbqmqiLwkDrXXK3xJRYFR4zO/Bg29b1HU/R8uf48F3yzEVXDlrgvfi3bpPZTALxFcJw6R
        RLd8m8OIN4zZLvx3fz+TamlNoRx+1AM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-iCkF-W6MMFWl72Npizquzw-1; Mon, 17 Apr 2023 02:20:24 -0400
X-MC-Unique: iCkF-W6MMFWl72Npizquzw-1
Received: by mail-qt1-f200.google.com with SMTP id e8-20020a05622a110800b003e4e915a164so12917853qty.4
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 23:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681712424; x=1684304424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePbMyRA1sPZRgCUtm4jF6vrpMcXUEcAn5cv4sWSGRdg=;
        b=hEbOM2ZjpA0yBKMVAv9ekfhzRR1QtifdG6wD7/2slVGFbHRLWLzknatX2dV4lmpqgE
         fG7IwcQhF28fd0Yd8GMHsKghm779Zi4nJTifG2kWT2GZCEFoBB69IFEktTdaZpyfuGDX
         WB8arWrEQj0m892GOPKOuY3PbXPLEeeDKY5g3TYW0+/Ft9BvgijI1sQmFsJcfwoKvzC8
         KkBTP3cy/NdCO5OK3lkU/E4mT0Nghn2cRzEa/R0j5YkJdsONisQPrtor/enBTLD4Y+Iz
         qXedHNZpkCv8G6QsKlFj3sIC3P9Ju141tpPQOreTHR/pho7PBmqPctFV4AmoB6Dv0OPv
         j5IQ==
X-Gm-Message-State: AAQBX9d+1dSi5U5/7IVX6QMKzi1tTDp9oA8gmQ9/+Pw5Tf57JkTP9GmJ
        yY9yfi89GLFc2M7oOIxH++Zd/DtaSSORvhC3d77dTXmro1Y/YaKCbeRqMrx/FPDbaJPPoQFO5U3
        +8vS+Rnei5PssjhLmAcdNSp4u
X-Received: by 2002:a05:6214:400e:b0:5ef:5503:d41c with SMTP id kd14-20020a056214400e00b005ef5503d41cmr13070238qvb.15.1681712424105;
        Sun, 16 Apr 2023 23:20:24 -0700 (PDT)
X-Google-Smtp-Source: AKy350YGBvzLQl8TSywlbRHoWsuwzUmdZAtbC2GsJy/SU9rWuxjFVNqOx/mP7CdWEeGgZjqG0Nm5bg==
X-Received: by 2002:a05:6214:400e:b0:5ef:5503:d41c with SMTP id kd14-20020a056214400e00b005ef5503d41cmr13070223qvb.15.1681712423865;
        Sun, 16 Apr 2023 23:20:23 -0700 (PDT)
Received: from redhat.com ([185.199.103.251])
        by smtp.gmail.com with ESMTPSA id lx4-20020a0562145f0400b005ef42af7eb7sm2870554qvb.25.2023.04.16.23.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 23:20:23 -0700 (PDT)
Date:   Mon, 17 Apr 2023 02:20:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Alvaro Karsz <alvaro.karsz@solid-run.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230417021725-mutt-send-email-mst@kernel.org>
References: <20230416074607.292616-1-alvaro.karsz@solid-run.com>
 <AM0PR04MB4723C6E99A217F51973710F5D49F9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230416164453-mutt-send-email-mst@kernel.org>
 <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEvFhVyWb5+ET_akPvnjUq04+ZbJC8o_GtNBWqSMGNum8A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 11:24:16AM +0800, Jason Wang wrote:
> On Mon, Apr 17, 2023 at 4:45 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Sun, Apr 16, 2023 at 04:54:57PM +0000, Alvaro Karsz wrote:
> > > After further consideration, other virtio drivers need a minimum limit to the vring size too.
> > >
> > > Maybe this can be more general, for example a new virtio_driver callback that is called (if implemented) during virtio_dev_probe, before drv->probe.
> > >
> > > What do you think?
> > >
> > > Thanks,
> > > Alvaro
> >
> > Let's start with what you did here, when more than 2 drivers do it we'll
> > move it to core.
> 
> I wonder how hard it is to let virtio support small vring size?
> 
> Thanks

Actually, I think that all you need to do is disable NETIF_F_SG,
and things will work, no?
Alvaro, can you try?


> >
> > --
> > MST
> >

