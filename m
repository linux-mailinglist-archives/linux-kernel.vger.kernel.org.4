Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D667682F90
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 15:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231928AbjAaOoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 09:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbjAaOoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 09:44:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4D1B76B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675176201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LAtdCvaYcBjQla+NfgEkiJO+riIsmgiBoPP1Uy0xazs=;
        b=BrFAYa3yju0MqzNKZU4VrhBCBGZc5Q1JefLfiXoJY4bRoZlhzcQQEPyoBp5l81Gpl3lCTQ
        GAMLp1syrLMpxgBGBZfxxi3j8xjJo6b2wsovje0OUWeK2iMb1OAuYM63b2KN1twhrhGw98
        z3tQ3O9yTiNjnfuvewaPh5vkcBPPd4s=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-357-PGhPTu9ENh6G6uIpLqmkvg-1; Tue, 31 Jan 2023 09:43:20 -0500
X-MC-Unique: PGhPTu9ENh6G6uIpLqmkvg-1
Received: by mail-qt1-f200.google.com with SMTP id c16-20020ac85190000000b003b841d1118aso3735350qtn.17
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 06:43:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LAtdCvaYcBjQla+NfgEkiJO+riIsmgiBoPP1Uy0xazs=;
        b=G0VzXvqsoEjEdjcIlvAprWNT6puyAEP2eGYk+pNdhfNs5LfybIwWsJKaj7ky6zEj8x
         2D5q83syE66nYoot8zH6W4ZAyNJ41N4MCJR8SVRXPo4L+52iaq+I/7QiXz1UojZBz9Zr
         MlbmeSIqoo3ANU1/WPD1KRyTeNyB5L1HnmUYbBckgy0rSnsvW6sTrM4g05BtUzt73ZG7
         XYQJW6xRZdUUcXkV9uhcktizN3T4tL/nvK3QA1ZKWeYT16mSFraZaRKVrBzokoXDuZXx
         PYjQK+JLRP5DLb8C23SX0w4qx0vmv8ekNkqZmJBRtUFJnghpqDIybhwKVQnQYvMGdkXG
         Tbag==
X-Gm-Message-State: AFqh2koJD7I8K9r9cSNCNC22EYmNxzCiosehzcJaqMPooCEglAYp5bzz
        zGKtcPV6akonXd4H8GEX4EqC25TgXcvjk8PVl+pD5J4IqjxX5XVSvTTk97hGoFU8tmxvAT0Pnx1
        BfhQ53f3F+pr2gvG3+b9x5wIE
X-Received: by 2002:ac8:7ec4:0:b0:3b6:3c9c:59f0 with SMTP id x4-20020ac87ec4000000b003b63c9c59f0mr75200613qtj.15.1675176199683;
        Tue, 31 Jan 2023 06:43:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuXH7IzWL307K632kUG5faoKR8tSdHwFt5EW1IhyhwYmM3PlJhpLhToOa2tJxLyWOWsmCmU4Q==
X-Received: by 2002:ac8:7ec4:0:b0:3b6:3c9c:59f0 with SMTP id x4-20020ac87ec4000000b003b63c9c59f0mr75200586qtj.15.1675176199464;
        Tue, 31 Jan 2023 06:43:19 -0800 (PST)
Received: from [192.168.0.2] (ip-109-43-176-155.web.vodafone.de. [109.43.176.155])
        by smtp.gmail.com with ESMTPSA id z20-20020ac84314000000b003b960aad697sm2448545qtm.9.2023.01.31.06.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 06:43:18 -0800 (PST)
Message-ID: <16e95056-919a-47dc-3ed7-50c29d39b6ae@redhat.com>
Date:   Tue, 31 Jan 2023 15:43:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC kvm-unit-tests 01/27] lib/string: include stddef.h for
 size_t
Content-Language: en-US
To:     Joey Gouly <joey.gouly@arm.com>,
        Andrew Jones <andrew.jones@linux.dev>, kvmarm@lists.linux.dev,
        kvm@vger.kernel.org
Cc:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Quentin Perret <qperret@google.com>,
        Steven Price <steven.price@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, linux-coco@lists.linux.dev,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230127112248.136810-1-suzuki.poulose@arm.com>
 <20230127114108.10025-1-joey.gouly@arm.com>
 <20230127114108.10025-2-joey.gouly@arm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230127114108.10025-2-joey.gouly@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 12.40, Joey Gouly wrote:
> Don't implicitly rely on this header being included.
> 
> Signed-off-by: Joey Gouly <joey.gouly@arm.com>
> ---
>   lib/string.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/lib/string.h b/lib/string.h
> index b07763ea..758dca8a 100644
> --- a/lib/string.h
> +++ b/lib/string.h
> @@ -7,6 +7,8 @@
>   #ifndef _STRING_H_
>   #define _STRING_H_
>   
> +#include <stddef.h>  /* For size_t */
> +
>   extern size_t strlen(const char *buf);
>   extern size_t strnlen(const char *buf, size_t maxlen);
>   extern char *strcat(char *dest, const char *src);

Reviewed-by: Thomas Huth <thuth@redhat.com>

