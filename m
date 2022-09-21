Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011C85C022F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiIUPtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiIUPsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:48:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D7BE7C316;
        Wed, 21 Sep 2022 08:47:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16A0113D5;
        Wed, 21 Sep 2022 08:47:47 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A7DF3F73D;
        Wed, 21 Sep 2022 08:47:39 -0700 (PDT)
Date:   Wed, 21 Sep 2022 16:47:37 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, rafael.j.wysocki@intel.com,
        wanghuiqiang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH 1/2] ACPI: PCC: replace wait_for_completion()
Message-ID: <20220921154737.az3d4ndxs3u3zwbl@bogus>
References: <20220920094500.11283-1-lihuisong@huawei.com>
 <20220920094500.11283-2-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920094500.11283-2-lihuisong@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 05:44:59PM +0800, Huisong Li wrote:
> Currently, the function waiting for completion of mailbox operation is
> 'wait_for_completion()'.  The PCC method will be permanently blocked if
> this mailbox message fails to execute. So this patch replaces it with
> 'wait_for_completion_timeout()'. And set the timeout interval to an
> arbitrary retries on top of nominal to prevent the remote processor is
> slow to respond to PCC commands.
>

Sounds good to me. The only concern(may be not serious) is what happens
if we receive response from the platform after the timeout. I have tested
for that in non ACPI non PCC context. I don't have a setup to trigger that
with ACPI PCC + this patch to test. Other than that, I am fine with this:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
