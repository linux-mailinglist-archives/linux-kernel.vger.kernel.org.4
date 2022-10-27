Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122ED6105C4
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 00:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235511AbiJ0WaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 18:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235235AbiJ0WaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 18:30:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B659239B9D;
        Thu, 27 Oct 2022 15:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666909818; x=1698445818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aoEiDTixrd3ldXf8sFLDxcEUQVB0T8uPkSk7p3cWyos=;
  b=fT+ok3WwaC4B1DFtAJd6jZmjkxNCql/+i73VjE4RbohhfM/2ziR8njS0
   pHamCQG/R6nL4b9Yd17vUpYyqUEd1HGzlairgGdLCPqaMRtvsOKMhHxTD
   jKyxC5qkm/muobd3BoGxr6ImGqOjJ0LR6qFb53LdEVjXMxQ5QLsH8O4RR
   Gz5VvfSrQUJDyHuAEVaG3T0ZW2m4CZG/XBsQJqgmhaqzqpP/vQNH52Sie
   /ADKb71rOO9FENLD5snp7maoFs0I/KQf5htXa24dX0o2qark9yfdQx2E9
   R7LzQ/pRon/WeYHCv9aY2JW1a0r6KLmaEKiLtPnQQ44tKbU8foyQSY0+u
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="394670487"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="394670487"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 15:30:17 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10513"; a="701518893"
X-IronPort-AV: E=Sophos;i="5.95,219,1661842800"; 
   d="scan'208";a="701518893"
Received: from vstelter-mobl.amr.corp.intel.com (HELO [10.212.214.108]) ([10.212.214.108])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2022 15:30:16 -0700
Message-ID: <235f4f04-b2ae-4a7f-043b-1cd6a85bd8ea@intel.com>
Date:   Thu, 27 Oct 2022 15:30:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] x86: intel_epb: Set Alder Lake N and Raptor Lake P normal
 EPB
Content-Language: en-US
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, rafael@kernel.org,
        len.brown@intel.com
Cc:     peterz@infradead.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20221027220056.1534264-1-srinivas.pandruvada@linux.intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20221027220056.1534264-1-srinivas.pandruvada@linux.intel.com>
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

So, the tl;dr on this is:

	The EPB setting is fundamentally a classic power vs. performance
	knob.  This change helps power a bunch (200+mw) while having a
	negligible performance impact (<1% if that), so it's a great
	trade-off.

Right?
