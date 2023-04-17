Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B51FB6E4539
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbjDQKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjDQKcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:32:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1778810D
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 03:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681727509; x=1713263509;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=R9ZDjMQbJbktdyenH5QRHh9b8IZO5KHOnPqhpyxlJ1s=;
  b=QT7trZ105xLudMr204vHs0Vn7tGb9c+Jgnlgtt606eNKk7DCtSSvw8be
   Q8OBsvlTJnZGdtwVZ25YD/VbPQ6A0ED0D1Ariaw2BrVHx0o2nauoDOa8S
   Yo//3MO1o/RjRBZ4tILX4s2/SalIv0OQqXaBN/Ww51X5Tx5wJRNFS7Js6
   jecFTu95+saGUPPTj2zePUSspRlaQnQWe6Z4mtZN9BkgCeJXgog65mQoL
   MKAKtXJt6DI6ENFXV0NOYxATnQX1BivMZU2imx0mwiugpuWCdSAPoEbiP
   cv0zmxi1Gc1VDk4iyOrjMgjQs6pinNDyLrRfyE0gAmvUuLS0GLVitMZV9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="347597320"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="347597320"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 03:29:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10682"; a="802064100"
X-IronPort-AV: E=Sophos;i="5.99,203,1677571200"; 
   d="scan'208";a="802064100"
Received: from habramov-mobl4.ger.corp.intel.com (HELO localhost) ([10.252.47.83])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 03:29:54 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Jeff Layton <jlayton@kernel.org>, Lyude Paul <lyude@redhat.com>,
        "Lin, Wayne" <Wayne.Lin@amd.com>,
        Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm: make drm_dp_add_payload_part2 gracefully handle
 NULL state pointer
In-Reply-To: <b99732f7c0dd968c0702ae7629695e8fb9cb573f.camel@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230413111254.22458-1-jlayton@kernel.org>
 <87edooarpq.fsf@intel.com>
 <CADnq5_PVnYMSiKO77+cfg_V-tDKYkVJYN3qGNb1vhQO3QtXskA@mail.gmail.com>
 <CO6PR12MB5489044012B2A96639470F38FC999@CO6PR12MB5489.namprd12.prod.outlook.com>
 <4d8479f20ef30866fcf73f3602f1237376110764.camel@kernel.org>
 <878reug394.fsf@intel.com>
 <7a1b00f02b125bd65824b18ea09509efe3cf777d.camel@redhat.com>
 <874jpegao0.fsf@intel.com>
 <b99732f7c0dd968c0702ae7629695e8fb9cb573f.camel@kernel.org>
Date:   Mon, 17 Apr 2023 13:29:51 +0300
Message-ID: <87leiqer8g.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023, Jeff Layton <jlayton@kernel.org> wrote:
> On Mon, 2023-04-17 at 11:44 +0300, Jani Nikula wrote:
>> On Fri, 14 Apr 2023, Lyude Paul <lyude@redhat.com> wrote:
>> > On Fri, 2023-04-14 at 13:35 +0300, Jani Nikula wrote:
>> > > On Fri, 14 Apr 2023, Jeff Layton <jlayton@kernel.org> wrote:
>> > > > On Fri, 2023-04-14 at 04:40 +0000, Lin, Wayne wrote:
>> > > > > [Public]
>> > > > > 
>> > > > > Hi Jeff,
>> > > > > 
>> > > > > Thanks. I might need more information to understand why we can't retrieve
>> > > > > the drm atomic state. Also , "Failed to create MST payload for port" indicates
>> > > > > error while configuring DPCD payload ID table. Could you help to provide log
>> > > > > with KMS + ATOMIC + DP debug on please? Thanks in advance!
>> > > > > 
>> > > > > Regards,
>> > > > > Wayne
>> > > > > 
>> > > > 
>> > > > Possibly. I'm not that familiar with display driver debugging. Can you
>> > > > send me some directions on how to crank up that sort of debug logging?
>> > > > 
>> > > > Note that this problem is _very_ intermittent too: I went about 2 weeks
>> > > > between crashes, and then I got 3 in one day. I'd rather not run with a
>> > > > lot of debug logging for a long time if that's what this is going to
>> > > > require, as this is my main workstation.
>> > > > 
>> > > > The last time I got this log message, my proposed patch did prevent the
>> > > > box from oopsing, so I'd really like to see it go in unless it's just
>> > > > categorically wrong for the caller to pass down a NULL state pointer to
>> > > > drm_dp_add_payload_part2.
>> > > 
>> > > Cc: Lyude.
>> > > 
>> > > Looks like the state parameter was added in commit 4d07b0bc4034
>> > > ("drm/display/dp_mst: Move all payload info into the atomic state") and
>> > > its only use is to get at state->dev for debug logging.
>> > > 
>> > > What's the plan for the parameter? Surely something more than that! :)
>> > 
>> > I don't think there was any plan for that, or at least I certainly don't even
>> > remember adding that D:. It must totally have been by mistake and snuck by
>> > review, if that's the only thing that we're using it for I'd say it's
>> > definitely fine to just drop it entirely
>> 
>> I guess we could use two patches then, first replace state->dev with
>> mgr->dev as something that can be backported as needed, and second drop
>> the state parameter altogether.
>> 
>> Jeff, up for it? At least the first one?
>> 
>> 
>> BR,
>> Jani.
>> 
>
> Sure. I'm happy to test patches if you send them along.

I was hoping to lure you into sending patches. ;)

Anyway, I'm not working on this.


BR,
Jani.

>
> Thanks,

-- 
Jani Nikula, Intel Open Source Graphics Center
