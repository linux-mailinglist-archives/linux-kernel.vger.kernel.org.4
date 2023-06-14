Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5865772FF87
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 15:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244831AbjFNNKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 09:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244455AbjFNNKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 09:10:18 -0400
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA671BE8;
        Wed, 14 Jun 2023 06:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1686748217; x=1718284217;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IaVCMsTsgBXgcxaR6Mk8JuSrSs/kMPQ7cemUYFW/TgY=;
  b=VF/LLFRRq6cb3E30vLf5LChBVBa/dmIFe462b1KsOkqiVA9CkGyhR/6V
   fody9NOkWePdlDn05e6yqEFmTxndg239vxrtAGYamm2RCYdt5l1IDSToH
   R6iZWnEcC9b86UYEL3VhPYZGKgq6M7ZRAAFAD08VthwudGwpReFpwef4n
   A=;
X-IronPort-AV: E=Sophos;i="6.00,242,1681171200"; 
   d="scan'208";a="10081887"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 13:10:15 +0000
Received: from EX19MTAUEC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 3461D4679E;
        Wed, 14 Jun 2023 13:10:12 +0000 (UTC)
Received: from EX19D028UEC003.ant.amazon.com (10.252.137.159) by
 EX19MTAUEC002.ant.amazon.com (10.252.135.253) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 14 Jun 2023 13:10:12 +0000
Received: from [10.95.176.26] (10.95.176.26) by EX19D028UEC003.ant.amazon.com
 (10.252.137.159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 14 Jun
 2023 13:10:10 +0000
Message-ID: <4c4178a1-1050-ced4-e6fb-f95c3bdefc98@amazon.com>
Date:   Wed, 14 Jun 2023 09:10:08 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: Observing RCU stalls in kernel 5.4/5.10/5.15/6.1 stable trees
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "Bhatnagar, Rishabh" <risbhat@amazon.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sashal@kernel.org" <sashal@kernel.org>, <abuehaze@amazon.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <12c6f9a3-d087-b824-0d05-0d18c9bc1bf3@amazon.com>
 <c4724b40-89f6-5aa7-720d-c4a4af57cf45@amazon.com>
 <2023061428-compacter-economic-b648@gregkh>
 <20230614092045.tNY8USjq@linutronix.de>
From:   Luiz Capitulino <luizcap@amazon.com>
In-Reply-To: <20230614092045.tNY8USjq@linutronix.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.95.176.26]
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D028UEC003.ant.amazon.com (10.252.137.159)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-06-14 05:20, Sebastian Andrzej Siewior wrote:
  
> 
> 
> On 2023-06-14 11:14:49 [+0200], gregkh@linuxfoundation.org wrote:
>> Oops, missed this.
>>
>> Yes, there might be, can you do 'git bisect' and track down the patch
>> that fixed this?
> 
> There was a report of a lockup during boot in VMs yesterday. If I
> remember correctly this still exists and might be related to this
> report. I'm going to have a look.

Thanks, Sebastian. Do you have a link for the discussion?

- Luiz
