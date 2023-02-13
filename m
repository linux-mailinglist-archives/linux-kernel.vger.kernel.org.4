Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA54694AFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjBMPW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjBMPWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:22:53 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E796E9E;
        Mon, 13 Feb 2023 07:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676301771; x=1707837771;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=o1K01OkpQ3fIZqS1M8k1+ZQBGAiuytgzdT2n9GoXrQg=;
  b=ApbWcszGGl/1KhrUcBSMTxROd7QfHUjfGPcVTiXOZedVlU5jzDTLgmUT
   sIRSAE9HYDuKtjj5qGUHRVRQNnHjBP49te4ZqZ6tSuf0EcTXdu1xeTF8C
   82Rc84UC0TGxI0O3OuF8MC2tXSuHWrsUgaQlOOYVk9FgcOZ5g7QDsIjuK
   8H2akh1mTLeySnwUw6+/g5bbvVhjtp1hjYUIERiZXDVjApB1G9K7C+rR+
   AZ5Kj6zFAP3jUD2hiOxjcEDH7nCf78PtO23FM1utBp2gt1Pyr4DSZFu5j
   HIDi6Ju/LSpwpUoX3Pu+4NKUQaYF4PjKluB9PtVtzs46nF6KftN09cH+N
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="332220160"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="332220160"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 07:22:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10620"; a="737547368"
X-IronPort-AV: E=Sophos;i="5.97,294,1669104000"; 
   d="scan'208";a="737547368"
Received: from eatoledo-mobl.amr.corp.intel.com (HELO [10.212.18.132]) ([10.212.18.132])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 07:22:49 -0800
Message-ID: <2c398ffb-6dd8-d43a-f99c-2033519a36be@linux.intel.com>
Date:   Mon, 13 Feb 2023 09:22:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.7.1
Subject: Re: [RFC PATCH v2 20/22] sound: usb: Prevent starting of audio stream
 if in use
Content-Language: en-US
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
 <b532bf7b-e1fb-3a9d-1b88-02f3159be47d@linux.intel.com>
 <60e42db4-1bbc-beea-d87d-6f93871b70c7@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <60e42db4-1bbc-beea-d87d-6f93871b70c7@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/11/23 03:52, Wesley Cheng wrote:
> Hi Pierre,
> 
> On 2/7/2023 5:29 AM, Pierre-Louis Bossart wrote:
>>
>>
>> On 2/6/23 19:15, Wesley Cheng wrote:
>>> Hi Pierre,
>>>
>>> On 1/26/2023 8:12 AM, Pierre-Louis Bossart wrote:
>>>>
>>>>
>>>> On 1/25/23 21:14, Wesley Cheng wrote:
>>>>> With USB audio offloading, an audio session is started from the ASoC
>>>>> platform sound card and PCM devices.  Likewise, the USB SND path is
>>>>> still
>>>>> readily available for use, in case the non-offload path is
>>>>> desired.  In
>>>>> order to prevent the two entities from attempting to use the USB bus,
>>>>> introduce a flag that determines when either paths are in use.
>>>>>
>>>>> If a PCM device is already in use, the check will return an error to
>>>>> userspace notifying that the stream is currently busy.  This ensures
>>>>> that
>>>>> only one path is using the USB substream.
>>>>
>>>> It's good to maintain mutual exclusion, but it's still very hard for an
>>>> application to figure out which card can be used when.
>>>>
>>>> Returning -EBUSY is not super helpful. There should be something like a
>>>> notification or connection status so that routing decisions can be made
>>>> without trial-and-error.
>>>>
>>>
>>> The USB offload driver does have access to the USB substream that is
>>> being utilized/offloaded.  Maybe in addition to this check, we can also
>>> set the PCM runtime state as well (for that particular substream)?  That
>>> way userspace can fetch information about if the stream is busy or not.
>>
>> You're missing the point. When a card is exposed but the PCM devices may
>> or may not be usable (consuming data with no sound rendered or returning
>> an error), it's much better to provide a clear connection status to
>> userspace.
>>
>> Let me give you an example. Intel drivers can expose 3 HDMI/DP PCM
>> devices. Userspace has no idea which one to use, so there's a jack
>> control that tells userspace whether there is a receiver connected so
>> that the audio server can use the relevant PCM device.
>>
>> Audio routing based on trial and error is really problematic, errors can
>> happen but they should be exceptional (e.g. xruns), not a means of
>> driver-userspace communication on the device status.
> 
> Thanks for clarifying.  The example helped me understand a bit more on
> how the potential use of the SND control interface.  Since we're dealing
> with multiple sound cards here (platform sound card (offload) and USB
> SND card (legacy)), what do you think about creating a SND control on
> both the USB backend (platform card) and the USB SND card listing the
> PCM device status?
> 
> That way at least userspace can have the information about which PCM dev
> (USB substream) is available (and not offloaded, or vice versa).  So the
> USB SND control will contain the PCM devices (exposed by the card) and
> if any are offloaded (if so mark them as unavailable).  Likewise, for
> the USB backend, if the legacy path is being used, mark them as
> unavailable for offloading.

We definitively need a control to indicate that a PCM offload device is
available or not.
There's still a very large open with the notion of having separate cards
for the same audio device. Not only would it duplicate the control parts
for e.g. volume control, but it would introduce the need to tag devices
across two cards are being the same physical device.
I still think the least-bad option is to have a single card and an
optional PCM device for offload.
