Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2940D5EC4EE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiI0NuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 09:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbiI0NuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 09:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F9B7C18C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664286602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ofqCX7PnDwCH2641aVSgoebhxmiEcI1UVFpct2yGqJc=;
        b=FUScNsCe9RYvC2upw1TztbdMv32aTlZ460oqUyxWyfIob7obB21bVf5XR/7p0TgqJyZeFA
        OpQ4QDb/fN5v8HrtWKnh1ozJ0rrZSRdFGYyBzBoaAVyetnNt4c35oKxjMr8e0vrVf4CVAr
        8Wlehl+mLfQCJA0XdW+tzSAo3hEftjw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-gXrFV-KVOXuWOAd2k3oDDw-1; Tue, 27 Sep 2022 09:50:01 -0400
X-MC-Unique: gXrFV-KVOXuWOAd2k3oDDw-1
Received: by mail-qt1-f197.google.com with SMTP id ay22-20020a05622a229600b0035bbb349e79so6829389qtb.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 06:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=ofqCX7PnDwCH2641aVSgoebhxmiEcI1UVFpct2yGqJc=;
        b=P1XNEFeVcBvaG3khNW0yWg2KDTMIgXbkYETGSfEy0q99BlaCnxzw9p89WfFlN0nX77
         3kER6zC+Cfvkqp2pwIWEHff/fC62dJxqKuHIL18bbSbKaYXqLcXoXrdIdq2mFjkx8wB3
         rgnyWUpRt45inEXJCIYImUm/pASIfeFf0+57gihSUumgm/h4Q/h9yKNZivRuwygc7rdg
         e1tw7QEZQwcImKvAGPLwJLdUiIXTqs/PreA2AntPoAnZdh0BeB1KnNsatj17lCdlpiKd
         EPdx7rUeRdhAQ5D+fbL7/UjqzDKeG5CB5gNdXtawE21adcZHgQ4l+Mn9yLDXwDr8pVcT
         LrIg==
X-Gm-Message-State: ACrzQf0pLZ3A2XCTjTA2Ts6N3gIeBLF3qn7BEBNZnfq9v6lPmvgPkYT/
        Slw8FFlnCxN5ss5k1PfRP8w9yDu+j4LXx/pPcv6fRf8N/7o6Ak5v4smrWAJkHm4NYiaNwO4W0My
        hZmesQI2/CEO+X28U9PMCImBM
X-Received: by 2002:ac8:7dc7:0:b0:35c:c050:16aa with SMTP id c7-20020ac87dc7000000b0035cc05016aamr22041917qte.455.1664286600562;
        Tue, 27 Sep 2022 06:50:00 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7c0Ohy85DoU6iQp5X+btljELCKn/uXSAjNiHTKbhnRxjc5Y3nT0n3WTDb8R9S/7JggYSEMwg==
X-Received: by 2002:ac8:7dc7:0:b0:35c:c050:16aa with SMTP id c7-20020ac87dc7000000b0035cc05016aamr22041898qte.455.1664286600331;
        Tue, 27 Sep 2022 06:50:00 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-104-40.dyn.eolo.it. [146.241.104.40])
        by smtp.gmail.com with ESMTPSA id s16-20020a05620a255000b006b98315c6fbsm1038185qko.1.2022.09.27.06.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:49:59 -0700 (PDT)
Message-ID: <7fef56880d40b9d83cc99317df9060c4e7cdf919.camel@redhat.com>
Subject: Re: [PATCH net-next 0/4] shrink struct ubuf_info
From:   Paolo Abeni <pabeni@redhat.com>
To:     Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, Wei Liu <wei.liu@kernel.org>,
        Paul Durrant <paul@xen.org>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Date:   Tue, 27 Sep 2022 15:49:55 +0200
In-Reply-To: <cover.1663892211.git.asml.silence@gmail.com>
References: <cover.1663892211.git.asml.silence@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 2022-09-23 at 17:39 +0100, Pavel Begunkov wrote:
> struct ubuf_info is large but not all fields are needed for all
> cases. We have limited space in io_uring for it and large ubuf_info
> prevents some struct embedding, even though we use only a subset
> of the fields. It's also not very clean trying to use this typeless
> extra space.
> 
> Shrink struct ubuf_info to only necessary fields used in generic paths,
> namely ->callback, ->refcnt and ->flags, which take only 16 bytes. And
> make MSG_ZEROCOPY and some other users to embed it into a larger struct
> ubuf_info_msgzc mimicking the former ubuf_info.
> 
> Note, xen/vhost may also have some cleaning on top by creating
> new structs containing ubuf_info but with proper types.

That sounds a bit scaring to me. If I read correctly, every uarg user
should check 'uarg->callback == msg_zerocopy_callback' before accessing
any 'extend' fields. AFAICS the current code sometimes don't do the
explicit test because the condition is somewhat implied, which in turn
is quite hard to track. 

clearing uarg->zerocopy for the 'wrong' uarg was armless and undetected
before this series, and after will trigger an oops..

There is some noise due to uarg -> uarg_zc renaming which make the
series harder to review. Have you considered instead keeping the old
name and introducing a smaller 'struct ubuf_info_common'? the overall
code should be mostly the same, but it will avoid the above mentioned
noise.

Thanks!

Paolo

