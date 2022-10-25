Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A3F60C27E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 06:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJYEKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 00:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiJYEKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 00:10:36 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33086123446;
        Mon, 24 Oct 2022 21:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666671033; x=1698207033;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZS+45Sls2VK+isFAisa0bARRPNlVfCiz5TAilPgxfu0=;
  b=ZUh9j5CLKTueRqwO/uK8yG8WtawKsxiKZrVgwmpzM1EqDHVP0Ki48Rox
   DM8SSwRkLEQY0x8DQtij1p18ntf7o9LCUHdKiFtBOwAisWMEqBGTf7kLt
   jwW1T5CZO/6MzOviiiMOX6OrrmjppZvl8IE7qNPvzGrH3N7WGxXNP6wOc
   e98Fy5RXXjfZk5c4VokbvAhAWQWRkp8E4IpnlqD7Wm1/VMlGqx10EEEM7
   bCG50XweHIajcPtnxqtabjQaKP2z2lNR2fdXTw3JrWaaNfvJAwr6n3Bw1
   N7bPvc4aOxHKosX6uoPDTl6bS6zcQQ1B2fYfMX8Z3rBKZ/Y1dJV2jhwv9
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287980087"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="287980087"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 21:10:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="609432991"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="609432991"
Received: from csun9-mobl.amr.corp.intel.com (HELO [10.209.104.152]) ([10.209.104.152])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 21:10:24 -0700
Message-ID: <7db9c3a5-2120-5ede-eb4e-077e3ed6c1f7@intel.com>
Date:   Mon, 24 Oct 2022 21:10:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V3] x86/split_lock: Add sysctl to control the misery mode
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>,
        Andre Almeida <andrealmeid@igalia.com>
References: <20221024200254.635256-1-gpiccoli@igalia.com>
 <Y1dcDmmIu8gSX4Rb@debian.me>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y1dcDmmIu8gSX4Rb@debian.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/24/22 20:46, Bagas Sanjaya wrote:
> The prose can be improved:

I'm not sure that's a universal improvement.  It chops out some valuable
context.
