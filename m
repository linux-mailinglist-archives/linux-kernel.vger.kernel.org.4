Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D7F61EE7E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiKGJPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiKGJPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:15:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7410AE75
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 01:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667812478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ODD1ZGgE/joRUxe72IIKk0W+RdNnjnLWhwebrM3eS0I=;
        b=RJm8VOhtUKI0mTyt0MOjhXw0mtDHJ4Nx5achv2F3AbSPk7CIU3zJU7u3F3As4a+BaLUTEH
        hlw4dDEp/bAIKzawWvaH/A4bCuH/LTzkIFz0NLXf4v2BbIL5NQrMVRkOfsT7K4J8J8lb7O
        gw23Y3+VHbyi538wLhhM6y01uNT/J84=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-286-vROwOZMYO2ymOPyZDk84Gw-1; Mon, 07 Nov 2022 04:14:34 -0500
X-MC-Unique: vROwOZMYO2ymOPyZDk84Gw-1
Received: by mail-qk1-f199.google.com with SMTP id n13-20020a05620a294d00b006cf933c40feso9769132qkp.20
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 01:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODD1ZGgE/joRUxe72IIKk0W+RdNnjnLWhwebrM3eS0I=;
        b=DE93t901qwIP9RtRHRbEZC3tbXCD/Rk2ohQ0sdwCE6nQnM3dqgqOZIoBNVSiQZcWJB
         TnHrlqouZuJR90wbyxJLf0taAU1/kIs0PQz6+jHpWEuDsXb+qCymT7VvGWpKCS2LjkBh
         1MnAhyr5VVmZTa6x84Oas36jlc0Gm2VDQS7/N7K6nqkEKxAKb3rxLPDTw8iaYm4J3tIA
         mbrVv7mMYN8SJXiRDyLxuhzg72yjzRwIe7kk79rWaSz1DILc4E44Kc2Gd5kcZtJQeiPc
         G/bhTj4QOvW6PcKe+YGTDnY1LULByZazKTQJn2CJbsX8gcp8FfUAYJcXKA9dL8lPZEgc
         kFrw==
X-Gm-Message-State: ANoB5pnXlAvG9DWzOn0viiKm6BOv5e5rNhnn3yO2zMgKJdza7yYvgew2
        V2w+BfIk/+ba1GB/gCU1/fN2iIAMoN+KEmqtCoPcZOMyqE1KXzKjIlI74lKs0605bAQ31QZNcYA
        P0sL6mdl0oAM+GoxDqgGYfW2E
X-Received: by 2002:ac8:4053:0:b0:3a5:89c9:3f3a with SMTP id j19-20020ac84053000000b003a589c93f3amr3366230qtl.277.1667812473903;
        Mon, 07 Nov 2022 01:14:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5ljjdNUz/NfeWybL5wh31/NNHiuP8MnAjjMocAGhKGlSLI6x8BHYMSXB/uLf5d4ihl8gtWYA==
X-Received: by 2002:ac8:4053:0:b0:3a5:89c9:3f3a with SMTP id j19-20020ac84053000000b003a589c93f3amr3366216qtl.277.1667812473639;
        Mon, 07 Nov 2022 01:14:33 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id bp30-20020a05622a1b9e00b003a50248b89esm5765634qtb.26.2022.11.07.01.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 01:14:33 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:14:24 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     ruanjinjie <ruanjinjie@huawei.com>, mst@redhat.com,
        eperezma@redhat.com, gautam.dawar@xilinx.com, elic@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa_sim: fix possible memory leak in vdpasim_net_init()
 and vdpasim_blk_init()
Message-ID: <20221107091424.dqlus2qdcsr2bmq3@sgarzare-redhat>
References: <20221104083423.2090463-1-ruanjinjie@huawei.com>
 <CACGkMEuxfB+9m1WW34L3sF6_F1iKCF9CSs9_P2V9jLh4sFXyAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACGkMEuxfB+9m1WW34L3sF6_F1iKCF9CSs9_P2V9jLh4sFXyAA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:41:42PM +0800, Jason Wang wrote:
>On Fri, Nov 4, 2022 at 4:41 PM ruanjinjie <ruanjinjie@huawei.com> wrote:
>>
>> If device_register() returns error in vdpasim_net_init() or
>> vdpasim_blk_init(), name of kobject which is allocated in dev_set_name()
>> called in device_add() is leaked.
>>
>> As comment of device_add() says, it should call put_device() to drop
>> the reference count that was set in device_initialize() when it fails,
>> so the name can be freed in kobject_cleanup().
>>
>> Signed-off-by: ruanjinjie <ruanjinjie@huawei.com>
>
>Acked-by: Jason Wang <jasowang@redhat.com>
>
>Should we have a fixes tag and cc stable?

Yep, I think so.

The fixes tags should be:

Fixes: 899c4d187f6a ("vdpa_sim_blk: add support for vdpa management tool")
Fixes: a3c06ae158dd ("vdpa_sim_net: Add support for user supported devices")

With them:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

