Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F079F6C9E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233239AbjC0Ij1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjC0Ii5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:38:57 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42DE7D8E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 01:33:31 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R6sIwq002016;
        Mon, 27 Mar 2023 03:33:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=+f6AXv/9wpIrc9ZyOdHQ1UKnx/Y/J05TC0RiqzcnUnM=;
 b=kjidK2YPzNZfPUNSZzO+gnRfDOmJ6YxgQaZZDb3ZZmfPB5S2oeedeQFQvnM8VXVgHKnA
 8YQtcJSrG9oKpGpGj3xROU5hQZX3I8eZ1v40YMU8Oo973ubh4S7G8NkOXrcHhYhxAPlj
 snEqgIXBgN7ub48DFhiSncMVS+oOSEMTzDRwI1D4sN/kFKo9UfnV9zONFzAvLvz615CL
 I/UrEH/+2rCj/pgHfL47FmCl4NtH1LIFsAEkyhunZOQl7yhv+AUSS3Fiiq84kLO8dgD2
 rXzUFrXAFD0y/mnkoaYqM7oITExD6WilDac0uhZvimTKTN9cJRr+4+lX9UnBLEwtdxhq Qw== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3phxc2j69w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 03:33:18 -0500
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.25; Mon, 27 Mar
 2023 03:33:16 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 27 Mar 2023 03:33:16 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 2B7AD11D3;
        Mon, 27 Mar 2023 08:33:16 +0000 (UTC)
Date:   Mon, 27 Mar 2023 08:33:16 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Svyatoslav Ryhel <clamor95@gmail.com>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        <patches@opensource.cirrus.com>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 0/1] Implement DMIC support in WM8903
Message-ID: <20230327083316.GR68926@ediswmail.ad.cirrus.com>
References: <20230325083643.7575-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230325083643.7575-1-clamor95@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: eetdR_vAdnT96ZJC8FnuOBaPDqQwnFL_
X-Proofpoint-ORIG-GUID: eetdR_vAdnT96ZJC8FnuOBaPDqQwnFL_
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 10:36:42AM +0200, Svyatoslav Ryhel wrote:
> According to comments in wm8903, driver lacks DMIC support.

Which comments? I am having some difficulty finding these?

Thanks,
Charles
