Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C646C6605
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjCWLBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjCWLAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:00:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919941EBFB;
        Thu, 23 Mar 2023 04:00:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r11so3176058wrr.12;
        Thu, 23 Mar 2023 04:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679569244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nYRr6g4GWy5gwn22Rd90B+i3jSK1ufJZOOg+wuyjFVk=;
        b=gEgk/fmBRVwwybZ8CKrJAk3GD5mTI4RBSYXwnGat0aEK0TmrJ5JMxk4hAosZCJT4k1
         doY2a8cuBk5OlkQoX56KLMZSwiHsPuHCRqM0JJjgoicym14RyGSvIpBVOpHSEv7eDEGX
         uDP8ILgXIYmJ1gfWvsIJPJjiVN1x2qwHdT+w9O7vRv1tuTUqwNWDlPX3mtdl6nn/gXNJ
         aPeTzINCjnxBkV9ID84Fc537todiNvExx6ylSQb0ZHLnqFwloTIigWUaW2Pb7Gpubpgn
         iVjb2yk36ZkfSQCImgayUK8EO/u2WkkMCQmoV491di4K6I6ZN1CLwEjpNFoVWyflc5m7
         fMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679569244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYRr6g4GWy5gwn22Rd90B+i3jSK1ufJZOOg+wuyjFVk=;
        b=GnfjIJaazPsSsbB67zZrciYE7nkkt0jz7yypeUje5sB1/k0JSCgrXe8He/mHsjeu7t
         CyZWI+H0syfsxzA+3+Su6t+wTrBN/idNpcL3cCNoDzXZh7rlUlEqDAO6+JBvJY9g2+ZC
         9AFhXOKgefTTC/qVSNaOmgDEhvplCl0Df+J6EL3Qc6L8rvs/uIID4jI9j9935Ibb+MIg
         8E4ecICOvFaWfBQjaxjsSy/7sHPWbI37rWAHdWfRwdBg5XIcMs9MUMCHH6kGxwN8fWCK
         yf/nusOogoy/j8E3uJ1l6Z9F6QfLUGPYjJP7UnDGg6o/nSia+g99Qg+gzGltf8t94YW0
         1SXQ==
X-Gm-Message-State: AAQBX9f6lQzVxOyRPFja0aWwTPfZTfZsQKeXckyMV+aIk67ancUAFFQw
        fwa/MpN43kIDguwl45dawaY=
X-Google-Smtp-Source: AKy350a3L1A43Kp2V0ku7B+3SBnycsVj+HOyb+6EOehj7S/shLeP4+tgkgvrxV27xm8vwb9KSwgC3g==
X-Received: by 2002:adf:eb02:0:b0:2d3:81b0:c09f with SMTP id s2-20020adfeb02000000b002d381b0c09fmr2162712wrn.64.1679569243878;
        Thu, 23 Mar 2023 04:00:43 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id l12-20020adfe9cc000000b002cea8e3bd54sm15854230wrn.53.2023.03.23.04.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 04:00:43 -0700 (PDT)
Date:   Thu, 23 Mar 2023 14:00:35 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Mingxuan Xiang <mx_xiang@hust.edu.cn>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: dwc3: host: remove dead code in
 dwc3_host_get_irq()
Message-ID: <e2067012-af9a-4cc7-ba12-3c055d54d915@kili.mountain>
References: <20230323095311.1266655-1-mx_xiang@hust.edu.cn>
 <eedbfdca-0eb1-4b01-976b-4ddba516cfad@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eedbfdca-0eb1-4b01-976b-4ddba516cfad@kili.mountain>
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is how I would write that function, but I can't justify sending it
because it's just a matter of personal taste.

diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index f6f13e7f1ba1..fcc831ac3236 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -36,32 +36,28 @@ static int dwc3_host_get_irq(struct dwc3 *dwc)
 	irq = platform_get_irq_byname_optional(dwc3_pdev, "host");
 	if (irq > 0) {
 		dwc3_host_fill_xhci_irq_res(dwc, irq, "host");
-		goto out;
+		return irq;
 	}
 
 	if (irq == -EPROBE_DEFER)
-		goto out;
+		return -EPROBE_DEFER;
 
 	irq = platform_get_irq_byname_optional(dwc3_pdev, "dwc_usb3");
 	if (irq > 0) {
 		dwc3_host_fill_xhci_irq_res(dwc, irq, "dwc_usb3");
-		goto out;
+		return irq;
 	}
 
 	if (irq == -EPROBE_DEFER)
-		goto out;
+		return -EPROBE_DEFER;
 
 	irq = platform_get_irq(dwc3_pdev, 0);
 	if (irq > 0) {
 		dwc3_host_fill_xhci_irq_res(dwc, irq, NULL);
-		goto out;
+		return irq;
 	}
 
-	if (!irq)
-		irq = -EINVAL;
-
-out:
-	return irq;
+	return -ENODEV;
 }
 
 int dwc3_host_init(struct dwc3 *dwc)
