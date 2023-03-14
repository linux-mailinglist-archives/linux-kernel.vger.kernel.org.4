Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA286B872F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 01:45:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCNApI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 20:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjCNApF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 20:45:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213EA738A1;
        Mon, 13 Mar 2023 17:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678754674; x=1710290674;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=90dRWroNclwALb4Ovzwr434NahGpHY4d/uZTBEjQsuM=;
  b=QJsy0XHzmfxgGvfgsbDqapF49+vrSnhvncHP3qYFBllWH5v0apwFLxX3
   f73CfMsYJVQW2NIbEEV7F0ArJUg6gVczmRY+IKwTFl9i3oTexa4HJKetE
   Yap1xB9fmrKYoPpyjrQWIuHZnimEV2pf04kwcVZQAo+LYsQwn2vKARp0O
   OKQPvUOw7eXytclEiTU6UYG/UKF2NA05lxwbUPyN5iTrJ61txjjW00fxs
   /ohx60gjvWokjpFE2KAOpeZ5dnne+kp0Uet/bPCD+GtSPGUyO9nGadGs7
   0IUwO8jwewHVBpP0TL1QtqwqDSwKjGWh+PajSFGFeGpUF8tjO89N/MH9a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="337321170"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="337321170"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 17:42:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="672118652"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="672118652"
Received: from mlhayes-mobl1.amr.corp.intel.com (HELO [10.255.39.159]) ([10.255.39.159])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 17:42:20 -0700
Message-ID: <8a37ccd3-f19e-b30d-d736-04e81b49f3a0@linux.intel.com>
Date:   Mon, 13 Mar 2023 19:42:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v3 00/28] Introduce QC USB SND audio offloading support
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, tiwai@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
 <4f8a66c0-398f-5655-3aa7-a59bc9ba56cc@linux.intel.com>
 <8b2f3ce7-3e0c-bdf0-8d9f-9aeabba09a15@quicinc.com>
 <a211f26d-a045-0729-871f-248d5fce3f3f@linux.intel.com>
 <684daf86-6c3f-7310-eebf-4ebfc3c480ca@quicinc.com>
Content-Language: en-US
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <684daf86-6c3f-7310-eebf-4ebfc3c480ca@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/13/23 18:43, Wesley Cheng wrote:
> Hi Pierre,
> 
> On 3/9/2023 4:37 PM, Pierre-Louis Bossart wrote:
>>
>>>>> Create vendor ops for the USB SND driver:
>>>>> qc_audio_offload: This particular driver has several components
>>>>> associated
>>>>> with it:
>>>>> - QMI stream request handler
>>>>> - XHCI interrupter and resource management
>>>>> - audio DSP memory management
>>>>
>>>> so how does this 'qc_audio_offload' interface with 'q6usb' described
>>>> above? how are the roles different or complementary?
>>>>
>>> So in general you can think that the qc_audio_offload is a complement to
>>> the USB SND USB class driver, while q6usb is to ASoC.  Since the ASoC
>>
>> Humm, that is far from clear. I don't get how a something that interacts
>> with the USB class driver can also be in charge of the audio DSP memory
>> management.
>>
> 
> This is because the USB class driver is the entity which is going to
> work with the USB HCD (XHCI) in this case to fetch the required
> addresses, and map that into memory accessible by the audio DSP.  It
> would be odd to be doing that from the q6usb end, which is part of the
> ASoC layer.
> 
>>> framework doesn't have any communication with USB SND, the ASoC DPCM USB
>>> backend (q6usb) will have to be the entity that maintains what is going
>>> on in USB SND.  That way, sessions initiated through the ASoC managed
>>> sound card can evaluate what is available based on information reported
>>> by q6usb.
>>>
>>> qc_audio_offload and q6usb will have some interaction between each
>>> other.  The majority of communication between qc_audio_offload and q6usb
>>> is reporting the device connection events.
>>
>> It's already complicated to figure out how the DSP and USB class driver
>> might interact and probe/timing dependencies, but with two additional
>> drivers in the mix it's really hard to understand.
>>
> 
> I did test some cases based on existence of both these drivers
> (qc_audio_offload and q6usb).  If either one doesn't exist in the
> system, then the offload path would not work.  I did improve some of
> these potential sequences in the latest revision, such as patch#28. This
> would address scenarios where the q6usb ASoC DPCM backend wasn't probed,
> while the USB SND (and qc_audio_offload) were still detecting device
> connections.
> 
> Once the Q6USB driver is probed, then the offload snd kcontrols would be
> created, and devices would be properly identified with the rediscover api.
> 
>> Maybe ascii-art would help describe the concepts and types of
>> information exchanged. Maintaining a consistent state across multiple
>> drivers is not an easy task.
>>
> 
> Hopefully this might help?  I know its a lot to read through.

