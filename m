Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EDA6F03A3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 11:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbjD0JrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 05:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243348AbjD0JrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 05:47:11 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F030E40F5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 02:47:05 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33R5FBLm004611;
        Thu, 27 Apr 2023 04:46:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=kGUJjqL1+qg8otYMpB2IAWWgUB5E/UIRkLDwAapWdsQ=;
 b=ogx9IDv8iZqvPRY43Av0RYr9lEilnSZWS5EU3/1VES9lhuxAva42kotWUQ/zEBZnDYoU
 jude2oEAZtLjPi2B4lU5Y56866duPrk24+qljHXdTTUZ2BhJaH0aNlUE6DzBZaljgvKV
 68DrFN8tMo+jXthGlh0vZzxGK/TaeE3Jk74KaUOE78txz5IAJLrHtdiI9wmLpwGdoDMC
 ENAZKKZ1GaLKszkMu0I5s6yHEp0Lz106PuU7qEL20adSieHdPIdEywIoH5MD5k8wTiFk
 L2WPDWmFI6k8gHOghpNiuQLaMqYqZ2kkpG26gS6Ndl5lMz0VqlyBjevpq3XATA9ovApB Bw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3q4c0pqn81-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 04:46:57 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 27 Apr
 2023 04:46:55 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Thu, 27 Apr 2023 04:46:55 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9244615A4;
        Thu, 27 Apr 2023 09:46:55 +0000 (UTC)
Date:   Thu, 27 Apr 2023 09:46:55 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Lee Jones <lee@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: wm831x: Use maple tree register cache
Message-ID: <20230427094655.GD68926@ediswmail.ad.cirrus.com>
References: <20230419-mfd-wm831x-maple-v1-1-e03e39d7bb0b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230419-mfd-wm831x-maple-v1-1-e03e39d7bb0b@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: ijmqoti1ksMpMnDKtPaunMU4NAWRYvJM
X-Proofpoint-ORIG-GUID: ijmqoti1ksMpMnDKtPaunMU4NAWRYvJM
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 07:03:33PM +0100, Mark Brown wrote:
> regmap has introduced a maple tree based register cache which makes use of
> this more advanced data structure which has been added to the kernel
> recently. Maple trees are much flatter than rbtrees, meaning that they do
> not grow to such depths when the register map is sparse which makes access
> a bit more efficient. The maple tree cache type is still a bit of a work
> in progress but should be effective for some devices already.
> 
> The wm831x devices have a pretty sparse register map and being always on
> devices never do cache syncs so don't hit the major current disadvantage
> so they should be good candiates for using the maple tree cache.  Update
> to do so, there should be little if any visible difference at runtime.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
