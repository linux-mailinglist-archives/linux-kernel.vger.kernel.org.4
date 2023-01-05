Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F012365E817
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjAEJoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjAEJoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:44:13 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BEB9479EA
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 01:44:12 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3056PuSj029903;
        Thu, 5 Jan 2023 03:43:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=lgodXZBbt5kLxYzL1iho626RtWNjC+pkJUsmZLZ3tuE=;
 b=IYYvo9PMu0JyMgudfOW8id0xh+yoakF1BoFbgkTOvnnbGKigZ+sGQJM5lVp73lPh5QeG
 D+L2mVKPGpyxSz7WcYvuqaFHX0cOyeLhc2LKEL6Dk/QeV04yZzaYMkRo+vqIUjM3wZ2D
 ywwc6bWOrK4viGS5kFYiRWFdpK1eUzAcyuY/y4o+DHsowa721sHF9nEZ6onUOkAKYMUP
 VnjPMQhQ1IpwaPNQlapY2PVtfYWcI261ZJOuANGDa6i1k7dwN/Ye8IwO9pm8kn2DGIEC
 DC2585z3bEAa1X11epQqzMnjGwXOfWw/ZpJC6qVWIRlccrgID16r8L7+SshEUKPnagqT XA== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3mtjctvdb6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 03:43:52 -0600
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 5 Jan
 2023 03:43:50 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.20 via Frontend Transport; Thu, 5 Jan 2023 03:43:50 -0600
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D6D5545D;
        Thu,  5 Jan 2023 09:43:50 +0000 (UTC)
Date:   Thu, 5 Jan 2023 09:43:50 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Liang He <windhl@126.com>
CC:     <lee@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: arizona: Use pm_runtime_resume_and_get() to
 prevent refcnt leak
Message-ID: <20230105094350.GJ36097@ediswmail.ad.cirrus.com>
References: <20230105061055.1509261-1-windhl@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230105061055.1509261-1-windhl@126.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-GUID: 9c8Xi-myRseE_grr8fYNqAa9c2B8lngL
X-Proofpoint-ORIG-GUID: 9c8Xi-myRseE_grr8fYNqAa9c2B8lngL
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2023 at 02:10:55PM +0800, Liang He wrote:
> In arizona_clk32k_enable(), we should use pm_runtime_resume_and_get()
> as pm_runtime_get_sync() will increase the refcnt even when it
> returns an error.
> 
> Signed-off-by: Liang He <windhl@126.com>
> ---

Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles
