Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3826678F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 16:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240263AbjALPTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 10:19:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240418AbjALPTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 10:19:18 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1217C32E97
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 07:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673536288; x=1705072288;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IuB1Fv8++BeV22rt4RNniswoWo4BzvVoSnQX21JaHBY=;
  b=CJN+Op1z7H+LYptl843gaqgs+B0Afwr1+yez+LgUU6bqRVAtp4gtwx3S
   B6wGY5wR5UUn6QzaYm9ipJhTtftkK0tYZ6uEzaNJGH8HZV7Ey6Lc1RtOd
   A52vLxFwnl4bQi9/wrwxdY6+VSfmKGyHZ5zsZ01jCnXh7BXXL/X48JQGA
   W44dCiamMlpnkz51cu78EHOFDXmAO3uohzaLuMvd3dqBV09vGPIQoTExU
   48FSxVjCpdq6h73nRlxs+0XpovBOSTRt8+VM0thUVePDs2Kdm4PX5qcj9
   ZYMiwbcCbgYEEKsNrWVeefNEugxqfyLRSRdbA1Pl0i2qqJMYl9Q2bYSvF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="311562742"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="311562742"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:38:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="781798888"
X-IronPort-AV: E=Sophos;i="5.97,211,1669104000"; 
   d="scan'208";a="781798888"
Received: from aeagersx-mobl1.ger.corp.intel.com (HELO [10.252.12.74]) ([10.252.12.74])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2023 06:38:16 -0800
Message-ID: <72d2e011-691f-4a1a-1421-c88990737497@linux.intel.com>
Date:   Thu, 12 Jan 2023 16:38:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
Subject: Re: [PATCH] ASoC: SOF: sof-audio: Check snd_sof_widget pointer not
 NULL
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        pierre-louis.bossart@linux.intel.com
Cc:     lgirdwood@gmail.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, rander.wang@intel.com,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        wenst@chromium.org
References: <20230112104542.115151-1-angelogioacchino.delregno@collabora.com>
 <ec65c3dc-135d-afbc-3f26-a28a2da791f7@linux.intel.com>
 <394ec60d-33c0-1386-9445-eb0c596cc46c@collabora.com>
