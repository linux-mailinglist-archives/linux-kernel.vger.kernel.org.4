Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600176EF83C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241399AbjDZQRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239512AbjDZQR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6F42D55;
        Wed, 26 Apr 2023 09:17:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7BE063732;
        Wed, 26 Apr 2023 16:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EB4C433EF;
        Wed, 26 Apr 2023 16:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682525846;
        bh=qsJu9qcEXfSq2zuM/m0CZcc0AWAn2Zc87aX2e31XwA4=;
        h=Date:To:Cc:From:Subject:From;
        b=pFBEfcpRaBskWVlrshcj7bk3yt2YpDFyO7IOBZSXTka2izBuUYjAV7NUz8jprMrLN
         aWrTfhcuYq5xcPM5RBHg2UzCeaytu85GfoBqAOKg4pIW3wPi9No3UduysKJKW5LTeI
         mCktaOTj1o1rX4L8EtLPhemcRG7KfD785WAP0IoWkwWETxZJsKJZpbZihsbDhJSHvv
         OJaxYQSl6hH2ikDJYRwF4G3brUVH13fKyUPylAr2SSAYItzJGbCo7xfxhfq9caSsR3
         dt1U6jwgeG1tp5gMQMxRVv/QqYguUlWSSjF2zPkYxXysKEv8tPmSmPtfjNbPf0fveF
         OztbLgBFNxlGQ==
Message-ID: <24c9f271-ed74-fffa-a49f-6e83da857593@kernel.org>
Date:   Wed, 26 Apr 2023 19:17:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Roger Quadros <rogerq@kernel.org>
Subject: dwc3 gadget: controller stop times out on system sleep
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thinh,

On Linux kernel v6.3
Test procedure: 

- modprobe g_zero
- Connect to PC host
- systemctl suspend

A large delay of 3 seconds is observed. The delay comes from dwc3_gadget_suspend()->dwc3_gadget_run_stop() waiting for DWC3_DSTS_DEVCTRLHLT to be set.
It returns -ETIMEDOUT.

Are we missing something to do a clean stop during suspend?

FYI. Unloading g_zero does not show this delay on stop.

cheers,
-roger
