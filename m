Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72856E6900
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjDRQJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjDRQJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A29F7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681834130;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gIUoBoNwGf60Ywv5E1OAkZFEq8OKvMFGG3u/CbQ6Qsc=;
        b=BrBnN371hATqPkPvumIowX30Y6IPUE94o5a1Ye4zOTrlNMmPSHUxF7hBXk7fDqftwSvfEt
        i+JH5GbxgoLbCjF2gmVprP27NBAP6up8Vzd0oqhz1NGwZ+sC9DqhrIuASDPsO9peaA79aB
        KUi5DjfxR3K5AxkWQXLS5z8SfAmxH7Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-ZYpfnteVPiCAfCFqyJFGRg-1; Tue, 18 Apr 2023 12:08:46 -0400
X-MC-Unique: ZYpfnteVPiCAfCFqyJFGRg-1
Received: by mail-wm1-f71.google.com with SMTP id bd16-20020a05600c1f1000b003f172e02edbso57159wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:08:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681834125; x=1684426125;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gIUoBoNwGf60Ywv5E1OAkZFEq8OKvMFGG3u/CbQ6Qsc=;
        b=DoUVmW5L2ntV7MtqaLCw0gpndwMuJyWr/pzNvWyt1CElL7IJyt8Fv/SdvPYdeYtpjn
         9JOeVLKepcYP/2p4sIBOliTMsMML4OmE8D8YDHvMjTIrLjCD9TEFwEwiVueudWj+nspb
         jcapbCTTu9mi9hqXJxIGjqkLQqvMihTACeIhKLCkgYfDsIq4jKN8YVL0mNP7XpF6U3qB
         Ymd+4POEtUoU1a0kyOxJCSrLtCSz/cpXh/6ohbs+UXlsqlNAWbx7KN74HGKWjwLMx52v
         SFLX2TzDhlOm2fGWhp73oIGnKjm6y15BmT/uxFxse3nMcRnL9qr+jVF6QAYl9jE3zzb+
         AXmg==
X-Gm-Message-State: AAQBX9dFXB33sxtrS4On/jznxItvW/dWVNJMBdtCswOLlfZjTiKjYKOu
        J5EnzylMIn7GhCtJ2U8RvKHY/6lxvd+J3rD8uBB9f5Km5J6DkM3rhRAMQKOaFY1UTVSH2v9y24s
        8HUYnWleeGaN+LkgX41fe3RIa
X-Received: by 2002:a7b:c8c7:0:b0:3f1:7277:ea6 with SMTP id f7-20020a7bc8c7000000b003f172770ea6mr5904488wml.31.1681834125215;
        Tue, 18 Apr 2023 09:08:45 -0700 (PDT)
X-Google-Smtp-Source: AKy350bQhtmsKVdkEBcCWOEBSriLVJpPeYaY5UBgzT96ZYCKTR4sOo7/hvme1QYnWdRlLhe666z+9w==
X-Received: by 2002:a7b:c8c7:0:b0:3f1:7277:ea6 with SMTP id f7-20020a7bc8c7000000b003f172770ea6mr5904470wml.31.1681834124913;
        Tue, 18 Apr 2023 09:08:44 -0700 (PDT)
Received: from ?IPV6:2003:cb:c715:3f00:7545:deb6:f2f4:27ef? (p200300cbc7153f007545deb6f2f427ef.dip0.t-ipconnect.de. [2003:cb:c715:3f00:7545:deb6:f2f4:27ef])
        by smtp.gmail.com with ESMTPSA id o42-20020a05600c512a00b003f1738d0d13sm6487wms.1.2023.04.18.09.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 09:08:44 -0700 (PDT)
Message-ID: <250ac32d-e8c8-2d42-19f5-f7518f6e1449@redhat.com>
Date:   Tue, 18 Apr 2023 18:08:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/6] selftests/mm: Add a few options for uffd-unit-test
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?UTF-8?Q?Mika_Penttil=c3=a4?= <mpenttil@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20230417195317.898696-1-peterx@redhat.com>
 <20230417195317.898696-4-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230417195317.898696-4-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.04.23 21:53, Peter Xu wrote:
> Namely:
> 
>    "-f": add a wildcard filter for tests to run
>    "-l": list tests rather than running any
>    "-h": help msg
> 

Sounds helpful.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

