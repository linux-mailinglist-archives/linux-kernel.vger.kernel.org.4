Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD8E67DEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjA0IUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjA0IUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:20:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562D238648
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674807574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MXfiZZetQqbi14d70Q9u+6V0Ixs67udoBCY1/+PVet8=;
        b=AUzwUmn2lRsZa1VDFq76iqM6PyRCe7TxQ9VYZhprOFriswFiQRFMy6F1Aetc8SAMRbH89b
        B+LoLdPR/lLPwpg62WR6fwd9tGxo1R6Yy2huUXHUydcqqeW40n2VeuNNO5qEN/PmKlKf43
        N1IFmnQSc0YLD7I6WnyPmQVbGNPbwgU=
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-159-UKgZ9ji8Ps2X19OaIZO2Bw-1; Fri, 27 Jan 2023 03:19:33 -0500
X-MC-Unique: UKgZ9ji8Ps2X19OaIZO2Bw-1
Received: by mail-vk1-f198.google.com with SMTP id t6-20020a1faa06000000b003e17e0a18b8so1668400vke.23
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:19:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXfiZZetQqbi14d70Q9u+6V0Ixs67udoBCY1/+PVet8=;
        b=cUb436B0BGhuRbKgUtug+DVO2RXeONTAI5MU/3GG0wLJPfc4YNbAB98BTEG73aNd2h
         xzrogD0bCWMUdZ4IAn+zs1JWWIMFPzQd0oa+VsIROWkcPaQ3N4SjID8NH3qCM0fB6w5z
         VBxIU5cKGxNhm6ev5lHTAZWpsZQ3TslgRhZUdCX9BIbBZO2sc1pMjXvGyIAnWuoFCx2F
         yFYUw1pl5qmKDOAO2ra99AaalLJpidx7p/ToAD8OtJUvsmDJpHtrf7RgeBJWWXIsQQhO
         x9ulcWW3hjTCPUTSgN3SvGT1HHUALAMF+89FDSUhNji1QQUuojalZ6p1szFGmTxOFTiX
         7rwA==
X-Gm-Message-State: AO0yUKXu1iHlYDEw4xeO3RFROOocto2uGbSaOEj3Oh1hAiBPTwGIBBkX
        azZB8Ojn0t2hy4PqD9inI1SYZWxYK2XA23DCG/LWLDjgPd1w2cfD1UiKNBGX/N84v4U7WRhbQcc
        x9y/w0/+OMi3ZM5bbQgoJbXSt
X-Received: by 2002:a1f:2ccd:0:b0:3b8:7586:c194 with SMTP id s196-20020a1f2ccd000000b003b87586c194mr2334881vks.3.1674807572501;
        Fri, 27 Jan 2023 00:19:32 -0800 (PST)
X-Google-Smtp-Source: AK7set8Wc4OoB+LOFJqQ4iS00UuEdhQhclYGMSUuPr4eiyJbnbW7Trc5XIZqA0yh/DrCh1g7rmzsOQ==
X-Received: by 2002:a1f:2ccd:0:b0:3b8:7586:c194 with SMTP id s196-20020a1f2ccd000000b003b87586c194mr2334872vks.3.1674807572100;
        Fri, 27 Jan 2023 00:19:32 -0800 (PST)
Received: from redhat.com ([37.19.199.113])
        by smtp.gmail.com with ESMTPSA id 4-20020a056122084400b003a31fd43853sm259702vkk.3.2023.01.27.00.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 00:19:31 -0800 (PST)
Date:   Fri, 27 Jan 2023 03:19:25 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andrey Smetanin <asmetanin@yandex-team.ru>
Cc:     Jason Wang <jasowang@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
Subject: Re: [PATCH] vhost_net: revert upend_idx only on retriable error
Message-ID: <20230127031904-mutt-send-email-mst@kernel.org>
References: <20221123102207.451527-1-asmetanin@yandex-team.ru>
 <CACGkMEs3gdcQ5_PkYmz2eV-kFodZnnPPhvyRCyLXBYYdfHtNjw@mail.gmail.com>
 <20221219023900-mutt-send-email-mst@kernel.org>
 <62621671437948@mail.yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62621671437948@mail.yandex-team.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 11:24:26AM +0300, Andrey Smetanin wrote:
> Sorry for the delay.
> I will send update on this week after some tests.
> 19.12.2022, 10:39, "Michael S. Tsirkin" <mst@redhat.com>:

Do you still plan to send something? Dropping this for now.

