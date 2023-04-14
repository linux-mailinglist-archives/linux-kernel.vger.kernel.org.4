Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC4E6E2523
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjDNOGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjDNOGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:06:41 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E864E4C22
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1681481180; x=1713017180;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=OM+rQA4A0grky8VAoNN9czxjS/MyZJeGcKsWzhjOGyM=;
  b=r9Tt2S+Mn1yThFfCxZ7PuuHZeHGlQT6DnR+POGmf3mvApLir+A3zQ+qD
   UVqu1AQ04cei5oYTVKvdYN3H+k4remM3UKrNdwkn6GrwPyp463DoneB9j
   ehyMBJpDwnJBgFmype6dlY6AkvDQRFo2LTkSYSfijB/i9IouHglrpcxpA
   E=;
X-IronPort-AV: E=Sophos;i="5.99,197,1677542400"; 
   d="scan'208";a="277200482"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 14:05:02 +0000
Received: from EX19MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id BC0544380F;
        Fri, 14 Apr 2023 14:04:59 +0000 (UTC)
Received: from EX19D003UWC001.ant.amazon.com (10.13.138.144) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Apr 2023 14:04:45 +0000
Received: from [192.168.11.110] (10.106.179.32) by
 EX19D003UWC001.ant.amazon.com (10.13.138.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 14 Apr 2023 14:04:44 +0000
Date:   Fri, 14 Apr 2023 09:04:36 -0500
From:   Geoff Blake <blakgeof@amazon.com>
To:     Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <ilkka@os.amperecomputing.com>
Subject: RE: [PATCH] perf/arm-cmn: Fix DTC reset
In-Reply-To: <20230414124239.GA27611@willie-the-truck>
Message-ID: <c6ac80dc-fe91-cd2a-4709-d21082840dec@amazon.com>
References: <f0b61513276ee2c448ae02a6840135571039cea7.1680792373.git.robin.murphy@arm.com> <b2488619-a306-981c-1172-7efce749c10e@amazon.com> <20230414124239.GA27611@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.106.179.32]
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D003UWC001.ant.amazon.com (10.13.138.144)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the confusion Will, but no, the patch does not solve the issue, 
the spurious interrupt storm still exists.  The patch needs the 
additional shutdown routine Robin had in his older set.

Geoff

