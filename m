Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C558691042
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 19:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBISYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 13:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBISYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 13:24:43 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18156031A
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 10:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675967082; x=1707503082;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eMqFJ7oEmEOMllyFxzTKk3m3PKmx25kcttt/uJcv9ic=;
  b=XBGSBUm8iHUD8uv7BtqiF5O1tXoauPUoJ++pRjxW51nglBdFjl18kZLA
   ++nENKBpWQVpYRcUBXO9oIRV9VgzzOaEj2vmlES3BsWUM7UNkBHoNxyIx
   aPEa07zp4Lw088Pzq4ptJpwKcRHFGycZZH+1CjQxUc0+IZq6Dyc3vqKf0
   6ygB6Vg4En3VeYDt+8FN6QI3AKKTZ9V6JSfSQWQVrH2R925LnSoZR7Vb6
   NrCfeaeJHkZ8TG1YolRrgTpn7jWgeBMNnR25uSAp78kIUWINLOfJbWAZf
   4wWKyxIR3gvq/gJo87j0qYLTGBQ2rA5NdEns1dVD9yEyA8E5TxUxysF2B
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="357604460"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="357604460"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 10:24:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10616"; a="776579097"
X-IronPort-AV: E=Sophos;i="5.97,284,1669104000"; 
   d="scan'208";a="776579097"
Received: from fpastor-mobl4.amr.corp.intel.com (HELO [10.212.74.130]) ([10.212.74.130])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2023 10:24:41 -0800
Message-ID: <b198c88a-7735-1d27-4086-97e9cc38ae8d@linux.intel.com>
Date:   Thu, 9 Feb 2023 12:24:41 -0600
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
 <f956351e-de37-062b-c02e-5cbdf9a3bdfd@linux.intel.com>
 <8fb08ac8-13ae-cd87-869e-34af894407e8@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <8fb08ac8-13ae-cd87-869e-34af894407e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>>>>> Wait for Fifo to be empty before going to suspend or before bank
>>>>> switch happens. Just to make sure that all the reads/writes are done.
>>>>
>>>> For the suspend case that seems like a valid approach, but for bank
>>>> switch don't we already have a bus->msg_lock mutex that will prevent
>>>> the
>>>> bank switch command from being sent before the other commands are
>>>> handled?
>>>
>>> All read/writes are fifo based, so writes could be still pending.
>>
>> I am not following. The bank switch happens with this function, where a
>> mutex is taken.
>>
>> int sdw_transfer(struct sdw_bus *bus, struct sdw_msg *msg)
>> {
>>     int ret;
>>
>>     mutex_lock(&bus->msg_lock);
>>
>>     ret = sdw_transfer_unlocked(bus, msg);
> 
> Qualcomm controller uses fifo to read/write, so return after writing to
> fifo might not always indicate that write is completed.
> 
> Qcom Soundwire controller do not have any synchronous interrupt
> mechanism to indicate write complete.

Ack, I forgot that one. Might be worth a comment or reworded commit message?
