Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B3E6078FA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 15:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiJUN5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 09:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiJUN5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 09:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26CE2623EB
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666360628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2q5UghdetJTCFNO+KrGeJhkMXuDAex77fkM/cP1drys=;
        b=hljublzM5kD9WMytNbxjJ8qAPs7cVQ8UWy0VGGLjPwWehedwhkVwYU/0eHlL31/rMbuYyp
        rW4Nsijr74cS3UxZDPJTJEyEeiNgR9VHmiGXXdo2SvVmibdi5YDvER1u1L3wef9DVzH2YB
        oVxr7SKF68tYfIc7gm2iJMdZ3/A/54g=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-7-5QWhKXNdPPaDMORmvtIECw-1; Fri, 21 Oct 2022 09:57:06 -0400
X-MC-Unique: 5QWhKXNdPPaDMORmvtIECw-1
Received: by mail-qv1-f69.google.com with SMTP id g12-20020a0cfdcc000000b004ad431ceee0so2352366qvs.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 06:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2q5UghdetJTCFNO+KrGeJhkMXuDAex77fkM/cP1drys=;
        b=Nigc47/W+xqjVMP3Rh8Jq0tbmh/yi3Wu38QS/c6RkroP3Btr/PRVekI6/xqqxymuUH
         gPKISoWcB9A16fIRub9Gjec6QBZSYUfj72tDzoefRB44/mVJIFTRKqJrjo3TgtoIL4Qr
         9/hpWnOw3xK0QOPkds3RDssGJOzGKCJ/cy8n0QaAw0O1olrBUBwVAsD8AODGBPQGvYUc
         1lDlZoLkHzfdK/0r80FGNxCoa3PHzyxno2oxLOSx3wWihscHLw6Lk/YvbdzDLTIPRAy6
         nTYSVYDhd3W02hE5boVsHJfl5UUJ+ahCgaALY3j5GxHkjreg6iACooyhIjgt0630eoTr
         87+Q==
X-Gm-Message-State: ACrzQf2ifUDu3xWv+bbTOg5nGmaRvZRAgyh7S06WaT41vKq/ZnqHkw24
        5frHVKlhJPduRyOyFMkrUTSiOR6J68sbLP5uUmnHa2LCDFUoImli7czGoSpsCEGRERQJmLX6P9c
        Jg3zlDerY3H1u19kS7sBIdk08
X-Received: by 2002:a05:622a:4ce:b0:39c:de34:139a with SMTP id q14-20020a05622a04ce00b0039cde34139amr16940549qtx.380.1666360626010;
        Fri, 21 Oct 2022 06:57:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4v459uY24feHKzdWHP9gBPSxTdJJPKDijOa3I8fTBcTkw8L/4QUAe6S/+pR5WP3uHZxL7Sag==
X-Received: by 2002:a05:622a:4ce:b0:39c:de34:139a with SMTP id q14-20020a05622a04ce00b0039cde34139amr16940509qtx.380.1666360625802;
        Fri, 21 Oct 2022 06:57:05 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id c22-20020ac85a96000000b003992448029esm8237194qtc.19.2022.10.21.06.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 06:57:05 -0700 (PDT)
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
In-Reply-To: <Y1KboXN0f8dLjqit@smile.fi.intel.com>
References: <20221021121927.2893692-1-vschneid@redhat.com>
 <20221021121927.2893692-3-vschneid@redhat.com>
 <Y1KboXN0f8dLjqit@smile.fi.intel.com>
Date:   Fri, 21 Oct 2022 14:57:01 +0100
Message-ID: <xhsmhlep9wa8i.mognet@vschneid.remote.csb>
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

On 21/10/22 16:16, Andy Shevchenko wrote:
> On Fri, Oct 21, 2022 at 01:19:26PM +0100, Valentin Schneider wrote:
>> The recently introduced sched_numa_hop_mask() exposes cpumasks of CPUs
>> reachable within a given distance budget, wrap the logic for iterating over
>> all (distance, mask) values inside an iterator macro.
>
> ...
>
>>  #ifdef CONFIG_NUMA
>> -extern const struct cpumask *sched_numa_hop_mask(int node, int hops);
>> +extern const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int hops);
>>  #else
>> -static inline const struct cpumask *sched_numa_hop_mask(int node, int hops)
>> +static inline const struct cpumask *
>> +sched_numa_hop_mask(unsigned int node, unsigned int hops)
>>  {
>> -	if (node == NUMA_NO_NODE && !hops)
>> -		return cpu_online_mask;
>> -
>>      return ERR_PTR(-EOPNOTSUPP);
>>  }
>>  #endif	/* CONFIG_NUMA */
>
> I didn't get how the above two changes are related to the 3rd one which
> introduces a for_each type of macro.
>
> If you need change int --> unsigned int, perhaps it can be done in a separate
> patch.
>
> The change inside inliner I dunno about. Not an expert.
>

That's a rebase fail, this should all be in the first patch, my bad.

