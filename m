Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5CE6A7725
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 23:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjCAW6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 17:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCAW6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 17:58:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3D44A1ED
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 14:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677711432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2GmVGzE9dg2H8nOmOuNAheynslug9iTn5GFX65axkqE=;
        b=RdUjITZnxnADstDrwJ5ZKfWnkdvyzID8yTTLMsc79o6X7cEZfDenuy6rMzZ35kTKuFIdXS
        ZGRhZtTm9OFxF1RkW001ikz05G8WKAYIIjGyIm4rVqfEunius+fjHZaEi6i8LOyIu6tamT
        IixjvJaK+5XvxyYoF6GV4uY/i8E/TjY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-GsYqupvXN9KmT8VQIWxXvA-1; Wed, 01 Mar 2023 17:57:11 -0500
X-MC-Unique: GsYqupvXN9KmT8VQIWxXvA-1
Received: by mail-qk1-f198.google.com with SMTP id c13-20020a05620a0ced00b007422bf7c4aeso9077964qkj.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 14:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677711430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GmVGzE9dg2H8nOmOuNAheynslug9iTn5GFX65axkqE=;
        b=AMsJ1xlfWOFqzlsd9ICqQZkEl2orrLVpYnA6OeQ0LjjRTNMC+kCONkKP71m20qq8nB
         PDSz4rJR3dqDn5qCOGHqX2HZkt+nPXdoGgLiO08nSrCbM+Liy4sP8ez3+MpVEdn7oAk/
         TUm40/mPKmUYEDwyvl7lTksFfXh5tg8GZy1xTHnDYP69Q+ggwuD47Gv30W9310agyBIG
         1ZuQwJfs8atpdGhRzXajpyIRUJdJRTJrNmATEeupPwP9eBIhR0c8B9s4jsvPDrYzGioi
         6bpPybl3jppxp3WJTCitaxVXmrAw4gyx50UcP5mxwTUfpYxfGKNdU+lIEc4p5CGKMuDn
         ZpUg==
X-Gm-Message-State: AO0yUKXfbs/FV5ARVQKJ7v2j1sSAmZ8wYFGa2teSMKd7JT36HYgZ0eAx
        QAEY1Fgc6jvxU8wjuRKRwzauoCVag/3FMNzkaswCTGVlnqioMOcSsi0PBPcMQfEfVMpRpeudejM
        31C4+TZfV2dtCd/BXwdtKTX+B
X-Received: by 2002:a05:622a:1ba4:b0:3bf:cc1b:9512 with SMTP id bp36-20020a05622a1ba400b003bfcc1b9512mr14202729qtb.1.1677711430642;
        Wed, 01 Mar 2023 14:57:10 -0800 (PST)
X-Google-Smtp-Source: AK7set93TBGRn5okBxELCZrMoM6GqobKhJyb02BwHut9lHnFowBfdKMI7m3T+/Bn8GWrR/4BHTjzBA==
X-Received: by 2002:a05:622a:1ba4:b0:3bf:cc1b:9512 with SMTP id bp36-20020a05622a1ba400b003bfcc1b9512mr14202715qtb.1.1677711430341;
        Wed, 01 Mar 2023 14:57:10 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id 14-20020a05620a040e00b006fbb4b98a25sm9597056qkp.109.2023.03.01.14.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Mar 2023 14:57:09 -0800 (PST)
Date:   Wed, 1 Mar 2023 17:57:08 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 09/11] mm/vmstat: use cmpxchg loop in cpu_vm_stats_fold
Message-ID: <Y//YREMSErJjiSzh@x1n>
References: <20230209150150.380060673@redhat.com>
 <20230209153204.873999366@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230209153204.873999366@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 12:01:59PM -0300, Marcelo Tosatti wrote:
>  /*
> - * Fold the data for an offline cpu into the global array.
> + * Fold the data for a cpu into the global array.
>   * There cannot be any access by the offline cpu and therefore
>   * synchronization is simplified.
>   */
> @@ -906,8 +906,9 @@ void cpu_vm_stats_fold(int cpu)
>  			if (pzstats->vm_stat_diff[i]) {
>  				int v;
>  
> -				v = pzstats->vm_stat_diff[i];
> -				pzstats->vm_stat_diff[i] = 0;
> +				do {
> +					v = pzstats->vm_stat_diff[i];
> +				} while (!try_cmpxchg(&pzstats->vm_stat_diff[i], &v, 0));

IIUC try_cmpxchg will update "v" already, so I'd assume this'll work the
same:

        while (!try_cmpxchg(&pzstats->vm_stat_diff[i], &v, 0));

Then I figured, maybe it's easier to use xchg()?

I've no knowledge at all on cpu offline code, so sorry if this will be a
naive question.  But from what I understand this should not be touched by
anyone else.  Reasons:

  (1) cpu_vm_stats_fold() is only called in page_alloc_cpu_dead(), and the
      comment says:
  
	/*
	 * Zero the differential counters of the dead processor
	 * so that the vm statistics are consistent.
	 *
	 * This is only okay since the processor is dead and cannot
	 * race with what we are doing.
	 */
	cpu_vm_stats_fold(cpu);

      so.. I think that's what it says..

  (2) If someone can modify the dead cpu's vm_stat_diff, what guarantees it
      won't be e.g. boosted again right after try_cmpxchg() / xchg()
      returns?  What to do with the left-overs?

Thanks,

-- 
Peter Xu