From:   =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <394ec60d-33c0-1386-9445-eb0c596cc46c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2023 15:12, AngeloGioacchino Del Regno wrote:
> Il 12/01/23 14:02, Péter Ujfalusi ha scritto:
>> Hi Angelo,
>>
>> On 12/01/2023 12:45, AngeloGioacchino Del Regno wrote:
>>> In function sof_unprepare_widgets_in_path(), check if swidget is
>>> actually not NULL, as the widget may not have been initialized at all.
>>>
>>> This commit solves the following kernel panic seen on MediaTek MT8195:
>>>
>>> [   18.025215] Unable to handle kernel NULL pointer dereference at
>>> virtual address 0000000000000014
>>> [   18.034266] Mem abort info:
>>> [   18.037314]   ESR = 0x0000000096000004
>>> [   18.041314]   EC = 0x25: DABT (current EL), IL = 32 bits
>>> [   18.046876]   SET = 0, FnV = 0
>>> [   18.050180]   EA = 0, S1PTW = 0
>>> [   18.053572]   FSC = 0x04: level 0 translation fault
>>> [   18.058700] Data abort info:
>>> [   18.061832]   ISV = 0, ISS = 0x00000004
>>> [   18.065919]   CM = 0, WnR = 0
>>> [   18.069137] user pgtable: 4k pages, 48-bit VAs, pgdp=0000000115495000
>>> [   18.075826] [0000000000000014] pgd=0000000000000000,
>>> p4d=0000000000000000
>>> [   18.082867] Internal error: Oops: 0000000096000004 [#1] SMP
>>> [   18.088688] Modules linked in: af_alg qrtr btusb btrtl btintel
>>> btmtk btbcm bluetooth 8021q garp uvcvideo mrp stp ecdh_generic llc
>>> ecc videobuf2_vmalloc mt7921e mt7921_common mt76_connac_lib mt76
>>> mac80211 snd_sof_ipc_msg_injector snd_sof_ipc_flood_test cfg80211
>>> snd_sof_mt8195 mtk_adsp_common snd_sof_xtensa_dsp snd_sof_of panfrost
>>> rfkill snd_sof crct10dif_ce cros_ec_sensors cros_ec_lid_angle
>>> gpu_sched sbs_battery cros_usbpd_logger cros_ec_sensors_core
>>> hid_multitouch snd_sof_utils fuse ipv6
>>> [   18.132109] CPU: 5 PID: 657 Comm: wireplumber Tainted: G       
>>> W          6.2.0-rc3-next-20230111+ #230
>>> [   18.141834] Hardware name: Acer Tomato (rev2) board (DT)
>>> [   18.147392] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
>>> BTYPE=--)
>>> [   18.154600] pc : sof_unprepare_widgets_in_path.isra.0+0x28/0x10c
>>> [snd_sof]
>>> [   18.161735] lr : sof_walk_widgets_in_order+0x198/0x1d0 [snd_sof]
>>> [   18.167996] sp : ffff80000eb0b870
>>> [   18.171558] x29: ffff80000eb0b870 x28: 0000000000000001 x27:
>>> ffff5d8e178c4c00
>>> [   18.178939] x26: ffffbd50140fd758 x25: ffffbd50140fd760 x24:
>>> 0000000000000000
>>> [   18.186321] x23: 0000000000000000 x22: ffff5d8e109dd080 x21:
>>> ffff5d8e0a429280
>>> [   18.193702] x20: 0000000000000000 x19: ffff5d8e11fe4800 x18:
>>> 0000000000000000
>>> [   18.201083] x17: 0000000000000000 x16: ffffbd5073deabb0 x15:
>>> 0000000000000000
>>> [   18.208464] x14: 0000000000000000 x13: 0000000000000000 x12:
>>> 0000000000000000
>>> [   18.215846] x11: 0000000000000000 x10: 0000000000002780 x9 :
>>> ffffbd50140eb4bc
>>> [   18.223228] x8 : ffff5d8e1b5327e0 x7 : 0000000000000000 x6 :
>>> ffff5d8e1b530000
>>> [   18.230610] x5 : 0000000000000003 x4 : 0000000000000001 x3 :
>>> 0000000000000000
>>> [   18.237991] x2 : 0000000000000000 x1 : ffff5d8e11fe4800 x0 :
>>> ffff5d8e0a429280
>>> [   18.245372] Call trace:
>>> [   18.248066]  sof_unprepare_widgets_in_path.isra.0+0x28/0x10c
>>> [snd_sof]
>>> [   18.254847]  sof_walk_widgets_in_order+0x198/0x1d0 [snd_sof]
>>> [   18.260760]  sof_widget_list_free+0x7c/0xbc [snd_sof]
>>> [   18.266066]  sof_pcm_hw_free+0x10c/0x1c0 [snd_sof]
>>> [   18.271110]  snd_soc_pcm_component_hw_free+0x8c/0xe0
>>> [   18.276327]  soc_pcm_hw_clean+0x60/0x11c
>>> [   18.280498]  dpcm_fe_dai_hw_free+0x98/0x110
>>> [   18.284930]  snd_pcm_common_ioctl+0xc48/0x1a2c
>>> [   18.289624]  snd_pcm_ioctl+0x38/0x50
>>> [   18.293448]  __arm64_sys_ioctl+0xb0/0xf4
>>> [   18.297620]  invoke_syscall+0x50/0x120
>>> [   18.301618]  el0_svc_common.constprop.0+0x17c/0x1b0
>>> [   18.306744]  do_el0_svc+0x40/0xc4
>>> [   18.310307]  el0_svc+0x48/0xf0
>>> [   18.313611]  el0t_64_sync_handler+0xb8/0xc0
>>> [   18.318041]  el0t_64_sync+0x1a0/0x1a4
>>> [   18.321953] Code: aa0103f3 f90013f5 aa0003f5 f9406834 (39405280)
>>> [   18.328293] ---[ end trace 0000000000000000 ]---
>>>
>>> Fixes: 9862dcf70245 ("ASoC: SOF: don't unprepare widget used other
>>> pipelines")
>>> Fixes: ce59804d2643 ("ASoC: SOF: clear prepare state when widget is
>>> unprepared")
>>> Signed-off-by: AngeloGioacchino Del Regno
>>> <angelogioacchino.delregno@collabora.com>
>>> ---
>>>   sound/soc/sof/sof-audio.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
>>> index e1ab8380e7d8..1988717762b3 100644
>>> --- a/sound/soc/sof/sof-audio.c
>>> +++ b/sound/soc/sof/sof-audio.c
>>> @@ -274,7 +274,7 @@ sof_unprepare_widgets_in_path(struct snd_sof_dev
>>> *sdev, struct snd_soc_dapm_widg
>>>       struct snd_soc_dapm_path *p;
>>>         /* return if the widget is in use or if it is already
>>> unprepared */
>>> -    if (!swidget->prepared || swidget->use_count > 1)
>>> +    if (!swidget || !swidget->prepared || swidget->use_count > 1)
>>>           return;
>>
>> we actually have a pending patch for upstream which did not yet made it
>> to the gate:
>> https://github.com/thesofproject/linux/commit/922646d533100044d95a050b222533d59f06020c
>>
>> It also adds symmetrical check for the prepare path.
>>
>> Would you be OK if I send that right away to replace your fix?
>>
> 
> I didn't know that you had something similar - I've been carrying this
> patch
> locally for ~1.5 months, thinking that it was an issue with MediaTek
> drivers...
> ...but after investigating a bit (read: after I've found some time to
> actually
> investigate), it really looked like a more generic issue - for which reason
> I decided to send this patch upstream.

Right, my guess would be that you could also hit the NULL pointer in
sof_prepare_widgets_in_path() but (I'm guessing) you have a failure
before you would hit that, then the stream is torn down and you catch it
in unprepare time.

> Speaking of your patch:
> I think that the check that you've added to
> sof_prepare_widgets_in_path() will
> never trigger... at least, it's never been the case here, but that may be a
> platform-specific thing (even though I also have virtual widgets on MTK).
> Also, your patch misses the Fixes tags (and this fix shall be backported).

Yes, the patch in SOF's tree does not have Fixes tag as we have not
faced with this issue until we started to use virtual widgets, so it was
meant to be a new 'feature' to support the virtual DAPM widgets without
swidget.

> Finally, I'd be OK with that if:
> 1. You add the Fixes tag for backporting; and
> 2. Describe why the swidget NULL check is required in
> sof_prepare_widgets_in_path()
>    and why the legacy HDA machine driver would call that function with
> NULL swidget
>    as that looks like a HDA driver bug, rather than a SOF core bug.

It is a generic feature (fix?) and as the commit message said it is
filtering out virtual widgets from topology (widgets that SOF is not
handling -> no swidget is allocated for them).
These widgets are present in DAPM to alolow the core to find and build
paths, but that is the only function they have, no swidget, just path
building blocks.

> 
> Regards,
> Angelo
> 
> 

-- 
Péter
