Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC03571FECB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235270AbjFBKRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235260AbjFBKRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B224E132
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685700983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=66wxXY6ZZlJ0bOmayJiPpTKIEXJpUPiWjuQHtkRwt6k=;
        b=c/LQQNiycpg8VS1hei49x3787hbcLPKwXaZ6Jb4HnGAbhrsuqP+1/s1Bepxpk+ANpJsBVX
        IVdGrQBJlYY7cemRESjT1Dh/prT2QyeSGn7gJ/sJqpqaMUAe32rRiECp5ZlqAn4xZ462NE
        CeLcvIgefXS1bw4zvIU/6BoT/nVrlAg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-mlSZRjA8MVy7eF9p-tX_Pg-1; Fri, 02 Jun 2023 06:16:15 -0400
X-MC-Unique: mlSZRjA8MVy7eF9p-tX_Pg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-307897bc279so1012045f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 03:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685700974; x=1688292974;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=66wxXY6ZZlJ0bOmayJiPpTKIEXJpUPiWjuQHtkRwt6k=;
        b=Dfzq7qhVXHXDaBHExp33k3Zo0RQcDGU1b5GUWoiOuyRFW+rxM8MdqArWUM9I74x4DJ
         YFskpkQaV3/4d30ZVs9kelIJpb94bPj5F0skaFXYZoB7/sVRH6qgoOMGKPw7YtkfBGfY
         yJopAcNXJJ5Hjx7BRaq46EZ1b5mEgBfJpq3Fu+mZ9VBU6QHxo9KgjDUbwVfwfRwQ6OMp
         C0hiUYZ5YnBXT+l+i+wYGAJaMCLzIr1OYE9zrnUgmOMXnfN9uFhZ+t4vgQ4/PU+MHnw3
         vgiaeV2QI/vwf21dkQXCldujKVj8JSyF+luU6u2CeGrRIhtnamZ45aWOem1PUsUCfCmf
         b4sQ==
X-Gm-Message-State: AC+VfDxWvkNpVXihijjyBkzGC/yQVL2joabBp1RqXRzYEutqnOE8Rx8u
        RaOF0uw9Ebox2V4Zvd7pN85mMaAhPQC0mY2isRb6Dny6br7fKgk+ai8cIRo0ttGjEMqqt92Ik49
        iIPAedL1JL4liR26X3wYRBoMy
X-Received: by 2002:adf:f6cc:0:b0:2ef:eb54:4dc0 with SMTP id y12-20020adff6cc000000b002efeb544dc0mr3952712wrp.51.1685700974169;
        Fri, 02 Jun 2023 03:16:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6ilwCo3viWaA/CBnYobMREKJMfmCTriGV2IM4tW1r1mkk3iAeSLDAYizjzKXSNfBMs+vdUnQ==
X-Received: by 2002:adf:f6cc:0:b0:2ef:eb54:4dc0 with SMTP id y12-20020adff6cc000000b002efeb544dc0mr3952702wrp.51.1685700973870;
        Fri, 02 Jun 2023 03:16:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id j10-20020adff54a000000b003047ae72b14sm1218679wrp.82.2023.06.02.03.16.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 03:16:13 -0700 (PDT)
Message-ID: <f7288e55-e3e0-76e3-0a95-0330cec13b65@redhat.com>
Date:   Fri, 2 Jun 2023 12:16:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 08/12] selftests/mm: fix a "possibly uninitialized"
 warning in pkey-x86.h
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
 <20230602013358.900637-9-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-9-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.06.23 03:33, John Hubbard wrote:
> This fixes a real bug, too, because xstate_size()  was assuming that
> the stack variable xstate_size was initialized to zero. That's not
> guaranteed nor even especially likely.
> 
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

