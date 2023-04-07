Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 245696DB128
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjDGRIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjDGRIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:08:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E5DA5CB;
        Fri,  7 Apr 2023 10:08:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D20C61128;
        Fri,  7 Apr 2023 17:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2739C433D2;
        Fri,  7 Apr 2023 17:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680887293;
        bh=F9eXAOVjjUTkx4GJvdCe60V7AF+Tu5+yzB4QhkxKFzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kS6Tq8/AdhYkJvytfHyj4T22LnB8x5qWAr3izYZ8j0HPSLGukGTc4IRs9yCSVwrou
         MfEBswBPApPcffskt2iQwKY/uACFaIjWZUg7sKmcKKOwiX+9/zoF0Wt7GR+09c4ob0
         VotnV0BFo9CsDi2+kgIXTiv4yYxQ41ZmI6v5UlBim+jwCwKeoiK7AAIS4aGPmj4FCa
         x3lODavUnCHkfyQSV3/jfQUI8wALlCIbnSizDjy/LA8hIs1K1r+ptaqEOSs/se7eOl
         6Qoe0GilPN/DfVBFnkAJkaff4kcVtouznnXtBG0c93tWBxNH2fSLA95jbvduQXg5Aa
         mxRXW/l3sD0jg==
Date:   Fri, 7 Apr 2023 10:11:03 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Gergo Koteles <soyer@irl.hu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v4 2/3] Input: add ABS_SND_PROFILE
Message-ID: <20230407171103.5jf46g4hw3fed7dn@ripper>
References: <cover.1677022414.git.soyer@irl.hu>
 <1a4752739568afbdbaaff48436d2bb595d2bda0d.1677022414.git.soyer@irl.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a4752739568afbdbaaff48436d2bb595d2bda0d.1677022414.git.soyer@irl.hu>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 01:10:33AM +0100, Gergo Koteles wrote:
> ABS_SND_PROFILE used to describe the state of a multi-value sound profile
> switch. This will be used for the alert-slider on OnePlus phones or other
> phones.
> 
> Profile values added as SND_PROFLE_(SILENT|VIBRATE|RING) identifiers
> to input-event-codes.h so they can be used from DTS.
> 
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
> ---
>  Documentation/input/event-codes.rst    | 6 ++++++
>  drivers/hid/hid-debug.c                | 1 +
>  include/uapi/linux/input-event-codes.h | 9 +++++++++
>  3 files changed, 16 insertions(+)
> 
> diff --git a/Documentation/input/event-codes.rst b/Documentation/input/event-codes.rst
> index b4557462edd7..d43336e64d6a 100644
> --- a/Documentation/input/event-codes.rst
> +++ b/Documentation/input/event-codes.rst
> @@ -241,6 +241,12 @@ A few EV_ABS codes have special meanings:
>      emitted only when the selected profile changes, indicating the newly
>      selected profile value.
>  
> +* ABS_SND_PROFILE:
> +
> +  - Used to describe the state of a multi-value sound profile switch.
> +    An event is emitted only when the selected profile changes,
> +    indicating the newly selected profile value.
> +
>  * ABS_MT_<name>:
>  
>    - Used to describe multitouch input events. Please see
> diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
> index e213bdde543a..76fb2ecbbc51 100644
> --- a/drivers/hid/hid-debug.c
> +++ b/drivers/hid/hid-debug.c
> @@ -1018,6 +1018,7 @@ static const char *absolutes[ABS_CNT] = {
>  	[ABS_DISTANCE] = "Distance",	[ABS_TILT_X] = "XTilt",
>  	[ABS_TILT_Y] = "YTilt",		[ABS_TOOL_WIDTH] = "ToolWidth",
>  	[ABS_VOLUME] = "Volume",	[ABS_PROFILE] = "Profile",
> +	[ABS_SND_PROFILE] = "SoundProfile",
>  	[ABS_MISC] = "Misc",
>  	[ABS_MT_TOUCH_MAJOR] = "MTMajor",
>  	[ABS_MT_TOUCH_MINOR] = "MTMinor",
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 022a520e31fc..e8d5ee027b40 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -866,6 +866,7 @@
>  
>  #define ABS_VOLUME		0x20
>  #define ABS_PROFILE		0x21
> +#define ABS_SND_PROFILE		0x22
>  
>  #define ABS_MISC		0x28
>  
> @@ -974,4 +975,12 @@
>  #define SND_MAX			0x07
>  #define SND_CNT			(SND_MAX+1)
>  
> +/*
> + * ABS_SND_PROFILE values
> + */
> +
> +#define SND_PROFILE_SILENT	0x00
> +#define SND_PROFILE_VIBRATE	0x01
> +#define SND_PROFILE_RING	0x02

The patch looks good to me, bu I'd need these header file additions in
order to merge the dts patch. Could I get an ack and take it through the
Qualocmm tree, or could you pick it up for 6.4, and then I can merge the
dts change after that?

Regards,
Bjorn

> +
>  #endif
> -- 
> 2.39.2
> 
