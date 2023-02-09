Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F21A690E61
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:34:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjBIQd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjBIQd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:33:56 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866C95CBCF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 08:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675960432; x=1707496432;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UCrVKBB8il7rlSBFVYB2c+lqqWNUhI97u5OeRJ7I8Bo=;
  b=dcZEEak/Zr+sdkpkwI1uvQe1cjLBCH9FPCZTq6OTtOuwP/Bd00oV/ytn
   mg76lgoj9TBezEfDnumlieu/QkXHAE/6/gfGRqY0js05vx9mWsyxVZrS/
   VTvZ8cp97RLHZtk5ibIDN6I+5GizdVTTfhUoSaZEAy1Dyl7MLA9L4umUw
   p+KL7JkviRg1kaay/EGQPk8AVA8FG1nYvXjo3UiH3xnH33yxcT6DKzEq4
   0g266WCp40UlI1JXmQJ25qfvjCSlkudGEtYaos90/GTu1lX7dV4HhUa24
   1rcgd//YtTpetnG3+VSTg93uvFMCDimEUBM79+pb9ChkHI9OMyxCjpjd9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="309801415"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="309801415"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 08:33:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="756471334"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="756471334"
Received: from fpastor-mobl4.amr.corp.intel.com (HELO [10.212.74.130]) ([10.212.74.130])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 08:33:51 -0800
Message-ID: <f956351e-de37-062b-c02e-5cbdf9a3bdfd@linux.intel.com>
Date:   Thu, 9 Feb 2023 10:33:50 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [PATCH 3/5] soundwire: qcom: wait for fifo to be empty before
 suspend
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, steev@kali.org,
        johan+linaro@kernel.org, quic_bjorande@quicinc.com
References: <20230209131336.18252-1-srinivas.kandagatla@linaro.org>
 <20230209131336.18252-4-srinivas.kandagatla@linaro.org>
 <dbec6aab-6456-72b3-39b6-3490dfdf083c@linux.intel.com>
 <a1d79008-3ec4-d7b5-12b5-ea5c6c5a8370@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <a1d79008-3ec4-d7b5-12b5-ea5c6c5a8370@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/9/23 09:52, Srinivas Kandagatla wrote:
> 
> 
> On 09/02/2023 15:23, Pierre-Louis Bossart wrote:
>>
>>
>> On 2/9/23 07:13, Srinivas Kandagatla wrote:
>>> Wait for Fifo to be empty before going to suspend or before bank
>>> switch happens. Just to make sure that all the reads/writes are done.
>>
>> For the suspend case that seems like a valid approach, but for bank
>> switch don't we already have a bus->msg_lock mutex that will prevent the
>> bank switch command from being sent before the other commands are
>> handled?
> 
> All read/writes are fifo based, so writes could be still pending.

I am not following. The bank switch happens with this function, where a
mutex is taken.

int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
{
	int ret;

	mutex_lock(&bus->msg_lock);

	ret = sdw_transfer_unlocked(bus, msg);

	mutex_unlock(&bus->msg_lock);

	return ret;
}

The transfer_unlocked is synchronous and waits for the command response
to be available.

In other words, there's both a mutual exclusion and a synchronous
behavior, so not sure how commands *before* the bank switch could be
pending?
