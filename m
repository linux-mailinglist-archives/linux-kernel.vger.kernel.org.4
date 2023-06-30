Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CE27444F4
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 00:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjF3Wp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 18:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjF3Wpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 18:45:55 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39E03C22;
        Fri, 30 Jun 2023 15:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688165154; x=1719701154;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=KJBJhwV9I7CqYfKYREOUi2QsUD9eqH0pYcAH+hwjTqQ=;
  b=aBy2Ii5ryfJq1FN+5H08rmR2KI/RVN30ASGloYlncujxHroGTiRKPdeo
   VqCDkMTa4CYy7ExELcdfOgpbZia5nwBNITOtJn5+ReTlzdI+8RgUF2m6j
   //t9uXQTfaF6VXz6h1A35ajF365P1YEOuEh0ysZjHC3Jbo/IqVUwAuUai
   MXZvQhUk33JjhvdspkSpkJNZ+hI8X5q6JZDr6CYVXxHOwF37nCT5TSH5Q
   yyhbtav3IgvcTtYPxBxSJKcd6wcLbIdjL8U+ditn5p19LUo4YHMG16CcU
   uolkJ1Yi+xA43ISltMmQetO7n0vo8Oguv/5aZo9a6QdKPAYdtqYNQric2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="352333047"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="352333047"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 15:45:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10757"; a="668115595"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="668115595"
Received: from jacobnar-mobl.amr.corp.intel.com ([10.212.196.106])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2023 15:45:54 -0700
Message-ID: <9ffecf8a6cbc97b257602d6b96216170a527cd02.camel@linux.intel.com>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Fix scaling for hybrid
 capable system with disabled E-cores
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 30 Jun 2023 15:45:52 -0700
In-Reply-To: <CAJZ5v0ju6ffS3yWD97h1r0A1AzxoX+xLiXEN7YhGotD8SJv13Q@mail.gmail.com>
References: <20230629194509.4094455-1-srinivas.pandruvada@linux.intel.com>
         <CAJZ5v0ju6ffS3yWD97h1r0A1AzxoX+xLiXEN7YhGotD8SJv13Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA2LTMwIGF0IDEwOjU5ICswMjAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToKPiBPbiBUaHUsIEp1biAyOSwgMjAyMyBhdCA5OjQ14oCvUE0gU3Jpbml2YXMgUGFuZHJ1dmFk
YQo+IDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4LmludGVsLmNvbT4gd3JvdGU6Cj4gPiAKPiA+
IApbLi4uXQoKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZ290byBod3BfY3B1X21hdGNoZWQ7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfQo+ID4gLS0KPiAKPiBBcHBsaWVkIGFzIDYuNS1yYyBtYXRlcmlhbCB3aXRoIHNvbWUgYWRq
dXN0bWVudHMuwqAgUGxlYXNlIGNoZWNrIHRoZQo+IGJsZWVkaW5nLWVkZ2UgYnJhbmNoLgpMb29r
cyBnb29kLgoKVGhhbmtzLApTcmluaXZhcwoKPiAKPiBUaGFua3MhCgo=

