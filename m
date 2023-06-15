Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF5A6731957
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbjFOM5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241952AbjFOM5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8452702
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686833820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U9JHKraOZ8C9H8TNlUxicYfNReQUH9J26rOccgFXmnY=;
        b=fJlMg1aqvaW7O2pgnXQivSLTYHkz1rZT4RPrEp78NKSko5FH0cjPDf1opclcir1z094hzb
        /dn816JDDP8fzZJBgy7VxR9roJFeJ5yB2epgXHahwtVMvlCcZryvCP3rpYDWR3p22YDs10
        FGEmpwOaXV3Mx83nGAkndKKyb14r3DE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-eixazXd5PFGpZZCB9IFxPQ-1; Thu, 15 Jun 2023 08:56:59 -0400
X-MC-Unique: eixazXd5PFGpZZCB9IFxPQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-4edc7406cb5so6512035e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 05:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686833817; x=1689425817;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9JHKraOZ8C9H8TNlUxicYfNReQUH9J26rOccgFXmnY=;
        b=JcjFiUWXWdlnjlE7c5sN0f5+T2GEGuJs9FrKfP+KIxljNsIQawWAo/6Hh6D5hEwWpm
         eWjktYEonBmUXwwWX3M0rxVp/aj8+qcQGdGipcx2mdOr2F/KhroERDsjHvkvCA6cBcYB
         qR76n4nmIX9inUfwnrXD5VlX76jj526kcyRWUPaSIgWnu+GTegS/6IocaAzWTX55XEqv
         4eZkgEbJvHRVuMhB7nXpTeZ4CbEJynF8i4/7KN8p8NgE7G8cPCAvfFQKf8xUzSSo2O+5
         B/eZGmSd5pwtE36twa9X2TmjsHV4vNPNmVDrC/hU+UpypkOdrzbgUDRy21XnUYSVsku4
         oxpQ==
X-Gm-Message-State: AC+VfDzulZEdMkbXUHD+jkNq3zu4ZN5ytieYcSY2zY6efSf44u28Qh6z
        9qSHfkTqRTaZsnVUlReu9ukT/o5ldrWTJfqv2mgEhNerF+6pzY5BF75fBcL8BxK7Nn8g0209s1G
        p7yQLmqBMJO/fgor/MsI5uCWd
X-Received: by 2002:a19:7113:0:b0:4f3:b258:fee4 with SMTP id m19-20020a197113000000b004f3b258fee4mr9938776lfc.59.1686833817551;
        Thu, 15 Jun 2023 05:56:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7bSB+Z4QicTb+uLFFwe367ysrOFiLTzBu/nB3bSm2df/9oyOxwkS4isQmvmMoD0F93eQAiFA==
X-Received: by 2002:a19:7113:0:b0:4f3:b258:fee4 with SMTP id m19-20020a197113000000b004f3b258fee4mr9938758lfc.59.1686833817121;
        Thu, 15 Jun 2023 05:56:57 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id c12-20020a05600c0acc00b003f195d540d9sm20419103wmr.14.2023.06.15.05.56.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jun 2023 05:56:56 -0700 (PDT)
Message-ID: <bd119703-7b7b-c4ab-0c38-9b85809de252@redhat.com>
Date:   Thu, 15 Jun 2023 14:56:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [External] Re: [RFC PATCH 1/3] zram: charge the compressed RAM to
 the page's memcgroup
Content-Language: en-US
To:     =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, mhocko@suse.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230615034830.1361853-1-hezhongkun.hzk@bytedance.com>
 <d9b22eaa-00a1-6c5c-99a0-126b085f7cb0@redhat.com>
 <CACSyD1NxcYn_Uy2DUk1ywSyWsxFzq4H+poaWvF55SZZz5W-uRw@mail.gmail.com>
 <3f54542e-235b-8456-f13f-786d21c6c14f@redhat.com>
 <CACSyD1OxAMowHTE7KnL8nac_-=Vp4eyO00oyMLFo0qcEHx33GA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CACSyD1OxAMowHTE7KnL8nac_-=Vp4eyO00oyMLFo0qcEHx33GA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.23 14:19, 贺中坤 wrote:
> On Thu, Jun 15, 2023 at 7:19 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> Yes, but my point is that there are cases where the pages you get are
>> not charged. zram_bvec_write_partial() is just one such example that
>> highlights the issue.
> 
> Sorry ,I got it.

I suspect for the swap->zram we should always get charged pages, because 
we're effectively writing out charged anon/shmem pages only -- without 
any buffer in between.

For the fs->zram or direct zram access device case I'm not so sure. It 
highly depends on what gets mapped into the bio (e.g., a kernel buffer, 
zeropage, ...). If it's a pagecache page, that should be charged and 
we're good. No so sure about fs metadata or some other fs cases (e.g., 
write() to a file that bypass the pagecache).

-- 
Cheers,

David / dhildenb

