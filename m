Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED355F6F93
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbiJFUqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiJFUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:45:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2190BE2D7;
        Thu,  6 Oct 2022 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665089157; x=1696625157;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OwJ1ROhRXZmye0Wodpt5I0o6ytjW0KtspOAjyDYbTpc=;
  b=NXodHHbywNd7aDXfMNLCEtHsyk5uQ3CUBS7beOTGOYGqhwctv0c/bFMi
   eTxV+vLwpCJx/dDE19EcA3WMundae/RNtLxLZLmktlf6dTy0yt46RzIgK
   I2jqjWe1wxJKb3ARrVtH7bqkWmFA2QVhMm8r1ybj2h4A6+NQ+xYbzr9S1
   iqQRDB0KdjvNOPK+GLpIP5xvu1NhantgVCjZf8yiS2qyChta/4toggijZ
   V9o8sUcQzfLdIWSgmSkRf53O25TAESxFtoIcR1IqbS7Qr63eusrn8xyCt
   4P4zIxSfK5PkuIm/vgOwXagUV+kyOq3m1IsNDHy8X3gLDJQRB/9twSe39
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="329999364"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="329999364"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 13:45:57 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="655769471"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="655769471"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO [10.212.128.129]) ([10.212.128.129])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 13:45:57 -0700
Message-ID: <d64e6e9f-27b9-9bbb-aaf8-fca1681eada5@intel.com>
Date:   Thu, 6 Oct 2022 13:45:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] x86/sgx: Replace kmap/kunmap_atomic calls
Content-Language: en-US
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-sgx@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Cc:     ira.weiny@intel.com
References: <20220929160647.362798-1-kristen@linux.intel.com>
 <3694452.kQq0lBPeGt@mypc>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <3694452.kQq0lBPeGt@mypc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/22 13:37, Fabio M. De Francesco wrote:
> kmap() were not suited in those cases because it might sleep. If the intents 
> of the author are simply map a page while in atomic, so to avoid sleeping in 
> atomic bugs, your conversions looks good. 
> 
> For the reasons above, can you please say something more about why this code 
> needed a kmap_atomic() instead of calling kmap()?

This question is backwards.  kmap_atomic() is the default that folks
use.  You use kmap_atomic() *always* unless you _need_ to sleep or one
of the other kmap()-only things.

Folks don't and shouldn't have to explain why this was using kmap_atomic().
