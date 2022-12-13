Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B6164B380
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235211AbiLMKrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:47:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235244AbiLMKqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:46:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA83A1B9F5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670928348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ng1wd9XMGqm8kfTwHIk/MN0YdretQ2zd7KrLEZThTl8=;
        b=TD1gazDlq1yl0A4XBIKZ2x3Pmp6ZXR9CpvKnPMFTN4nGr7YMnhYt+2veFkGIh5wmlcDIjT
        WPBUOeZ6g/h2C8yYOja8OVcCP4KRQnNdbUa3FHKrWByH7I1TTSvP/W5lZvzdvsWGr1A/Mg
        +cmzCOenZzXuxoXIM9VNZXUeq7DV73g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-599-gOdcezJ2Oia4xbnFLbqUlA-1; Tue, 13 Dec 2022 05:45:46 -0500
X-MC-Unique: gOdcezJ2Oia4xbnFLbqUlA-1
Received: by mail-wr1-f70.google.com with SMTP id w11-20020adfbacb000000b002418a90da01so2811190wrg.16
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 02:45:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ng1wd9XMGqm8kfTwHIk/MN0YdretQ2zd7KrLEZThTl8=;
        b=qh8hGiGCBGevlIk44m6AdX2qOYtMNnlUeZ0qFAO9fyJANes7m35NtTyHAU5lKdCAkW
         yA0/sIhRruRVq6BR9Bv2EL5cPZ8uJw0tjO6OfC7WcZceon+qUdQS742Y0b5xT9sZvVQ2
         ET0OOGwaymWHKPfBkeuheGoXC8lvZmg58uLbWCILpNVn+CdOkm3H3CsXOZxoo36hHAzc
         xA1GeR9TGNXphPQ9ucN9y6iUGa5kewIlOcvei/aZA32SazLi/CO7GEyv2RK4U+OCyEHQ
         VQB769fUIrxcXXUM1gIcABpQAlzX9JMDV85jbXz9Z9SGQI/XT+aJr25lEqF0a7WZnI1I
         0zzg==
X-Gm-Message-State: ANoB5pkAj5UEtxZCpv/+T4F2Q7UeA/k5/OeMmxp8nI9rgonNttxwewo/
        fLFmIUQC8rdfhEf9VFM/uigjggM2tJmWaJbap0mT2oqb/+eeOws+oiTxb8/2MD8XOzGGVPaGC42
        iHVVQ0+HTcvsNpQiKIyOMd6r/
X-Received: by 2002:a5d:4747:0:b0:242:1f8d:999 with SMTP id o7-20020a5d4747000000b002421f8d0999mr12652330wrs.14.1670928345340;
        Tue, 13 Dec 2022 02:45:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4ztoklTJqIwHxoPbA5x2OKUpO2qh4VDozvm8AXd41GT3ej8DL4wCxvlY2h7af0pfy4ekABUA==
X-Received: by 2002:a5d:4747:0:b0:242:1f8d:999 with SMTP id o7-20020a5d4747000000b002421f8d0999mr12652317wrs.14.1670928345137;
        Tue, 13 Dec 2022 02:45:45 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it. [87.11.6.51])
        by smtp.gmail.com with ESMTPSA id i8-20020adfefc8000000b0022cdeba3f83sm11389245wrp.84.2022.12.13.02.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 02:45:44 -0800 (PST)
Date:   Tue, 13 Dec 2022 11:45:42 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Jakub Kicinski <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        Krasnov Arseniy <oxffffaa@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        kernel <kernel@sberdevices.ru>
Subject: Re: [RFC PATCH v4 2/4] test/vsock: rework message bounds test
Message-ID: <20221213104542.o2fzurh3fsrkgod4@sgarzare-redhat>
References: <6be11122-7cf2-641f-abd8-6e379ee1b88f@sberdevices.ru>
 <44a15b4f-5769-7ed8-f4d1-04abbca6f379@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <44a15b4f-5769-7ed8-f4d1-04abbca6f379@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 08:50:55PM +0000, Arseniy Krasnov wrote:
>This updates message bound test making it more complex. Instead of
>sending 1 bytes messages with one MSG_EOR bit, it sends messages of
>random length(one half of messages are smaller than page size, second
>half are bigger) with random number of MSG_EOR bits set. Receiver
>also don't know total number of messages.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/control.c    |  28 +++++++
> tools/testing/vsock/control.h    |   2 +
> tools/testing/vsock/util.c       |  13 ++++
> tools/testing/vsock/util.h       |   1 +
> tools/testing/vsock/vsock_test.c | 128 +++++++++++++++++++++++++++----
> 5 files changed, 157 insertions(+), 15 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

