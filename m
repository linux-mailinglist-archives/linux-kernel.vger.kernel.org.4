Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E007F5B5999
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 13:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiILLrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 07:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiILLrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 07:47:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DFE3C8CA;
        Mon, 12 Sep 2022 04:47:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F2B7611C2;
        Mon, 12 Sep 2022 11:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 013F0C433D6;
        Mon, 12 Sep 2022 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662983269;
        bh=RDy0tUvA0Kec3HrshmYh6dhtgau20w88sb8xZPDcq3M=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=QcL0kolZpF80TRTIL37njbpkb1fVuZbc+YqZ0DgsJYHuemvN4AwwlrWj5+9FhgB8W
         /zBSkRVBArwMY4WfX1EZOIDqPeOdtA9GKQmygshOKVru41b6lJqCOBe7ruimjd5ODp
         /sD9WOXjaRfX7LtIc+cytwEY10Rzg/S8+1GdopyiGY0zO4obt9djnWSbik9DWCJr25
         WKeRTYcIk3bKCDKoe4iS5vPvPAyvPA6cWe7wzdRjn7ll7gVWTQolRDbdXNZBeUrvMo
         lzb7uAKFTpje9Ti4V+T4Bds4/OuzxAx6TAEFv+u7Y6pNtGTnudBapr7JcAE0FeTc/w
         6gFdpQSsMDCqA==
Date:   Mon, 12 Sep 2022 12:47:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Subject: Re: [RESEND] HID: steam: Prevent NULL pointer dereference in
 steam_{recv,send}_report
Message-ID: <Yx8cYZnmnN09lD4A@google.com>
References: <20220803111831.387506-1-lee@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220803111831.387506-1-lee@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Aug 2022, Lee Jones wrote:

> It is possible for a malicious device to forgo submitting a Feature
> Report.  The HID Steam driver presently makes no prevision for this
> and de-references the 'struct hid_report' pointer obtained from the
> HID devices without first checking its validity.  Let's change that.

This patch has been floating around since the beginning of July.

It fixes a real issue which was found by creating a virtual
(software based) malicious device and registering it as a HID device.

There is nothing preventing a real attacker from creating a H/W
version of the device in order to instigate an out-of-bounds read,
potentially leading to a data leak.

Would someone be kind enough to review please?

> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Fixes: c164d6abf3841 ("HID: add driver for Valve Steam Controller")
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/hid/hid-steam.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index a3b151b29bd71..fc616db4231bb 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -134,6 +134,11 @@ static int steam_recv_report(struct steam_device *steam,
>  	int ret;
>  
>  	r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
> +	if (!r) {
> +		hid_err(steam->hdev, "No HID_FEATURE_REPORT submitted -  nothing to read\n");
> +		return -EINVAL;
> +	}
> +
>  	if (hid_report_len(r) < 64)
>  		return -EINVAL;
>  
> @@ -165,6 +170,11 @@ static int steam_send_report(struct steam_device *steam,
>  	int ret;
>  
>  	r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
> +	if (!r) {
> +		hid_err(steam->hdev, "No HID_FEATURE_REPORT submitted -  nothing to read\n");
> +		return -EINVAL;
> +	}
> +
>  	if (hid_report_len(r) < 64)
>  		return -EINVAL;
>  

-- 
Lee Jones [李琼斯]
