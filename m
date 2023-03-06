Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3711B6AC2C2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjCFOOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjCFON7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:13:59 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57B130E9D
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 06:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678111916; x=1709647916;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xi3v3QeGd/ATW5ctLs8lAraHaVUyWzURxJ/YHdmzh00=;
  b=nsFbU1ayWZMtAAPFSVosUulpRsVPQiHpLxDHHIa2vRubAWbzq363LmQL
   AJlHCWdZjF/Xb0/jb5sL9WCDIDVTT3MyGQvUAFzOAEJ2G5g7xoVOsallP
   GzE/ws5RzLA1Ucy6Vam41UftVff9qQazcgWWLBihmivmpns5G2Un3I+DM
   TJICaaKTdIUCnhxzpwCBfHZCozXwJZSZFsl6T9zs+Bqvi2MLKmiAq5e/z
   WxAkGNzbntuu6FF5QXk5watIqtldHGLqeCi8nETHahXKbXRfhMJUTobcq
   6TKwyQGNIAWTC5ntm7h3UJGPGXB45rGUiPynypCcf0+m+USclrKnf1wrQ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="334274190"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="334274190"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 06:08:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="786246698"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="786246698"
Received: from skechkar-mobl1.ger.corp.intel.com (HELO [10.213.236.73]) ([10.213.236.73])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 06:08:49 -0800
Message-ID: <84228e23-7d16-ce4f-9b75-9afb9633f9c2@intel.com>
Date:   Mon, 6 Mar 2023 06:08:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] x86/mm: fix __swp_entry_to_pte() for Xen PV guests
Content-Language: en-US
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230306123259.12461-1-jgross@suse.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <20230306123259.12461-1-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 04:32, Juergen Gross wrote:
> Fixes: 05289402d717 ("mm/debug_vm_pgtable: add tests validating arch helpers for core MM features")
> Signed-off-by: Juergen Gross <jgross@suse.com>

This looks sane.  Any reason this shouldn't be cc:stable@?
