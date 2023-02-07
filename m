Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B803268D436
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 11:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjBGKab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 05:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbjBGKaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 05:30:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C330279AD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 02:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675765759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XeNNXdPHcFQFjrDCbOR/TvrpskWkdGBwv23ZwvAwhAQ=;
        b=UO1XhJhXp+IJnTNYshZK7vZUjvRg8lX5ss+Vj6mhVrFdSndq7ai4ZcnnsiI8HuZ4pCpSHy
        +tXdM3RwIqatATEs7sx2Knd78dY/Q58q6UGr+xrs1L0LHAaOC6rbXGHZmpUGwvNwXavP3a
        OdVE18GWpHVPbI/k5L9une1bM4jIUMM=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-416-K3YDBfrfMOmUy2qgzfdV7A-1; Tue, 07 Feb 2023 05:29:18 -0500
X-MC-Unique: K3YDBfrfMOmUy2qgzfdV7A-1
Received: by mail-qt1-f200.google.com with SMTP id g2-20020ac870c2000000b003b9c8ab53e9so8164599qtp.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 02:29:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeNNXdPHcFQFjrDCbOR/TvrpskWkdGBwv23ZwvAwhAQ=;
        b=KMvfiDnOyzURJ9iqKjlg1kLoeT5D6wB50lXUsCEqSW6F0TN8V93o9ZKC/19rfpgD30
         gj7tUEXqkdrQp4t5aWsZKjC4CsQ6D/uIY81n6X37z2r/v61MVACR2viZpbb29iKID5X+
         0J9IfhKQqMPLUDstC6jnZlm5ZhYgQVFbkej86dFL9FtIyM5P2OcYIXkMuEhwUxpRZB/U
         oN7pQ6+D2TEx4mlIisU12gXcm6AVGxEFXx+pBUKQfSDmYuTfOfos4mAKFCcRoAbN0lvi
         cvAsLN+fJWhQ0qmPFDkuJKUiPt23ns5RZEKhRnrdA9dV/rEZudJfJXQAYK0YKWPNbAL5
         ZOJw==
X-Gm-Message-State: AO0yUKWw6uJiBvec47CtPho1eLgIEoSdjNENTvpUYN1J1KWVREg7Zu9U
        au0zp4MVOqbHJa5T1qkx4T6ujFL7PMrXHUp8LNJWQEvfdscugidU2SVxJtsXMHbq/sdNcTPb1Hg
        kOB7QiMNLhLxf/BS0g5/LOKnp
X-Received: by 2002:a05:6214:628:b0:568:d153:823a with SMTP id a8-20020a056214062800b00568d153823amr3751774qvx.15.1675765757637;
        Tue, 07 Feb 2023 02:29:17 -0800 (PST)
X-Google-Smtp-Source: AK7set9BUnmZ40Hqit30IPBlDyN9DB7QZjcW+HxvsM96EkuqWD4++1pq7itmtw1eDdcYnxruJSbEJA==
X-Received: by 2002:a05:6214:628:b0:568:d153:823a with SMTP id a8-20020a056214062800b00568d153823amr3751745qvx.15.1675765757393;
        Tue, 07 Feb 2023 02:29:17 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id r6-20020a05620a03c600b00702d1c6e7bbsm8958153qkm.130.2023.02.07.02.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 02:29:16 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Barry Song <baohua@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Gal Pressman <gal@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haniel Bristot de Oliveira <bristot@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Peter Lafreniere <peter@n8pjl.ca>,
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
Subject: Re: [PATCH 3/9] sched: add sched_numa_find_nth_cpu()
In-Reply-To: <20230206210943.79e01af9@kernel.org>
References: <20230121042436.2661843-1-yury.norov@gmail.com>
 <20230121042436.2661843-4-yury.norov@gmail.com>
 <20230206210943.79e01af9@kernel.org>
Date:   Tue, 07 Feb 2023 10:29:12 +0000
Message-ID: <xhsmh4jrxsr9j.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/23 21:09, Jakub Kicinski wrote:
> On Fri, 20 Jan 2023 20:24:30 -0800 Yury Norov wrote:
>> The function finds Nth set CPU in a given cpumask starting from a given
>> node.
>>
>> Leveraging the fact that each hop in sched_domains_numa_masks includes the
>> same or greater number of CPUs than the previous one, we can use binary
>> search on hops instead of linear walk, which makes the overall complexity
>> of O(log n) in terms of number of cpumask_weight() calls.
>
> Valentin, would you be willing to give us a SoB or Review tag for
> this one?  We'd like to take the whole series via networking, if
> that's okay.

Sure, feel free to add

  Reviewed-by: Valentin Schneider <vschneid@redhat.com>

to patches that don't already have it.

