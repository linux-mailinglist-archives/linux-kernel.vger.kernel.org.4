Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2076131CA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 09:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiJaIiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 04:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiJaIiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 04:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750FF6570
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667205432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=g7Dq1aOGhSqbnLXSSpuWXNREMYffR0XtNShs/CkTqkk=;
        b=J4pmhOukayObkTFWH79f5A0DPfP3fNVhc2pPxcWPjKhf3CpJtB7/Q26Mo/jNppaN+mICTl
        AAYPcAdA7npgkIlWkgbjapkChKoZMAu7286m4aVw74BIcc+7jxCgNLErF5CM3+1K+UQE6+
        4MpMQH9h0bOgCkkXaob1VNAnQTm+2aw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-447-eUUTRrJHPdi85CyuV-kXNA-1; Mon, 31 Oct 2022 04:37:07 -0400
X-MC-Unique: eUUTRrJHPdi85CyuV-kXNA-1
Received: by mail-ed1-f69.google.com with SMTP id r12-20020a05640251cc00b00463699c95aeso954710edd.18
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 01:37:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g7Dq1aOGhSqbnLXSSpuWXNREMYffR0XtNShs/CkTqkk=;
        b=Cd8h71QLNaUiTWAerVPVk5Tj11jK2z/plR40CMP+/Ky7wl0Vs2Ide5pYTaM74P4rEL
         RZJE0KH4Ow8Pnlt7WcknakcJp48FoK+F12WL+B3KmDg689rmEdupraD8dXWu7YHnD6tt
         1fODmv7I55bIb9GgEatwzGdJAceXKImvQCDz3JuLo65W1QUlubeIV4yORXPI/ac2FSSx
         9FDjBqv423prHs3Cb2tpSlQNYfTirt93lhzntcwncySlKovyA/XVQv0zOlD/em3JL985
         3X4Yiuf993mYY9T4NmXBfhj7ZqhN8Fs/lt5D5uPHPgQWjPr1aL6RRlmeyYBw36afg38p
         3Cmg==
X-Gm-Message-State: ACrzQf01ZRK2/r6KASreegONpSaulsuGitZM75AA52qvq4DGwBvfVCDC
        FJ7lQQyCYzVDEqDq1vmOV3aeLNjG3uOF5qH2XoDefvGQLylQ5aDLI4G26YDOg3DjIAEQfQPNdaI
        zw9iJcX8CQRVCHQjgrJYe1meZ
X-Received: by 2002:a17:906:4795:b0:794:8b93:2e33 with SMTP id cw21-20020a170906479500b007948b932e33mr11943137ejc.265.1667205426653;
        Mon, 31 Oct 2022 01:37:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5uNSsXtfuDCxQDPjmlh78PdWRxENqpMT+1GcFwXzsCqnYJKcM79AP3wlMyFUJpg0Tdpzq1ow==
X-Received: by 2002:a17:906:4795:b0:794:8b93:2e33 with SMTP id cw21-20020a170906479500b007948b932e33mr11943114ejc.265.1667205426401;
        Mon, 31 Oct 2022 01:37:06 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it. [82.53.134.234])
        by smtp.gmail.com with ESMTPSA id m24-20020aa7c2d8000000b0044dbecdcd29sm2909250edp.12.2022.10.31.01.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 01:37:06 -0700 (PDT)
Date:   Mon, 31 Oct 2022 09:37:04 +0100
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, arseny.krasnov@kaspersky.com,
        netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, stephen@networkplumber.org,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/2] vsock: remove the unused 'wait' in
 vsock_connectible_recvmsg()
Message-ID: <20221031083704.yqzz4qcrzbcqxbrw@sgarzare-redhat>
References: <20221028205646.28084-1-decui@microsoft.com>
 <20221028205646.28084-2-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221028205646.28084-2-decui@microsoft.com>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 01:56:45PM -0700, Dexuan Cui wrote:
>Remove the unused variable introduced by 19c1b90e1979.
>
>Fixes: 19c1b90e1979 ("af_vsock: separate receive data loop")
>Signed-off-by: Dexuan Cui <decui@microsoft.com>
>---
> net/vmw_vsock/af_vsock.c | 2 --
> 1 file changed, 2 deletions(-)

Good catch!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index ee418701cdee..d258fd43092e 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2092,8 +2092,6 @@ vsock_connectible_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
> 	const struct vsock_transport *transport;
> 	int err;
>
>-	DEFINE_WAIT(wait);
>-
> 	sk = sock->sk;
> 	vsk = vsock_sk(sk);
> 	err = 0;
>-- 
>2.25.1
>

