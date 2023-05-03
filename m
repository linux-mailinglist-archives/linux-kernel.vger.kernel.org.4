Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0696F5586
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjECKBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjECKBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:01:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5B310FE
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683108037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/6nW/ulj6fgmoP9Hji3Y8JXnyxUQC9ywV4YbenugH1I=;
        b=QMUmp2wq9rEOFMRszGBiIsNkeBeAUlmMB9Bg2xbWTnnw7F0NKSQ7vODggV1wfhQc/pGhEw
        FaaH/3UGMddG60r8w46S0oXWzR69N68Q/kM1wsbG23U2CBHCFWMVwx3+gnXHrmywXeXWS2
        gDjHPokn+OTi0N2cRLwYZZjBfosdSww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-LSV5PULeNQmgsQkdqE_NTw-1; Wed, 03 May 2023 06:00:35 -0400
X-MC-Unique: LSV5PULeNQmgsQkdqE_NTw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30633990a69so857478f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 03:00:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683108035; x=1685700035;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/6nW/ulj6fgmoP9Hji3Y8JXnyxUQC9ywV4YbenugH1I=;
        b=b3PpgNQITMm4efMP1Plzg/MH39rNeltpnZlFKS1yKlD5PmP/T8IYQSHSzhvGcN7aQV
         voo2ltn7lhsTYBIj6+/5tFTitGdzWvFUiq7w621GcMGV+/PNRpq4jRF4Bgj//ePvcNOD
         vAxEMZNzNdMwqwdqTALZcAGNFSCeumPyWOYBO7mLG3gwMy8mBpkv9VKjZEUof2CVIhKv
         ZfnmUcDqIEc/3+BKqsC2qErmnxwPrmluYiIS1STcX8XxXox6JmrZ5+lTGYgDcKV7iIC/
         lH1OYN6T8LsfIouZU3yajxEH7pxOTsgn/oHrmIRU3Tcu7JbitrHXf+ctOG4/Hw/UxPe3
         BN7w==
X-Gm-Message-State: AC+VfDyyF4+vX96m8KAlbhQ1UJBMGXReLAPysWusdMrsuS7sNsiak9DW
        QQrXhT8TFCOwiLyaNPVY0mzfwF7ZBqE1RuxeD1gT27QFsWLlY8V8gpsnT9xISQeiVkI5sdYl7V1
        Mwl4tGu6Y+9+cuck/YgvexvVW
X-Received: by 2002:a5d:4f90:0:b0:2f8:f144:a22c with SMTP id d16-20020a5d4f90000000b002f8f144a22cmr14188534wru.62.1683108034788;
        Wed, 03 May 2023 03:00:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5sZP/W3eAA1sD5mGDayMPgI7uxdRqkhgoaxqYxdWD5TDfzw7oHq1zZ2xQsVtBHq7cLgK1BLg==
X-Received: by 2002:a5d:4f90:0:b0:2f8:f144:a22c with SMTP id d16-20020a5d4f90000000b002f8f144a22cmr14188495wru.62.1683108034475;
        Wed, 03 May 2023 03:00:34 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600012d200b002ceacff44c7sm33457472wrx.83.2023.05.03.03.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 03:00:34 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Pawel Chmielewski <pawel.chmielewski@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Gal Pressman <gal@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Barry Song <baohua@kernel.org>
Subject: Re: [PATCH v2 0/8] sched/topology: add for_each_numa_cpu() macro
In-Reply-To: <CAAH8bW9SBrFG+gkH2sT4O_tEQaM-bNT2++v0iyjnuf_aME2DNg@mail.gmail.com>
References: <20230430171809.124686-1-yury.norov@gmail.com>
 <xhsmhildak6t0.mognet@vschneid.remote.csb>
 <CAAH8bW9SBrFG+gkH2sT4O_tEQaM-bNT2++v0iyjnuf_aME2DNg@mail.gmail.com>
Date:   Wed, 03 May 2023 11:00:32 +0100
Message-ID: <xhsmhfs8dka4f.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/23 14:58, Yury Norov wrote:
>> LGTM, I ran the tests on a few NUMA topologies and that all seems to behave
>> as expected. Thanks for working on this!
>>
>> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
>
> Thank you Valentin. If you spent time testing the series, why
> don't you add your Tested-by?

Well, I only ran the test_bitmap stuff and checked the output of the
iterator then, I didn't get to test on actual hardware with a mellanox card
:-)

But yeah, I suppose that does count for the rest, so feel free to add to
all patches but #5:

Tested-by: Valentin Schneider <vschneid@redhat.com>

