Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08905EC9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 18:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiI0Qp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 12:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbiI0QpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 12:45:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04CD11469
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664297114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1HjyYya3FB48JS2/Ql1r5PWH5BLiIQBcqxgu9zTRgq8=;
        b=XmxxU0wpOiwfAxSPe2J8q7IambWkJzdVIJFx0XtWEswlhz9DSHtQvfmtJDU4NiSst0UFOP
        eklPGmGeTVNwGSatZsVtBHiIxivAuGx8Hjt1natgGUVHC6tGpi0vdMHstNfVkMQnxOF4rN
        C/f3oxGeDKnoOermnP1YHOgXKi/Sggk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-592-j9FQEJaqO1GGLinqDKIawA-1; Tue, 27 Sep 2022 12:45:13 -0400
X-MC-Unique: j9FQEJaqO1GGLinqDKIawA-1
Received: by mail-wm1-f69.google.com with SMTP id y15-20020a1c4b0f000000b003b47578405aso2963906wma.5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 09:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=1HjyYya3FB48JS2/Ql1r5PWH5BLiIQBcqxgu9zTRgq8=;
        b=gNRllUkC+jUIfAf/OfCcHMM1p0uXfD2fH0J3v+kyqNdYShMIPS+1bPZVW639BDcK/w
         tXdxfxuu6wXtCv+er7YoOntw7C+i9VYD42AXMbsnDsFtQC9wfcl0Tsw2mI1lgI6x3rTw
         VOz290iRXPOa/hM8lzBwa4R1aKoq3ss7XmsLUF8XDOThWvFxJ5a3tSR4XUG7JqZaGJVC
         1p8J5McT9x6M86Gu183xNO+Gnywr6szhFWxFPzVDnX+z95rt+Yp13ltBpj4FI3mMCbiX
         m997CcMle+M3e1Jp+bCATwISPgP0rL6vEgEWYPjPrrHIul7tfjbV29C/wmnrEJvqEQQg
         Ifuw==
X-Gm-Message-State: ACrzQf2fnKMA7yrGiEqTmRwJEUunmN8a/+WJHZLc1JU6fcFtxL+KK1BZ
        1IEMz/l/jDYoRZJ02ES8ASQEucQQ+askjv5PWo908g7ghZtzGt086jKa/XolAOTDFY5SsAEJ35+
        3Q6t6s9a0piB8cslMyR99XLCU
X-Received: by 2002:adf:c641:0:b0:22a:2da9:e248 with SMTP id u1-20020adfc641000000b0022a2da9e248mr17796272wrg.132.1664297112379;
        Tue, 27 Sep 2022 09:45:12 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7sduHtnjJfER4xAtTXqMI7EcFTzkHDpdXfxL8UJvUUqEplT6WjoWUU9zwE1j3IiJwYv3cPgQ==
X-Received: by 2002:adf:c641:0:b0:22a:2da9:e248 with SMTP id u1-20020adfc641000000b0022a2da9e248mr17796246wrg.132.1664297112149;
        Tue, 27 Sep 2022 09:45:12 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id o2-20020adfeac2000000b00228c375d81bsm2265890wrn.2.2022.09.27.09.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 09:45:11 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gal Pressman <gal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
Subject: Re: [PATCH v4 5/7] sched/topology: Introduce sched_numa_hop_mask()
In-Reply-To: <YzBtH8s98eTmxaJo@yury-laptop>
References: <20220923132527.1001870-1-vschneid@redhat.com>
 <20220923155542.1212814-4-vschneid@redhat.com>
 <YzBtH8s98eTmxaJo@yury-laptop>
Date:   Tue, 27 Sep 2022 17:45:10 +0100
Message-ID: <xhsmhh70s4vhl.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/22 08:00, Yury Norov wrote:
> On Fri, Sep 23, 2022 at 04:55:40PM +0100, Valentin Schneider wrote:
>> +/**
>> + * sched_numa_hop_mask() - Get the cpumask of CPUs at most @hops hops away.
>> + * @node: The node to count hops from.
>> + * @hops: Include CPUs up to that many hops away. 0 means local node.
>> + *
>> + * Requires rcu_lock to be held. Returned cpumask is only valid within that
>> + * read-side section, copy it if required beyond that.
>> + *
>> + * Note that not all hops are equal in distance; see sched_init_numa() for how
>> + * distances and masks are handled.
>> + *
>> + * Also note that this is a reflection of sched_domains_numa_masks, which may change
>> + * during the lifetime of the system (offline nodes are taken out of the masks).
>> + */
>
> Since it's exported, can you declare function parameters and return
> values properly?
>

I'll add a bit about the return value; what is missing for the parameters?

