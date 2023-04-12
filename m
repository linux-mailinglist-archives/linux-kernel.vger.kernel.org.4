Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D236DF00C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 11:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjDLJKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 05:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDLJKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 05:10:20 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01852A9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 02:10:18 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33C5sGqE023356;
        Wed, 12 Apr 2023 04:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=UigUkNR6881wrnlvVj1g9hFPk4PfO8ZLIjY/sdfTSMs=;
 b=eOSmWuQJX8NCioqB0DvL2oVQhd5/41euMJo8E9Xoj8oOBLlgNnwjUqfmgdWS4agsU+zl
 6Ym7N5DASTA1H7GZ5re4fQpJSsM9/LKkjAVGGqkJvB8/0UZOWnuTIC2I6vIvrkrwXiXR
 1iyyM7oFWHWXS6mgokgZdcelIFlxDZxXnjqZ4MtukxU2il+5BawDWTnPUkNRcmN2WhRu
 SHiYXK5rJooEyO1XCW2HJ1XmedCMIkPinH2HstqfzSNByijMhUZ/3W08MfU9jqCs1kQV
 qgM54ungHLlLR5mD7MyJdggf4kKZB5pLl317dRYxgFH72OMMVv6mmQ59ppcuE6odUbLJ EQ== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3pu4pq6jjg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Apr 2023 04:09:58 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Wed, 12 Apr
 2023 04:09:57 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Wed, 12 Apr 2023 04:09:57 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 05C7C45;
        Wed, 12 Apr 2023 09:09:57 +0000 (UTC)
Date:   Wed, 12 Apr 2023 09:09:56 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
CC:     <alsa-devel@alsa-project.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        David Rhodes <david.rhodes@cirrus.com>,
        James Schulman <james.schulman@cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 2/3] ASoC: cs4271: flat regcache, trivial simplifications
Message-ID: <20230412090956.GY68926@ediswmail.ad.cirrus.com>
References: <20230410223902.2321834-1-alexander.sverdlin@gmail.com>
 <20230410223902.2321834-3-alexander.sverdlin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230410223902.2321834-3-alexander.sverdlin@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: udVNQjJh6RmxTrSwzNkVSE-TvB0h1R_8
X-Proofpoint-ORIG-GUID: udVNQjJh6RmxTrSwzNkVSE-TvB0h1R_8
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 12:39:01AM +0200, Alexander Sverdlin wrote:
> - Switch to REGCACHE_FLAT, the whole overhead of RBTREE is not worth it
>   with non sparse register set in the address range 1..7.
> - Move register width to central location
> 
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
