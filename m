Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15D65E5896
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 04:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiIVCa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 22:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIVCay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 22:30:54 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38DAFABF0C;
        Wed, 21 Sep 2022 19:30:53 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MXzfn15J7zMpQl;
        Thu, 22 Sep 2022 10:26:09 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:30:51 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 22 Sep 2022 10:30:50 +0800
Message-ID: <3af017ce-87fb-168d-9ef0-60c7a43487a3@huawei.com>
Date:   Thu, 22 Sep 2022 10:30:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] ACPI: PCC: fix Tx done interface in handler
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <huangdaode@huawei.com>
References: <20220920094500.11283-1-lihuisong@huawei.com>
 <20220920094500.11283-3-lihuisong@huawei.com>
 <20220921154319.bsczh2nftuypeucs@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20220921154319.bsczh2nftuypeucs@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/9/21 23:43, Sudeep Holla 写道:
> On Tue, Sep 20, 2022 at 05:45:00PM +0800, Huisong Li wrote:
>> A error, "Client can't run the TX ticker", is printed even if PCC command
>> executed successfully. This root cause is that PCC handler calls
>> 'mbox_client_txdone()' which depands on the client can received 'ACK'
>> packet. But PCC handler detects whether the command is complete through
>> the Tx ACK interrupt. So this patch fix it.
>>
> Thanks for fixing this. Someone mentioned about the error and it was in
> my TODO list.
Great minds think alike😁
>
> I would prefer to reword the subject and commit message as below:
> "
> ACPI: PCC: Fix Tx acknowledge in the PCC address space handler
>
> Currently, mbox_client_txdone() is called from the PCC address space
> handler and that expects the user the Tx state machine to be controlled
> by the client which is not the case and the below warning is thrown:
>
>    | PCCT: Client can't run the TX ticker
>
> Let the controller run the state machine and the end of Tx can be
> acknowledge by calling mbox_chan_txdone() instead.
> "
Thank you for your suggestion. I will fix it in V2.
> With that:
>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
>
