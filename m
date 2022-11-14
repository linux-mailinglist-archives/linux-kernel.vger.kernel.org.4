Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906476279F9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236662AbiKNKFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbiKNKFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:05:03 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11B81F9D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:02:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668420163; x=1699956163;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=ZpphfstUP7oMJ91iN9xXMmrOJnu/uu6RmVG1mEwLx1g=;
  b=FI4G7QoSAwRv1NK19Rg2p0/CcbrlZJAXxdTB4egNh+jLF+eE43qrcnxN
   BpZY96IYbhgqw9sJaMwYjSYPcgkAC/c34MOuaD4taHjild8A1f72CLNx7
   Xt7CyfxwPVbitismVKGBXhys3ifUMMlLf5X7/GmUV924jw2CnbYxOWKuq
   ZLm9ZgWznJK+brhGzrY5oaVMedNbSZvGTnQ0Rvvb1TBqWDgEz3vKb7Orf
   ZsldV1YHR1t8CGTDeveVgUG14J1Pqt4q1FbkN2HAPVAyt2z4e5P/7dcZa
   eR56RRytJhoHoj15LCelzCAjAaJz/36mcHcYfYKfHRPEjw9EBhwR7lf/8
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="292329711"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="292329711"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 02:02:33 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10530"; a="763420378"
X-IronPort-AV: E=Sophos;i="5.96,161,1665471600"; 
   d="scan'208";a="763420378"
Received: from dsmahang-mobl.ger.corp.intel.com (HELO localhost) ([10.252.59.240])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 02:02:31 -0800
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     Doug Anderson <dianders@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Subject: Re: [PATCH] drm/edid: Dump the EDID when drm_edid_get_panel_id()
 has an error
In-Reply-To: <CAD=FV=UUpR9Euq5r+MujO6BdTk2cnWe_0JTdcP_e5RP47apUcw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20221021130637.1.I8c2de0954a4e54e0c59a72938268e2ead91daa98@changeid>
 <e6bc800b-2d3b-aac9-c1cb-7c08d618fc8e@quicinc.com>
 <CAD=FV=V4m5HNavewSTkrh64_BzLAkivR2mRkTQdaxA8k9JKQbA@mail.gmail.com>
 <956de566-d60a-f257-edff-85a2eac06d99@quicinc.com>
 <CAD=FV=UUpR9Euq5r+MujO6BdTk2cnWe_0JTdcP_e5RP47apUcw@mail.gmail.com>
Date:   Mon, 14 Nov 2022 12:02:28 +0200
Message-ID: <87iljh4zwr.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Nov 2022, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Tue, Oct 25, 2022 at 1:39 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>>
>> Hi Doug
>>
>> On 10/24/2022 1:28 PM, Doug Anderson wrote:
>> > Hi,
>> >
>> > On Fri, Oct 21, 2022 at 2:18 PM Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>> >>
>> >> Hi Doug
>> >>
>> >> On 10/21/2022 1:07 PM, Douglas Anderson wrote:
>> >>> If we fail to get a valid panel ID in drm_edid_get_panel_id() we'd
>> >>> like to see the EDID that was read so we have a chance of
>> >>> understanding what's wrong. There's already a function for that, so
>> >>> let's call it in the error case.
>> >>>
>> >>> NOTE: edid_block_read() has a retry loop in it, so actually we'll only
>> >>> print the block read back from the final attempt. This still seems
>> >>> better than nothing.
>> >>>
>> >>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>> >>
>> >> Instead of checkinf for edid_block_status_valid() on the base_block, do
>> >> you want to use drm_edid_block_valid() instead?
>> >>
>> >> That way you get the edid_block_dump() for free if it was invalid.
>> >
>> > I can... ...but it feels a bit awkward and maybe not quite how the
>> > functions were intended to work together?
>> >
>> > One thing I notice is that if I call drm_edid_block_valid() I'm doing
>> > a bunch of duplicate work that already happened in edid_block_read(),
>> > which already calls edid_block_check() and handles fixing headers. I
>> > guess also if I call drm_edid_block_valid() then I should ignore the
>> > "status" return value of edid_block_read() because we don't need to
>> > pass it anywhere (because the work is re-done in
>> > drm_edid_block_valid()).
>> >
>> > So I guess I'm happy to do a v2 like that if everyone likes it better,
>> > but to me it feels a little weird.
>> >
>> > -Doug
>>
>> Alright, agreed. There is some duplication of code happening if we use
>> drm_edid_block_valid(). I had suggested that because it has inherent
>> support for dumping the bad EDID.
>>
>> In that case, this change LGTM, because in principle you are doing the
>> same thing as _drm_do_get_edid() (with the only difference being here we
>> read only the base block as opposed to the full EDID there).
>>
>> Hence,
>>
>> Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
>
> I've given this patch a bunch of time because it wasn't urgent, but
> seems like it could be about time to land. I'll plan to land it next
> Monday or Tuesday unless anyone has any other comments.

Ack, it's benign enough.

BR,
Jani.

>
> Thanks!
>
> -Doug

-- 
Jani Nikula, Intel Open Source Graphics Center
