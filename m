Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCB968204B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 01:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjAaABI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 19:01:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjAaAAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 19:00:52 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DE62ED70;
        Mon, 30 Jan 2023 16:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675123220; x=1706659220;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WUwUPxlnqbiRmgDhKOibNerjH9tu78jzKFyyYvm0Dns=;
  b=ahNoGFSQZ6IVRlNnLiFYdmH1erqTcOlikz2ncAWDdt4F27oEV7rLg3W/
   VHXVwTq/y3t5WRCKUjmAEG1Ly2MMrA4QyWEMPK0zmRENQsfNydwPAGZUz
   E1/JWyyamNLFp50NDeVO5nLSVlxwI3RNiApIouMkFjOnTKJzn+dL7isO9
   ryJ9jfZz/VYU9hdlOYYYu1ptcz+mRjgIHDcmGlsuPuD71LOmyeHRhHzit
   glzqoTXBLP5JTDYacRXj4jmryGaatffYBIK3+UXcMqld6xxI1kgykD3Pn
   jKETZB5o2lifY82gl3IH+fV6a5ZipIHkrSBhALYaU2nB33AUHHoGj1izx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="327726719"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="327726719"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 16:00:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="614227920"
X-IronPort-AV: E=Sophos;i="5.97,259,1669104000"; 
   d="scan'208";a="614227920"
Received: from inuber-mobl5.amr.corp.intel.com (HELO [10.212.58.60]) ([10.212.58.60])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 16:00:18 -0800
Message-ID: <ebf8ebed-ef79-bf18-4635-360f916877a6@linux.intel.com>
Date:   Mon, 30 Jan 2023 17:59:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [RFC PATCH v2 09/22] ASoC: qcom: qdsp6: Introduce USB AFE port to
 q6dsp
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
 <20230126031424.14582-10-quic_wcheng@quicinc.com>
 <dea77277-6971-fe27-1ae0-ed551e84b6e4@linux.intel.com>
 <5dec443d-9894-2d06-1798-c56b8f2e1e5e@quicinc.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <5dec443d-9894-2d06-1798-c56b8f2e1e5e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/23 16:54, Wesley Cheng wrote:
> Hi Pierre,
> 
> On 1/26/2023 7:38 AM, Pierre-Louis Bossart wrote:
>>
>>
>> On 1/25/23 21:14, Wesley Cheng wrote:
>>> The QC ADSP is able to support USB playback endpoints, so that the main
>>> application processor can be placed into lower CPU power modes.  This
>>> adds
>>> the required AFE port configurations and port start command to start an
>>> audio session.
>>>
>>> Specifically, the QC ADSP can support all potential endpoints that are
>>> exposed by the audio data interface.  This includes, feedback endpoints
>>> (both implicit and explicit) as well as the isochronous (data)
>>> endpoints.
>>> The size of audio samples sent per USB frame (microframe) will be
>>> adjusted
>>> based on information received on the feedback endpoint.
>>
>> I think you meant "support all potential endpoint types"
>>
>> It's likely that some USB devices have more endpoints than what the DSP
>> can handle, no?
>>
> 
> True, as we discussed before, we only handle the endpoints for the audio
> interface.  Other endpoints, such as HID, or control is still handled by
> the main processor.

The number of isoc/audio endpoints can be larger than 1 per direction,
it's not uncommon for a USB device to have multiple connectors on the
front side for instruments, mics, monitor speakers, you name it. Just
google 'motu' or 'rme usb' and you'll see examples of USB devices that
are very different from plain vanilla headsets.

>> And that brings me back to the question: what is a port and the
>> relationship between port/backend/endpoints?
>>
>> Sorry for being picky on terminology, but if I learned something in days
>> in standardization it's that there shouldn't be any ambiguity on
>> concepts, otherwise everyone is lost at some point.
>>
> 
> No worries, I can understand where you're coming from :).  After
> re-reading some of the notations used, I can see where people may be
> confused.
> 
>>
>>>   static struct afe_port_map port_maps[AFE_PORT_MAX] = {
>>> +    [USB_RX] = { AFE_PORT_ID_USB_RX, USB_RX, 1, 1},
>>>       [HDMI_RX] = { AFE_PORT_ID_MULTICHAN_HDMI_RX, HDMI_RX, 1, 1},
>>>       [SLIMBUS_0_RX] = { AFE_PORT_ID_SLIMBUS_MULTI_CHAN_0_RX,
>>>                   SLIMBUS_0_RX, 1, 1},
>>
>> And if I look here a port seems to be a very specific AFE concept
>> related to interface type? Do we even need to refer to a port in the USB
>> parts?
>>
> 
> Well, this is a design specific to how the Q6 AFE is implemented.  There
> is a concept for an AFE port to be opened.  However, as mentioned
> earlier, the "port" term used in soc-usb should be more for how many USB
> devices can be supported.
> 
> If there was a case the audio DSP would support more than one USB
> device, I believe another AFE port would need to be added.


would the suggested infrastructure work though, even if the DSP could
deal with multiple endpoints on different devices ? You have static
mutexes and ops, can that scale to more than one USB device?