It's very helpful! Thanks for spending the time to illustrate the
different building blocks.

> 
>      USB                          |            ASoC
> --------------------------------------------------------------------
>                                   |  _________________________
>                                   | |sm8250 platform card     |
>                                   | |_________________________|
>                                   |         |           |
>                                   |      ___V____   ____V____
>                                   |     |Q6USB   | |Q6AFE    |  #5
>                                   |     |"codec" | |"cpu"    |
>                                   |     |________| |_________|
>                                   |         ^
>                                   |         |  #6
>                                   |      ___V____
>                                   |     |SOC-USB |
>   ________   #1  ________         #7    |        |
>  |USB SND |<--->|QC offld|<------------>|________|
>  |(card.c)|     |        |<----------       ^
>  |________|     |________|___ #4  | |       |
>      ^               ^       |    | |    ___V__________________
>      | #2            |  #2   |    | |   |APR/GLINK             |
>   __ V_______________V_____  |    | |   |______________________|
>  |USB SND (endpoint.c)     | |    | |              ^
>  |_________________________| |    | | #8           |
>              ^               |    | |   ___________V___________
>              | #3            |    | |->|audio DSP              |
>   ___________V_____________  |    |    |_______________________|
>  |XHCI HCD                 |<-    |
>  |_________________________|      |
> 
> 
> #1 - USB SND and QC offload:
> Initialization:
> - Register platform operations, to receive connect/disconnect events
>   from USB SND.
> - QC offload creates a QMI handle, in order to receive QMI requests
>   from the audio DSP.
> 
> Runtime:
> - USB SND passes along "struct snd_usb_audio" in order for QC offload
>   to reference USB UAC desc parsing/USB SND helper APIs.
> - USB device disconnection events will result in clearing of the chip
>   entry.
> 
> #2 - USB SND and QC offload endpoints:
> Runtime:
> - In the non-offloaded path, USB snd will utilize functions exposed by
>   USB SND endpoint, to help with fetching USB EP references and queuing
>   URBs.
> - In the offload path, qc offload will utilize the functions to fetch
>   USB EP references, so that it can use that information to query the
>   XHCI HCD.
> - Likewise, both will clean up endpoints when audio stream is not in use.
> 
> #3 - XHCI HCD:
> Initialization:
> - During XHCI probe timing, when the USB HCD is added to the system, it
>   will also initialize the secondary event rings.
> 
> Runtime:
> - During USB device plug ins/outs, allocates device slot, assigns eps,
>   and initializes transfer rings.
> 
> #4 - QC offload and XHCI:
> Runtime:
> - QC offload needs to reference the transfer ring and secondary event ring
>   addresses by executing XHCI offload management APIs.
> - This happens when audio DSP receives a USB QMI stream request.
> 
> #5 - ASoC components:
> Initialization:
> - The SM8250 platform sound card driver fetches DT node entries defining
>   the ASoC links. This chain/link has the components involved for a
>   particular Q6AFE path. (not only USB offload)
>     - "cpu" - this is the ASoC CPU DAI that handles interaction with the
>               Q6 DSP's audio protocol. (AFE ports)
>     - "codec" - the ASoC codec (backend) DAI defined
> - Registers ASoC platform sound card based on links defined in the DT node.
>   - Probes DAI components involved, ie Q6USB and Q6AFE
> 
> Runtime:
> - Q6AFE has the bulk of the interaction w/ the audio DSP to start an audio
>   session, such as issuing AFE port start commands (part of the protocol
>   used to communicate the audio session info)
> - Q6USB will be there to now check for if format requested is supported by
>   the device, and maintain offloading status.
> 
> #6 - Q6USB and SOC-USB:
> Initialization:
> - Q6USB will query QC offload for USB device connection states. (through
>   soc-usb)
> - Creates a SOC USB entry, that carries information about resources,
>   such as audio DSP memory information and requested XHCI event ring
>   index.
> 
> Runtime:
> - SOC-USB will receive connect/disconnect events and propagate to Q6USB.
>   - Q6USB makes devices available for offloading based on these events.
> - Sets Q6AFE port configurations to select the USB SND card# and PCM#.
> 
> #7 - SOC-USB and QC offload:
> Initialization:
> - Rediscover USB SND devices when the SOC-USB entry is created (if needed)
>     - For situations where the Q6USB DAI hasn't been probed.
> 
> Runtime:
> - Propagate connect/disconnect events.

