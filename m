Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB098613F20
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 21:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJaUmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 16:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiJaUmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 16:42:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D2F13FAA;
        Mon, 31 Oct 2022 13:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667248926; x=1698784926;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4QXM7gE/uqb6LDcsSHzadVqaBw+7DjxOMt0t6Z5GyVE=;
  b=IvLi9AJ/H7VSJrr/+xGowvnaMQNFovf6qvcdcQnGrQJQ1SdFnoQw3pfd
   qXJIOAJ1O3MoSMfJlz4OAeF1UkzvDObkI9mGV2p83MzHvshTB6GSH3jXX
   eV6M75p4pwfghmLiGqKmznxBbkWUX0+WuiSFO0lb+M9edA6thoUdmeCKd
   14DhYrmVDnfUPpORCz2iYGgk8ECdPjJngV7vFddlG/+3AFkHGbgdRkxUD
   jiDyifim3a5GMPdIwmoJveJm5FrE8Ffie+yqtEQ3zkerAuxbhFac9uA5s
   ljOa8Pwl40qwz8dPSygBHzuppFyH28fGmE3lDG5fG3Fgkepa09p47yiMl
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="307719033"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="307719033"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 13:42:04 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="664922436"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="664922436"
Received: from jfbondi-mobl1.amr.corp.intel.com (HELO [10.212.163.129]) ([10.212.163.129])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 13:42:03 -0700
Message-ID: <ceb5f38d-9006-597d-f1c3-83a92618f966@intel.com>
Date:   Mon, 31 Oct 2022 13:42:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH V2] x86/sgx: Reduce delay and interference of enclave
 release
Content-Language: en-US
To:     Reinette Chatre <reinette.chatre@intel.com>,
        dave.hansen@linux.intel.com, jarkko@kernel.org, tglx@linutronix.de,
        bp@alien8.de, mingo@redhat.com, hpa@zytor.com,
        md.iqbal.hossain@intel.com, haitao.huang@intel.com,
        linux-sgx@vger.kernel.org, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <00efa80dd9e35dc85753e1c5edb0344ac07bb1f0.1667236485.git.reinette.chatre@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <00efa80dd9e35dc85753e1c5edb0344ac07bb1f0.1667236485.git.reinette.chatre@intel.com>
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

On 10/31/22 10:29, Reinette Chatre wrote:
> I do not know if this qualifies as stable material.

I kept this unmarked for stable.  If anyone feels strongly about it,
they're more than welcome to submit it themselves.
