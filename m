Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33EE6B9066
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCNKn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjCNKn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:43:56 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF05EF947
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:43:19 -0700 (PDT)
X-KPN-MessageId: f4436f54-c254-11ed-be37-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id f4436f54-c254-11ed-be37-00505699b430;
        Tue, 14 Mar 2023 11:42:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=MblS3wPiejH8wWKzPlRNHbipiWFCA8kFaj7hsvg8aIw=;
        b=IC1Bek6tsLB+ZBUNcDl3p2uU4adHKFJTNwb/AKrs331rzK40Mv+EgCYHoIV0e1MNHxxRNVpKdOH1u
         4fu5XN5lv+mLFusQyNzts9Ul1OSCejTm+DL3yNa3jm+QZHPySDS1h5Ck/lEINQUxl6QFNeLl71zcgk
         bi7ykaaHDON3BrkiYGV2eFa+GZaMJMBHiIS3We+44p9xpkzwLCy/0NIxxx2phxbKzkK3XuWzE060H9
         3M6iGSBP5aEEt2s6WULeFnfSNdDcmXrfTJjDdP8sh16nPPoLkukaSgxJaL3zkdlDCxUso3P540aHLa
         bvLdn0oCfNbUDnoIV4Ti0A8uR+4N5fg==
X-KPN-MID: 33|FkStRVpM6778JWRbee5ORbKlr5uso33caDVGRFqX+YdM2ajMXig/EgK1pUqjMB2
 ZvpFy22o4lZ02rXeesS5Bkw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|b6x6ba6BbG6VwHaXfZoELLAJBsMWVu0BpjvVbFinw6bBbG9MWR/C5kVxOti2FHv
 KdyqhcYeHZREjXLMFQDHNlQ==
X-Originating-IP: 173.38.220.44
Received: from [10.47.77.214] (unknown [173.38.220.44])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id f52d4607-c254-11ed-a8eb-005056998788;
        Tue, 14 Mar 2023 11:42:49 +0100 (CET)
Message-ID: <cbf34cf1-e065-8136-8344-89ca1864f637@xs4all.nl>
Date:   Tue, 14 Mar 2023 11:42:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 2/4] media: videobuf2: Replace bufs array by a list
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        'Laurent Pinchart' <laurent.pinchart@ideasonboard.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     "tfiga@chromium.org" <tfiga@chromium.org>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "ming.qian@nxp.com" <ming.qian@nxp.com>,
        "shijie.qin@nxp.com" <shijie.qin@nxp.com>,
        "eagle.zhou@nxp.com" <eagle.zhou@nxp.com>,
        "bin.liu@mediatek.com" <bin.liu@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "tiffany.lin@mediatek.com" <tiffany.lin@mediatek.com>,
        "andrew-ct.chen@mediatek.com" <andrew-ct.chen@mediatek.com>,
        "yunfei.dong@mediatek.com" <yunfei.dong@mediatek.com>,
        "stanimir.k.varbanov@gmail.com" <stanimir.k.varbanov@gmail.com>,
        "quic_vgarodia@quicinc.com" <quic_vgarodia@quicinc.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>,
        "ezequiel@vanguardiasur.com.ar" <ezequiel@vanguardiasur.com.ar>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "daniel.almeida@collabora.com" <daniel.almeida@collabora.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "kernel@collabora.com" <kernel@collabora.com>
References: <20230313135916.862852-1-benjamin.gaignard@collabora.com>
 <20230313135916.862852-3-benjamin.gaignard@collabora.com>
 <20230313181155.GC22646@pendragon.ideasonboard.com>
 <86df05244d974416903e919d387a0a0b@AcuMS.aculab.com>
 <e704b505-86d8-c6f2-8546-adccdab72622@xs4all.nl>
 <dc04d48e34ed40e58f43badd001a81d0@AcuMS.aculab.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <dc04d48e34ed40e58f43badd001a81d0@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 3/14/23 11:11, David Laight wrote:
> From: Hans Verkuil
>> Sent: 14 March 2023 08:55
> ...
>> Why not start with a dynamically allocated array of 32 vb2_buffer pointers?
>> And keep doubling the size (reallocing) whenever more buffers are needed,
>> up to some maximum (1024 would be a good initial value for that, I think).
>> This max could be even a module option.
> 
> I don't know the typical uses (or the code at all).
> But it might be worth having a small array in the structure itself.
> Useful if there are typically always (say) less than 8 buffers.
> For larger sizes use the (IIRC) kmalloc_size() to find the actual
> size of the structure that will be allocate and set the array
> size appropriately.

The typical usage is that applications allocate N buffers with the
VIDIOC_REQBUFS ioctl, and in most cases that's all they use. The
current max is 32 buffers, so allocating that initially (usually
during probe()) will cover all current cases with a single one-time
kzalloc.

Only if the application wants to allocate more than 32 buffers will
there be a slight overhead.

Regards,

	Hans

> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)

