Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B50671FDF3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 11:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjFBJd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 05:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjFBJdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 05:33:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61079134
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685698364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zGO5HytmLACgK9GKNF+3cgvVOya1l1UlgEMwgI/rmuY=;
        b=E6Xv5+wUcQbk+xtHAsSPyIUd2cX0xxhCrW6NDVMGFUcBgE15zvSyjSWCTiJkENMuVHQIih
        Ruem2Kbw5QAWznUNuxm5X2RLHJTZ2OJ1wb6Ww2cw7FnvMmsQ318KYd9gWUwUlhIU71Ywgo
        bODJLq3uVu3JaMVwGdGX1rBr6TrszyE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-214-YorHQp-rMKG4xUVdoUp1Xw-1; Fri, 02 Jun 2023 05:32:42 -0400
X-MC-Unique: YorHQp-rMKG4xUVdoUp1Xw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3f60162f7fcso10322275e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 02:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685698361; x=1688290361;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGO5HytmLACgK9GKNF+3cgvVOya1l1UlgEMwgI/rmuY=;
        b=O4EzOAi9CCI0Th95zliDpbjZQLRYob574afC8xLgjnM42YuyMWYeaOWlVIIQzt9lRI
         3hIE9rT6YmQLnWLxow8ugD6dBWtN9ioLi09p6uXLkUcmnnlsszmVWSni6/IEcZ/8vAZh
         t8Zaxd9xr0pVZBBpY+QFtqOKTXj4Meh71hD5FoRJYxafF6cgl63jTco9c+hJsPM7CeJ0
         0biF6HwePAKAWXcQIX/BFJfRDWgkqBLBG9BB1AVEHf2xR08RP9+inHbhuvIBepWXpQck
         owhviQsRepYtjw8cVAGQoS5qRhk/nNgJsbCqHIPRtS5Q7hJpjjyO0FkjmGymEzCO8ip9
         UZSA==
X-Gm-Message-State: AC+VfDw2tF42cmY9li9jrpkjX6+NbQn29O5RME+uL6JUnA2g7mD4qB5S
        i5x4MJ2q2Ya1A9yjY84VQqAeuWVgt5PPhRUeYNpNvKvVby6skLRD7sj3Z0YFSFZyJP4OXkVrWwr
        /8ooM2q7FguOL2HdS7aBdO1fR
X-Received: by 2002:a7b:ce0a:0:b0:3f4:fc5e:fbf2 with SMTP id m10-20020a7bce0a000000b003f4fc5efbf2mr1343874wmc.8.1685698361249;
        Fri, 02 Jun 2023 02:32:41 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qXLoMOUyOwyxB8QJi5/lh8XWNUX/jSwFh9mmS99bJj5kctxTuQ4RoxvaIPaaRHATi9LX5Ug==
X-Received: by 2002:a7b:ce0a:0:b0:3f4:fc5e:fbf2 with SMTP id m10-20020a7bce0a000000b003f4fc5efbf2mr1343855wmc.8.1685698360862;
        Fri, 02 Jun 2023 02:32:40 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:ae00:f2e3:50e0:73f7:451? (p200300d82f2eae00f2e350e073f70451.dip0.t-ipconnect.de. [2003:d8:2f2e:ae00:f2e3:50e0:73f7:451])
        by smtp.gmail.com with ESMTPSA id m16-20020a7bcb90000000b003f6028a4c85sm4897350wmi.16.2023.06.02.02.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:32:40 -0700 (PDT)
Message-ID: <78c0b444-8a95-396e-5f5e-8175f94a49cc@redhat.com>
Date:   Fri, 2 Jun 2023 11:32:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 00/12] A minor flurry of selftest/mm fixes
Content-Language: en-US
To:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20230602013358.900637-1-jhubbard@nvidia.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230602013358.900637-1-jhubbard@nvidia.com>
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
> It turned out that an even dozen patches were required in order to get the
> selftests building cleanly, and all running, once again. I made it worse on
> myself by insisting on using clang, which seems to uncover a few more warnings
> than gcc these days.
> 
> So I still haven't gotten to my original goal of running a new HMM test that
> Alistair handed me (it's not here yet), but at least this fixes everything I ran
> into just now.

Thanks, now I can stop commenting out some (IIRC primarily uffd-related) 
tests when just wanting to run some specific tests on some of odd 
installations :D

I assume this round you only consideres 64bit builds, right? My last 
attempts with 32bit revealed a lot of issues, and I only fixed what I 
really wanted to test (COW).

-- 
Thanks,

David / dhildenb

