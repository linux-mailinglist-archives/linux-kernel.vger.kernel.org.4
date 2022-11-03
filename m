Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7860618796
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 19:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiKCSdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 14:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiKCSdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 14:33:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8921E3D8;
        Thu,  3 Nov 2022 11:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667500344; x=1699036344;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=wJHxXMwz4IGhtwnDctSuhSAsogpPRrGlQTB5IUCB9qY=;
  b=AMNB2kIxDDfjVn6Di7viAutuZ8lmjof7O9lHqQzZlk4FC/W5vZdg1t2D
   oWNjOescAib+ynRhy5tu3yoRqwnFdbFz2gxuXDxuErOf2+tq4q5Fnahnb
   lVdQSuGgEvlaqTy3rns2tq/fQtLGtrAXEFaBnzYT2yqO/qlNqV6bnlAnz
   Qq4x9OQVXjLbdU+i1rVWJk2d3Gh0VFqPVo/x4FTDQn8HKlwXBmeRXmcvr
   qd0GN3nzd7l1SEcJ4JCMQCIIwNt7H1f9VLju87IIX3uhUCxOR+/97SDmO
   5SG5cxxT+relbVtLjOv0dP4Qbebqk4xZQ5AcDcqkJJ/pPZRyFanb0A4tB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="308485913"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="308485913"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 11:32:24 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="777414886"
X-IronPort-AV: E=Sophos;i="5.96,134,1665471600"; 
   d="scan'208";a="777414886"
Received: from btoolex-mobl.amr.corp.intel.com (HELO [10.209.95.24]) ([10.209.95.24])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 11:32:23 -0700
Message-ID: <2bee4f6a-5f25-eee1-471b-f1c4f94c3877@intel.com>
Date:   Thu, 3 Nov 2022 11:32:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86: intel_epb: Set Alder Lake N and Raptor Lake P normal
 EPB
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        dave.hansen@linux.intel.com, bp@alien8.de
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        len.brown@intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        x86@kernel.org
References: <20221027220056.1534264-1-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0hVaO-j6PEZ0u+uz==0it3qvZ8XdkrXk4F2x692OfgBcQ@mail.gmail.com>
 <CAJZ5v0gMgq+=WvzL8yiKr6AW9+dGb9w5uVOYjthC6a1HJRXMOQ@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAJZ5v0gMgq+=WvzL8yiKr6AW9+dGb9w5uVOYjthC6a1HJRXMOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/22 11:25, Rafael J. Wysocki wrote:
> I'm wondering if there are any plans to pick up this one into the x86
> tree?  If not, I can take care of it.

I'll bump it up to the front of the queue. :)

Thanks for the reminder.
