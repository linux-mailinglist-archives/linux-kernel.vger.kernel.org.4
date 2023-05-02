Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209C86F4837
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbjEBQVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233922AbjEBQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0735D1B1;
        Tue,  2 May 2023 09:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 936FE626A7;
        Tue,  2 May 2023 16:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5890C4339B;
        Tue,  2 May 2023 16:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683044500;
        bh=cFJ8a6f80qJJIon/6vWEsVZtcR6LqKDxeq8RA9J2dN0=;
        h=From:To:Cc:Subject:Date:From;
        b=M/5NHz43vfQmeVan9T1m8BGENgz2iBJb2iu5TN26mU3NIkpn/G1AzYtJLO//F8ZTo
         edyA/vW27mJYu1MDztvV8LNFgSfqjvafZI4YCkml4MeH2iOVDqt856ceujbNPuJYKZ
         og1XAb//SujXKTc6rx40BnqKRbOc+Oh6l3Z66Qz0Mea7jBANo+UlAJdc6E6kWQmJo3
         imCUHzYvGtwWR+yNUbafHE31vPFnhIgNd+1YxvgFQOcFEpfVa+TfzNkibIJ2fLdqPX
         Ul0AhgLp8RloN776uf0VKVK0NFNnQ5VILHSG8aPQjmfnuAZBhth6OL7V1yH6/i7fLk
         amVfxsNzOVvEg==
From:   Roger Quadros <rogerq@kernel.org>
To:     Thinh.Nguyen@synopsys.com
Cc:     gregkh@linuxfoundation.org, r-gunasekaran@ti.com, srk@ti.com,
        wcheng@codeaurora.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2 0/2] usb: dwc3: gadget: Improve dwc3_gadget_suspend/resume
Date:   Tue,  2 May 2023 19:21:31 +0300
Message-Id: <20230502162133.148821-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series improves suspend/resume handling
- check for error condition .suspend
- avoid Timeout error and delay in .suspend

Changelog:
v2:
- rebase on greg/usb-next
- split into 2 patches. Add Fixes tag and cc stable.
- do not check for !softconnect in error condition in dwc3_gadget_suspend()

Roger Quadros (2):
  usb: dwc3: gadget: Avoid controller stop in .suspend if !softconnect
  usb: dwc3: gadget: Improve dwc3_gadget_suspend() and
    dwc3_gadget_resume()

 drivers/usb/dwc3/gadget.c | 68 +++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

-- 
2.34.1

