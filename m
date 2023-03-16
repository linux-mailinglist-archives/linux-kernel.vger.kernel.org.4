Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9425B6BCAD5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjCPJaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbjCPJ3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:29:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 06AEE49897
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:29:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D37C2F4;
        Thu, 16 Mar 2023 02:30:29 -0700 (PDT)
Received: from bogus (unknown [10.57.52.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46D833F67D;
        Thu, 16 Mar 2023 02:29:43 -0700 (PDT)
Date:   Thu, 16 Mar 2023 09:29:10 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org,
        conor.dooley@microchip.com, ionela.voinescu@arm.com,
        Pierre.Gondois@arm.com, Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arch_topology: Clear LLC sibling when cacheinfo
 teardown
Message-ID: <20230316092910.doolw3xiuwwakile@bogus>
References: <20230314075345.1325187-1-suagrfillet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314075345.1325187-1-suagrfillet@gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 03:53:45PM +0800, Song Shuai wrote:
> The teardown of CPUHP_AP_BASE_CACHEINFO_ONLINE now only invokes
> free_cache_attributes() to clear share_cpu_map of cacheinfo list.
> At the same time, clearing cpu_topology[].llc_sibling is
> called quite late at the teardown code in hotplug STARTING section.
>
> To avoid the incorrect LLC sibling masks generated, move its clearing
> right after free_cache_attributes().
>

Technically in terms of flow/timing this is correct. However I would like
to know if you are seeing any issues without this change ?

Technically, if a cpu is hotplugged out, the cacheinfo is reset first
and then the topology. Until the cpu is removes, the LLC info in the
topology is still valid. Also I am not sure if anything gets scheduled
and this LLC info is utilised once the teardown of CPUHP_AP_BASE_CACHEINFO_ONLINE
has started.

So I am trying to understand if we really need this change. Please let me
know if I am missing anything here.

-- 
Regards,
Sudeep
