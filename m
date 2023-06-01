Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A03471F04C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjFARI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjFARI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:08:56 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F54DD1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 10:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685639335; x=1717175335;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TR5fGtwRtA3BECP2nBOSsf+c8VaVhidSV/NOHGkaUvg=;
  b=ktQbfnmAJjVVn1EwtZTSv5amOgiQAJHV0lO3TQRLsT9fKtw1wz1Zu94a
   ermI7xPKjXFOequbHCNr4vd5Y8XKF+GLgokkCSFA9C0BGJJw52oGLcXIM
   MdSJHBY2tO+xDp0/s8G2vXp0JZCeXlxfbW39sgggk7d+8xht6zi7ND4fQ
   XipIU0FpUrejgx+cFZBn0XKZK3DSp5QEXDam0zLkJq+DHcPzx94UVuGFS
   EnqfJ88iuf8mPvSXdwFxdC1WSx598cv+Kxo9o1MyVHcVOELT/zntcEOdc
   OTs6GPbbmNIadxMbrALpALKGa+FNoQSnJk6QtUEyBIcXAOQmEC3ykNmWy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358919584"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="358919584"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 10:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657873151"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657873151"
Received: from jdboswor-mobl.amr.corp.intel.com (HELO [10.212.227.45]) ([10.212.227.45])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 10:08:41 -0700
Message-ID: <b6c4347d-bd03-0332-c4a9-9d2a11f17a6a@intel.com>
Date:   Thu, 1 Jun 2023 10:08:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
Content-Language: en-US
To:     Ross Lagerwall <ross.lagerwall@citrix.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
References: <20230530150106.2703849-1-ross.lagerwall@citrix.com>
 <5aae0317-72cf-fc3c-6ce3-7e1fe1d6b699@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <5aae0317-72cf-fc3c-6ce3-7e1fe1d6b699@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/23 09:57, Dave Hansen wrote:
> On 5/30/23 08:01, Ross Lagerwall wrote:
>> Since firmware doesn't indicate the iBFT in the E820, add a reserved
>> region so that it gets identity mapped when running as Dom 0 so that it
>> is possible to search for it. Move the call to reserve_ibft_region()
>> later so that it is called after the Xen identity mapping adjustments
>> are applied.

Oh, and one more thing:

What is the end user visible effect of this problem and of your solution?

Do Xen Dom 0 systems fail to find their boot iSCSI volume and refuse to
boot?  I take it after this patch that they can boot again.
