Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51705E5E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiIVJKr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIVJKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:10:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442608F949
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663837842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=morPVWV2ApZvdpDztZBUk6AXlt+AabwlvFbLlrqV78g=;
        b=U9H95KA/SbvrMo6v0zO65elzhJ2uL9CldbGbJpoMS5+FvYM4ffixGK0CklP7EUlCInF4+a
        Zum6nSSKZCQSOukhXcic4yJ3T/nno2zEr9hPQCBTmfRw9pCGkQcKuWUygk0+SodyvFxAP+
        uIM7tJQ9H+noUsy6Nr/VcKs8K2qvFzA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-511-H6n2iVawMkmpEUFcYxGLOQ-1; Thu, 22 Sep 2022 05:10:41 -0400
X-MC-Unique: H6n2iVawMkmpEUFcYxGLOQ-1
Received: by mail-wr1-f72.google.com with SMTP id m2-20020adfc582000000b0021e28acded7so3070874wrg.13
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:10:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=morPVWV2ApZvdpDztZBUk6AXlt+AabwlvFbLlrqV78g=;
        b=qYaq9VshT9lBz1IKad+7Y9/q43xCG/m95/2pjklcOB5YKEqWu5O1BWjG1QPjzeo2jF
         J5aFHMXjSn+X25b+fW5Jy3KvMMcq6lY9232slwkEp5gY3Os8l1n+cnFqRZMN7ZHTzMvo
         h7/uLcGMFG8jifWB9uHLYMy5jV69m6DyVGOqseR+9+Qp0wibsXuFBXDBLcIFjy8dItL4
         /m5Zkhk08avGNBlKy0HXYtcDxcs3RGUvDvEZOUAyu9DHfacbDJLa2c6oc+8bfymnGJnq
         54I+kPBSI9k8qF7yeA4sAhOZsP2N45qeb2DULJsqYAm/gg92pBQtcG/ENocQnbBonWST
         Gt7g==
X-Gm-Message-State: ACrzQf3S04LcKomA8u4p4l8phNvhzXx2P0Ty+gC4auHO8WFez9deR1Hu
        0DACYloDcqAa/0brY/cXOzs5zUHAirPHD1bn1kbWcTM9KKwbEfrCakNxlDiOXHvLfU8u5GWEcnJ
        J7HMlCM9bix59W1DTD2l3JgrW
X-Received: by 2002:a5d:5b19:0:b0:22b:237c:3de8 with SMTP id bx25-20020a5d5b19000000b0022b237c3de8mr1273126wrb.285.1663837839813;
        Thu, 22 Sep 2022 02:10:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7VpYxGn7XvbqoxWHkJ4g1p2oLdCxcI0CJ5KNSjNQGKsAc575PVXhFFaCl71jQAm7KG4p3Ttw==
X-Received: by 2002:a5d:5b19:0:b0:22b:237c:3de8 with SMTP id bx25-20020a5d5b19000000b0022b237c3de8mr1273106wrb.285.1663837839605;
        Thu, 22 Sep 2022 02:10:39 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-76.dyn.eolo.it. [146.241.104.76])
        by smtp.gmail.com with ESMTPSA id i10-20020a05600c354a00b003b462b314e7sm5498478wmq.16.2022.09.22.02.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:10:38 -0700 (PDT)
Message-ID: <f3ad0de40b424413ede30abd3517c8fad0c3caca.camel@redhat.com>
Subject: Re: [PATCH] Do not name control queue for virtio-net
From:   Paolo Abeni <pabeni@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>, Junbo <junbo4242@gmail.com>
Cc:     Jesper Dangaard Brouer <hawk@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org
Date:   Thu, 22 Sep 2022 11:10:37 +0200
In-Reply-To: <20220918081713-mutt-send-email-mst@kernel.org>
References: <20220917092857.3752357-1-junbo4242@gmail.com>
         <20220918025033-mutt-send-email-mst@kernel.org>
         <CACvn-oGUj0mDxBO2yV1mwvz4PzhN3rDnVpUh12NA5jLKTqRT3A@mail.gmail.com>
         <20220918081713-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2022-09-18 at 08:17 -0400, Michael S. Tsirkin wrote:
> On Sun, Sep 18, 2022 at 05:00:20PM +0800, Junbo wrote:
> > hi Michael
> > 
> > in virtio-net.c
> >     /* Parameters for control virtqueue, if any */
> >     if (vi->has_cvq) {
> >         callbacks[total_vqs - 1] = NULL;
> >         names[total_vqs - 1] = "control";
> >     }
> > 
> > I think the Author who write the code
> 
> wait, that was not you?

I believe 'the Author' refers to the author of the current code, not to
the author of the patch.

@Junbo: the control queue is created only if the VIRTIO_NET_F_CTRL_VQ
feature is set, please check that in your setup.

Thanks

Paolo


