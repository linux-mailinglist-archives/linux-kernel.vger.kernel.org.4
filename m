Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0725260C3D3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiJYGeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJYGeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:34:05 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D407211D985;
        Mon, 24 Oct 2022 23:34:04 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id z9so3305003ilu.10;
        Mon, 24 Oct 2022 23:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VY4uiQINAn+QNKqNLYdLuvR39IkMOW5yKvxvg9QwqI8=;
        b=C0wIa3MBCs9h8r8BMk85NhUmB32niC0FVJGtBwWms81UchyTqsnlKS5jKvVy3mn9Gy
         nH0aE8XFkvHnRzp/7hgfcTQ6jirQYxZ7Qkj+5OjoHNJO7JwJMQmMgKLfSF6DvULMqK97
         mVBc4sX+lNL3TYNcN2G34nz54GKuUQ3DEKpTAnxi5s+y7AAu+C+sBO7RDo+ibv2eMy3W
         WULgOJPlPOR+HqrCok++V/8fiimeb6aKKUmic8vzFbdF3sBKhN6+JnKzLk407JT7MDe2
         x0e2IGnUb7w33fiEJEJ3K51CL9YW6WnDuJXHIKEN2WRnsjkvP/JJeCmayKMAIhOJrvdA
         903Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VY4uiQINAn+QNKqNLYdLuvR39IkMOW5yKvxvg9QwqI8=;
        b=nqkQMji4i3s07QwiyKFMaQoUQF5/0z4WUnKYVWxiUTSnV2zPsHL79MoQbM5/myHyAS
         x1JLX/wwmXvQRv43GTA0oglQDQ38OYvlJcsvEKda3sVlplCozJh5/3+EpgHtiafdVgaB
         dQiMSks/0GCb9iNBrn7dVPiXG7bMiUrfbp9lM5j43OElDwl0hlVcfK9G48kvWlZHvM0t
         /Ik/xI1SKILRl+xwiJQuysffhW0Va+/AQJE35qj1Ge8gZnq538ATo5tnavf//EVPeN64
         +VE3hNBkpoNyhcAEBQtFadPy9GfhPCg+NWbnOwIcIUqCW4r3ZANZ5g+KsnI98OwKdEkN
         t96g==
X-Gm-Message-State: ACrzQf02o/Vw3GsEcZQjYogAVGahcw7HR2EB/8b/UA9UCk72e2nBQGM/
        ce+d4d6zJ0g+e0CbHC26XukvODQBT3Jw60WG
X-Google-Smtp-Source: AMsMyM5zXTToXYbLlKJbBRDvjmuwz3yZyM7RxL75VowagP7nYR4QUVprUwv8Vft8Vs7331NuJhN3gg==
X-Received: by 2002:a05:6e02:12ec:b0:2fa:9024:b513 with SMTP id l12-20020a056e0212ec00b002fa9024b513mr22462669iln.120.1666679643900;
        Mon, 24 Oct 2022 23:34:03 -0700 (PDT)
Received: from qjv001-XeonWs (c-67-167-199-249.hsd1.il.comcast.net. [67.167.199.249])
        by smtp.gmail.com with ESMTPSA id o12-20020a0566022e0c00b006a102cb4900sm786751iow.39.2022.10.24.23.34.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Oct 2022 23:34:03 -0700 (PDT)
Date:   Tue, 25 Oct 2022 01:34:01 -0500
From:   Jeff Vanhoof <jdv1029@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-usb@vger.kernel.org,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: uvc gadget performance issues with skip interrupt impl
Message-ID: <20221025063359.GA19049@qjv001-XeonWs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

During the queuing up of requests from the UVC Gadget Driver to DWC3 for one
frame, if a missed isoc event occurs then it is possible for the next
consecutive frame(s) to also see missed isoc related errors as a result,
presenting to the user as a large video stall.

This issue appears to have come in with the skip interrupt implementation in
the UVC Gadget Driver:

usb: gadget: uvc: decrease the interrupt load to a quarter
https://lore.kernel.org/r/20210628155311.16762-6-m.grzeschik@pengutronix.de

Below is an example flow of how the issue can occur (and why).

For example (ISOC use case):
1) DWC3 driver has 4 requests queued up from the UVC Gadget Driver.

2) First request has IOC bit set due to no_interrupt=0 also being set, and IMI
bit is set to detect missed ISOC.

3) Requests 2,3,4 do not have IOC bit set due to no_interrupt=1 being set for
them. (Note: Whether or not the IMI bit is set for these requests does not
matter, issue can still crop up as there is no guarantee that request 2,3,4
will see a missed isoc event)

4) First request gets a missed isoc event and DWC3 returns the req and error to
UVC Gadget Driver.

5) UVC Gadget Driver, in uvc_video_complete, proceeds to cancel the queue by
calling uvcg_queue_cancel.

6) UVC Gadget Driver stops sending additional requests for the current frame.

7) DWC3 will still have requests 2,3,4 queued up and sitting in its
started_list as these requests are not given back to the UVC gadget driver
because they each have no_interrupt=1 set, and the DWC3 driver will not have
any additional interrupts triggered for them as a result.

8) Approximately 30-100ms later a new frame enters the UVC Gadget Driver (from
V4L2), and it proceeds to send additional requests to the DWC3 driver.

9) Because requests 2,3,4 are still sitting in the started_list of the dwc3
driver, the driver does not stop and restart the transmission that normally
helps it recover from the missed isoc situation (this usually happens in
between frames).

10) Some of the requests from the new frame will have no_interrupt=0 set, but
these requests will be considered missed/late by the DWC3 controller.

11) Because these new requests have the IOC bit set (and possibly IMI),
interrupts will be triggered causing the DWC3 Driver to return the req and
error to the UVC Gadget Driver.

12) And if the last set of requests sent by the UVC Gadget Driver have
"no_interrupt=1" set, then DWC3 may not interrupt further until new requests
come in, and the cycle of frame drops/errors will continue.

I have briefly mentioned this issue in another conversation with Thinh. At the
time he mentioned that 3 things could possibly be done to help resolve this
issue:

1) The UVC Gadget Driver should ensure that the last requests queued to DWC3
must always have "no_interrupt=0" set.

2) DWC3 can detect stale requests, stop the transmission and give back the
requests to the UVC Gadget Driver, and restart the transmission for the new set
of requests.

3) Set "no_interrupt=0" for each request.
 
I have tested out various implementations for all 3 possibilities and they each
seem to work ok. Note that these test implementations are not ready for prime
time, but served as a way to prove that potential changes in these areas could
help to resolve this issue.

I believe that a change for the UVC Gadget Driver should be made, but it also
makes sense for the DWC3 driver to also attempt to recover from this situation
if possible.

Does anyone have an opinion on the best way to proceed?

Thanks,
Jeff

