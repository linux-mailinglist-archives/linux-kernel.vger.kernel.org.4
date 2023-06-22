Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD10673A7B4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbjFVRvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjFVRvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:51:10 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3211988
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 10:51:08 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 4E370320091F;
        Thu, 22 Jun 2023 13:51:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 22 Jun 2023 13:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        joshtriplett.org; h=cc:cc:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1687456264; x=1687542664; bh=YShG2YqeRJvKnP47Pbk8/8ySMjdc+Phgy1r
        7NJzoXfc=; b=SF3aqluC/IlV+k9DLDSKAp+31amBIhvk9UE5+dvW2Ijcyr2bJd4
        7BlRGHlvlhEcD4Es9xhE49EDHdXY14Y9VhiNFGgyN9mNh/ckoU+Lgk19fyJ3B7uE
        rhxbJMjWclOH19bup1IS1I58Ji9J7ZLdtPgxVekAdWjXUlPvp1K1O/2GmW5SYaLn
        VC92wrrivqS1T2YM35Ma8GJtCrU4Mq64PHQpXg+ojptdUYvnVYD81zCNZ/rOR9hr
        P/qZ/s1LI1P/sTejJDnQaY7LDXZJE7EXT6bwrjIaMa5z6arhVJJpLG8Q0OQrgsWZ
        3VRWPbmnvhYX823N1TCaRp7Ca5Hh2sP9KuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687456264; x=1687542664; bh=YShG2YqeRJvKn
        P47Pbk8/8ySMjdc+Phgy1r7NJzoXfc=; b=exlrvdUYUoMDG8MDXJ8u8mfxKtEql
        +zvUJJEZqVlqgS2f67G+puMPmbRlwYzmsduZvG9JAAk6hODatMPKHKOflm3gDgbX
        zDxvDgVHkbG0+cB6Pt0dFymjlKbpU/9Hlm7fwlR+0hwgKJxMr1tL6copOCPLoFk6
        zd1E5gPzw8s71taUVWS8ooi9oiqjcboIKf70QmcUSlnemLCb4TuvujRTXcZ4BPL7
        OF13mvUPO81n2iZNq0sseF2ivH9VLx7Lsd1Kfsuk+Vd7pzPfJotq/P/zeqE6G0Vf
        x+BgiWCCa2QbCrsxCAR1oegwfb/zkCW2OJwRFqm9kgcfAo3bZyPhIAGng==
X-ME-Sender: <xms:CIqUZOCWTi7LHibaGxvSsS6xEUlBv81h7KpEef4rpz_CleKsvMIEEQ>
    <xme:CIqUZIiZefH6j351xw6pxT3OOdWfXeQjsn1Kiyuhd5inDVVNLTv-dZBg9bYl6eqkZ
    PDBsfJpdJKNl02wr2Y>
X-ME-Received: <xmr:CIqUZBnndoFOiCBp3zE5ERyz8sRZzBfNzolriwqpEq4ORKrX_P-2PRQUZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeeguddgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeflohhs
    hhcuvfhrihhplhgvthhtuceojhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgheqne
    cuggftrfgrthhtvghrnhepudeigeehieejuedvtedufeevtdejfeegueefgffhkefgleef
    teetledvtdfftefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhoshhhsehjohhshhhtrhhiphhlvghtthdrohhrgh
X-ME-Proxy: <xmx:CIqUZMxHMPGMLqp_7goph5HF9ACxdJaRhk3QB8RLR29uttOK1ociGA>
    <xmx:CIqUZDSeY2alb9ohgujJ86ysfhJbDSJtXn9xfmIBI3dCIMh7rTgW8Q>
    <xmx:CIqUZHawY4mh0BN-A7VjtW3nnkkzcSIFcCdf-5fSJCao7mrZ0nki-w>
    <xmx:CIqUZBP7AEHWCuGC7aelRvD_EUMgp32WZSuWSMDyEb6sbIbpxdajIg>
Feedback-ID: i83e94755:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jun 2023 13:51:03 -0400 (EDT)
Date:   Thu, 22 Jun 2023 10:51:02 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Allen Ballway <ballway@chromium.org>
Cc:     arun.r.murthy@intel.com, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/i915/quirk: Add quirk for devices that cannot be
 dimmed
Message-ID: <ZJSKBg+LymhvINoG@localhost>
References: <20230606211901.1.I06e778109090b5dc85c44da7b742d185aa6adb59@changeid>
 <20230622172817.2281527-1-ballway@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622172817.2281527-1-ballway@chromium.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 05:28:15PM +0000, Allen Ballway wrote:
> --- a/drivers/gpu/drm/i915/display/intel_backlight.c
> +++ b/drivers/gpu/drm/i915/display/intel_backlight.c
> @@ -1192,6 +1192,11 @@ static u32 get_backlight_min_vbt(struct intel_connector *connector)
> 
>  	drm_WARN_ON(&i915->drm, panel->backlight.pwm_level_max == 0);
> 
> +	if (intel_has_quirk(i915, QUIRK_NO_DIM)) {
> +		/* Cannot dim backlight, set minimum to hightest value */

Typo: s/hightest/highest/
