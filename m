Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D11654567
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 17:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiLVQ5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 11:57:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiLVQ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 11:57:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474BE15A3D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671728174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k/3du/op7s2XwFWnzrxCbjJ5sahmXWbdc2/voSAdWto=;
        b=CPXFfuFMmE/IvbXuoYb9FNJk7V0JpWM2zjzFq1BKtp0e4i4lkhiuz7P4SF5imUpUS1pVnp
        gnD9WujITD9hfKly4kTqASq8x3agn9cOzACH88IPSIHEK+EYmw1xp4EoxgwZsYVEsJh9rE
        KP4wF38LHfY+Vtt6dftO+lQpYVpxrNY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-488-7DQtwwODPjmkMlkb5TasIw-1; Thu, 22 Dec 2022 11:56:13 -0500
X-MC-Unique: 7DQtwwODPjmkMlkb5TasIw-1
Received: by mail-wr1-f70.google.com with SMTP id j29-20020adfb31d000000b0024237066261so609749wrd.14
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 08:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k/3du/op7s2XwFWnzrxCbjJ5sahmXWbdc2/voSAdWto=;
        b=ijDyxiHNZ42j6stKtJO7kzfSNmMeVyWFB1X8WMP76AQhALjw2eK558HHOjsQO7fvEw
         1/JKjyRfN4w3WVJUojTbqetXcKsUJi72ix5l8p4b8wFPhDAirOuWp2lvsCAr19WBng87
         VODFq+VXnXBm2Wh6pKJIRb1F+q/c1wKcNZHHp0B1PXVRFqCZtHjB6f4KovlbmNhTjyAJ
         +ksApzgQrqG4nBhJuxcBDL97rAJKJoygu8u9PvR5CQUF0S8oP0t20ZWzzzdBFNvW2zBB
         PzGXcVVxSlULVaSvgky0Wc479NK8h2rRmU+BMSueIheU3HWRJIsHn0UDbqLpffXV/jkC
         SatA==
X-Gm-Message-State: AFqh2ko0khJcRUU6MikJvKQuMpYrSJESIGBTVsV5wZu2Vz6KbouIOxrP
        P4th6uu8ntrlJRgoCk+pkelY/4xZ/u6OSWtexmagX76diY70kFejZXAp0klz5qLHersvJhSBqSx
        geY82Qu2JxGpvj1i5XCepgI1f
X-Received: by 2002:a05:600c:250:b0:3d2:2043:9cbf with SMTP id 16-20020a05600c025000b003d220439cbfmr4851716wmj.10.1671728172059;
        Thu, 22 Dec 2022 08:56:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv4xgkg7KLH/hiCUKBDZiFlN4DrDAD2ZA/UncwoAvgYxklIzMidtoPS7acqKoDcVCRrc9wXfw==
X-Received: by 2002:a05:600c:250:b0:3d2:2043:9cbf with SMTP id 16-20020a05600c025000b003d220439cbfmr4851708wmj.10.1671728171866;
        Thu, 22 Dec 2022 08:56:11 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id n25-20020a7bc5d9000000b003d969a595fbsm1595610wmk.10.2022.12.22.08.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 08:56:11 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, "Tim C . Chen" <tim.c.chen@intel.com>
Subject: Re: [PATCH v2 3/7] sched: Teach arch_asym_cpu_priority() the idle
 state of SMT siblings
In-Reply-To: <20221222045505.GB407@ranerica-svr.sc.intel.com>
References: <20221122203532.15013-1-ricardo.neri-calderon@linux.intel.com>
 <20221122203532.15013-4-ricardo.neri-calderon@linux.intel.com>
 <e7d6c19b-593d-acfd-35af-73b1840be276@arm.com>
 <20221212175433.GB27353@ranerica-svr.sc.intel.com>
 <72ed59b5-c7e1-c425-d1b6-e8d703d11d7a@arm.com>
 <20221222045505.GB407@ranerica-svr.sc.intel.com>
Date:   Thu, 22 Dec 2022 16:56:10 +0000
Message-ID: <xhsmhtu1ne5sl.mognet@vschneid.remote.csb>
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

On 21/12/22 20:55, Ricardo Neri wrote:
> On Wed, Dec 21, 2022 at 06:12:52PM +0100, Dietmar Eggemann wrote:
>> Imagine an arch w/ SD_ASYM_PACKING on SMT & MC overwriting
>> arch_asym_cpu_priority(). `bool check_smt` wouldn't be sufficient to
>> know whether a call to something like sched_smt_siblings_idle()
>> (is_core_idle()) which iterates over cpu_smt_mask(cpu) would make sense.
>
> Agreed. I was hoping I could get away with this. x86 would not have the
> the SD_ASYM_PACKING flag at the SMT level and Power7 would ignore
> `check_smt`. :)
>
> Callers of sched_asym_prefer() could use the flags of the sched domain to
> check if we are at the SMT level.
>
> I rescanned the code again and it looks like the needed sched domain flags
> are available in all the places sched_asym_prefer() is called. The only
> exception is asym_smt_can_pull_tasks(), but we already know that we don't
> need such check. (We are looking for the sched group priority, regardless
> of the idle state of the SMT siblings).
>

Given this is fed back to arch code, another option here would be to feed
the topology level this is happening at. You get it via sd->level and it
maps back into the arch's sched_domain_topology_level array.

Though the SD flags are probably the more generic solution.

