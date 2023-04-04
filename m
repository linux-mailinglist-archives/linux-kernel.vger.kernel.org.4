Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED366D5990
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjDDH0Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233850AbjDDHZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:25:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF762704;
        Tue,  4 Apr 2023 00:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DD3962F6D;
        Tue,  4 Apr 2023 07:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFFBDC433A0;
        Tue,  4 Apr 2023 07:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680593145;
        bh=mn2h65ezqykHfNm9cluQczqVnvmM9+sVb+m1AOd6lJU=;
        h=From:To:Cc:Subject:Date:From;
        b=lIywFly4FN+zFkJsDzTqGqa8hMizWK05LijBmRxH9Zg5f4ZwRn9XUkRjdST5V1IUB
         0/o8tYOzxPjPXxopgGPmsXR5SLEK36GbuXESBJH+wvPbPb2lt8jO3aFmbe9enxk6RN
         pXhGbWhaY7f4tgHC3CyavobyPzahxG24Sbz34adT06sAzxAKe3FNlafqYMENv+gtxk
         Gute3LdACRrlJp/64Fmmq4QrVUlR4LbAMpAKopnDsJLzJyHIFo1hEvJz1STlsSChhF
         +xyErAYB/uwQL1L/9iJlocQhWvzLRWc0H/5dZUvaaTI1L9ocSGosTAQ5oNoBZA4IB+
         zS2g7l17fJcbA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pjb3U-0004xO-HA; Tue, 04 Apr 2023 09:26:12 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 00/11] USB: dwc3: error handling fixes and cleanups
Date:   Tue,  4 Apr 2023 09:25:13 +0200
Message-Id: <20230404072524.19014-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When reviewing the dwc3 runtime PM implementation I noticed that the
probe error handling and unbind code was broken. The first two patches
addresses the corresponding imbalances.

The probe error handling has suffered from some bit rot over years and
an attempt to clean it up lead to the realisation that the code dealing
with the "hibernation" feature was both broken and had never been used.
Rather than try to fix up something which has never been used since it
was first merged ten years ago, let's get rid of this dead code until
there is a mainline user (and a complete implementation).

The rest of the series clean up probe and core initialisation by using
descriptive error labels and adding a few helper functions to improve
readability which will hopefully help prevent similar bugs from being
introduced in the future.

Johan


Johan Hovold (11):
  USB: dwc3: fix runtime pm imbalance on probe errors
  USB: dwc3: fix runtime pm imbalance on unbind
  USB: dwc3: disable autosuspend on unbind
  USB: dwc3: gadget: drop dead hibernation code
  USB: dwc3: drop dead hibernation code
  USB: dwc3: clean up probe error labels
  USB: dwc3: clean up phy init error handling
  USB: dwc3: clean up core init error handling
  USB: dwc3: refactor phy handling
  USB: dwc3: refactor clock lookups
  USB: dwc3: clean up probe declarations

 drivers/usb/dwc3/core.c   | 426 ++++++++++++++++----------------------
 drivers/usb/dwc3/core.h   |   8 -
 drivers/usb/dwc3/gadget.c |  46 +---
 3 files changed, 182 insertions(+), 298 deletions(-)

-- 
2.39.2

