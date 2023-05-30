Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7768371612C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjE3NMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjE3NMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:12:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2B792
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685452302;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+6EG5NOedHhUekhNBuWsOrX2N+gdRBd6QiNFzYQtzg=;
        b=VzssYmibBm2bQu7H8LFC/I4fHCvgvV5s5yww5XnnRx7AsbvkevEwzTEfn5cmVs4IbDfPyd
        1MvRx2g6OnwWENm/Tet1k+SdzTs+Fc+ano5uBNUhANmj0+954VxxYilGqQo8zOX45vrd9Q
        /Hx7lbR9YaVuLHpWoOtGucb7pD1b2c4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-GvLTR58PM-SPxtXiyDgaqQ-1; Tue, 30 May 2023 09:11:41 -0400
X-MC-Unique: GvLTR58PM-SPxtXiyDgaqQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-96f4d917e06so601794766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:11:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685452300; x=1688044300;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r+6EG5NOedHhUekhNBuWsOrX2N+gdRBd6QiNFzYQtzg=;
        b=FRjZDcos2YUGWFAObUedB7msggQZ2L+LyQ07g+oAhXcGtM5sbcR9Cs8Wmb3axwkekK
         9d9UvEFNnNgBFdVNqV4TsTVXq2TxHR3stV3ZfqWnOq0g1cq14bACfE2YP4KK21tHJXBy
         Xz2ZRXexKO/pKvHrqnceG28Y/D5kmEcIQ2SkOPbhDYo1hyzF+cF9i/6O2srtsC66Fs6O
         HdkfrwAe2CQ/VNWvULBEZ30RzxONPO97bjRk6DrF5nXEmwM6RVqJWJwwRmX7xhp1LxOY
         cDfE1ns/fMsA6MqIEuoyJjqZTqv5aUTOaZPanJDwizEz91ALtvrQJ+JM3KXC7kUl2StL
         04BQ==
X-Gm-Message-State: AC+VfDycq7/p2/ENs1D4r7N5cX3o6cMg4XoRlDdgs3zxFAqABP+XxPzM
        VGMtm1TFghRzGftzgF1mLJHmvH5okp2ISKNchDfzSN5B0oN6PAKtrctr+SHWCvzBiHZS0FckSVG
        ZHbyU88z9sKn6tNziThPmw6fq
X-Received: by 2002:a17:907:6292:b0:96f:ddaa:c30d with SMTP id nd18-20020a170907629200b0096fddaac30dmr2358229ejc.26.1685452300006;
        Tue, 30 May 2023 06:11:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5rr6tIM5V+1BgGKNSxcvQbqymOEo9kSvokrEaCOceWoHcCAp3vqmzpgpVudXV76YB2ALbsAQ==
X-Received: by 2002:a17:907:6292:b0:96f:ddaa:c30d with SMTP id nd18-20020a170907629200b0096fddaac30dmr2358202ejc.26.1685452299746;
        Tue, 30 May 2023 06:11:39 -0700 (PDT)
Received: from [192.168.0.224] (host-87-12-203-248.business.telecomitalia.it. [87.12.203.248])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906114b00b00965af4c7f07sm7258183eja.20.2023.05.30.06.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:11:39 -0700 (PDT)
Message-ID: <e9ea284d-3a8b-b9ef-d179-b67628771bf4@redhat.com>
Date:   Tue, 30 May 2023 15:11:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 1/2] sched/deadline: Fix bandwidth reclaim equation in
 GRUB
To:     Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        youssefesmat@google.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, luca abeni <luca.abeni@santannapisa.it>
References: <20230526145519.2282062-1-vineeth@bitbyteword.org>
 <20230526172959.5440b9dd@nowhere>
 <CAO7JXPgLFgXANqXY7L-YLbijxJCOgUKmd8nUQizb62JorOXGhA@mail.gmail.com>
 <CAO7JXPit6snFM2oW-uSs-mtbmKr9wpbX2exqAUF0iAiaAO6hOg@mail.gmail.com>
 <CAO7JXPgf9ffVQ3n9iD8-1abuDSAZHWAZmz56BmM68uJZ7uy+Uw@mail.gmail.com>
Content-Language: en-US
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <CAO7JXPgf9ffVQ3n9iD8-1abuDSAZHWAZmz56BmM68uJZ7uy+Uw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/23 18:15, Vineeth Remanan Pillai wrote:
> I have just sent the fix as a reply to the initial patch. I shall send a
> v5 if needed. Please let me know.

Please, send a v5... so we avoid mixing up patches on testing.

-- Daniel

