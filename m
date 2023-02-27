Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2864F6A3D75
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:52:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbjB0Iwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjB0IwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:52:18 -0500
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D19193E4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1677487502; x=1709023502;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4+h0aoYkidJgeWb694GJg+GljUa72J6p/ycCwVzrKtg=;
  b=BllJI9mBZ5mOhvaXcH4Th5OY5pvAovkqN4B8uUSqHOzTNDQhVT5Zzt6/
   LRMNik79RbqwukwBO/WdewhUmVGGiKUpOWbm4T1VrcAcaL2ZbDAZgbJA3
   6n0OLvCL7v1/560r/qBC6QBzBe5qup41YExEwfFNFS4lDh+vTYdVWjWk9
   E=;
X-IronPort-AV: E=Sophos;i="5.97,331,1669075200"; 
   d="scan'208";a="186841133"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 08:43:14 +0000
Received: from EX19D020EUA004.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id DD33444555;
        Mon, 27 Feb 2023 08:43:08 +0000 (UTC)
Received: from EX19D033EUC004.ant.amazon.com (10.252.61.133) by
 EX19D020EUA004.ant.amazon.com (10.252.50.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Mon, 27 Feb 2023 08:43:07 +0000
Received: from u40bc5e070a0153.ant.amazon.com (10.1.212.27) by
 EX19D033EUC004.ant.amazon.com (10.252.61.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.24; Mon, 27 Feb 2023 08:43:01 +0000
Date:   Mon, 27 Feb 2023 09:42:54 +0100
From:   Roman Kagan <rkagan@amazon.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Peter Zijlstra <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Valentin Schneider <vschneid@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ben Segall <bsegall@google.com>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH v3] sched/fair: sanitize vruntime of entity being placed
Message-ID: <Y/xtDWYTKLutOqrM@u40bc5e070a0153.ant.amazon.com>
Mail-Followup-To: Roman Kagan <rkagan@amazon.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        Valentin Schneider <vschneid@redhat.com>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Ben Segall <bsegall@google.com>, Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>
References: <20230209193107.1432770-1-rkagan@amazon.de>
 <CAKfTPtB7ZDyCh0MiNQtyimVhYJ6E3C+2bTptj9CX3+mepH8YAQ@mail.gmail.com>
 <Y/T36NvaCxSfS8Z/@u40bc5e070a0153.ant.amazon.com>
 <CAKfTPtCDxdVEmPQf=6g7n7Y+bkozXAJT1NG92wDc_quNaDiHMg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAKfTPtCDxdVEmPQf=6g7n7Y+bkozXAJT1NG92wDc_quNaDiHMg@mail.gmail.com>
X-Originating-IP: [10.1.212.27]
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D033EUC004.ant.amazon.com (10.252.61.133)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 06:26:11PM +0100, Vincent Guittot wrote:
> On Tue, 21 Feb 2023 at 17:57, Roman Kagan <rkagan@amazon.de> wrote:
> > What scares me, though, is that I've got a message from the test robot
> > that this commit drammatically affected hackbench results, see the quote
> > below.  I expected the commit not to affect any benchmarks.
> >
> > Any idea what could have caused this change?
> 
> Hmm, It's most probably because se->exec_start is reset after a
> migration and the condition becomes true for newly migrated task
> whereas its vruntime should be after min_vruntime.
> 
> We have missed this condition

Makes sense to me.

But what would then be the reliable way to detect a sched_entity which
has slept for long and risks overflowing in .vruntime comparison?

Thanks,
Roman.



Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879



