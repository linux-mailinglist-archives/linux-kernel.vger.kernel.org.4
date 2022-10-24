Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BC560B57E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 20:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbiJXSaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 14:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiJXS3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 14:29:33 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE584DBE4F
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:11:27 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id m6so9549366pfb.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 10:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz6IbE5QNnnx6hJZ/M0UjY5y91KtBmJ2N2+vRHclsWk=;
        b=jMAILx40MPutTId9cA76kdNpd5+IF/jsYoAiCZulvw8X/IP92M1oStkrlS16VnSfHE
         j7vPtpyn3+dYkoIutGCl2biNjkwG6GJsUBlkKeFbPAKhhLJmDonUSwWacbNMAFzAGOLe
         HKFhP+clB4FKX+FPx2dogTaU4amR80AHQWXktxPwUfoSNUFNmuoDVQedUQZGYWECr078
         9+dFJKkzA+OSzYk6VKtO6qtkGRarJCQCViwhdHFJsD6enjGBmSUBl6HEpPWYGvX09Y0z
         w8bloSicoz45EgrizIGo793zb6vvbRzbdCZvfR5zwKNUQKOIQnVndTU1AbiqjtUIILFf
         NaJw==
X-Gm-Message-State: ACrzQf3vuSPyZFMPel5DDMIUih4wJQOhmD7jbI79ad+YatyivvTNqxOp
        Mea4FUCp2Ogm8ec73WY4Da0=
X-Google-Smtp-Source: AMsMyM6+WSzSlEp+quC0KcmnxizQlZQIWdYnzAzRiVq53wrWRx03JpIdIaymZqYO8E/TtoMFvpImfA==
X-Received: by 2002:a05:6a00:1687:b0:565:a932:f05a with SMTP id k7-20020a056a00168700b00565a932f05amr34363733pfc.21.1666631390642;
        Mon, 24 Oct 2022 10:09:50 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090276c700b0017f73caf588sm829plt.218.2022.10.24.10.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 10:09:50 -0700 (PDT)
Date:   Mon, 24 Oct 2022 10:09:47 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, linux-mm@kvack.org
Subject: Re: [PATCH 0/8] Cleanup and optimization patches for percpu
Message-ID: <Y1bG2zlKA+Bb9UbV@fedora>
References: <20221024081435.204970-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024081435.204970-1-bhe@redhat.com>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Oct 24, 2022 at 04:14:27PM +0800, Baoquan He wrote:
> These were found out when reading percpu code, and queued in my local
> branch for long time. Send them out for reviewing.
> 
> Baoquan He (8):
>   mm/percpu: remove unused pcpu_map_extend_chunks
>   mm/percpu: use list_first_entry_or_null in pcpu_reclaim_populated()
>   mm/percpu: Update the code comment when creating new chunk
>   mm/percpu: add comment to state the empty populated pages accounting
>   mm/percpu: replace the goto with break
>   mm/percpu.c: remove the lcm code since block size is fixed at page
>     size
>   mm/percpu: remove unused PERCPU_DYNAMIC_EARLY_SLOTS
>   mm/slub, percpu: correct the calculation of early percpu allocation
>     size
> 
>  include/linux/percpu.h |  7 +++----
>  mm/percpu.c            | 44 +++++++++++++++++-------------------------
>  mm/slub.c              |  3 ++-
>  3 files changed, 23 insertions(+), 31 deletions(-)
> 
> -- 
> 2.34.1
> 
> 

Thanks for the clean ups. The empty page accounting is more subtle than
I remember.


Andrew, I think for these cleanups it'd be easiest for you to pick these
up.

Thanks,
Dennis
