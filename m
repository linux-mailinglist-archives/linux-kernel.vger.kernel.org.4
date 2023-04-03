Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A35896D3E8B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 10:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjDCIBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjDCIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:01:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D281FF7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 01:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680508854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7ZVSpNV+BDI0cGpEAjlsP+qfsorb2sHTxV+V9nP6fMk=;
        b=hV0q8OMgP7WhD/J6E6yDGb/FWCUt3JOPY7E9OE6YmKMOZH6daj9LwB0f3UrS3epX301CWJ
        90yWaJ5ozD3GDd2FpJbn2QpnQ6vifaPpJSE4JeNdgvbAT5lbjdTYAN7jXCv5M2VM0tiq8G
        Y3Qq3MMbbXPRJdFFRKl5TN7LU8/2CXg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-qiGHHpFXM2mLE2LGUaFcRw-1; Mon, 03 Apr 2023 04:00:52 -0400
X-MC-Unique: qiGHHpFXM2mLE2LGUaFcRw-1
Received: by mail-wm1-f72.google.com with SMTP id d11-20020a05600c34cb00b003ee89ce8cc3so14130550wmq.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 01:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680508852;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZVSpNV+BDI0cGpEAjlsP+qfsorb2sHTxV+V9nP6fMk=;
        b=eJj/lH7cu30i2z93LH0wJS3eV8Ft9m6g5RqKgCI3ePHG0JRhDfsPuxum/DbvQJN0F7
         Gevcn7WCRrFm5LPmW/8bg+//Qf1VF1O0wPoJiJ2eUtOdgUfJbtItwiT3dLIvfe2eePwJ
         HfdyCfJWxCycGeer8XGmkMBMpVWED0awM/upZTaGLGs10/CurpyM0xJUFfpNZj/bq1AD
         rRbPujVR5m9G0HzquDQv//cXByYaIjZo7ak1f4ZUEe3qK0KJyfx/kXCX+kmqawmrmyB3
         JuDEqsIJFihlQrsFKneanfkRAQncXplwdasPsZTcTp2Y30zYDxm3PBffsy8ttd3UCm6g
         MYrA==
X-Gm-Message-State: AAQBX9e01Knw3Vc/IJ/jb6WRdcknZqrd5fxm1a0n72TEviAFaJtwD5cT
        Ec6PWbwEsmTcVZpxY0JgdAYplupMP4d2xNjeNGTieBNTEaCUmuGE9sRkqPcqMglp2oeWSm5IhUD
        pDDAcRPWv2ssQwGiMA6RoV1pG
X-Received: by 2002:a1c:7405:0:b0:3ef:62cd:1eb with SMTP id p5-20020a1c7405000000b003ef62cd01ebmr22822799wmc.7.1680508851894;
        Mon, 03 Apr 2023 01:00:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350bwmtu9rK901WmqifFz8QsJqu6Ft8ILRFdJiU7GK6K7EesJBFcey9gkdJeTosjvqrE6LlC1eQ==
X-Received: by 2002:a1c:7405:0:b0:3ef:62cd:1eb with SMTP id p5-20020a1c7405000000b003ef62cd01ebmr22822772wmc.7.1680508851567;
        Mon, 03 Apr 2023 01:00:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5e00:8e78:71f3:6243:77f0? (p200300cbc7025e008e7871f3624377f0.dip0.t-ipconnect.de. [2003:cb:c702:5e00:8e78:71f3:6243:77f0])
        by smtp.gmail.com with ESMTPSA id 24-20020a05600c029800b003ed246c1d28sm11160957wmk.44.2023.04.03.01.00.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 01:00:50 -0700 (PDT)
Message-ID: <c901682e-6b4b-71e7-78b4-c46d1acb5dee@redhat.com>
Date:   Mon, 3 Apr 2023 10:00:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 15/29] selftests/mm: uffd_open_{dev|sys}()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
References: <20230330155707.3106228-1-peterx@redhat.com>
 <20230330160749.3107270-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230330160749.3107270-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 18:07, Peter Xu wrote:
> Provide two helpers to open an uffd handle.  Drop the error checks around
> SKIPs because it's inside an errexit() anyway, which IMHO doesn't really
> help much if the test will not continue.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

