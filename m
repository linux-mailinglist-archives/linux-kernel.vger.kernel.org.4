Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E7C6DDB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjDKNCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230249AbjDKNCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:02:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA6045256;
        Tue, 11 Apr 2023 06:02:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4ECFD75;
        Tue, 11 Apr 2023 06:02:24 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5089D3F6C4;
        Tue, 11 Apr 2023 06:01:39 -0700 (PDT)
Date:   Tue, 11 Apr 2023 14:01:36 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v2 0/2] Allow parameter in smc/hvc calls
Message-ID: <20230411130136.lkblyfg3jaeitzrt@bogus>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230410182058.8949-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410182058.8949-1-quic_nkela@quicinc.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 11:20:56AM -0700, Nikunj Kela wrote:
> Currently, smc/hvc calls are made with parameters set
> to zeros. We are using multiple scmi instances within
> a VM and hypervisor associates a tag with each instance
> and expects the tag in hvc calls from that instance, while
> sharing the same smc-id(func_id) among the instances.
> 
> This patch series introduces new optional dtb bindings which
> can be used to pass parameters to smc/hvc calls.
>

Just to be sure that I understood the problem(as your 2 parameters confused
me), this is just to help hypervisor/secure side to identify the right
channel/shared memory when the same SMC/HVC function id is shared right ?

If that is the case, why can't we just pass the shmem address as the
parameter ? I would like to avoid fragmentation here with every vendor
trying to do different things to achieve the same.

I would just change the driver to do that. Not sure if it breaks any existing
implementation or not. If it does, we can add another compatible to identify
one needing this fixed(shmem address) as additional parameter.

Does that make sense at all ? Or am I missing some/all of the requirements
here ?

-- 
Regards,
Sudeep
