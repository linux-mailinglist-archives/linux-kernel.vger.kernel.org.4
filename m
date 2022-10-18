Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0832B603105
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJRQuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 12:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiJRQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 12:50:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A14050B8B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666111806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7Tm5JCAIMhjvmiBFpFhEHwWPITj0JcQocFbip2mfREU=;
        b=Sc0JA5g6QvUlwQ07fZTUqp1uoCYAZkL67/VIyRarBCNTCSyuhWFixBMU3xgXpFawk0/CJZ
        Yrea/w3b5ZodMkrymzYJ+NPFuRp8H1euv1U8DI2TuIQTtvoARB7whmN7OfV3BqFQOJE/MT
        tp/KV900pytmFmoApvTtHmUsBG3ASfw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-619-pF0AdDZBOoi9TwPXu_IW_A-1; Tue, 18 Oct 2022 12:50:05 -0400
X-MC-Unique: pF0AdDZBOoi9TwPXu_IW_A-1
Received: by mail-qk1-f200.google.com with SMTP id j13-20020a05620a410d00b006e08208eb31so12631020qko.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 09:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Tm5JCAIMhjvmiBFpFhEHwWPITj0JcQocFbip2mfREU=;
        b=DJBFhYtvuuSLUE2as0JFGD34hZRJ9Xa8lIUZaVr9KDiULirKo9JMe21FD53EfZwJgd
         rTIvBsCgRAZn1ylgeaR2qsox9H5fKH1mrt8+mJT0yeYurV3byIELy1GOzj3412Qc6Pa3
         UGLChaTcJzv0qvWnJ4MpKUOiQ31XAjVmEJKwYEKh6a0eBC69RWSTIWjiEcearmKyWCsy
         wX1fRwf+JH+6tbZOYLBLkQy8etGKb6NQRaP6TJsrK4Xg1thUndRY4wODnOauj2ziEHXS
         ORLDDxB6u0tf6bIp59/N6aIQM/66HVAaSOu0lNse5hxjKBzOctX51Yoq1s5+9SZFmgF+
         iVTw==
X-Gm-Message-State: ACrzQf2rzprwvgEKToQiEjuPjEalkFL3gByA/gkxi+S7y4/LAr7sO8h3
        2jZuQO1BMKxbbAWQvMMWdr+DN1Q6frPoZj8JtDS12tv90T0JDWVbaX7AtlIn2qiE1rvlhONwtKK
        LmK2Ktlozsq/R9QGMUciyfzS5
X-Received: by 2002:a05:6214:27ec:b0:4b2:1337:a442 with SMTP id jt12-20020a05621427ec00b004b21337a442mr2965301qvb.20.1666111804507;
        Tue, 18 Oct 2022 09:50:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM4U4uK6OVhT20CLjACsP21+jL2yR6/slxJzsjXi33DwcqiXKPhbECIEjn4iYNxKMsyfPadJCw==
X-Received: by 2002:a05:6214:27ec:b0:4b2:1337:a442 with SMTP id jt12-20020a05621427ec00b004b21337a442mr2965272qvb.20.1666111804336;
        Tue, 18 Oct 2022 09:50:04 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id j5-20020ac874c5000000b0039ccd7a0e10sm2171918qtr.62.2022.10.18.09.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 09:50:03 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tariq Toukan <ttoukan.linux@gmail.com>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yury Norov <yury.norov@gmail.com>,
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
Subject: Re: [PATCH v4 0/7] sched, net: NUMA-aware CPU spreading interface
In-Reply-To: <07a034cf-507a-e4ad-d78c-e5dd5a8d98b5@gmail.com>
References: <20220923132527.1001870-1-vschneid@redhat.com>
 <07a034cf-507a-e4ad-d78c-e5dd5a8d98b5@gmail.com>
Date:   Tue, 18 Oct 2022 17:50:00 +0100
Message-ID: <xhsmhwn8xvzyf.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/22 09:36, Tariq Toukan wrote:
>
> Hi,
>
> What's the status of this?
> Do we have agreement on the changes needed for the next respin?
>

Yep, the bitmap patches are in 6.1-rc1, I need to respin the topology ones
to address Yury's comments. It's in my todolist, I'll get to it soonish.

> Regards,
> Tariq

