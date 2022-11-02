Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8EA7615BA0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 05:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKBE6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 00:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBE6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 00:58:19 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946452E3;
        Tue,  1 Nov 2022 21:58:18 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id y13so15399457pfp.7;
        Tue, 01 Nov 2022 21:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RbstM8lzzSiPg3gKms9wPFxy8QEIYEyXHa6HfyuIAfg=;
        b=lU75T51tluaVptGqr20ZsMfr+qxV4DE4PxVEDG7aqQN5uwQ0g20oD0rendWM+197BS
         SOenEWQRq8JGLInk/v4NCUb5EvfcSD1iouDtCCvA5MLB6zCRllsrEM1s9uKk4Gs1acdu
         aT4e103aLvAlqeqI9wLO/C6N+xk0hwtP0YNg493e/QBSQVC3E+CvpliPWRiyv70pKTKe
         8tf2W/nWFRx7KNciaeMmnPMKSHddOzAnFfw8Ql0dp8OrVn2BwcW/0Le1XAANRXBm+U9/
         t+fcivQeeUfKGfrOY7QFrsoiGGINLq6kmA9bqTScmXg3QgNBNQJtsacSX42LHmjx7Ndb
         78Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RbstM8lzzSiPg3gKms9wPFxy8QEIYEyXHa6HfyuIAfg=;
        b=sHUbqJaiTAWfSxkwM5GNEZAVmMkmfSST6BwDypFzRxIJoX9qeGg5RHDwcGaUVlk7R2
         ChqcwvuEDuZbI3+Zm4XBj8lqtD/Cbvx4OE+L4XhpeuGSsStW3km40R5Up4/poy4i60sb
         LtFArgkPtXjEU0Q1p/n+uRMjeFLMjDQV7gQKnIqJ2N+pEUZTZCZ72YFteGSc9NviKmib
         tUyvr4pWRG93wPwKS/JxYl72NFfTSq9+WwXJyLHvLI4q9zLcAXjv2wVuwTmyMVqBdnlm
         6swKteUGJbumXSa9d4qVqx6auL4wSiIEPZyB7mUFyp6/QDT1FymrnKzd8qM47h6+XdpI
         OD6g==
X-Gm-Message-State: ACrzQf1othXMYJf6UPy9t9JX6UAFccvmbj9oAPZjjV1EUKpKeJM8Ly4B
        wWeF3hfegINSEv3ODzHhonj5OikM8tA=
X-Google-Smtp-Source: AMsMyM57O7RGmn6i3Y+10L0qSzPCy3Z/ziWmlz9imNeqgt3V4rOw3nmgK4m5Y/opiWMYA7M3tlTCGw==
X-Received: by 2002:a05:6a00:32c9:b0:56b:a54e:68be with SMTP id cl9-20020a056a0032c900b0056ba54e68bemr23319286pfb.16.1667365098077;
        Tue, 01 Nov 2022 21:58:18 -0700 (PDT)
Received: from redpanada ([112.150.165.132])
        by smtp.gmail.com with ESMTPSA id v10-20020a17090abb8a00b002137030f652sm439884pjr.12.2022.11.01.21.58.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 01 Nov 2022 21:58:17 -0700 (PDT)
Date:   Wed, 2 Nov 2022 13:58:14 +0900
From:   Daewoong Kim <daewoong00.kim@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: core: pass usb_get_status() 'type' argument to
 usb_control_msg()
Message-ID: <20221102025930.GA2163061@marvel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the commit 2e43f0fe379c
("usb: core: add a 'type' parameter to usb_get_status()"), the 'type'
parameter was added. It should be passed to usb_control_msg() as an
argument.

Signed-off-by: Daewoong Kim <daewoong00.kim@gmail.com>
---
 drivers/usb/core/message.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index 4d59d927ae3e..a81f23d81480 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1150,7 +1150,7 @@ int usb_get_status(struct usb_device *dev, int recip, int type, int target,
 		return -ENOMEM;
 
 	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0),
-		USB_REQ_GET_STATUS, USB_DIR_IN | recip, USB_STATUS_TYPE_STANDARD,
+		USB_REQ_GET_STATUS, USB_DIR_IN | recip, type,
 		target, status, length, USB_CTRL_GET_TIMEOUT);
 
 	switch (ret) {
-- 
2.25.1

