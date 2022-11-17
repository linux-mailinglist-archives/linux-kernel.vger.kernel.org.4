Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D5962DA9A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbiKQMY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239697AbiKQMYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:24:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68A024F3D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668687832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5jdvVC382FTzq1UHx+dqms0RlcCWrWtt69iT+pMSrhc=;
        b=Zcn30s6mzHo2TA2845EVihGK7vA5Dp9MKdZXfGilcuB6FGDDuYtLgWGz1WFZcjTGZKklnD
        2jkG9Ap4TgoS+EGcsBnkoQC/og7AmoHvNrEnGMOM9wPmqoqqJ7EDLOFGx/n5PK9xejdqoH
        5BiyJ+NDBxVVP4oQBxAnxSkqEhTMCaQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-ZaW5yNJWOvKv4Wg8BV20nQ-1; Thu, 17 Nov 2022 07:23:51 -0500
X-MC-Unique: ZaW5yNJWOvKv4Wg8BV20nQ-1
Received: by mail-wr1-f72.google.com with SMTP id d10-20020adfa34a000000b00236616a168bso633419wrb.18
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 04:23:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5jdvVC382FTzq1UHx+dqms0RlcCWrWtt69iT+pMSrhc=;
        b=5D7V3DpbqwV9qV7wliA4/vjCuT/DEJzKf18W+BKOnViPwFw2mMcNRYgOTps34uA26a
         RSYGX5N51pV9v8QXnq62FKzV0XpY4RAbjk1gmtA0eu5JkylTgfpLhSbpfaLESGeyjR14
         2iVG+LhKbEJXaZUPHGTWSL+o/ULqShwmNZMQNEb0E3RgzGgaa7hyk5qksMgz5UTXnUPx
         wJ5M1O5EhTFqvYSGryj4btByPrea7AJygpMo4nKVUD3Hc8NvwpZq9KbReEppei+U+eU4
         u5ImqFx5mXQXzC08HImIldU8JBBzOGkpcpec/xn3q+bVPg7bweP6aP+oQdPnW5R67e/b
         Lc6g==
X-Gm-Message-State: ANoB5plTxCwsz0wnLMHDQco1Vy0H+KFfEFFtSJe6bFs4ktmMd7T1NHUM
        PzqNidq9wXEr+jHbmBu62xM7retAGYYEDiHUCFNyIzrfJ8G6oSgE6/ejaGzDof8PsAgroWCi+vm
        TOoJwB8icFo0OQkCKKy/tNRN3
X-Received: by 2002:a5d:4ace:0:b0:236:7988:b282 with SMTP id y14-20020a5d4ace000000b002367988b282mr1368733wrs.341.1668687830285;
        Thu, 17 Nov 2022 04:23:50 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6CQ2UnPStDreGkKJNcXcxnxWYWv26PNS2guHgtGUV1HlDKjg+B2zZNBBQjpHdL/U5XI5rkiQ==
X-Received: by 2002:a5d:4ace:0:b0:236:7988:b282 with SMTP id y14-20020a5d4ace000000b002367988b282mr1368719wrs.341.1668687830120;
        Thu, 17 Nov 2022 04:23:50 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id r4-20020a05600c35c400b003c6b874a0dfsm1315337wmq.14.2022.11.17.04.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 04:23:49 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Barry Song <baohua@kernel.org>,
        Ben Segall <bsegall@google.com>,
        haniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gal Pressman <gal@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Tariq Toukan <ttoukan.linux@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/4] cpumask: improve on cpumask_local_spread() locality
In-Reply-To: <Y3PXw8Hqn+RCMg2J@yury-laptop>
References: <20221112190946.728270-1-yury.norov@gmail.com>
 <xhsmh7czwyvtj.mognet@vschneid.remote.csb> <Y3PXw8Hqn+RCMg2J@yury-laptop>
Date:   Thu, 17 Nov 2022 12:23:45 +0000
Message-ID: <xhsmho7t5ydke.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/22 10:32, Yury Norov wrote:
> On Tue, Nov 15, 2022 at 05:24:56PM +0000, Valentin Schneider wrote:
>>
>> Is this meant as a replacement for [1]?
>
> No. Your series adds an iterator, and in my experience the code that
> uses iterators of that sort is almost always better and easier to
> understand than cpumask_nth() or cpumask_next()-like users.
>
> My series has the only advantage that it allows keep existing codebase
> untouched.
>

Right

>> I like that this is changing an existing interface so that all current
>> users directly benefit from the change. Now, about half of the users of
>> cpumask_local_spread() use it in a loop with incremental @i parameter,
>> which makes the repeated bsearch a bit of a shame, but then I'm tempted to
>> say the first point makes it worth it.
>>
>> [1]: https://lore.kernel.org/all/20221028164959.1367250-1-vschneid@redhat.com/
>
> In terms of very common case of sequential invocation of local_spread()
> for cpus from 0 to nr_cpu_ids, the complexity of my approach is n * log n,
> and your approach is amortized O(n), which is better. Not a big deal _now_,
> as you mentioned in the other email. But we never know how things will
> evolve, right?
>
> So, I would take both and maybe in comment to cpumask_local_spread()
> mention that there's a better alternative for those who call the
> function for all CPUs incrementally.
>

Ack, sounds good.

> Thanks,
> Yury

