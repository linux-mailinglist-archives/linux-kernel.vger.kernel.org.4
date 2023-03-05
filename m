Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E734D6AB111
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 15:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjCEOie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 09:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjCEOid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 09:38:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C52E394
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 06:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678027065;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2xiLXG4WSmkTpMmwIQe04rs5eHpEcwgO7icH5sCUMyM=;
        b=QALNdyTzwrKF4YGm4Ewgdkg1cwD5j19cGJM/NVJS/K+dMW6Qm3SHq5+K43DTnITqdivJz6
        ehGif0z/g08TCmoeJ0gFdIKEvylN+Zl0L5M9aqvYab1FEdSEIRcbPq+YiAneF6ryyjMkXn
        jNGZIukPeMEXmTV+WMbGmPpT4bE5BEE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-KZmuySNEOwez8hgFBZW3vw-1; Sun, 05 Mar 2023 09:37:43 -0500
X-MC-Unique: KZmuySNEOwez8hgFBZW3vw-1
Received: by mail-qt1-f199.google.com with SMTP id z1-20020ac87ca1000000b003ba2a2c50f9so3911631qtv.23
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 06:37:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678027062;
        h=content-language:content-transfer-encoding:mime-version:user-agent
         :date:message-id:subject:from:cc:to:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xiLXG4WSmkTpMmwIQe04rs5eHpEcwgO7icH5sCUMyM=;
        b=XUAFZIIxTGljxHgTldIQgCnE/YAMw6KbqGUJKNRalUYnorrN42X1ETAym62TRjkqwB
         ID8byaVhtOit8pVWWkVC/aNAoJLWG+gp7oF78OfsCCA4B42B8Z28QOKvfljS60NN7jy0
         ZIgCJAIvziFW6MqdQWL8beuBn88RkuEgZUMc35OjgF/GS8ZSbNtIB/OzH0cpzswweSU8
         tzqGlHA4DOOokmK3IU2HQvtSa8IVv6XnYJjHBOTWiXfSMeUTzd8RrT5ODOuHksWkW0yc
         qF8nSraEZcCZsMItBy1oJPshc6CzENHHccgp9r6moT5xiOvOe6ncSKrxbPQhhcm4KA0h
         Yrmg==
X-Gm-Message-State: AO0yUKUNagtsu2VsWBv2DHpXvVc0tDgrSfDXYxa4xf6nwrQAMfxBanRw
        G8mqS4W/DUJuY3S1oJKgoJY250wiAoJh1+4f/3qSj+KJ3hlnDxmTDhg62P8NpFivgtXSjjDQDLt
        s4e8JK223HFv9mWgHZ78gAqW4UiL5bta1cPvXk7YXKu5Sbu/sQJgBNtCfmWOjXsYsYG4gOnJ2bv
        KvsEM=
X-Received: by 2002:ac8:5a08:0:b0:3b8:49a9:48c0 with SMTP id n8-20020ac85a08000000b003b849a948c0mr12715504qta.13.1678027062732;
        Sun, 05 Mar 2023 06:37:42 -0800 (PST)
X-Google-Smtp-Source: AK7set+VrA0Et9eLuahiJYW56eKaXW52VVFT9+7kh5g/EXJNfZNGE+HuYseAdGu49pJ6vAzpoYPjoQ==
X-Received: by 2002:ac8:5a08:0:b0:3b8:49a9:48c0 with SMTP id n8-20020ac85a08000000b003b849a948c0mr12715483qta.13.1678027062460;
        Sun, 05 Mar 2023 06:37:42 -0800 (PST)
Received: from [192.168.1.19] (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id q41-20020a05620a2a6900b0074341cb30d0sm134484qkp.62.2023.03.05.06.37.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Mar 2023 06:37:42 -0800 (PST)
To:     keescook@chromium.org, Nathan Chancellor <nathan@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Tom Rix <trix@redhat.com>
Subject: RFC: extend -Wno-array-bounds to gcc 13
Message-ID: <76df9787-3574-7d9e-02da-3d5bd8212d72@redhat.com>
Date:   Sun, 5 Mar 2023 06:37:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc version 13.0.1 20230304 (experimental) and W=1 on x86 a large 
number of false positives errors are thrown.

Could we extend ?

f0be87c42cbd ("gcc-12: disable '-Warray-bounds' universally for now")

Tom

