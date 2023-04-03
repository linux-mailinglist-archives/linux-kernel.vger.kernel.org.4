Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106126D4CF7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjDCQBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232932AbjDCQA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:00:59 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9E71BF1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 09:00:43 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EAAAF60005;
        Mon,  3 Apr 2023 16:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1680537642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5awF1RFpMHZWDaLIMt0lSfQ4rxtozrqLH4YEjfHnBJE=;
        b=bQZaqeVOcY6cRrjX4mEaZ/ofaVrTXuj2j8gFm+gs0+PymUy9VbKEYhKo0va1jh3caNXv77
        Txi33VuJF5l4fz6OYN2+qqHsqptFOO4tPeijLV9T67gh1g8r/XwIsPVdM9WbUYS6yOBVdB
        OKbcpqKBaRl5T+EIG+n8jITprCm1x6SCan0WJS3++PUqSQkxZpuh9LopwxnUJbW1XllPFW
        DVzweHOl5Xb3VW9EkeYwfiKFVRSHGEpuqqq3hLg9jveCZp7AFYNOIXoUKMX/7AuDs2xTsb
        iM9UvAngaE55Ov+71vXFipOEYvm9+4ygW+N98Ud9eUh/D37B589mHcWAa5O/6A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Martin Kurbanov <mmkurbanov@sberdevices.ru>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Chuanhong Guo <gch981213@gmail.com>,
        Aidan MacDonald <aidanmacdonald.0x0@gmail.com>,
        Felix Matouschek <felix@matouschek.org>, kernel@kempniu.pl
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v4] mtd: spinand: add support for ESMT F50x1G41LB
Date:   Mon,  3 Apr 2023 18:00:38 +0200
Message-Id: <20230403160039.144916-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230329114240.378722-1-mmkurbanov@sberdevices.ru>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'd74c36480a679b27ce8a70c2e88fed31b86323d9'
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-29 at 11:42:40 UTC, Martin Kurbanov wrote:
> From: Chuanhong Guo <gch981213@gmail.com>
> 
> This patch adds support for ESMT F50L1G41LB and F50D1G41LB.
> It seems that ESMT likes to use random JEDEC ID from other vendors.
> Their 1G chips uses 0xc8 from GigaDevice and 2G/4G chips uses 0x2c from
> Micron. For this reason, the ESMT entry is named esmt_c8 with explicit
> JEDEC ID in variable name.
> 
> Datasheets:
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50L1G41LB(2M).pdf
> https://www.esmt.com.tw/upload/pdf/ESMT/datasheets/F50D1G41LB(2M).pdf
> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> Tested-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next, thanks.

Miquel
