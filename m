Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46BC668E389
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjBGWo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBGWo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:44:27 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE95B9EC0;
        Tue,  7 Feb 2023 14:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675809866; x=1707345866;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w4yUWgdrMkSu5h1zXbr5sfr/CirMhN4jXxr0vnH7soA=;
  b=HfO1bJch7urb36Y8969+dlDJjzJG33h4btEq+2Q74gm5aF1+wEJxGWhq
   0xy1m4whevJPOkWbzdj3CZeMzZQqag+0Fu3AjZdS1q88zE9t6dbMtgXCF
   l/d3EY2EI4CDZVQMfKenurSVnlBbnQZ2313G6c3ER7BWqTI26qqGeFPa5
   3iThx4tVsArsSqARBR6Pdi6RAg9btw0r4XUQUd+o9q8Xwx7YsoMxIkwNy
   N/rGoUCtODkCee/Hdy7lDNN2rMH2PQmvbDXLlNvZ7Hf6GlxmaO9bNffSf
   XcytN1lDVwzGomT8AL0AdhINWJH91r/Rmq3fUsKSDyR9ddbZO0igPBMab
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="357027931"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="357027931"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 14:44:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="616981528"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="616981528"
Received: from jinggu-mobl.amr.corp.intel.com (HELO [10.212.120.142]) ([10.212.120.142])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 14:44:23 -0800
Message-ID: <b532bf7b-e1fb-3a9d-1b88-02f3159be47d@linux.intel.com>
Date:   Tue, 7 Feb 2023 07:29:19 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v2 20/22] sound: usb: Prevent starting of audio stream
 if in use
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
        Thinh.Nguyen@synopsys.com, broonie@kernel.org,
        bgoswami@quicinc.com, tiwai@suse.com, robh+dt@kernel.org,
        agross@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-21-quic_wcheng@quicinc.com>
 <557f8f76-38f5-5e07-905e-774e03120bd2@linux.intel.com>
 <b26c9e4c-5a9c-a2ff-19a7-78419c6b81df@quicinc.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <b26c9e4c-5a9c-a2ff-19a7-78419c6b81df@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/23 19:15, Wesley Cheng wrote:
> Hi Pierre,
> 
> On 1/26/2023 8:12 AM, Pierre-Louis Bossart wrote:
>>
>>
>> On 1/25/23 21:14, Wesley Cheng wrote:
>>> With USB audio offloading, an audio session is started from the ASoC
>>> platform sound card and PCM devices.  Likewise, the USB SND path is
>>> still
>>> readily available for use, in case the non-offload path is desired.  In
>>> order to prevent the two entities from attempting to use the USB bus,
>>> introduce a flag that determines when either paths are in use.
>>>
>>> If a PCM device is already in use, the check will return an error to
>>> userspace notifying that the stream is currently busy.  This ensures
>>> that
>>> only one path is using the USB substream.
>>
>> It's good to maintain mutual exclusion, but it's still very hard for an
>> application to figure out which card can be used when.
>>
>> Returning -EBUSY is not super helpful. There should be something like a
>> notification or connection status so that routing decisions can be made
>> without trial-and-error.
>>
> 
> The USB offload driver does have access to the USB substream that is
> being utilized/offloaded.  Maybe in addition to this check, we can also
> set the PCM runtime state as well (for that particular substream)?  That
> way userspace can fetch information about if the stream is busy or not.

You're missing the point. When a card is exposed but the PCM devices may
or may not be usable (consuming data with no sound rendered or returning
an error), it's much better to provide a clear connection status to
userspace.

Let me give you an example. Intel drivers can expose 3 HDMI/DP PCM
devices. Userspace has no idea which one to use, so there's a jack
control that tells userspace whether there is a receiver connected so
that the audio server can use the relevant PCM device.

Audio routing based on trial and error is really problematic, errors can
happen but they should be exceptional (e.g. xruns), not a means of
driver-userspace communication on the device status.
