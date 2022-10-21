Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A45A607EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiJUTHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiJUTHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:07:04 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD1C28B1F5;
        Fri, 21 Oct 2022 12:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666379223; x=1697915223;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/EQtWCHFFkeAZlmUk41kUqKtdZ+qGfIDaB7P0+omrmQ=;
  b=WHjjD7m4Dkrb52YAToh3xidj06u7/7vCayG3+rpWaVKiQ2vEx5THzmIH
   LK0HHz6d22nYHLu7abvUQKZqN2jfGa/lUHuN9Vz6iINnPuPBYRAGDqmEB
   A2DgOmtJxeF5dADyp2Y5jPIEP2FMqCOk5RfSzTE2itHGJqsOEj+XCWYsT
   y4mB1YV+Z8de7W0sju4uJ61wSflmoWlgUw6lTtwz/IH1UEV25zwPoz5oS
   7r8GcbebnLf/PCFyIYJ8byicjm5AdMo7IemkG+HFAd38eIWjotzZetXhr
   KtowshtT9fFkfSZHIFhMXUvevqhv0LQJmRhp3/4gqnnRXHkucEsYauhUd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="371299725"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="371299725"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 12:07:01 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="581717074"
X-IronPort-AV: E=Sophos;i="5.95,202,1661842800"; 
   d="scan'208";a="581717074"
Received: from thnguy1-mobl2.amr.corp.intel.com (HELO [10.209.91.210]) ([10.209.91.210])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 12:07:00 -0700
Message-ID: <ad716b6f-3d1a-8aab-b452-2e01769348dd@intel.com>
Date:   Fri, 21 Oct 2022 12:07:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2] x86/split_lock: Add sysctl to control the misery mode
Content-Language: en-US
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Andre Almeida <andrealmeid@igalia.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>
References: <20221014180506.211592-1-gpiccoli@igalia.com>
 <44b41091-d474-9f80-fcf1-93c8d1316272@intel.com>
 <267fb708-9fae-f651-d8c6-e34a873d668f@igalia.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <267fb708-9fae-f651-d8c6-e34a873d668f@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 12:03, Guilherme G. Piccoli wrote:
...
>> 	if (need_release_sem)
>> 		up(...);
>>
>> That's nice and compact.  It's also logically easy to follow because you
>> can see how the need_release_sem gets set only after the
>> down_interruptible().  It's also nice to have both sites share the
>> 'need_release_sem' naming for grepping.
>>
> 
> ...but, this is a very good suggestion, and will eliminate the need for
> two delayed_works, right?

Yes, that too.
