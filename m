Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14AF68374D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 21:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjAaUKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 15:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjAaUKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 15:10:05 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC4A526E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 12:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1675195804; x=1706731804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3QJEpYpI2eSvedsOr9JhsxuvFY/DP2Zf8Av5ZZRfQIA=;
  b=pZwlkGMO/4KPgV7vlrH+PnTZVE3+Vd+zXD+W/e4fHtpFQuvWl97x3JoY
   hLpGQU+kc2QDIVGtaaPFow08LQa0v3CHtEfcMOcUjhpEdiZDu7gSsMNPc
   V3VqUJyfomFw1oaqadXM5GusckvE3RiU7FghbovIa9vlJCHC3rZqekI1U
   o=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 31 Jan 2023 12:10:03 -0800
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 12:10:03 -0800
Received: from hu-sbhattip-lv.qualcomm.com (10.49.16.6) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Tue, 31 Jan 2023 12:10:03 -0800
Date:   Tue, 31 Jan 2023 12:10:01 -0800
From:   Sukadev Bhattiprolu <quic_sukadev@quicinc.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>, Vlastimil Babka <vbabka@suse.cz>,
        Joonsoo Kim <js1304@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        "Georgi Djakov" <quic_c_gdjako@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm,page_alloc,cma: configurable CMA utilization
Message-ID: <20230131201001.GA8585@hu-sbhattip-lv.qualcomm.com>
References: <20230131071052.GB19285@hu-sbhattip-lv.qualcomm.com>
 <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9lZoI89Nw4bjjOZ@P9FQF9L96D.corp.robot.car>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 10:10:40AM -0800, Roman Gushchin wrote:
> Hi Sukadev!
> 
> Can you, please, share a bit more details about your setup? E.g. what is
> the zone size, the cma area size and the value you want to set your sysctl to?

Hi Roman,

I currently have a device with 8GB Zone normal and 600MB of CMA. We have a
slightly different implementation and use up all the available CMA region.
i.e. going forward, we intend to set the ratio to 100 or even higher.

We have other devices with 4GB or less memory but I don't have the CMA
size atm. Let me know if you need more info.

Thanks!

Sukadev
