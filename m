Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41445622533
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbiKIITc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:19:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiKIIT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:19:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCBC11A10
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667981914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dgGprYoeTN22cTQDR5YOz3sASLNpnLaaRp5I0puxy0k=;
        b=AVb96HoqsFxhJwmho87cl+Da/mWdRY3ElfBZelcdDeXuwQYkiALZsWe7lVYHB0PkbQR/g/
        9YRZg1HEBCVtUKruYIT/AL7CxTlbOzt7+YyyNYUHYMqDFNnkDWWEuQsSZmPnndkJuwp3aL
        oclobTSHpCtr6ZO1fMM26i5h8tR7uEM=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-653-xFkTsfolNJGMXmJd5uiOHw-1; Wed, 09 Nov 2022 03:18:32 -0500
X-MC-Unique: xFkTsfolNJGMXmJd5uiOHw-1
Received: by mail-qk1-f200.google.com with SMTP id n13-20020a05620a294d00b006cf933c40feso15295258qkp.20
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgGprYoeTN22cTQDR5YOz3sASLNpnLaaRp5I0puxy0k=;
        b=iiys62u7wJTvbanvGwFXY6yOBAGvY3VcmSVOIJFJzeRqDOxQBmEm5tZNbj5RfO7u6P
         B18vxZh0symUgHnq3KkowRj/27gBdNUvtjW3RUmkgD7Tkpe2yV5PODZcs7X3otP3+W9T
         U817CQv4aLBI2K++zcwlrIXTkeuXPNai6lLs+suvvPiB1noXyVdVKXFKFRhJfNtxuHDS
         z8JdYjNhPUdrRtVwbTPO4gJtiJjoOVSX0MywiScb+yoZhyv6EnEzJT0cr5QVdSE841eO
         HwyfUgE3z646eckzUfPzwA8/Znv8d8WgMTJv4trhR2eIGBtIuA/LqxlDMloXgN0rAaC4
         l9eQ==
X-Gm-Message-State: ACrzQf33voIEE3QvNBbXTnl9oN+vUE8CKgfV3lIfQM6nSVqnns4w0vTu
        TquiWUQxLsh+btD/yXD1AM5cgpiOoxYGkVv/v0jALTQvrYbA67udPfDcGrdZ7Z1M01wZsftc/yi
        WclVDD4ELaMj+nL39HKmjT8I7
X-Received: by 2002:a0c:de07:0:b0:4bc:187a:7085 with SMTP id t7-20020a0cde07000000b004bc187a7085mr38386060qvk.13.1667981912274;
        Wed, 09 Nov 2022 00:18:32 -0800 (PST)
X-Google-Smtp-Source: AMsMyM5nr5OeV6fr2CjoyWBfrNdvGZsceXntb36rsvEakUXbxiiIfozncmPJPob44jTHHjm5hBECkg==
X-Received: by 2002:a0c:de07:0:b0:4bc:187a:7085 with SMTP id t7-20020a0cde07000000b004bc187a7085mr38386045qvk.13.1667981912018;
        Wed, 09 Nov 2022 00:18:32 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id bi14-20020a05620a318e00b006b929a56a2bsm10711570qkb.3.2022.11.09.00.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 00:18:31 -0800 (PST)
Date:   Wed, 9 Nov 2022 09:18:23 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] vhost: fix range used in translate_desc()
Message-ID: <20221109081823.tg5roitl26opqe6k@sgarzare-redhat>
References: <20221108103437.105327-1-sgarzare@redhat.com>
 <20221108103437.105327-3-sgarzare@redhat.com>
 <CACGkMEuRnqxESo=V2COnfUjP5jGLTXzNRt3=Tp2x-9jsS-RNGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACGkMEuRnqxESo=V2COnfUjP5jGLTXzNRt3=Tp2x-9jsS-RNGQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 11:28:41AM +0800, Jason Wang wrote:
>On Tue, Nov 8, 2022 at 6:34 PM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> vhost_iotlb_itree_first() requires `start` and `last` parameters
>> to search for a mapping that overlaps the range.
>>
>> In translate_desc() we cyclically call vhost_iotlb_itree_first(),
>> incrementing `addr` by the amount already translated, so rightly
>> we move the `start` parameter passed to vhost_iotlb_itree_first(),
>> but we should hold the `last` parameter constant.
>>
>> Let's fix it by saving the `last` parameter value before incrementing
>> `addr` in the loop.
>>
>> Fixes: 0bbe30668d89 ("vhost: factor out IOTLB")
>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> ---
>>
>> I'm not sure about the fixes tag. On the one I used this patch should
>> apply cleanly, but looking at the latest stable (4.9), maybe we should
>> use
>>
>> Fixes: a9709d6874d5 ("vhost: convert pre sorted vhost memory array to interval tree")
>
>I think this should be the right commit to fix.

Yeah, @Michael should I send a v2 with that tag?

>
>Other than this
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>

Thanks for the review,
Stefano

