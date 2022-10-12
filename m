Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30E55FC710
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbiJLONd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 10:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJLON3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 10:13:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1085CAA3E1;
        Wed, 12 Oct 2022 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665584009; x=1697120009;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w1F+xH3uOCNR/MUIW2In9TBDA4726uxIeG/UuOzJlbs=;
  b=LL2zKKWRjrCgvCAh4jh0MlatfffH3mtIHSpLu4zJKXdVFXl3hyDQq60a
   aRFZjWSeBuX74W1L9kbB0NFV91Ph1jex1yskwNjid1e111SSF/psosu8t
   SCu5byMTD3Qo0V5sixz/s3sieFSiXEcUYhjAtzkbRKzYwNvuCop7CgqPo
   BTnovh73Y4KEw9yUPrqnH4YAgDICNwGhTWARhKVClTZMY3BNT8UIbQnQ4
   UMkeNJdfmX0TZrzU9vTCt2FuBuM2E1gTXqjR+xOyWp8E8b4lKRZjyR7x3
   GS8+Gz+AAl++Yu9JKuCdljLcKGjjLE3OdRsS88yYLNeXun5mxRPRxFWl3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="391108756"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="391108756"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 07:13:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10497"; a="769223030"
X-IronPort-AV: E=Sophos;i="5.95,179,1661842800"; 
   d="scan'208";a="769223030"
Received: from mpatter1-mobl.amr.corp.intel.com (HELO [10.209.53.34]) ([10.209.53.34])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2022 07:13:26 -0700
Message-ID: <711f8036-787a-571e-1c0d-1a258175ebb2@intel.com>
Date:   Wed, 12 Oct 2022 07:13:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
References: <20220929160647.362798-1-kristen@linux.intel.com>
 <Y0BEV+Xgkrln8xoh@iweiny-desk3> <Y0ZphugZZBhlv/vT@kernel.org>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <Y0ZphugZZBhlv/vT@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/22 00:15, Jarkko Sakkinen wrote:
> There's no data to show that this change would be useful to do.

Jarkko, I think the overall transition to kmap_local_page() is a good
one.  It is a superior API and having it around will pave the way for
new features.  I don't think we should demand 'data' for each and every
one of these.

Please take a look around the tree and see how other maintainers are
handling these patches.  They're not limited to SGX.
