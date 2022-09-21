Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022FD5C01EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:43:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiIUPne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiIUPnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:43:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D722CE00E;
        Wed, 21 Sep 2022 08:43:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E83F13D5;
        Wed, 21 Sep 2022 08:43:29 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DBC83F73D;
        Wed, 21 Sep 2022 08:43:21 -0700 (PDT)
Date:   Wed, 21 Sep 2022 16:43:19 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, rafael.j.wysocki@intel.com,
        wanghuiqiang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH 2/2] ACPI: PCC: fix Tx done interface in handler
Message-ID: <20220921154319.bsczh2nftuypeucs@bogus>
References: <20220920094500.11283-1-lihuisong@huawei.com>
 <20220920094500.11283-3-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920094500.11283-3-lihuisong@huawei.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 05:45:00PM +0800, Huisong Li wrote:
> A error, "Client can't run the TX ticker", is printed even if PCC command
> executed successfully. This root cause is that PCC handler calls
> 'mbox_client_txdone()' which depands on the client can received 'ACK'
> packet. But PCC handler detects whether the command is complete through
> the Tx ACK interrupt. So this patch fix it.
>

Thanks for fixing this. Someone mentioned about the error and it was in
my TODO list.

I would prefer to reword the subject and commit message as below:
"
ACPI: PCC: Fix Tx acknowledge in the PCC address space handler

Currently, mbox_client_txdone() is called from the PCC address space
handler and that expects the user the Tx state machine to be controlled
by the client which is not the case and the below warning is thrown:

  | PCCT: Client can't run the TX ticker

Let the controller run the state machine and the end of Tx can be
acknowledge by calling mbox_chan_txdone() instead.
"

With that:

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
