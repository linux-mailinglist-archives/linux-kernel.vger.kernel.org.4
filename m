Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2C1625CDB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiKKOWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiKKOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:21:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8001645ECF;
        Fri, 11 Nov 2022 06:14:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 322781FB;
        Fri, 11 Nov 2022 06:14:13 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57C313F73D;
        Fri, 11 Nov 2022 06:14:05 -0800 (PST)
Date:   Fri, 11 Nov 2022 14:14:02 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, rafael.j.wysocki@intel.com,
        wanghuiqiang@huawei.com, zhangzekun11@huawei.com,
        wangxiongfeng2@huawei.com, tanxiaofei@huawei.com,
        guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH V2 2/2] mailbox: pcc: fix 'pcc_chan_count' when fail to
 initialize PCC
Message-ID: <20221111141402.7cun26euzubpesjs@bogus>
References: <20221110015034.7943-1-lihuisong@huawei.com>
 <20221111024448.25012-1-lihuisong@huawei.com>
 <20221111024448.25012-3-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111024448.25012-3-lihuisong@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change $subject as
"mailbox: pcc: Reset pcc_chan_count to zero in case of PCC probe failure"

On Fri, Nov 11, 2022 at 10:44:48AM +0800, Huisong Li wrote:
> Currently, 'pcc_chan_count' is a non-zero value if PCC subspaces are parsed
> successfully and subsequent processes is failure during initializing PCC
> process. This may cause that pcc_mbox_request_channel() can still be
> executed successfully , which will misleads the caller that this channel is
> available.
>

I would reword this something like:
"Currently, 'pcc_chan_count' is remains set to a non-zero value if PCC
subspaces are parsed successfully but something else fail later during
the initial PCC probing phase. This will result in pcc_mbox_request_channel()
trying to access the resources that are not initialised or allocated and
may end up in a system crash.

Reset pcc_chan_count to 0 when the PCC probe fails in order to prevent
the possible issue as described above.
"

> Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe")

Other than that,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
