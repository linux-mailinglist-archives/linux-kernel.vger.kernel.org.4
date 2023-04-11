Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEA76DD92B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjDKLPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjDKLP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:15:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3694691
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681211623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pWOLv0WX3GwUsspxOTFb+6/lyFHPxiFz6fR9eO1Jkbs=;
        b=ddu7oKb3He42G/WADpgzrXIb4dGhfqhcW2EB565szstU0icxtSMdfonLEcbVFQhA2xuwKP
        CELpO9o3J9WLSph+cHjhLHlUirR3kUbU/ILZyuxPziVvzZZk1MLFo3sa7cQn/MQQee8MEc
        9rfkltRIO6+DzFqb3k5XeT3D3M0P104=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-KBpX7e_-PBuKZKUeug5mwg-1; Tue, 11 Apr 2023 07:13:42 -0400
X-MC-Unique: KBpX7e_-PBuKZKUeug5mwg-1
Received: by mail-wm1-f69.google.com with SMTP id u12-20020a05600c19cc00b003f07be0e96bso2545077wmq.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:13:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681211621;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pWOLv0WX3GwUsspxOTFb+6/lyFHPxiFz6fR9eO1Jkbs=;
        b=XPbrxYJqf2WQHA2wSvGMz6mtMVXdiJIL9hytBXxkOYuYBSpAe9hNLCOOfUll249ikj
         4mFfRFB62T633KPOLjmqwfqIDIyYvoCM+PU4WVPg8o084cP9+ECJ8mSE/YGfaqmEx4iO
         3/oIGyPwKgKBCAGQXTnsvEbqFJs82Qt36rGtAln/Hqfj9XSx6Rq+WcxDj/tEl3J4iLx2
         yXfE8D6Ki6Y/q6+bZvkYYQl9YusGiYiGb19HZ0KBQN5U8Fw/4pjj5FCpsHPk/ntywvVD
         FpzqSOW5aPRYj5UDXzYtQYeVG5ZAcvmH/FtK9iypHXzsvT+AzQJhJyKcc37953hW23cO
         YmgA==
X-Gm-Message-State: AAQBX9cp5QqSsMwjxDw9yzM16F+Ko5cnzEWc8pN7BMBy05OF1SgIh6qY
        FP+QYV167e6eYUYRzzkvhFzOLHTqeJsUOppWPhCEaKxtLr1URt6CfXSCQ6ICnuX/MuS15i7u+O5
        GfPx89SBU8W/+VW9XJ6RgWO/b
X-Received: by 2002:a7b:c051:0:b0:3ee:da1:1346 with SMTP id u17-20020a7bc051000000b003ee0da11346mr9265252wmc.36.1681211620925;
        Tue, 11 Apr 2023 04:13:40 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yl98KmSsmJ4WWU8bJsbrQ2am/B1DfCxkytMG8LAIGPKJIu6SLn2Tg7roihlUl5VNYTY9Oe4Q==
X-Received: by 2002:a7b:c051:0:b0:3ee:da1:1346 with SMTP id u17-20020a7bc051000000b003ee0da11346mr9265241wmc.36.1681211620587;
        Tue, 11 Apr 2023 04:13:40 -0700 (PDT)
Received: from redhat.com ([2.52.10.80])
        by smtp.gmail.com with ESMTPSA id q31-20020a05600c331f00b003ee610d1ce9sm20383391wmp.34.2023.04.11.04.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 04:13:39 -0700 (PDT)
Date:   Tue, 11 Apr 2023 07:13:37 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] virtio_pci: Wait for legacy device to be reset
Message-ID: <20230411071111-mutt-send-email-mst@kernel.org>
References: <CACGkMEscqtaTpCed_f2cfknO4--mXCyp33u1CmZwNEZxyf=ifQ@mail.gmail.com>
 <TY2PR06MB3424BACFA8B6CB463C12E31E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411024459-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424E3C222C3B896BB583DFD859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411025335-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424DB10784CA5504A10099E859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411032014-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424DE523E669A3B1910D7F0859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
 <20230411061409-mutt-send-email-mst@kernel.org>
 <TY2PR06MB3424185F07F76D82746B6503859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TY2PR06MB3424185F07F76D82746B6503859A9@TY2PR06MB3424.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 10:57:51AM +0000, Angus Chen wrote:
> > > > Yes, not very clear still. What are the device and vendor ID of the
> > > > card? Does it have the virtio capabilities?
> > > > Thanks
> > > It's have the virtio capabilities.
> > > When it is used in bare metal ，
> > >    it just use PCI_VENDOR_ID_REDHAT_QUMRANET.
> > > When it use in vm,
> > >  It is just like :
> > > { PCI_DEVICE_SUB(PCI_VENDOR_ID_REDHAT_QUMRANET,
> > >              VIRTIO_TRANS_ID_NET,
> > >              PCI_VENDOR_ID_JAGUARMICRO,
> > >              VIRTIO_ID_NET) },
> > >     { PCI_DEVICE_SUB(PCI_VENDOR_ID_REDHAT_QUMRANET,
> > >              VIRTIO_TRANS_ID_BLOCK,
> > >              PCI_VENDOR_ID_JAGUARMICRO,
> > >              VIRTIO_ID_BLOCK) },
> > >
> > 
> > Okay. So it's a transitional device. The question, then,
> > is how come you end up with drivers/virtio/virtio_pci_legacy.c
> > with a modern linux at all?
> > Did you by chance set force_legacy = true ?
> Yes,I can provide more information about it.
> We can test it use force_legacy ,or we use a server with multi os but it use only one card.
> Thanks.

Okay, so I don't yet see lots of value of merging this patch upstream.
The problematic code does not run by default as the modern driver is
used, and applying the patch upstream does nothing to fix the multi-os
case.

What did I miss?


-- 
MST

