Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A35EAB20
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 17:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbiIZPcP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 11:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236542AbiIZPbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 11:31:09 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C783B8E0C8;
        Mon, 26 Sep 2022 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1664201860; x=1695737860;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BBzeIIKz/LcOJedaqZyeeCjFt9aw0fAR/RhHCsWbipI=;
  b=g2bJSF151A2A2aIrZBM831q00KvnPYi98cxG0kQzx23BI7TUUn6gBplG
   v9d9CCM8pBmvjDCXGFyR4kNoSiA0R8frJgszBoaqr+R9gl+CMZg8rQRqH
   FkAU3fO/s7enFlHOwPS81NSWzIss8b6K/WSubcIaqf1444tr3221vzqj0
   8=;
X-IronPort-AV: E=Sophos;i="5.93,346,1654560000"; 
   d="scan'208";a="263256718"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 14:10:38 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-11a39b7d.us-west-2.amazon.com (Postfix) with ESMTPS id B89C7455BF;
        Mon, 26 Sep 2022 14:10:37 +0000 (UTC)
Received: from EX19D002UWA001.ant.amazon.com (10.13.138.247) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Mon, 26 Sep 2022 14:10:37 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX19D002UWA001.ant.amazon.com (10.13.138.247) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.12;
 Mon, 26 Sep 2022 14:10:36 +0000
Received: from dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com
 (172.19.181.128) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.38 via Frontend Transport; Mon, 26 Sep 2022 14:10:36
 +0000
Received: by dev-dsk-alisaidi-1d-b9a0e636.us-east-1.amazon.com (Postfix, from userid 5131138)
        id 8B4B820A8; Mon, 26 Sep 2022 14:10:35 +0000 (UTC)
From:   Ali Saidi <alisaidi@amazon.com>
To:     <renyu.zj@linux.alibaba.com>
CC:     <acme@kernel.org>, <alexander.shishkin@linux.intel.com>,
        <alisaidi@amazon.com>, <german.gomez@arm.com>,
        <james.clark@arm.com>, <john.garry@huawei.com>, <jolsa@kernel.org>,
        <leo.yan@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <mark.rutland@arm.com>, <mike.leach@linaro.org>,
        <mingo@redhat.com>, <namhyung@kernel.org>, <peterz@infradead.org>,
        <timothy.hayes@arm.com>, <will@kernel.org>,
        <xueshuai@linux.alibaba.com>, <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH] perf arm-spe: augment the data source type with neoverse_spe list
Date:   Mon, 26 Sep 2022 14:10:32 +0000
Message-ID: <20220926141032.30734-1-alisaidi@amazon.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <1664197396-42672-1-git-send-email-renyu.zj@linux.alibaba.com>
References: <1664197396-42672-1-git-send-email-renyu.zj@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-14.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> When synthesizing event with SPE data source, commit 4e6430cbb1a9("perf
> arm-spe: Use SPE data source for neoverse cores") augment the type with
> source information by MIDR. However, is_midr_in_range only compares the
> first entry in neoverse_spe.
> 
> Change is_midr_in_range to is_midr_in_range_list to traverse the
> neoverse_spe array so that all neoverse cores synthesize event with data
> source packet.
> 
> Fixes: 4e6430cbb1a9("perf arm-spe: Use SPE data source for neoverse cores")
> Signed-off-by: Jing Zhang <renyu.zj@linux.alibaba.com>

Thanks for catching this, you're absolutely right.

Reviewed-by: Ali Saidi <alisaidi@amazon.com>

Ali

