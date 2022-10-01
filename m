Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6105F1A77
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbiJAHIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJAHIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:08:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3210C15D87E;
        Sat,  1 Oct 2022 00:08:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9ED0B80B27;
        Sat,  1 Oct 2022 07:08:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC282C433C1;
        Sat,  1 Oct 2022 07:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664608085;
        bh=W4Ja25FWaaWt7ufd0WRR9moilESdaUHujQ1HovD4axQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j90+Ya4cB4eZLni7oSlPz59BerIrrLTQlH1D/lXQyy42ab3qHsqlLOi/NGWP4OYTN
         lJIz6He3uSfA9L27cVuS6QvXbEtcHJIaixeBZCqJpCQ0hZezp0huYFyUvgu//A43ro
         lKoRXpnQMXMKPTLwjxvm9LmDhiRGHGKVOybcywh8=
Date:   Sat, 1 Oct 2022 09:08:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paul Jones <paul@spacefreak18.xyz>
Cc:     jikos@kernel.org, anssi.hannula@gmail.com, linux-@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: usbhid: hid-pidff: Set Replay Length to
 Infinite when set to 0
Message-ID: <YzfnedNeOZWEJit0@kroah.com>
References: <20220930225127.Horde.AdDRdase1XW5AUKNNLyXVo3@cloud.brak.space>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220930225127.Horde.AdDRdase1XW5AUKNNLyXVo3@cloud.brak.space>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 10:51:27PM +0000, Paul Jones wrote:
> Greetings,
>  
> Started using my Accuforce v2 Sim wheel on Linux. I was getting no response from racing simulators through Wine, but native linux test tools worked fine. It seems that many real-world applications will send 0 as the replay length, which was resulting in the behavior I was experiencing (nothing). It makes sense to interpret 0 as an infinite effect and therefore set the replay length of the effect to 0xffff. While the PID document does not explicitly state that 0 should be infinite, it does hint toward null values being interpreted as infinite.
>  
> ---
>  
> diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
> index 3b4ee21cd811..70653451c860 100644
> --- a/drivers/hid/usbhid/hid-pidff.c
> +++ b/drivers/hid/usbhid/hid-pidff.c
> @@ -301,7 +301,7 @@ static void pidff_set_effect_report(struct pidff_device *pidff,
>  pidff->block_load[PID_EFFECT_BLOCK_INDEX].value[0];
> pidff->set_effect_type->value[0] =
>  pidff->create_new_effect_type->value[0];
> - pidff->set_effect[PID_DURATION].value[0] = effect->replay.length;
> + pidff->set_effect[PID_DURATION].value[0] = effect->replay.length == 0 ? 0xffff : effect->replay.length;
> pidff->set_effect[PID_TRIGGER_BUTTON].value[0] = effect->trigger.button;
> pidff->set_effect[PID_TRIGGER_REPEAT_INT].value[0] =
>  effect->trigger.interval;
>  
> -- 
>  
> - Paul
>  

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/email-clients.txt in order to fix this.

- Your patch does not have a Signed-off-by: line.  Please read the
  kernel file, Documentation/SubmittingPatches and resend it after
  adding that line.  Note, the line needs to be in the body of the
  email, before the patch, not at the bottom of the patch or in the
  email signature.

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
