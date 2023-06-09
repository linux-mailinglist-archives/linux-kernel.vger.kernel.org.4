Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908B1729E22
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241241AbjFIPQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239903AbjFIPQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:16:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA9E1BEB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686323765; x=1717859765;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WsfbXnCcsa4TSM5XB3U7xjDRRc9X6Hu2PjNqEmPgRBA=;
  b=ZJgTb/F63hvnMBTMB2BI4v+Rke/DKzLKfk5yyo9KwBDTKvT4D+AiudZD
   2W3PNAyKGKkpBwR9XI0ehVwICpKOGC9TEukzK65kM/Qbp3irxrFfxkPbJ
   TahPsp+WRcLejkeMn51C0sXm6Ybhq3n0mjuoVhKDRNF7Q3UkEiB1947jh
   22OxXR7OVPBSB3Ay7hzmVc2GsDlw3/mH5WdwFwxgAT4zWgxcwCLTiR+Kn
   r70+AWHUlBXniqg8bKHKIDoXc25iS0K7ez5W33zCJIl+dW1fJVOFVx3yZ
   n4FwKXvGUaW34xylmtkpZnB95N+dFryWvmE4RSLgqdCzUlQkjkbSR3hnt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="337978239"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="337978239"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:16:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10736"; a="740198658"
X-IronPort-AV: E=Sophos;i="6.00,229,1681196400"; 
   d="scan'208";a="740198658"
Received: from mdeisher-mobl3.amr.corp.intel.com (HELO [10.212.149.144]) ([10.212.149.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2023 08:16:02 -0700
Message-ID: <2e28fcdb-f0ff-dca4-3dc4-34b11cc7e469@intel.com>
Date:   Fri, 9 Jun 2023 08:16:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
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
References: <20230605102840.1521549-1-ross.lagerwall@citrix.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230605102840.1521549-1-ross.lagerwall@citrix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 03:28, Ross Lagerwall wrote:
> The result of these changes is that it is possible to boot a diskless
> Xen + Dom0 running off an iSCSI disk whereas previously it would fail to
> find the iBFT and consequently, the iSCSI root disk.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com> # for x86

The work in this patch seems pretty evenly split between x86 and iSCSI.
Any preferences on who picks it up?
