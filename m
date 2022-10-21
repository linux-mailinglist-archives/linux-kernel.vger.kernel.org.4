Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24723607935
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 16:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiJUOHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 10:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbiJUOHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 10:07:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB1027B083
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666361225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3QGZu1yFvyf6/rAbNjced6K1/QFYwLbCoSzwaCS4YJw=;
        b=UQ6d3f1bLiXRSuHhKB9st1L2SNYwn5fhiyRqfF0omjQlW18Q/zsjTl8s8eFRh86fj9k/wG
        zhT2rIAOtMrNZTUW1pd+5GAE/FxdfEzJIxAW8hYXqDStZfBDzBE+xlXW9zu9e5EknvK499
        F6uE/f2KCNl8M76Kw49ub2OlpxVlwZM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-223-y63OaO3-NomZumErPuTwCA-1; Fri, 21 Oct 2022 10:07:03 -0400
X-MC-Unique: y63OaO3-NomZumErPuTwCA-1
Received: by mail-qt1-f199.google.com with SMTP id u11-20020a05622a198b00b0039cca1826c8so2586801qtc.11
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 07:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3QGZu1yFvyf6/rAbNjced6K1/QFYwLbCoSzwaCS4YJw=;
        b=ru4KqLnGkfWZYeJhDH70USzXrc+IctzNk2I9gFzAgdCUp0kXX7NEA3ko4v/tNFhOVX
         TxBmdd77w8Gey5c/hWoAK2+Q1CVr5R1txzJV+1BLbqPnqBTLzu49rqtd4vYqWr2KI37j
         QDqwe7z0nfvRCzl1C9hbTLzg4CaJepi7Suzbbcwq3xpHQZQc6lwFR2NO391LAvqd8OQm
         OckUdNojHXsVVAqwvQtTKipaslpWHRflLqd7zrHpWOTzezNMDk2/sAtXWJ+lyI8nvlC6
         rGpG9fdfdTqziEWahu4ZBTJ+UFZdefL9DQGbPVBsxc0MS8yaAdTM3v8pTjtCQvRD9qr2
         SnQg==
X-Gm-Message-State: ACrzQf3Vyd9ldubo+IWoOJwxLnwyzeD9q7W4UHKeV0sVtPJzN7TVXWxN
        knIS4mvHWYLUv3HGrBSU9IMJiVl5vzezbRBOLFmfMDOJ662s/yCclRRUO5bdcVj7Yv886j5rPm+
        OcyMQ1nSC7JmQzX3wWr731YOv
X-Received: by 2002:ac8:5712:0:b0:39c:cd48:25e4 with SMTP id 18-20020ac85712000000b0039ccd4825e4mr16757922qtw.581.1666361211335;
        Fri, 21 Oct 2022 07:06:51 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5PUFH3m6ZTTlU33UA2PdaYuGQE9STy2VAbagGXGo9HRDsPB0Do+jHqX5qJCpNPyjJaSVkgmg==
X-Received: by 2002:ac8:5d49:0:b0:399:c50c:7171 with SMTP id g9-20020ac85d49000000b00399c50c7171mr17149746qtx.564.1666361200452;
        Fri, 21 Oct 2022 07:06:40 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id n12-20020a05620a294c00b006ced5d3f921sm9926015qkp.52.2022.10.21.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 07:06:39 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
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
Subject: Re: [PATCH v5 2/3] sched/topology: Introduce for_each_numa_hop_mask()
In-Reply-To: <Y1Kf+aZPIxGCbksM@smile.fi.intel.com>
References: <20221021121927.2893692-1-vschneid@redhat.com>
 <20221021121927.2893692-3-vschneid@redhat.com>
 <Y1KboXN0f8dLjqit@smile.fi.intel.com>
 <Y1Kf+aZPIxGCbksM@smile.fi.intel.com>
Date:   Fri, 21 Oct 2022 15:06:36 +0100
Message-ID: <xhsmhilkdw9sj.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/10/22 16:34, Andy Shevchenko wrote:
> On Fri, Oct 21, 2022 at 04:16:17PM +0300, Andy Shevchenko wrote:
>> On Fri, Oct 21, 2022 at 01:19:26PM +0100, Valentin Schneider wrote:
>
> ...
>
>> > +#define for_each_numa_hop_mask(mask, node)				     \
>> > +	for (unsigned int __hops = 0;					     \
>> > +	     /*								     \
>> > +	      * Unsightly trickery required as we can't both initialize	     \
>> > +	      * @mask and declare __hops in for()'s first clause	     \
>> > +	      */							     \
>> > +	     mask = __hops > 0 ? mask :					     \
>> > +		    node == NUMA_NO_NODE ?				     \
>> > +		    cpu_online_mask : sched_numa_hop_mask(node, 0),	     \
>> > +	     !IS_ERR_OR_NULL(mask);					     \
>>
>> > +	     __hops++,							     \
>> > +	     mask = sched_numa_hop_mask(node, __hops))
>>
>> This can be unified with conditional, see for_each_gpio_desc_with_flag() as
>> example how.
>
> Something like
>
>       mask = (__hops || node != NUMA_NO_NODE) ? sched_numa_hop_mask(node, __hops) : cpu_online_mask
>

That does simplify things somewhat, thanks!

> --
> With Best Regards,
> Andy Shevchenko

