Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450406177AE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 08:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiKCH1b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 03:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbiKCH1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 03:27:23 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B444FCC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 00:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667460435; bh=ZaXYFmLXWsMi7kNj6g7178734pMvEJ6Lz2L2Bc9KYcM=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=oqfbGD+rxr+PEFg/GEJZnPD/0zKapH+9fiLLfzPpGNYpBcn0PY3fKHVyEKw66laHv
         Qwo539L5SGqS3vn8eevb8RyUixVAGQy/QUH2u2b52+/Le+BsAn+eYJLHd9ZrYWdjzW
         TFKpvF+fDXElxWlJ1Xc7W+l5rHGFBuFP49SwOkKU=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Thu,  3 Nov 2022 08:27:15 +0100 (CET)
X-EA-Auth: 1C2lZXt0cX05DonxAPqvbQLj2ZH3ORBoy6pOP51zkhWHzVKWGt62eo4hwELyz8uFeNvyCwvQ5Qj2/hYRbbPz4VyQZ7/LoXqC
Date:   Thu, 3 Nov 2022 12:57:09 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: staging: emxx_udc question on i_write_length datatype
Message-ID: <Y2NtTXwMef0kp01s@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
While reviewing this [1] coccicheck warning, I observed something that concerned
me. The variable i_write_length is declared to be of u32 type. Later it is
assigned a value DMA_MAX_COUNT * mpkt; which is 256 * u32;

I am unable to estimate if mpkt (or max packet size) can attain value greater
than 16777215 in which case the result will overflow the 32 bits of
i_write_length. Is it safe to make i_write_length to be a u64?

[1] drivers/staging/emxx_udc/emxx_udc.c:1007:28-29: WARNING opportunity for min()