Is the SOC-USB module or building blocks intended to be generic or
Qualcomm agnostic?

It's not clear to me how it would handle "audio DSP memory information
and requested XHCI event ring index."

In addition, it seems to be the "bridge" or means of communication
between qc_audio_offload and q6usb, is this not based on custom events
or triggers?

Along the same lines, this SOC-USB entity interfaces with APR/GLINK
which doesn't speak to me so it must be a QCOM interface?

I am trying to see if this design could be used for other architectures,
and the QCOM-specific and generic parts are not obvious.

> #8 - audio DSP and QC offload:
> Runtime:
> - Handle QMI requests coming from audio DSP.  These requests come AFTER
>   the Q6AFE port is opened by the Q6AFE DAI(#6)
> - Returns memory information about resources allocated by XHCI.
> - Enables audio playback when this QMI transaction is completed.
> 
>>>
>>>>> When the audio DSP wants to enable a playback stream, the request is
>>>>> first
>>>>> received by the ASoC platform sound card.  Depending on the selected
>>>>> route,
>>>>> ASoC will bring up the individual DAIs in the path.  The Q6USB
>>>>> backend DAI
>>>>> will send an AFE port start command (with enabling the USB playback
>>>>> path), and
>>>>> the audio DSP will handle the request accordingly.
>>>>>
>>>>> Part of the AFE USB port start handling will have an exchange of
>>>>> control
>>>>> messages using the QMI protocol.  The qc_audio_offload driver will
>>>>> populate the
>>>>> buffer information:
>>>>> - Event ring base address
>>>>> - EP transfer ring base address
>>>>>
>>>>> and pass it along to the audio DSP.  All endpoint management will now
>>>>> be handed
>>>>> over to the DSP, and the main processor is not involved in transfers.
>>>>>
>>>>> Overall, implementing this feature will still expose separate sound
>>>>> card and PCM
>>>>> devices for both the platorm card and USB audio device:
>>>>>    0 [SM8250MTPWCD938]: sm8250 - SM8250-MTP-WCD9380-WSA8810-VA-D
>>>>>                         SM8250-MTP-WCD9380-WSA8810-VA-DMIC
>>>>>    1 [Audio          ]: USB-Audio - USB Audio
>>>>>                         Generic USB Audio at usb-xhci-hcd.1.auto-1.4,
>>>>> high speed
>>>>>
>>>>> This is to ensure that userspace ALSA entities can decide which route
>>>>> to take
>>>>> when executing the audio playback.  In the above, if card#1 is
>>>>> selected, then
>>>>> USB audio data will take the legacy path over the USB PCM drivers,
>>>>> etc...
>>>>
>>>> I already voiced my concerns about exposing two cards, each with their
>>>> own set of volume controls with the same device. It would be much
>>>> better
>>>> to have an additional offloaded PCM device for card0...
>>>>
>>>> But if the consensus is to have two cards, it's still not clear how the
>>>> routing would be selected. In the case where there are two USB audio
>>>> devices attached, the offloaded path would only support one of the two.
>>>> How would userspace know which of the two is selected?
>>>>
>>>
>>> With patch#24:
>>> https://lore.kernel.org/linux-usb/20230308235751.495-25-quic_wcheng@quicinc.com/T/#u
>>>
>>> Now, userspace can at least choose which device it wants to offload.
>>> Part of doing that would mean userspace knows what USB SND card devices
>>> are available, so it is aware of which devices are shared (between the
>>> offload and USB SND path)
>>>
>>>> And how would userspace know the difference anyways between two
>>>> physical
>>>> devices attached to the platform with no offload, and one physical
>>>> device with one additional offload path? The names you selected
>>>> can't be
>>>> used to identify that card1 is the optimized version of card0.
>>>>
>>>
>>> Is userspace currently able to differentiate between cards that are
>>> created by USB SND versus ASoC?  How complex can the userspace card
>>> discovery be?  Can it query kcontrols at this point in time?  If so,
>>> maybe we can change the names of the newly added ones to reflect that it
>>> is an offload device?
>>>
>>> SND kcontrol names are currently:
>>> Q6USB offload status
>>> Q6USB offload SND device select
>>
>> I must admit I've never seen kcontrols being used to identify what the
>> card is, and in this case it's a pretend-card that's just an improved
>> version of another. It might be easier to use something else, such as
>> the component strings.
> 
> Its not exactly a pretend card, right?  This is part of the overall
> platform sound card we have in the system.  At the moment, I'm only
> testing by adding the USB audio routing, but there can be several ASoC
> links defined in the overall platform card.

Sorry, I misunderstood the proposal. I thought there would be one card
for "generic USB Audio", and another one for "DSP-offloaded USB Audio".
I assumed, probably mistakenly, that all local audio endpoints
(speaker,mics) would be exposed as a separate card.

It looks like it's more "generic USB Audio" and "DSP Audio", with the
USB offload being exposed as a PCM device of the latter.

Did I get this right? In this case, presumably there can be some sort of
UCM file for the "DSP Audio card" that contains the configuration or
knows which kcontrols to look for. But my point about detection hold.
You could perfectly well have a 'Jack control' that tells userspace when
a device is connected. That way there's no guess work, it's similar to
HDMI for Intel: the device is exposed but only valid when the jack
control is set.

> The Q6AFE CPU DAI has multiple audio AFE "ports" they can handle.  USB
> is only one of those.
> 
>>>
>>>> Before we review low-level kernel plumbing, it would be good to give a
>>>> better overview of how userspace applications are supposed to interact
>>>> with the cards and identify the offloaded path. Testing with
>>>> tinyplay/tinymix is fine, but that's a developer-level or CI unit test.
>>>> we've got to see the broader picture of how a sound server would use
>>>> this USB offload capability.
>>>
>>> Sure, I think that is fine.  I was hoping that at least adding some of
>>> the new kcontrols would help userspace make use of this path in general,
>>> but we can add more information if required.
>>
>> Can I ask if this solution has been used with a complete userspace stack
>> already? I could see how this might be used with a relatively fixed
> 
> Its been used only with the Android HAL.

ok, that aligns with what I was thinking.

> 
>> Android HAL, where the platform and routing are relatively controlled. I
>> don't see how a more generic audio server would deal with the discovery
>> and routing.
>>
> 
> This is why your input is helpful, since it provides another use case
> that wasn't considered.  I think in our previous discussions the tagging
> possibility was a good idea, and was hoping that it could help.  Could
> tag all USB SND cards to the platform sound card as well, and if the
> power saving path is chosen, it would issue the playback on the platform
> sound card. (if not in use)
> 
> In this case, the offload path wouldn't be the default routing, and only
> enabled for power optimized path.
> 
> Thanks
> Wesley Cheng
