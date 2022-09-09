Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35545B3CB8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 18:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiIIQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiIIQLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 12:11:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EB3FA6AA
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 09:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662739911; x=1694275911;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R7uldPIxQTD99q9iPRRhNcQ5enqGBJMtDCznMl2iRNE=;
  b=Tr7UWzu81Xib/jQICErXnxaFWVL5fPIxfu8vsPWFLhr6CMAnsY9RcjvU
   6PfM8poKRLmc9S3SLud8V1PfrADrwC0YkEcFBvbfqa+eR4XxLU3shnfhp
   6vM94BXczHgYfCRSbCOIq8iNRZ7pooS5UcgDvFV0gIGeAg/t6r/B6X8sU
   H/0r7kUzYA2m7tV9ZLvzEBzNouSGpSSDIP0EqVAw+6Rak6rQkxAyhStXJ
   IGXGynf9sVBm49dLmISslGNwzBYpfsIClVcSyF4ZKZeoE9TYarTHdCfTm
   5h5gW5PtqUvhQxGsK6NlGNWag29hWt+RlPdpjF+BHK0Or0kcRvpIMe5B7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10465"; a="298849762"
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="298849762"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 09:11:17 -0700
X-IronPort-AV: E=Sophos;i="5.93,303,1654585200"; 
   d="scan'208";a="611101556"
Received: from schen9-mobl.amr.corp.intel.com ([10.212.177.99])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2022 09:11:16 -0700
Message-ID: <c14415f18273d134665819bb0d43b1c99b88030c.camel@linux.intel.com>
Subject: Re: [PATCH v5 2/2] ipc/msg: mitigate the lock contention with
 percpu counter
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiebin Sun <jiebin.sun@intel.com>, akpm@linux-foundation.org,
        vasily.averin@linux.dev, shakeelb@google.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, ebiederm@xmission.com,
        legion@kernel.org, manfred@colorfullife.com,
        alexander.mikhalitsyn@virtuozzo.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com
Date:   Fri, 09 Sep 2022 09:11:16 -0700
In-Reply-To: <20220909203636.2652466-3-jiebin.sun@intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
         <20220909203636.2652466-1-jiebin.sun@intel.com>
         <20220909203636.2652466-3-jiebin.sun@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-09-10 at 04:36 +0800, Jiebin Sun wrote:
> The msg_bytes and msg_hdrs atomic counters are frequently
> updated when IPC msg queue is in heavy use, causing heavy
> cache bounce and overhead. Change them to percpu_counter
> greatly improve the performance. Since there is one percpu
> struct per namespace, additional memory cost is minimal.
> Reading of the count done in msgctl call, which is infrequent.
> So the need to sum up the counts in each CPU is infrequent.
> 
> Apply the patch and test the pts/stress-ng-1.4.0
> -- system v message passing (160 threads).
> 
> Score gain: 3.99x
> 
> CPU: ICX 8380 x 2 sockets
> Core number: 40 x 2 physical cores
> Benchmark: pts/stress-ng-1.4.0
> -- system v message passing (160 threads)

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

> 
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> ---
> 

