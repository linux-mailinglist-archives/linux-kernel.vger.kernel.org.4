Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1EF6568E6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 10:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiL0JcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 04:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiL0JcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 04:32:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB4A266A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672133477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XjEgqHC0TjJVZZyBA3pSEYd/RXRUNHEpnJ2isGBT+vY=;
        b=guyTxLxYeQlrbJTfl8zBeGAMo2qtIE/3Irj70MUtR1RTPBAP9eVrzeuoLiRwVmmL71NqWs
        q+Pf5TqvnJuc7ms04lK6TsGbpOGDryuXTvRXIaSO/5D2QoCaXbFOHIV7u91jRH94Gz3SGU
        ig+FBpfowUJsZ1wW+3aKp23+uLdTojE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-631-f0beVVegOC-HoPxi3y6SXg-1; Tue, 27 Dec 2022 04:31:14 -0500
X-MC-Unique: f0beVVegOC-HoPxi3y6SXg-1
Received: by mail-wr1-f72.google.com with SMTP id c21-20020adfa315000000b002425bf67a87so1709455wrb.19
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 01:31:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XjEgqHC0TjJVZZyBA3pSEYd/RXRUNHEpnJ2isGBT+vY=;
        b=zHuNkb/1YerUTlkab3A1/5aY/iduiwvy/014jWx+5N3CMdcaMac0381X7ONAsVKMJe
         PfI17+sELT7t2kX+iPalMUKfVZg143s6jExaYqDXhI+eIdjvwVHCrmR2XG+OqjU+Algk
         U7zEzkjBksf54eNsoWcqgzwsuTQDVBtez2GONXMLrbnnsQWM+E026vpzTv8TJ3wj5xVx
         OQfV7knIjq8PHbjlP+uvkT9HTQrw/tM1c21b9yQxTR5XSD9etRId7ovT0kEvt91ONgac
         1EBKdez/aXZynG+iR/N95hejj55XkQqYGlkdWZar6eLEBR2HcJxRPKO0iiKMsixPDx2n
         mhxw==
X-Gm-Message-State: AFqh2krtCTILkB3p3j+7HB6nMvgQfeCVGUir5PMdYyX+iiw++3SY4kVD
        toPGvqhGgEczCC3Z3+Bk5Isqk2pj/T6yzgTK9FzqKbXTeeleJ6S4Hb8up8y+FbzkddaR+OKMwgp
        lraTjgNVZb8Qcqhg0zfNDZO+3
X-Received: by 2002:adf:e6d1:0:b0:27c:dcf5:ad52 with SMTP id y17-20020adfe6d1000000b0027cdcf5ad52mr4845011wrm.11.1672133473258;
        Tue, 27 Dec 2022 01:31:13 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtDqoROpQZXF0N0D/7AOnnSo+AghfYu/wxAstc5C3cls1UCZ3EJFRFCd83x4sF0qZzA1zj90A==
X-Received: by 2002:adf:e6d1:0:b0:27c:dcf5:ad52 with SMTP id y17-20020adfe6d1000000b0027cdcf5ad52mr4844997wrm.11.1672133473018;
        Tue, 27 Dec 2022 01:31:13 -0800 (PST)
Received: from redhat.com ([2.52.151.85])
        by smtp.gmail.com with ESMTPSA id h29-20020adfaa9d000000b002368f6b56desm15219971wrc.18.2022.12.27.01.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 01:31:12 -0800 (PST)
Date:   Tue, 27 Dec 2022 04:31:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, eperezma@redhat.com,
        edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
        pabeni@redhat.com, davem@davemloft.net
Subject: Re: [PATCH 4/4] virtio-net: sleep instead of busy waiting for cvq
 command
Message-ID: <20221227042855-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-5-jasowang@redhat.com>
 <1672107557.0142956-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvzhAFj5HCmP--9DKfCAq_4wPNwsmmg4h0Sbv6ra0+DrQ@mail.gmail.com>
 <20221227014641-mutt-send-email-mst@kernel.org>
 <1ddb2a26-cbc3-d561-6a0d-24adf206db17@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ddb2a26-cbc3-d561-6a0d-24adf206db17@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 05:17:20PM +0800, Jason Wang wrote:
> > > > In particular, we will also directly break the device.
> > > It's kind of hardening for malicious devices.
> > ATM no amount of hardening can prevent a malicious hypervisor from
> > blocking the guest. Recovering when a hardware device is broken would be
> > nice but I think if we do bother then we should try harder to recover,
> > such as by driving device reset.
> 
> 
> Probably, but as discussed in another thread, it needs co-operation in the
> upper layer (networking core).

To track all state? Yea, maybe. For sure it's doable just in virtio,
but if you can find 1-2 other drivers that do this internally
then factoring this out to net core will likely be accepted.

-- 
MST

