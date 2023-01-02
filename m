Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9B065B4E4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236615AbjABQMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbjABQMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:12:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53A8337
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672675845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0NmhDSiaQrrVJCMvGRbMDi8tVjpwlzfwkqxg2mnsE2c=;
        b=dDUJqyiTFnGuhoBgxOzTEOr11QmceXbZ4DU8aXAOAod11Gth5FC7U1XS15ots4jPvZ8rXl
        SVhUozAwee83AS/Z7EXzwR78WWgSylLhzd9ROzYanIfsBwC1aZpg6debKmoIKzVHrk2XLd
        ZRC49ItQ8ICIeSNbQIPQd5n4t0OkxBI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-CTeUHJLuN6Kzi_MgwgcL5w-1; Mon, 02 Jan 2023 11:10:43 -0500
X-MC-Unique: CTeUHJLuN6Kzi_MgwgcL5w-1
Received: by mail-wm1-f69.google.com with SMTP id l31-20020a05600c1d1f00b003d9720d2a0eso14905785wms.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NmhDSiaQrrVJCMvGRbMDi8tVjpwlzfwkqxg2mnsE2c=;
        b=Ly054nmlKTv4V8WPQOIXS6sVCz+QIVcrylDJNgyTkAsy12bBLk0KrcBRnbUsKM1P55
         uJUYdzLfG1jebEI7QNCAxmjK0IQ1rx5hY3Qh9Kyx0mgbhGEorLaCV7dnhEwKWbrYmLaE
         bSZ3zLgj+U4WWzqTHfHghfggIg+3g+UDxYG99c3dlCPH0WrEx9K37j+sdB9tM5SFQrEH
         X/Wai7mfP4PimWzv06uR/U67AhLwjv/dXwYMZUAjKyuubYrr/NM7RJKLjx1xjMkH+94w
         wV9RXOgcFeqZJhtgK5SzR0b5MoFjH99zLxpzl1Ldr0LP9mj63YA7xTJxpNdvZgodoRg6
         Vmdg==
X-Gm-Message-State: AFqh2kre49dho2cP+FFHxBRFqsrohgobJdSX78yrayts3LI65DL39mqm
        Ev1tv9uSV1/cfGJmc4m4cRtqEOKZTttgOJIF1x2RL5bp0k6/I5OCrveb4MnUrXcK+XINbghajSw
        NB5udMt0fYqqON7TIuzP4v30F
X-Received: by 2002:a05:600c:4920:b0:3cf:7514:a82e with SMTP id f32-20020a05600c492000b003cf7514a82emr29615530wmp.23.1672675842677;
        Mon, 02 Jan 2023 08:10:42 -0800 (PST)
X-Google-Smtp-Source: AMrXdXskldjRSYhz4SR5xTIRDebGy49uwim8uWpYjsQBMgXFHdXu5r42wcRaBTeTwn2Jjj3Ngw9FZQ==
X-Received: by 2002:a05:600c:4920:b0:3cf:7514:a82e with SMTP id f32-20020a05600c492000b003cf7514a82emr29615513wmp.23.1672675842475;
        Mon, 02 Jan 2023 08:10:42 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889? (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de. [2003:cb:c703:500:9382:2e5a:fea:8889])
        by smtp.gmail.com with ESMTPSA id d9-20020a05600c3ac900b003d973d4fb28sm33175942wms.4.2023.01.02.08.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:10:42 -0800 (PST)
Message-ID: <f29b6cb0-d46b-7d89-c8ad-12b9addf8ce8@redhat.com>
Date:   Mon, 2 Jan 2023 17:10:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] selftest/vm: add mremap expand merge offset test
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
        Jakub Matena <matenajakub@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>
References: <420e491062db9151504aef5661c8a2d928ef6bd7.1672675224.git.lstoakes@gmail.com>
 <9d13393a-d203-23de-30ae-4d6476a94fd7@redhat.com> <Y7MBqfYv54rY48Wi@lucifer>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y7MBqfYv54rY48Wi@lucifer>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.01.23 17:09, Lorenzo Stoakes wrote:
> On Mon, Jan 02, 2023 at 05:03:31PM +0100, David Hildenbrand wrote:
> 
>> With the exit() in place, the else branch is implicit and the else can be
>> dropped.
> 
> Good point, we'll go to a v4 then :) that does neaten things up
> actually. Hopefully this should suffice!

Maybe wait until tomorrow for feedback from others. Make sure to include 
my acked-by.

Thanks :)

-- 
Thanks,

David / dhildenb

