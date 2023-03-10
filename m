Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8E16B3C02
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 11:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCJK1J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 05:27:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjCJK1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 05:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906C5110516
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678443978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSYT9NdKeIbjdIT8S3/yTKu9A/BiOzhczLFXXBYF9tk=;
        b=MYVnxnphoDJD98CZgDLfxhXGjMIP7xTZ3zcq3kJpLlK6ihgi2ejPunrXO6duW3aEG+p983
        mJ7vch39wvrcM+QsdrCsNpZxLkYnNL4+lWULIK/Tr8AkcSMiYBLnHTf1pj3w4zQ1i0iDK8
        SJc3qDD2y44jX3/asxUfZnDCbg1DuFU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-av8b9GlxNuG8kuSfza7DJg-1; Fri, 10 Mar 2023 05:26:17 -0500
X-MC-Unique: av8b9GlxNuG8kuSfza7DJg-1
Received: by mail-ed1-f69.google.com with SMTP id b7-20020a056402350700b004d2a3d5cd3fso7040650edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 02:26:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678443976;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSYT9NdKeIbjdIT8S3/yTKu9A/BiOzhczLFXXBYF9tk=;
        b=z6I4c7uo+7zfb4fNp1JNzvC/AJcnyItGf7+LHbq9SzIsZ0rRalRFxV4fdjbwqBNx49
         ZjrM0HgRtVAZQ1ElYHHl6MPwuakDa42npetJ5nhYqj5SZneTzrDME9JGMAnpi1zryky3
         SZuP92Gx2/WutYdsNOFyDGV3BFS968fPN0l0IxBzBBQKBDeoCrxZFd0LSwzXjqJFzoUN
         Jp0yzgdE//to5vR0w6JvZrtoI+Dman3Wq4p1CgVybMinOxKeGhcRX416KyOqKSdEtlKQ
         9oK40oB1qHxY4E9XFdvuabbT1LZeNOfsxOHR3T2bAi7DHnX8LFyVwbgvqqU3n7gZIDx8
         l3xQ==
X-Gm-Message-State: AO0yUKX6iS2cjRb3n8zGS30ANMpOxg6bFGM/rV06c2bYyBLw/Q2ngUjI
        fX7SRk5FmmzDDKcHzB5EdgfE5UQO8lLdcVGzH6m4XEj8L/0qx3ha3lDBuRcL4WwjoPXZMPSe+zd
        L/t21vaMDxT5s+3xaFoaLnL79VjWm3Sw3
X-Received: by 2002:a17:906:4756:b0:8ed:5af8:d4ba with SMTP id j22-20020a170906475600b008ed5af8d4bamr1557177ejs.38.1678443976130;
        Fri, 10 Mar 2023 02:26:16 -0800 (PST)
X-Google-Smtp-Source: AK7set+xHrvOFHbxAWQ1eD/jbBpVJSXkKAk6Q7FFe6t2ghKJjQXr/bZkp4vlYrU3T86K9j2Y0urShg==
X-Received: by 2002:a17:906:4756:b0:8ed:5af8:d4ba with SMTP id j22-20020a170906475600b008ed5af8d4bamr1557163ejs.38.1678443975907;
        Fri, 10 Mar 2023 02:26:15 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id m25-20020a170906235900b008ca52f7fbcbsm789348eja.1.2023.03.10.02.26.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 02:26:15 -0800 (PST)
Message-ID: <9d0bbfb3-cb7f-15f9-0e84-172dd08c6148@redhat.com>
Date:   Fri, 10 Mar 2023 11:26:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/5] staging: rtl8723bs: remove some unused functions
Content-Language: en-US, nl
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230310083449.23775-1-straube.linux@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230310083449.23775-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/10/23 09:34, Michael Straube wrote:
> This series removes some unused functions from hal/hal_com.c.

Thanks, the entire series looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

for the series.

Regards,

Hans

> 
> Michael Straube (5):
>   staging: rtl8723bs: MapCharToHexDigit() is not used
>   staging: rtl8723bs: ParseQualifiedString() is not used
>   staging: rtl8723bs: isAllSpaceOrTab() is not used
>   staging: rtl8723bs: linked_info_dump() is not used
>   staging: rtl8723bs: rtw_get_raw_rssi_info() is not used
> 
>  drivers/staging/rtl8723bs/hal/hal_com.c     | 108 --------------------
>  drivers/staging/rtl8723bs/include/hal_com.h |   9 --
>  2 files changed, 117 deletions(-)
> 

