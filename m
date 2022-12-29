Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF4DA658963
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 05:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiL2EZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 23:25:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiL2EZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 23:25:38 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6F0312635
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 20:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672287937; x=1703823937;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BJXoitm0I+6z4KjMNlveJ7bNygZWeR+fU9YE1uEI6uQ=;
  b=DsH5kBUcRa9lLuZKRRCY1V6FbLpRi65+Rrqp9ZOpSqJJ4VzcSu3XfWmp
   5/Ji69NZdhrIjre/dalmhOb2Up2VUfFIns8FDlXEzbEYimKs9r2WUolwt
   kvVxHO2kyaBFeJoLYLIZFhKTVL1mmN/5tr9lhXnXmllQM9NQJQsek7AzC
   6XPv0XNu6evmocg6FWY26QKP5c7+AY6wj20et8VHezyvJJFP8rsk+HACg
   UKkCVNgmPuHsUEV7NssjBnQp3ZSiOFw6Fu7g5hqpRnjiTzLxgkmCXugFt
   t6E5bgOKdsUSArA2IMb/7YfBl7XKV+yuwz2zeX2J2c3uV7IQZjJ/YVRRk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="304478158"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; 
   d="scan'208";a="304478158"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 20:25:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10574"; a="760843758"
X-IronPort-AV: E=Sophos;i="5.96,282,1665471600"; 
   d="scan'208";a="760843758"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.254.211.143]) ([10.254.211.143])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2022 20:25:35 -0800
Message-ID: <65fe4913-0f05-6b52-191e-d28628dcf2eb@intel.com>
Date:   Thu, 29 Dec 2022 12:25:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails
Content-Language: en-US
To:     Jason Wang <jasowang@redhat.com>,
        Tanmay Bhushan <007047221b@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <772e9fe133f21fa78fb98a2ebe8969efbbd58e3c.camel@gmail.com>
 <CACGkMEv-DradKs+k7AT50jTxO7S3DX-hJf0EQpsUp7WZii49nw@mail.gmail.com>
From:   "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEv-DradKs+k7AT50jTxO7S3DX-hJf0EQpsUp7WZii49nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/28/2022 2:58 PM, Jason Wang wrote:
> On Wed, Dec 28, 2022 at 5:15 AM Tanmay Bhushan <007047221b@gmail.com> wrote:
>>  From 7eae04667ddaac8baa4812d48ef2c942cedef946 Mon Sep 17 00:00:00 2001
>> From: Tanmay Bhushan <007047221b@gmail.com>
>> Date: Tue, 27 Dec 2022 22:02:16 +0100
>> Subject: [PATCH] vdpa: ifcvf: Do proper cleanup if IFCVF init fails
>>
>> ifcvf_mgmt_dev leaks memory if it is not freed before
>> returning. Call is made to correct return statement
>> so memory does not leak. ifcvf_init_hw does not take
>> care of this so it is needed to do it here.
>>
>> Signed-off-by: Tanmay Bhushan <007047221b@gmail.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
Acked-by: Zhu Lingshan <lingshan.zhu@intel.com>

Thanks
>
>> ---
>>   drivers/vdpa/ifcvf/ifcvf_main.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c
>> b/drivers/vdpa/ifcvf/ifcvf_main.c
>> index f9c0044c6442..44b29289aa19 100644
>> --- a/drivers/vdpa/ifcvf/ifcvf_main.c
>> +++ b/drivers/vdpa/ifcvf/ifcvf_main.c
>> @@ -849,7 +849,7 @@ static int ifcvf_probe(struct pci_dev *pdev, const
>> struct pci_device_id *id)
>>          ret = ifcvf_init_hw(vf, pdev);
>>          if (ret) {
>>                  IFCVF_ERR(pdev, "Failed to init IFCVF hw\n");
>> -               return ret;
>> +               goto err;
>>          }
>>
>>          for (i = 0; i < vf->nr_vring; i++)
>> --
>> 2.34.1
>>
>>

